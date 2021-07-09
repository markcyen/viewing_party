class AddColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :invitations, :status, :integer
  end
end
