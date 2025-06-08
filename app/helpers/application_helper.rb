module ApplicationHelper
  def polymorphic_show(record)
    record.respond_to?(:category) ? polymorphic_url([record.category, record]) : polymorphic_url(record)
  end

  def article_colour(article)
    case article.class.to_s
    when "Document", "Paragraph"
      "#404040"
    when "Article"
      article.category.colour || "#404040"
    else
      "#404040"
    end
  end
end
