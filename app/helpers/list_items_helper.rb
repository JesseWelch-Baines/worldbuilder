module ListItemsHelper

  def item_list_links(item)
    links = {}

    case item.class.to_s
    when 'WritableField'
      links.merge!(
        move_up_path: move_up_writable_field_path(item),
        move_down_path: move_down_writable_field_path(item)
      )
    when 'World'
      links.merge!(
        change_to_path: change_to_world_path(item, callback: root_path)
      )
    end

    links
  end

end
