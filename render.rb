require 'erb'
require 'fileutils'


DIST_DIR = 'dist'
BASE_HTML_DIR = 'src/views/html'
ERB_REGEX = /.*\.erb/

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

class MainHtml < Page
  MAIN_ERB = 'src/views/main.html.erb'

  def initialize(content: '', stylesheets: [], scripts: [])
    @content = content
    @stylesheets = stylesheets
    @scripts = scripts

    super(MAIN_ERB)
  end
end

class Composer
  attr_reader :outer, :inner

  def initialize(outer:, inner:)
    @outer = outer
    @inner = inner
  end

  def render
    outer.content = inner.render

    outer.render
  end
end

class Writer
  attr_reader :out_file

  def initialize(out_file)
    @out_file = out_file
  end

  def write(content)
    path, name = File::split(@out_file)
    
    FileUtils.mkdir_p(path)
    File.open(@out_file, File::CREAT | File::WRONLY) { |f| f.write(content) }
  end
end


class DirWalker
  attr_reader :base_dir

  def initialize(base_dir, pattern = /.*/, max_recursion_depth: Float::INFINITY)
    @base_dir = base_dir
    @pattern = pattern
    @max_recursion_depth = max_recursion_depth
  end

  def walk(&block)
    recursively_yield_files(@base_dir, &block)
  end

  private

  def recursively_yield_files(directory, current_depth = 0, &block)
    return if current_depth >= @max_recursion_depth

    Dir.each_child(directory) do |child|
      path = File::join(directory, child)

      matches_pattern = !@pattern.match(path).nil?

      if File::file?(path) && matches_pattern
        block.call(path)
      elsif File::directory?(path)
        recursively_yield_files(path, current_depth + 1, &block)
      end
    end
  end
end


def main
  main_erb = MainHtml.new

  directories = DirWalker.new(BASE_HTML_DIR, ERB_REGEX)

  directories.walk do |file|
    out_file = File::join(
      DIST_DIR,
      file
        .sub(BASE_HTML_DIR, "")
        .sub(".erb", "")
    )

    puts "Rendering #{file} to #{out_file}"

    page = Page.new(file)
    composer = Composer.new(outer: main_erb, inner: page)

    writer = Writer.new(out_file)

    writer.write(composer.render)
  end
end


main if __FILE__ == $0
