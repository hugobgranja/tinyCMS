module HomeHelper

  def item_name(m)
    if m.item_type == 'Page'
      @pages_by_id[m.item_id].name
    else
      @links_by_id[m.item_id].name
    end
  end

  def page_in_menu?(menu, item_id)
    menu.any? { |i| i.item_id == item_id && i.item_type == 'Page' }
  end

  def link_in_menu?(menu, item_id)
    menu.any? { |i| i.item_id == item_id && i.item_type == 'Link' }
  end

end