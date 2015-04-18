class AddOnResponseToResponders < ActiveRecord::Migration
  def change
    add_column :responders, :on_response, :boolean, default: false
  end
end
