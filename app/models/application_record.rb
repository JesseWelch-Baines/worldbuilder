class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  self.implicit_order_column = 'created_at'

  def class_name
    self.class.to_s.downcase
  end

  def color
    case self.class.to_s
    when 'Paragraph'
      'text-gray-600'
    when 'Character'
      'text-pink-600'
    when 'Location'
      'text-blue-600'
    when 'Item'
      'text-purple-600'
    when 'Event'
      'text-yellow-500'
    when 'Document'
      'text-green-600'
    else
      'text-gray-700'
    end
  end
end
