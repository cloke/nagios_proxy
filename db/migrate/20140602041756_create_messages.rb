class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string  :instance_id
      t.string  :command
      t.string  :parameters

      t.timestamps
    end
  end
end
