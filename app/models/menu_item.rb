class MenuItem < ActiveRecord::Base
  validates :order, presence: true, uniqueness: true
  validates :item, presence: true

  belongs_to :item, polymorphic: true
end