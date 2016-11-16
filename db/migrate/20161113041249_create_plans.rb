class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :identifier
      t.integer :amount
      t.integer :ads_qtd
      t.integer :feature_qtd
      t.integer :trial
      t.boolean :status

      t.timestamps
    end
  end
end
