class Message < ActiveRecord::Base
  def execute_commands
    messages = Message.where processed: false, instance_id: 'dev_server_1'
  end
end
