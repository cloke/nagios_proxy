class AddProcessedToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :processed, :boolean, :default => false
  end
end
