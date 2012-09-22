express = require 'express'
http = require 'http'
fs = require 'fs'

app = express()
server = http.createServer app
io = require('socket.io').listen server


# serve static files

app.get '/', (req, res) ->
  res.sendfile __dirname + '/static/index.html'

app.get '/__keen/socket.io.min.js', (req, res) ->
  res.sendfile __dirname + '/static/socket.io.min.js'

app.get '/__keen/zepto.min.js', (req, res) ->
  res.sendfile __dirname + '/static/zepto.min.js'

app.get /^\/(.+)$/, (req, res) ->
  res.sendfile req.params[0]


socks = []
filenames = []
timeout = null

update = ->
  while filenames.length
    f = filenames.pop()
    while f in filenames  #remove duplicates
      filenames.splice(filenames.indexOf(f), 1)

    fs.readFile f, 'utf8', (err, data) ->
      throw err if err
      for sock in socks
        sock.emit 'update', f, data
      timeout = null


io.sockets.on 'connection', (socket) ->
  socks.push socket
  socket.on 'watch', (filename) ->
    console.info 'watching', filename
    try
      fs.watch filename, (event, filename)->
        console.info '', event, filename
        filenames.push(filename)
        unless timeout
          timeout = setTimeout(update, 100)
    catch error
      console.error 'error watching', filename
      console.error error



server.listen 9000
