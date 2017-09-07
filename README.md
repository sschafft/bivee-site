# Bivee website
http://bivee.co

## Local setup:

1. Clone this repository
2. Install [Bundler](http://bundler.io) and [Node](https://nodejs.org/en/) if you don't already have them.
3. Run `bundle install` and `npm install` in the command line
4. All set!

## Development:

- Run `bundle exec middleman` to start a local Middleman server; site will be available at `http://localhost:4567` in your browser. You can see the sitemap and config at `http://localhost:4567/__middleman`.
- `bundle exec middleman build` will compile the site to the `/build` folder.

## Deploy:

- Add remote to main bivee site: `git remote add deploy-repo git@github.com:biveeco/biveeco.github.io.git`
- https://github.com/biveeco/biveeco.github.io
- Run `middleman deploy`
