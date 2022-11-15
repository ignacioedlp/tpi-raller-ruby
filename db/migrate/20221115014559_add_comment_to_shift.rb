class AddCommentToShift < ActiveRecord::Migration[7.0]
  def change
    add_column :shifts, :comment, :string
  end
end
