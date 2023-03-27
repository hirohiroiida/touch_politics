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
  validates :username, uniqueness: true, presence: true
  validates :user_id, uniqueness: true, presence: true
end
