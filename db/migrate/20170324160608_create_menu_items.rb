class CreateMenuItems < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_items do |t|
      t.integer :order
      t.references :item, polymorphic: true, index: true
    end
  end
end