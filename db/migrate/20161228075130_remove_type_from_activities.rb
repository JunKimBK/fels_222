class RemoveTypeFromActivities < ActiveRecord::Migration[5.0]
  def change
    remove_column :activities, :type, :string
  end
end
