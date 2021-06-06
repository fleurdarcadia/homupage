class Page
  attr_reader :src
  attr_accessor :content

  def initialize(src, content: '')
    @src = src
    @content = content
  end

  def render
    container = ERB.new(File.read(@src))

    container.result(binding)
  end
end
