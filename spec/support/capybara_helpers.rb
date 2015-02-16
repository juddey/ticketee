module CapybaraHelpers
  def list_item(content)
    find("ul:not(.actions) li", text: content)
  end

  def tag(name)
    find("div.tag", text: name)
  end
end

RSpec.configure do |c|
  c.include CapybaraHelpers, type: :feature
end
