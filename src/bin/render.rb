require 'erb'

require_relative '../../lib/pages/pages.rb'


def main
  main_erb = MainHtml.new
  about_erb = Page.new('src/views/html/about.html.erb')

  composer = Composer.new(outer: main_erb, inner: about_erb)

  puts composer.render
end


main if __FILE__ == $0
