class DeleteColumnType < ActiveRecord::Migration[5.0]
  def change
    remove_column :activities, :type, :string
    add_column :activities, :action, :string
  end
end
