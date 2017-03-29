class Admin::LinksController < Admin::AdminController

  def create
    @link = Link.create(link_params)

    respond_to do |format|
      format.js
    end
  end

  def update
    @link = Link.find(params[:id])
    @name_changed = @link.name != params[:link][:name]
    @updated = @link.update(link_params)

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @link = Link.find(params[:id])
    
    @link.destroy

    respond_to do |format|
      format.js
    end
  end

  private
  
  def link_params
    params.require(:link).permit(:name, :url)
  end  

end