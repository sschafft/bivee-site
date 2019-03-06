# Bivee's website
http://bivee.co

## Adding content

### People

This applies to staff and consultants.

Create a markdown file (`*.html.md`) in either the `staff` or `consultants` folders in `source/people`. The folder the file lives in will determine where it appears on the site.

Next, add the following metadata:

````yml
---
name:
job_title:
portrait:
  thumb:
  full_size:
interests:
---
````

`name` is their full name.

`job_title` is optional, and should only be added for staff.

The `portrait` field contains the paths to the photos of this person we want to display, in small (`thumb`) and larger (`full_size`) versions. You can add either a single string (e.g. `/people/staff/assets/helly.jpg`) or [metadata for a responsive image](#about-responsive-images). Note that paths to the portrait image should be absolute (not relative to the markdown file), since the images will be displayed in many places on the site.

`interests` is a list of this person's skills and expertise, which we use to describe and sort our staff and partner listings on the site. Try to use the same words as other people files where possible.

After the metadata, add their bio in regular markdown format.

### Partners

"Partner" content is the same as "people", but has slightly different metadata. Since partners are companies, we display a logo instead of a portrait and a website instead of a job title.

Create a markdown file (`*.html.md`) in the `source/people/partners` folder, and add the following metadata:

````yml
---
name:
website:
logo:
  thumb:
  full_size:
expertise:
---
````

`name` is the company name. Err on the informal side. If a company is usually referred to as "Evie's Diner" but their formal name is "Evelyn's Eateries, Inc. Ltd.", go with the former.

`website` is the company's website. Use the url of their homepage, and include the `http[s]://` prefix.

`logo` works the same as `portrait` for people, with `thumb` and `full_size` versions that accept either single path or [responsive image](#about-responsive-images) values.

Finally, `expertise` is a list of that company's specialities and capabilities. Try to stick with words that are relevant to their relationship with Bivee (e.g. if they shot photos for us, use `photography`), and use the same words as other partner files where possible, as these are used like tags to categorize listings.

### Projects

### About responsive images

We use ["responsive" images](https://developer.mozilla.org/en-US/docs/Learn/HTML/Multimedia_and_embedding/Responsive_images) wherever possible on the site to reduce load times and ensure that content scales appropriately to any screen size. Our site uses a lot of imagery and textures, so it's important to reduce download sizes wherever we possibly can to keep pages loading fast.

As a convention, we create scaled versions of images and add a suffix to the filename to describe its width. For example, `photo@480w.jpg` is how we'd name an image version that is 480 pixels wide (and therefore sized for phones and small screens). We'd then save all versions of this image to the same location.

In our content files and metadata, we use a simple set of fields to describe an image location and the size variations available:

````yml
full_size:
  source: '/people/staff/assets/helly@{size}w.jpg'
  sizes: [400, 800, 1200, 1600]
````

In this case, we have a portrait of Helly available in four widths. The `source` field is the location of the image files, and the `sizes` field is a list (array) of the sizes available.

Instead of writing out all four image paths under `source`, we just use a placeholder, `{size}` to indicate where the image size appears in the filename. The templates will then swap in each value from `sizes` and generate the correct HTML5 `srcset` markup. The above metadata, for instance, would be output as:

````html
<img src="/people/staff/assets/helly@400w.jpg" srcset="/people/staff/assets/helly@800w.jpg 800w, /people/staff/assets/helly@1200w.jpg 1200w, /people/staff/assets/helly@1600w.jpg 1600w" alt="Helly Stoyanova">
````

And the browser will load the appropriate size, as needed, depending on screen size, window size, and resolution.

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
