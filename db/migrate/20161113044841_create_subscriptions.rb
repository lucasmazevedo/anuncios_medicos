class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.references :plan, foreign_key: true
      t.references :user, foreign_key: true
      t.string :subscription_id
      t.string :in_trial
      t.boolean :suspended
      t.boolean :active

      t.timestamps
    end
  end
end
