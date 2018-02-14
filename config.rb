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
data.case_studies.each do |project|
  proxy "work/#{project.slug.urlize}/index.html", '/project.html', locals: {
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

  # is this url the current page?
  def current_page?(url)
    return true if current_resource.path == url
  end

  # is this url in the current directory (in the sitemap)?
  def current_dir?(url)
    current_dir = url.gsub(settings.url_root, '').gsub('.html', '/').to_s
    return true if current_page.url.include? current_dir
  end

  def find_all_staff
    sitemap.resources.select do |r|
      r.path.include?('staff') unless r.data.name == exclude
    end
  end

  def find_staff(names)
    names.collect do |name|
      sitemap.resources.select do |r|
        r.path.include?('staff') if r.data.name == name
      end[0]
    end
  end

  # return a list of site resouces for staff from a list of names
  # @param names ARRAY or STRING (optional): the names of the staff you need.
  #        use 'all' to get everybody.
  # @param exclude ARRAY (optional): the names of staff you want to exclude.
  #        use only when names is 'all'.
  def find_staff_profiles(names: 'all')
    if names == 'all'
      return find_all_staff.sort_by do |r|
        r.data.tribal_dominance
      end
    end
    find_staff(names).sort_by do |r|
      r.data.tribal_dominance
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
  config[:host] = 'http://www.bivee.co'
  activate :minify_css
  activate :minify_html

  # Enable cache buster
  activate :asset_hash

  # autoprefix CSS for older browsers
  activate :autoprefixer do |config|
    config.browsers = ['last 2 versions', 'Explorer >= 9']
  end

  # Or use a different image path
  # set :http_prefix, '/Content/images/'
end
