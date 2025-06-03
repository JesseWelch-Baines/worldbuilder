# data manipulation methods for global use
module Utilities
  require "action_view"

  def random_except(array, exception)
    if array.include?(exception)
      array.reject { |v| v == exception }.sample
    else
      array.sample
    end
  end

  def sanitise_attachments(trix_html)
    trix_html.gsub("<figure*/figure>") { |attachment| attachment_text(attachment) }
    Rails.logger.info(CGI.unescapeHTML(JSON.parse("{#{trix_html.scan(/{([^}]*)}/).first.last}}")["content"]))

    trix_html
  end

  def attachment_text(attachment)
    ActionView::Base.full_sanitizer.sanitize(CGI.unescapeHTML(JSON.parse(attachment)["content"]))
  end
end
