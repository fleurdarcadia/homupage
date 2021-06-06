class Page
  attr_reader :src, :stylesheets, :scripts
  attr_accessor :content

  def initialize(src, content: '', stylesheets: [], scripts: [])
    @stylesheets = stylesheets
    @scripts = scripts
    @content = content
    @src = src
  end

  def render
    container = ERB.new(File.read(@src))

    container.result(binding)
  end
end
