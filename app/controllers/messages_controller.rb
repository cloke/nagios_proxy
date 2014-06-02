class MessagesController
  def execute_commands
    messages = Message.where processed: false, instance_id: 'dev_server_1'
    messages.each do |message|
      commands = message.command.split '/'
      self.send commands.shift, commands, message.parameters
      message.update_attributes! processed: true
    end
  end

  def create *args
    args.first[0].classify.constantize.new.create args[1]
  end

  def method_missing(meth, *args, &block)
    p "missing method!! #{meth}, #{args.first[0]}, #{block}"
  end
end