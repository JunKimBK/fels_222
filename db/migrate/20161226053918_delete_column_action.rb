class DeleteColumnAction < ActiveRecord::Migration[5.0]
  def change
    remove_column :activities, :action, :string
    add_column :activities, :action_type, :integer
  end
end
