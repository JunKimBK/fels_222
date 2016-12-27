class DeleteColumnActionType < ActiveRecord::Migration[5.0]
  def change
    remove_column :activities, :action_type, :integer
    add_column :activities, :action, :string
  end
end
