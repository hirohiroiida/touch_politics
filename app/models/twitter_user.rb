# == Schema Information
#
# Table name: twitter_users
#
#  name       :string(255)
#  username   :string(255)
#  created_at :datetime
#  user_id    :bigint           not null, primary key
#
class TwitterUser < ApplicationRecord
  has_many :tweets, dependent: :destroy

  validates :username, uniqueness: true, presence: true
  validates :user_id, uniqueness: true, presence: true

  def start_time
    self.my_related_model.start ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
  end

end
