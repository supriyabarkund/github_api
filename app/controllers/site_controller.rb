class SiteController < ApplicationController
  require 'rest-client'

  def index; end

  def list_of_repo
    url = "orgs/webonise/repos?type=#{params[:type]}"
    response = get_api(url)
    @repo_list = JSON.parse(response.to_str)
  end

  def list_of_commits
    url = "repos/webonise/usa-basketball/commits?author=#{params[:author]}"
    response = get_api(url)
    @commits_list = JSON.parse(response.to_str)
  end

  def list_of_branches
    url = 'repos/webonise/usa-basketball/branches'
    response = get_api(url)
    @results = JSON.parse(response.to_str)
  end

  def list_of_pulls
    url = "repos/webonise/usa-basketball/pulls?state=#{params[:state]}"
    response = get_api(url)
    @pull_list = JSON.parse(response.to_str)
  end

  private

  def get_api(url)
    response = RestClient::Request.new(
        :method => :get,
        :url => 'https://api.github.com/' + url,
        :user => 'barkundsupriya-webonise',
        :password => 'webonise123#',
        :headers => { :accept => :json, :content_type => :json }
      ).execute
  end
end
