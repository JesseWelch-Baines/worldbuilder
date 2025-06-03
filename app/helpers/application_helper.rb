module ApplicationHelper
  def polymorphic_show(record)
    record.respond_to?(:category) ? polymorphic_url([record.category, record]) : polymorphic_url(record)
  end
end
