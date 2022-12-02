class AddAdminUserToShift < ActiveRecord::Migration[7.0]
  def change
    add_column :shifts, :admin_user_id, :bigint
    add_index :shifts, :admin_user_id
  end
end
