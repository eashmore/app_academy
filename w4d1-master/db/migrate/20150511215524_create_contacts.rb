class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :contacts, [:user_id, :email], unique: true
  end
end
