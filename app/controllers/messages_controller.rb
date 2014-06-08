class MessagesController
  def execute_commands
    messages = Message.where processed: false, instance_id: 'dev_server_1'
    messages.each do |message|
      commands = message.command.split '/'
      model = commands.pop.classify.constantize.find message[:referenced_model_id]
      model.send commands.pop, message.parameters
      message.update_attributes! processed: true
    end
  end

  def method_missing(meth, *args, &block)
    p "missing method!! #{meth}, #{args.first[0]}, #{block}"
  end
end