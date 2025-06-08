class Form::RichTextFieldComponent < ViewComponent::Base
  def initialize(form:, field_name:)
    @f = form
    @field_name = field_name
  end
end
