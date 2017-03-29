class Page < ActiveRecord::Base
  before_validation :set_slug
  after_save :reload_routes

  validates :name, presence: true, uniqueness: true
  validates :content, presence: true
  validates :slug, presence: true, uniqueness: true

  has_many :menu_items, as: :item, dependent: :destroy

  private

  def set_slug
    if slug.blank?
      self.slug = ActiveSupport::Inflector.transliterate(self.name).downcase.gsub(/[^a-z0-9_ ]/i, '').tr(' ', '-')
    end
  end

  def reload_routes
    Rails.application.reload_routes!
  end

end