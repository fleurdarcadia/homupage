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
