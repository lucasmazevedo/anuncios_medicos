class Message 

  include ActiveModel::Validations
  include ActiveModel::Model
  include ActiveModel::Conversion
  
  attr_accessor :name, :email, :content, :ads, :reason

  validates_presence_of :name, :email, :content, :reason



end