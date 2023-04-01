class TweetsController < ApplicationController
  require 'json'
  require 'typhoeus'
  require 'date'

  def create
    tweets = get_tweet(params[:id])
    user = TwitterUser.find_or_initialize_by(user_id: params[:id])
    
    tweets_objects = tweets.map do |hash|
      hash = hash.transform_keys(&:to_sym)
      hash.except!(:edit_history_tweet_ids)
      text = hash[:text]
      if text.length > 50
        hash[:text] = text.slice(0, 50)
      end
      hash[:tweet_id] = hash.delete(:id)
      hash[:start_time] = Time.zone.parse(hash.delete(:created_at)).to_datetime
      Tweet.new(hash)
    end
    
    user.tweets = tweets_objects
  
    if user.save && tweets_objects.all?(&:save)
      redirect_to twitter_user_path(params[:id]), success: '保存しました'
    else
      redirect_to twitter_user_path(params[:id]), notice: '保存に失敗しました'
    end
  end

  private

  def get_tweet(user_id)
    url = "https://api.twitter.com/2/users/#{user_id}/tweets"
    query_params = {
      "max_results" => 100,
      "tweet.fields" => "created_at",
    }
    options = {
      method: 'get',
      headers: {
        "User-Agent" => "v2RubyExampleCode",
        "Authorization" => "Bearer #{ENV['BEARER_TOKEN']}"
      },
      params: query_params
    }
    request = Typhoeus::Request.new(url, options)
    response = request.run
    if response.code == 200
      tweets = JSON.parse(response.body)['data']
    else
      0
    end
  end
end
