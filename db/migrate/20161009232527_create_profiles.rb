class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string :fullname, limit: 200
      t.string :cpf, limit: 11
      t.string :phonearea, limit: 2
      t.string :phone, limit: 9
      t.date :birthdate
      t.string :zipcode, limit: 8
      t.string :street
      t.string :number
      t.string :district
      t.string :city
      t.string :state
      t.string :code
      t.string :avatar

      t.timestamps
    end
  end
end
