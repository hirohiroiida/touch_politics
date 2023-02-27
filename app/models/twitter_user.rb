# == Schema Information
#
# Table name: twitter_users
#
#  name       :string(255)
#  username   :string(255)
#  created_at :datetime
#  user_id    :integer          not null, primary key
#
class TwitterUser < ApplicationRecord
end
