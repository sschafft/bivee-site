# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.4.3'

# Middleman
gem 'middleman', '> 4.0'

# Middleman extensions
gem 'middleman-autoprefixer'
gem 'middleman-google-analytics'
gem 'middleman-livereload'
gem 'middleman-minify-html'

# Robots txt
gem 'middleman-robots'

# Specify newer version of these gems per Github security warnings
gem 'ffi', '>= 1.9.24'
gem 'rack', '>= 2.0.6'

# Content/asset compilers
gem 'kramdown' # markdown engine
gem 'rake' # required for SassC (below)
gem 'sassc' # use faster LibSass engine

# Ruby/rails utilities
gem 'string-urlize'
gem 'titleize'

# Rubocop for linting
gem 'rubocop', '~> 0.52.1', require: false

# For faster file watcher updates on Windows:
gem 'wdm', '~> 0.1.0', platforms: %i[mswin mingw]

# Windows does not come with time zone data
gem 'tzinfo-data', platforms: %i[mswin mingw jruby]
