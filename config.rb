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
config[:css_dir] = 'assets/dist/stylesheets'
config[:js_dir] = 'assets/dist/javascripts'

# # ignore css and js, b/c we're handling with external pipeline
ignore 'assets/stylesheets/*'
ignore 'assets/javascripts/*'

# explicitly set the markdown engine to Kramdown
set :markdown_engine, :kramdown

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

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

###
# Middleman Deployment
###

# @scott TODO update deploy settings for new repository branch
activate :deploy do |deploy|
  deploy.deploy_method = :git
  # Optional Settings
  deploy.build_before = true # default: false
  deploy.remote   = 'git@github.com:biveeco/biveeco.github.io.git' # remote name or git url, default: origin
  deploy.branch   = 'master' # default: gh-pages
  deploy.commit_message = 'Deployed to master'      # commit message (can be empty), default: Automated commit at `timestamp` by middleman-deploy `version`
  # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
end

###
# Set up the blog extension
###

# activate :blog do |blog|
#     blog.name = "work"
#     blog.prefix = "work"
#     blog.sources = "{year}/{title}.html"
#     blog.permalink = "{year}/{title}.html"
#     blog.summary_separator = /EXCERPT/
#     blog.layout = "case_study"
# end

# activate :blog do |blog|
#     blog.name = "writing"
#     blog.prefix = "writing"
#     blog.sources = "{year}-{month}-{day}-{title}.html"
#     blog.permalink = "{year}/{month}/{title}.html"
#     blog.taglink = "tags/{tag}.html"
#     blog.summary_separator = /EXCERPT/
#     blog.layout = "article"
# end

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
  activate :external_pipeline,
    name: :yarn,
    command: build? ? 'yarn run build' : 'yarn run dev',
    source: "source/assets/dist",
    latency: 1
  activate :livereload
end


# Build-specific configuration
configure :build do
  config[:host] = "https://www.bivee.co"
  # For example, change the Compass output style for deployment
  # activate :minify_css

  if ENV["CONTEXT"] == "staging"
    activate :robots, 
      rules: [
        { user_agent: '*', disallow: %w[/] }
      ]
  else
    activate :robots, 
      rules: [
        { user_agent: '*', allow: %w[/] }
      ],
      sitemap: 'https://www.bivee.co/sitemap.xml'
  end

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
