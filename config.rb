# frozen_string_literal: true

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

page '/staff/*', layout: 'staff_profile'

# General configuration

config[:images_dir] = 'assets/images'
config[:fonts_dir] = 'assets/fonts'
config[:css_dir] = 'assets/stylesheets'

config[:sass_assets_paths] = ['node_modules']

# # ignore js, b/c we're handling with external pipeline
ignore 'assets/javascripts/*'

activate :external_pipeline,
         name: :yarn,
         command: build? ? 'yarn run build' : 'yarn run dev',
         source: '.tmp/dist',
         latency: 1

# explicitly set the markdown engine to Kramdown
config[:markdown_engine] = :kramdown

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
data.case_studies.projects.each do |project|
  proxy "work/#{project.slug.urlize}/index.html", '/case_study.html', locals: {
    title: project.title,
    slug: project.slug,
    date: project.date,
    type: project.type,
    cover: project.cover,
    team: project.team
  }, ignore: true
end

# Helpers
# rubocop:disable Metrics/BlockLength
helpers do
  # 'Component' decorator for partial function
  # -> just used to point automatically to 'components' dir so you don't have
  #    to type the full path
  def component(name, opts = {}, &block)
    partial("components/#{name}", opts, &block)
  end

  def class_list(classes)
    return " class='#{classes.is_a?(String) ? classes : classes.join(' ')}'" unless classes.empty?
  end

  def props_list(props)
    return "='#{props.is_a?(String) ? props : props.join(' ')}'" unless props.empty?
  end

  # figure out the utility padding classes to use
  # arguments:
  # STRING/HASH values (required): size of padding
  # -> Pass in a string to apply the same padding to all sides, e.g. 'wide'
  # -> Pass in a hash to apply padding to each side, e.g. { top: 'narrow' }.
  #    Any sides you leave out will have no padding.
  def padding_classes(values)
    if values.is_a?(String)
      "padding-#{values}" unless values == 'none'
    else
      values.collect do |side, width|
        width == 'medium' ? "padding-#{side}" : "padding-#{side}-#{width}"
      end.join(' ')
    end
  end

  # figure out the utility border classes to use
  # arguments:
  # ARRAY list (required): a list of the sides that should get borders
  # rubocop:disable Metrics/LineLength
  # rubocop is being annoying about guard statements vs. if statements here
  def border_classes(sides)
    return 'border' if sides == 'all'
    return sides.collect { |side| "border-#{side}" }.join(' ') if sides.respond_to?(:collect)
  end
  # rubocop:enable Metrics/LineLength

  # is this url the current page?
  def current_page?(url)
    return true if current_resource.path == url
  end

  # is this url in the current directory (in the sitemap)?
  def current_dir?(url)
    current_dir = url.gsub(settings.url_root, '').gsub('.html', '/').to_s
    return true if current_page.url.include? current_dir
  end

  # return a list of site resouces for staff from a list of names
  # arguments:
  # ARRAY exclude (optional): the names of staff you want to exclude.
  def find_staff_profiles(exclude: [])
    profiles = sitemap.resources.select do |r|
      r.path.include?('staff') unless exclude.include?(r.data.name)
    end
    profiles.sort_by do |r|
      # order alphbetically by last name
      # -> use split to find the last word in the string
      r.data.name.split(' ').last
    end
  end
end
# rubocop:enable Metrics/BlockLength

activate :directory_indexes
page 'README.md', directory_index: false
page 'LICENSE', directory_index: false
page '404.html', directory_index: false

activate :relative_assets

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload,
           livereload_css_target: 'assets/stylesheets/main.css'
end

# Build-specific configuration
configure :build do
  config[:host] = 'https://www.bivee.co'
  activate :minify_css
  activate :minify_html

  if ENV['CONTEXT'] == 'production'
    activate :robots,
             rules: [
               { user_agent: '*', allow: %w[/] }
             ],
             sitemap: 'https://www.bivee.co/sitemap.xml'
  else
    activate :robots,
             rules: [
               { user_agent: '*', disallow: %w[/] }
             ]
  end

  # Enable cache buster
  activate :asset_hash

  # autoprefix CSS for older browsers
  activate :autoprefixer do |config|
    config.browsers = ['last 2 versions', 'Explorer >= 9']
  end

  # Or use a different image path
  # set :http_prefix, '/Content/images/'
end
