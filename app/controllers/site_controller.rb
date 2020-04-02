class SiteController < ApplicationController

  before_filter :get_api
  require 'octokit'

  def index; end

  def list_of_repo
    @repo_list = @client.org_repos(@client.user.company.downcase,
                                  {type: "#{params[:type]}"})
  end

  def list_of_commits
    @commit_list = @client.list_commits("#{@client.user.company.downcase}/#{params[:project]}",
                    options: { author: "#{params[:author] }"})
  end

  def list_of_branches
    @branch_list = @client.branches("#{@client.user.company.downcase}/#{params[:project]}")
  end

  def list_of_pulls
    @pull_list = @client.pulls("#{@client.user.company.downcase}/#{params[:project]}",
                                state: "#{params[:state]}")
  end

  private

  def get_api
    @client = Octokit::Client.new(login: 'barkundsupriya-webonise', password: 'webonise123#')
  end
end
