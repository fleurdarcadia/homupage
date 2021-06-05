require 'erb'


class Page
  MAIN_ERB = 'src/views/main.erb'

  attr_reader :src, :stylesheets, :scripts

  def initialize(src, stylesheets: [], scripts: [])
    @src = src
    @stylesheets = stylesheets
    @scripts = scripts
    @content = nil
  end

  def load
    @content = File.read(@src)
    self
  end

  def render
    container = ERB.new(File.read(MAIN_ERB))

    container.result(binding)
  end
end


def main
  test_page = Page.new('src/views/test.html')
  puts test_page.load.render
end


main if __FILE__ == $0
