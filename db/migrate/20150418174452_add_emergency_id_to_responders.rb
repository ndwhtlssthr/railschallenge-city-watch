class AddEmergencyIdToResponders < ActiveRecord::Migration
  def change
    add_column :responders, :emergency_id, :integer
    remove_column :responders, :on_response
  end
end
