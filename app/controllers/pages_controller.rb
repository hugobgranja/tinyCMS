class PagesController < ApplicationController

  def show
    @menu = MenuItem.includes(:item).all
    @page = Page.find_by(id: params[:id])

    @page = Page.find_by(id: Setting.home) unless @page

    redirect_to not_found_path unless @page
  end

end