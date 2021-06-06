require 'erb'

require_relative '../../lib/pages/page.rb'
require_relative '../../lib/pages/composer.rb'


MAIN_ERB = 'src/views/main.erb'

def main
  main_erb = Page.new('src/views/main.erb')
  test_erb = Page.new('src/views/test.html')

  composer = Composer.new(outer: main_erb, inner: test_erb)

  puts composer.render
end


main if __FILE__ == $0
