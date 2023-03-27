class TwitterUsersController < ApplicationController
  require 'json'
  require 'typhoeus'
  require 'date'

  def create
    user_data = get_userid(params[:username])
    
    if user_data != 0
      @twitter_user = TwitterUser.new(name: user_data['name'], username: params[:username], user_id: user_data['id'])
      if @twitter_user.save
        redirect_to root_path, notice: 'Twitter user was successfully created.'
      else
        redirect_to root_path, notice: 'すでに登録されています'
      end
    else
      redirect_to root_path, notice: '該当するuserがいません'
    end
  end

  def destroy
    @twitter_user = TwitterUser.find(params[:id])
    @twitter_user.destroy
    redirect_to root_path, notice: '削除しました'
  end

  def show
    tweets = get_tweet(params[:id])
    @events = []
    tweets["data"].each do |tweet|
      created_at = DateTime.parse(tweet["created_at"])
      @events << { start_time: created_at, title: "Tweet" }
    end
    @calendar_events_by_day = @events.group_by { |event| event[:start_time].beginning_of_day }
  end


  private

  def get_userid(username)
    url = "https://api.twitter.com/2/users/by/username/:username".gsub(':username', username)
    query_params = {
      "user.fields" => "id,name,username"
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
    if response.code == 200 && JSON.parse(response.body)['data'].present?
      JSON.parse(response.body)['data']
    else
      0
    end
  end

  def get_tweet(id)
    url = "https://api.twitter.com/2/users/#{id}/tweets"
    query_params = {
      "max_results" => 5,
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
      JSON.parse(response.body)
    else
      0
    end
  end

  def tweets_by_dayyyyyyy(tweets)
    tweet_count_by_day = Hash.new(0)
    tweets.each do |tweet|
      created_at = tweet["created_at"]
      created_date = Date.parse(created_at)
      tweet_count_by_day[created_date] += 1
    end
    tweet_count_by_day
  end

end
