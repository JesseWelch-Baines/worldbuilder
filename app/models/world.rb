class World < ApplicationRecord
  belongs_to :user
  has_many :paragraphs, dependent: :destroy
  has_many :characters, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :writable_fields

  attr_accessor :gen_type, :gen_size

  validates_presence_of :name
  validates :name, uniqueness: { scope: :user_id }

  def insert_writable_field(model, field_id, order)
    writable_fields.select { |wf| wf.model == model && wf.order >= order.to_i }.each do |writable_field|
      next if writable_field.id == field_id

      writable_field.update(order: writable_field.order + 1)
    end
  end

  def move_writable_field(writable_field, direction)
    writable_field.update(order: writable_field.order + direction)

    writable_fields.select { |wf| wf.model == writable_field.model && wf.order == writable_field.order.to_i && wf.id != writable_field.id }.each do |other_field|
      other_field.update(order: other_field.order - direction)
    end
  end

  def generate_writable_list(model)
    pdf = Prawn::Document.new do
      text(model.capitalize, align: :center)
      move_down 30
    end

    association(model).scope.each do |record|
      pdf.formatted_text([{ text: record.name, style: [:bold] }])
      pdf.text(record.description.to_trix_html)
      pdf.move_down 20
    end

    pdf.render
  end

end
