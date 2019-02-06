class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.integer :age
      t.string :username, limit: 30
      t.string :email

      t.timestamps
    end
  end
end
