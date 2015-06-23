class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title
      t.text :body
      t.string :private_or_public
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
