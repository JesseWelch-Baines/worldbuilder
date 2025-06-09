class NewListItemComponent < ViewComponent::Base
  def initialize(path:, data: {})
    @path = path
    @data = data
  end
end
