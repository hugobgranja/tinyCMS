class Admin::HomeController < Admin::AdminController

  def index
    @pages = Page.all.order(:id)
    @links = Link.all.order(:id)

    @pages_by_id = @pages.index_by(&:id)
    @links_by_id = @links.index_by(&:id)

    @menu = MenuItem.all.order(:order)
  end

  def menu_update
    MenuItem.delete_all

    menuItems = params[:menu].split(', ')

    menuItems.each_with_index do |m,i|
      item = m.split(' ')

      if item[0] == 'Page'
        MenuItem.create(order: i, item_id: item[1], item_type: item[0])
      elsif item[0] == 'Link'
        MenuItem.create(order: i, item_id: item[1], item_type: item[0])
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def set_home
    Setting.home = params[:id]
    @id = params[:id]

    respond_to do |format|
      format.js
    end
  end

  def set_settings
    if Setting.site_name != params[:site_name]
      Setting.site_name = params[:site_name]
    end

    if Setting.meta_description != params[:meta_description]
      Setting.meta_description = params[:meta_description]
    end

    if Setting.meta_keywords != params[:meta_keywords]
      Setting.meta_keywords = params[:meta_keywords]
    end

    respond_to do |format|
      format.js
    end
  end

end