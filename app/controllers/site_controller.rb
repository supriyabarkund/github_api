class SiteController < ApplicationController

  before_filter :get_api
  require 'octokit'

  def index; end

  def list_of_repo
    @repo_list
  end

  def list_of_commits
    @commit_list
  end

  def list_of_branches
    url = 'repos/webonise/usa-basketball/branches'
    response = get_api(url)
    @results = JSON.parse(response.to_str)
  end

  def list_of_pulls
    @pull_list
  end

  private

  def get_api
    client = Octokit::Client.new(:login => 'supriya.barkund@weboniselab.com', :password => 'webonise123#')
    @repo_list = client.org_repos(client.user.company, {:type => "#{params[:type]}"})
    @commit_list = client.commits("webonise/usa-basketball", :options => {:author => "#{params[:author]}"})
    @pull_list = client.pulls('webonise/usa-basketball', :state=> "#{params[:state]}")
  end
end
