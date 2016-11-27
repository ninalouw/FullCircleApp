class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.string :name
      t.integer :minutes
      t.integer :count_consecutive_days_completed
      t.datetime :latest_date_completed

      t.timestamps
    end
  end
end
