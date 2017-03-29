Rails.application.config.after_initialize do
  if defined? Bullet
    Bullet.enable = true
    Bullet.alert = true
  end
end