class ChangeOnReponseToString < ActiveRecord::Migration
  def change
    change_column :responders, :on_response, :string
  end
end
