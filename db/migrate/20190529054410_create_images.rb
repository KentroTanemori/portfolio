class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.integer :post_image_id
      t.string :image_id

      t.timestamps
    end
  end
end
