# == Schema Information
#
# Table name: twitter_users
#
#  name       :string(255)
#  username   :string(255)
#  created_at :datetime
#  user_id    :integer          not null, primary key
#
require 'rails_helper'

RSpec.describe TwitterUser, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
