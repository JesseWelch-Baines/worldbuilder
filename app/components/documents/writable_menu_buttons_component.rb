class Documents::WritableMenuButtonsComponent < ViewComponent::Base
  def initialize(order:)
    @order = order
  end
end