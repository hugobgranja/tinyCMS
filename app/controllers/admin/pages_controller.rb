class Admin::PagesController < Admin::AdminController

  def create
    @page = Page.create(page_params)

    respond_to do |format|
      format.js
    end
  end

  def update
    @page = Page.find(params[:id])
    @name_changed = @page.name != params[:page][:name]
    @updated = @page.update(page_params)

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @page = Page.find(params[:id])
    
    @page.destroy

    respond_to do |format|
      format.js
    end
  end

  def not_found
  end

  private

  def page_params
    params.require(:page).permit(:name, :content)
  end

end