###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# General configuration

config[:images_dir] = 'assets/images'
config[:fonts_dir] = 'assets/fonts'
config[:css_dir] = 'assets/dist/stylesheets'
config[:js_dir] = 'assets/dist/javascripts'

# # ignore css and js, b/c we're handling with external pipeline
ignore 'assets/stylesheets/*'
ignore 'assets/javascripts/*'

# explicitly set the markdown engine to Kramdown
set :markdown_engine, :kramdown

###
# Middleman Deployment
###

activate :deploy do |deploy|
  deploy.deploy_method = :git
  # Optional Settings
  # deploy.remote   = 'custom-remote' # remote name or git url, default: origin
  deploy.branch   = 'master' # default: gh-pages
  # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
  deploy.commit_message = 'Deployed to master'      # commit message (can be empty), default: Automated commit at `timestamp` by middleman-deploy `version`
end


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

# Generate proxy pages from the blog articles' "chapter" frontmatter
# data.chapters.each do |chapter|
#     proxy "#{chapter.urlize}/index.html", "/chapter.html", :locals => {
#         title: chapter
#     }, :ignore => true
# end

# activate :directory_indexes
# page "README.md", :directory_index => false
# page "LICENSE", :directory_index => false
# page "404.html", :directory_index => false

activate :relative_assets

# Reload the browser automatically whenever files change
configure :development do
    activate :external_pipeline,
        name: :npm,
        command: 'npm start',
        source: "source/assets/dist",
        latency: 1

    activate :livereload
end


# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
