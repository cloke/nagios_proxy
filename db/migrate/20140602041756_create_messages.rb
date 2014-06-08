class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string  :instance_id
      t.string  :command
      t.string  :parameters
      t.integer :referenced_model_id
      t.boolean :processed, :default => false
      t.timestamps
    end
  end
end
