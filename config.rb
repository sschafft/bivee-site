###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Set up the blog extension
###

activate :blog do |blog|
    blog.name = "work"
    blog.prefix = "work"
    blog.sources = "{year}/{title}.html"
    blog.permalink = "{year}/{title}.html"
    blog.summary_separator = /EXCERPT/
    blog.layout = "case_study"
end

activate :blog do |blog|
    blog.name = "writing"
    blog.prefix = "writing"
    blog.sources = "{year}-{month}-{day}-{title}.html"
    blog.permalink = "{year}/{month}/{title}.html"
    blog.taglink = "tags/{tag}.html"
    blog.summary_separator = /EXCERPT/
    blog.layout = "article"
end

activate :directory_indexes
page "404.html", :directory_index => false

###
# Helpers
###

# Use relative URLs
activate :relative_assets

# autoprefix CSS
activate :autoprefixer do |config|
    config.browsers = ['last 2 versions', 'Explorer >= 8']
end

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
  set :no_swf, true
end

# Methods defined in the helpers block are available in templates
helpers do
    # shortcut to reference global partials folder
    def render_partial partial_name, locals={}
        partial "layouts/partials/#{partial_name}", locals: locals
    end
end

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'
set :fonts_dir, 'assets/fonts'

set :sass_assets_paths, [File.join(root, 'node_modules')]

# files.watch :source, path: File.expand_path('node_modules', app.root)

# activate: External_pipeline,
#    name: browserify,
#    command: "cd test-App / && ember # {build?? : build  :  : serve } --Environment # {config [ : environment ]} ",
#    source: "test-App / dist ",
#    latency: 2

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
