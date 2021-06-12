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
