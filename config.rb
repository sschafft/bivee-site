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

page '/people/staff/*', layout: 'profile'
page '/people/consultants/*', layout: 'profile'
page '/people/partners/*', layout: 'partner'

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
         source: '.tmp/assets/',
         latency: 1

# explicitly set the markdown engine to Kramdown
config[:markdown_engine] = :kramdown

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
data.work.projects.each do |project|
  proxy "work/#{project.slug.urlize}/index.html", '/project.html', locals: {
    project: project
  }, ignore: true
end

# Helpers
# rubocop:disable Metrics/BlockLength
helpers do
  # render markdown from an any string
  # https://stackoverflow.com/questions/43926754/how-to-output-data-from-yaml-variables-written-in-markdown-into-an-html-haml-f#44014190
  def render_markdown(content)
    Kramdown::Document.new(content).to_html
  end

  # 'Component' decorator for partial function
  # -> just used to point automatically to 'components' dir so you don't have
  #    to type the full path
  def component(name, opts = {}, &block)
    partial("components/#{name}", opts, &block)
  end

  def class_list(classes)
    list = classes.is_a?(String) ? classes : classes.join(' ').rstrip
    return " class='#{list}'" unless list.empty?
  end

  def props_list(props)
    list = props.is_a?(String) ? props : props.join(' ').rstrip
    return "='#{list}'" unless list.empty?
  end

  # figure out the utility padding classes to use
  # arguments:
  # STRING/HASH values (required): size of padding
  # -> Pass in a string to apply the same padding to all sides, e.g. 'wide'
  # -> Pass in a hash to apply padding to each side, e.g. { top: 'narrow' }.
  #    Any sides you leave out will have no padding.
  # -> we need all this logic in this method, doesn't make sense to split it up
  # rubocop:disable Metrics/MethodLength
  def padding_classes(values)
    if values.is_a?(String)
      case values
      when 'none'
        'no-padding'
      when 'medium'
        'padding'
      else
        "padding-#{values}"
      end
    else
      values.collect do |side, width|
        case width
        when 'none'
          "no-padding-#{side}"
        when 'medium'
          "padding-#{side}"
        else
          "padding-#{side}-#{width}"
        end
      end.join(' ').rstrip
    end
  end
  # rubocop:enable Metrics/MethodLength

  # figure out the utility border classes to use
  # arguments:
  # ARRAY list (required): a list of the sides that should get borders
  def border_classes(sides, class_prefix = 'border')
    if sides.is_a?(String)
      return '' if sides == 'none'
      return class_prefix if sides == 'all'
      "#{class_prefix}-#{sides}"
    else
      sides.collect do |side|
        "#{class_prefix}-#{side}"
      end.join(' ').rstrip
    end
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

  # return a list of site resouces for staff from a list of names
  # arguments:
  # ARRAY exclude (optional): the names of staff you want to exclude.
  def find_people(group: 'staff', exclude: [])
    profiles = sitemap.resources.select do |resource|
      resource.path.include?(group) unless exclude.include?(resource.data.name)
    end
    # clear out the assets folder from the selection
    # -> so we don't accidentally include pictures, logos, etc.
    profiles.reject do |r|
      r.path.include?('assets')
    end
  end

  def order_by_last_name(resources)
    resources.sort_by do |r|
      r.data.name.split(' ').last
    end
  end

  def order_by_name(resources)
    resources.sort_by do |r|
      r.data.name
    end
  end

  # convert staff portrait frontmatter data to the string or hash
  # needed by the 'responsive_image' component
  # -> expects this data format:
  #    A) [frontmatter value]: scott.jpg
  #    - or -
  #    B) [frontmatter value]:
  #         - source: scott@480.jpg
  #           width: 480
  def portrait_source(source, path: 'assets/images/portraits/')
    return "#{path}#{source}" if source.is_a?(String)

    source.map do |portrait|
      [portrait.width, "#{path}#{portrait.source}"]
    end.to_h
  end
end
# rubocop:enable Metrics/BlockLength

activate :directory_indexes
page 'README.md', directory_index: false
page 'LICENSE', directory_index: false
page '404.html', directory_index: false

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
