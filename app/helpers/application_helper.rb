module ApplicationHelper
  def polymorphic_show(record)
    record.respond_to?(:category) ? polymorphic_url([record.category, record]) : polymorphic_url(record)
  end

  def article_colour(article)
    case article.class.to_s
    when "Document", "Paragraph"
      article.colour || "black"
    when "Article"
      article.category.colour || "black"
    else
      "black"
    end
  end
end
