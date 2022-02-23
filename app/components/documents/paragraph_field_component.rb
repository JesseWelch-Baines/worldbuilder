class Documents::ParagraphFieldComponent < ViewComponent::Base
  def initialize(form:, writable_instance_id:)
    @form = form
    @writable_instance_id = writable_instance_id
  end
end