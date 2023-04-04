class TwitterUsersController < ApplicationController
  require 'json'
  require 'typhoeus'
  require 'date'

  def index
    @twitter_users = TwitterUser.all

  end

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
    @twitter_user = TwitterUser.find(params[:id])
    @tweets = @twitter_user.tweets
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
end
