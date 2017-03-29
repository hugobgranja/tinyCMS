class Link < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :url, presence: true

  has_many :menu_items, as: :item, dependent: :destroy
end