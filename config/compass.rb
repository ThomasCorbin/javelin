# This configuration file works with both the Compass command line tool and within Rails.
# Require any additional compass plugins here.
require 'fancy-buttons'


#   I'm not sure why I had to add this, but now I do. Weird.
require 'sass/plugin'

project_type = :rails
project_path = Compass::AppIntegration::Rails.root
# Set this to the root of your project when deployed:
http_path = "/"
#css_dir = "public/stylesheets/compiled"
css_dir = "public/stylesheets/compiled"
sass_dir = "app/stylesheets"
environment = Compass::AppIntegration::Rails.env
# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true

Sass::Plugin.options[:never_update] = true
