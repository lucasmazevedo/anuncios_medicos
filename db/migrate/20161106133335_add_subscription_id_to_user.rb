class AddSubscriptionIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :subscription_id, :string
  end
end
