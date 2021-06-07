require 'erb'

require_relative '../../lib/authoring/authoring.rb'
require_relative '../../lib/pages/pages.rb'


def main
  main_erb = MainHtml.new
  about_erb = Page.new('src/views/html/about.html.erb')

  composer = Composer.new(outer: main_erb, inner: about_erb)

  writer = Writer.new('./about.html')

  puts composer.render

  directories = DirWalker.new('src')

  directories.walk do |file|
    puts "Found file #{file}"
  end
end


main if __FILE__ == $0
