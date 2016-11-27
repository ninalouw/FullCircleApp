class AddUserReferencesToGoals < ActiveRecord::Migration[5.0]
  def change
    add_reference :goals, :user, foreign_key: true
  end
end
