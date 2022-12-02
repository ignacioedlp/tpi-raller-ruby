class AddBranchOfficeToAdminUser < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_users, :branch_office_id, :bigint
    add_index :admin_users, :branch_office_id
  end
end
