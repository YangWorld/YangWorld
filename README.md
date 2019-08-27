# YangWorld
YangWorld - A Retro Yang-Filled Adventure Coming Soon! Try it now: http://proto.yangworld.io


## Setup

### Install dependencies

Not all Love2d libraries use luarocks, so we sort of manage ones that don't.

To use a new library, add it to the `.pebbles` file. Github repos are only supported so if the user name is "x" and the repo name is "y", we would append "x/y" to `.pebbles`.

To install all the libraries inside `.pebbles`, run `make install-pebbles`.

These get installed to `./libs`.

### Install love.js

run `make love.js`

This clones the repo at the this project's root directory and sets everything up.

## Building

Generate the `.love` file with `make package`.

Generate the static site with `make web`.

`make web` gets called automatically by `make serve` and `make deploy`.

## Running

### Locally

run `make run`

### In the browser (locally)

run `make serve`, then go to localhost:8000 in your browser.

## Deploy

run `make deploy`