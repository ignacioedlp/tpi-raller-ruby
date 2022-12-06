class CreateShifts < ActiveRecord::Migration[7.0]
  def change
    create_table :shifts do |t|
      # Quiero un modelo de turnos con referencias de los usuarios y las oficinas

      t.references :branch_office
      t.references :user

      t.datetime "date"
      t.text "reason"
      t.boolean "completed", default: false, null: false
      t.index ["branch_office_id", "user_id"], name: "index_branch_offices_users_on_branch_office_id_and_user_id"

      t.timestamps
    end
  end
end
