class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :avatar, AvatarUploader

  validates :fullname, presence: true


  def fullphone
  	return "(#{phonearea}) #{phone}"
  end

  def location
  	return "#{city}/#{state}"
  end
end
