class CreateOpeningHours < ActiveRecord::Migration[7.0]
  def change
    create_table :opening_hours do |t|
      t.references :branch_office
      t.integer :day
      t.time :opens
      t.time :closes

      t.timestamps
    end
  end
end
