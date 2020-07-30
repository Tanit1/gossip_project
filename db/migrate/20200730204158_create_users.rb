class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :email
      t.text :description

      t.belongs_to :city, index: true

      t.timestamps
    end
  end
end
