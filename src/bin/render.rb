require 'erb'

require_relative '../../lib/authoring/authoring.rb'
require_relative '../../lib/pages/pages.rb'


DIST_DIR = 'dist'
BASE_HTML_DIR = 'src/views/html'
ERB_REGEX = /.*\.erb/

def main
  main_erb = MainHtml.new

  directories = DirWalker.new(BASE_HTML_DIR, ERB_REGEX)

  directories.walk do |file|
    out_file = file
      .sub(BASE_HTML_DIR, "")
      .sub(".erb", "")

    puts "Rendering #{file} to #{out_file}"

    page = Page.new(file)
    composer = Composer.new(outer: main_erb, inner: page)

    writer = Writer.new(File::join(DIST_DIR, out_file))

    writer.write(composer.render)
  end
end


main if __FILE__ == $0
