======
 Keen
======


Livecoding for the Web, from your desktop editor!


## Why

I want instant feedback while coding on the Web. I want to livecode (like on [livecodelab](http://www.sketchpatch.net/livecodelab/index.html) and [livecoder.net](http://livecoder.net/)) when I'm working on a project, not just to play around. As such, I want to use my desktop editor (emacs, vim, sublime, textmate, etc.), not a web-based editor like [codemirror](http://codemirror.net/) or [ace](http://ace.ajax.org/).


## How

Keen will serve a local directory via HTTP, watch for file (script, style) changes and update those files in the browser.

It works by serving up a wrapper at `/` that loads `index.html` from the local directory in an iframe. Whenever files referenced by `<script>` or `<link rel="stylesheet">` tags change on disk, they are sent to the browser via `socket.io`. Scripts are then `eval`'d, and styles are updated.


## What

Keen is a [node.js](http://nodejs.org/) module, written in coffescript, using socket.io.

Install it with `npm install -g keen`.

Run `keen` in a directory with an `index.html`, open your browser at `http://localhost:9000`.
Edit a script file included in the page, hit save, and watch it instantly reload.

Use with CoffeeScript, Sass, Compass, etc. in 'watch' mode for great justice. Use a [Procfile](http://ddollar.github.com/foreman/) to start them all.


## More


### Usage

    keen


### Caveats

For now, `keen` only works with static content, because of the [same origin policy](http://en.wikipedia.org/wiki/Same_origin_policy). You can't run it with your node-based or rails or django app. I plan to fix this, but you will likely need to change your app slightly.


### Status

Warning: this is *alpha* software. Don't use it for anything other than development.
