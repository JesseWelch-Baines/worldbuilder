class Documents::ParagraphFieldComponent < ViewComponent::Base
  def initialize(form:, article_instance_id:)
    @form = form
    @article_instance_id = article_instance_id
  end
end
