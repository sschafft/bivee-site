###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
page '/staff/*', :layout => 'staff_profile'

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

###
# General config
###

config[:css_dir] = 'assets/stylesheets'
config[:js_dir] = 'assets/javascripts'
config[:images_dir] = 'assets/images'
config[:fonts_dir] = 'assets/fonts'

set :sass_assets_paths, ['source/assets/stylesheets', File.join(root, 'node_modules')]

# Add Webpack bundles to the sitemap/assets
activate :external_pipeline,
  name: :webpack,
  command: build? ? 'npm run javascripts:deploy' : 'npm run javascripts:dev',
  source: ".tmp/dist",
  latency: 1

activate :directory_indexes
page "404.html", :directory_index => false

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
    # "Component" decorator for partial function
    # -> just used to point automatically to "components" dir so you don't have to type the full path
    def component(name, opts = {}, &block)
        partial("components/#{name}", opts, &block)
    end

    # is this url the current page?
    def current_page?(url)
        if current_resource.path == url
            return true
        end
    end

    # is this url in the current directory (in the sitemap)?
    def current_dir?(url)
        if current_page.url.include? url.gsub(settings.url_root,'').gsub(".html", "/").to_s
            return true
        end
    end
end

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
