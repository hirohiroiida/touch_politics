# == Schema Information
#
# Table name: tweets
#
#  start_time      :datetime
#  text            :text(65535)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  tweet_id        :bigint           not null, primary key
#  twitter_user_id :bigint           not null
#
# Indexes
#
#  index_tweets_on_twitter_user_id  (twitter_user_id)
#
# Foreign Keys
#
#  fk_rails_...  (twitter_user_id => twitter_users.user_id)
#
FactoryBot.define do
  factory :tweet do
    
  end
end
