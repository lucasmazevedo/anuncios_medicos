class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
  	add_column :ads, :images, :json
   
  end
end
