class Documents::ArticleMenuButtonsComponent < ViewComponent::Base
  def initialize(order:)
    @order = order
  end
end
