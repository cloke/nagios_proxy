class Message < ActiveRecord::Base
  serialize :parameters, JSON
end
