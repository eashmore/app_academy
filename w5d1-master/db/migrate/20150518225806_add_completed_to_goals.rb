class AddCompletedToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :completed, :string
  end
end
