require 'fileutils'


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
