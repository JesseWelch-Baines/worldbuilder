module ListItemsHelper
  def item_list_links(item)
    case item.class.to_s
    when "Document"
      {
        show_path: polymorphic_url([item]),
        edit_path: edit_polymorphic_url(item),
      }
    when "Article"
      {
        show_path: polymorphic_url([item.category, item]),
        edit_path: polymorphic_url([item.category, item]) + "/edit",
      }
    when "World"
      {
        show_path: polymorphic_url(item),
        change_to_path: set_current_world_path(world_id: item, callback: root_path),
        edit_path: edit_polymorphic_url(item),
      }
    else
      {}
    end
  end
end
