class CreateEmergencies < ActiveRecord::Migration
  def change
    create_table :emergencies do |t|
      t.datetime :resolved_at
      t.string :code, null: false
      t.integer :fire_severity, null: false
      t.integer :police_severity, null: false
      t.integer :medical_severity, null: false
      t.boolean :full_response, null: false, default: false
    end
  end
end
