class Writer
  attr_reader :out_file

  def initialize(out_file)
    @out_file = out_file
  end

  def write(content)
    File.open(@out_file, File::CREAT | File::WRONLY) { |f| f.write(content) }
  end
end
