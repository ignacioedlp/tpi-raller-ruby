class CreateOpeningHours < ActiveRecord::Migration[7.0]
  def change
    create_table "opening_hours", force: :cascade do |t|
      t.bigint "branch_office_id"
      t.integer "day"
      t.time "opens"
      t.time "closes"
      t.index ["branch_office_id"], name: "index_opening_hours_on_branch_office_id"
    end 
  end
end
