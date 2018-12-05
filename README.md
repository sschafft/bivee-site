# Bivee's website
http://bivee.co

## About this site:

This site is built primarily on Middleman, a static site generator. It uses [Sass](http://sass-lang.com) for its styling (via [LibSass](https://github.com/sass/sassc-ruby)) and a variant of [AMCSS](https://amcss.github.io) for its CSS naming conventions and architecture. Javascript is handled with [Webpack](https://webpack.js.org), and front-end dependencies are managed with Yarn. It's hosted on [Netlify](http://netlify.com).

## Local setup:

1. Clone this repository
2. Install [Bundler](http://bundler.io) and [Node](https://nodejs.org/en/) and [Yarn](http://yarnpkg.com) if you don't already have them.
3. Run `bundle install` and `yarn install` in the command line
4. All set!

## Development:

- Run `bundle exec middleman` to start a local Middleman server; site will be available at `http://localhost:4567` in your browser. You can see the sitemap and config at `http://localhost:4567/__middleman`.
- `bundle exec middleman build` will compile the site to the `/build` folder.

## Deploy:

- Get your pull request reviewed and merge it into the `master` branch.
- The site will automatically build and go live on the host (Netlify) when the PR is merged via Git hook. Branch "previews" are available for PRs.
- To manually build: run `bundle exec middleman build`; this will build the site. This will build the site, compile assets (CSS, JS), and run linters.

## Test:

- `yarn test` will run linters.
