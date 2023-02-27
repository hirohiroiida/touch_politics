class TweetsController < ApplicationController
  require 'json'
  require 'typhoeus'

  def search
    username = params[:username]
    userid = get_userid(username)
    if userid != 0
      redirect_to "/twitter/show?userid=#{userid}"
    else
      redirect_to root_path
    end
  end

  def show
    @userid = params[:userid]
    @result = get_tweet(@userid)
  end

  private

  def get_userid(username)
    url = "https://api.twitter.com/2/users/by/username/:username".gsub(':username', username)
    options = {
      method: 'get',
      headers: {
        "User-Agent" => "v2RubyExampleCode",
        "Authorization" => "Bearer #{ENV['BEARER_TOKEN']}"
      },
    }
    request = Typhoeus::Request.new(url, options)
    response = request.run
    if response.code == 200 && JSON.parse(response.body)['data'].present?
      JSON.parse(response.body)['data']['id']
    else
      0
    end
  end

  def get_tweet(userid)
    url = "https://api.twitter.com/2/users/:id/tweets".gsub(':id', userid)
    query_params = {
      "max_results" => 10,
      "expansions" => "author_id",
      "tweet.fields" => "attachments,author_id,conversation_id,created_at,entities,id,lang",
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
end
