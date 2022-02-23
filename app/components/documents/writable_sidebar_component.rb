class Documents::WritableSidebarComponent < ViewComponent::Base
  def initialize(writable_instance:, document:)
    @writable_instance = writable_instance
    @document = document
  end
end