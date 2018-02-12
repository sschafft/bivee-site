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

# # ignore js, b/c we're handling with external pipeline
ignore 'assets/javascripts/*'

activate :external_pipeline,
  name: :yarn,
  command: build? ? 'yarn run build' : 'yarn run dev',
  source: ".tmp/dist",
  latency: 1

# explicitly set the markdown engine to Kramdown
set :markdown_engine, :kramdown

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
data.case_studies.each_with_index do |project, index|
  proxy "work/#{project.slug.urlize}/index.html", "/project.html", locals: {
    title: project.title,
    slug: project.slug,
    date: project.date,
    type: project.type,
    cover: project.cover,
    team: project.team
  }, ignore: true
end

# Helpers
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

  # return a list of site resouces for staff from a list of names
  # @param names ARRAY or STRING (optional): the names of the staff you need. use "all" to get everybody.
  # @param exclude ARRAY (optional): the names of staff you want to exclude. use only when names is "all".
  def get_staff_profiles(names: "all", exclude: false)
    if names == "all"
      return sitemap.resources.select {|r| r.path.include?("staff") unless r.data.name == exclude }.sort_by {|r| r.data.tribal_dominance }
    else
      return names.collect {|name| sitemap.resources.select {|r| r.path.include?("staff") if r.data.name == name }[0] }.sort_by {|r| r.data.tribal_dominance }
    end
  end

end

activate :directory_indexes
page "README.md", :directory_index => false
page "LICENSE", :directory_index => false
page "404.html", :directory_index => false

activate :relative_assets

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload,
    livereload_css_target: "stylesheets/main.css"
end


# Build-specific configuration
configure :build do
  config[:host] = "http://www.bivee.co"
  # For example, change the Compass output style for deployment
  activate :minify_css
  # activate :imageoptim

  # Enable cache buster
  activate :asset_hash

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
