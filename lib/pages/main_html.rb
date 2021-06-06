require_relative './page.rb'

class MainHtml < Page
  MAIN_ERB = 'src/views/main.html.erb'

  def initialize(content: '', stylesheets: [], scripts: [])
    @content = content
    @stylesheets = stylesheets
    @scripts = scripts

    super(MAIN_ERB)
  end

  def render
    super
  end
end
