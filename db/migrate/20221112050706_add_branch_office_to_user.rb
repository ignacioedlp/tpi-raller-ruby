class AddBranchOfficeToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :branch_office_id, :bigint
    add_index :users, :branch_office_id
  end
end
