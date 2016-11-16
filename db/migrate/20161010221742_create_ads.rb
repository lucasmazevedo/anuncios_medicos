class CreateAds < ActiveRecord::Migration[5.0]
  def change
    create_table :ads do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.string :title, limit: 200
      t.text :description
      t.string :state
      t.decimal :price,  precision: 8, scale: 2
      t.string :tags
      t.boolean :featured, default: false
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
