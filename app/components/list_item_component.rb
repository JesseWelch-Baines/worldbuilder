class ListItemComponent < ViewComponent::Base
  def initialize(item:, index:, count:, links:)
    @item = item
    @index = index
    @count = count
    @links = links
  end
end
