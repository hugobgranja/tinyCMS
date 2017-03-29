# RailsSettings Model
class Setting < RailsSettings::Base
  source Rails.root.join("config/app.yml")
  namespace Rails.env

  after_save :reload_routes

  private

  def reload_routes
    if self.var == 'home'
      Rails.application.reload_routes!
    end
  end

end
