require 'haml/html'

namespace :hamlify do
  desc "Convert html to haml"
  task :convert => :environment do

    #   Searches through the views folder for erb files
    Dir["#{Rails.root}/app/views/**/*.erb"].each do |file_name|

      #   Creates a new file path for the haml to be exported to
      haml_file_name = file_name.gsub( /erb$/, 'haml' )

      #   if the haml is missing, create it and get rid of the erb file.
      if ! File.exists? haml_file_name

        puts "Hamlifying: #{file_name} -> #{haml_file_name}"

        #   Reads erb from the file
        erb_string = File.open( file_name ).read

        #   Converts erb to haml
        haml_string = Haml::HTML.new( erb_string, :erb => true ).render

        #   Write the haml
        file = File.new haml_file_name, 'w'
        file.write haml_string

        #   Get rid of the erb
        File.delete file_name
      end
    end
  end
end
