class SiteController < ApplicationController

  before_filter :get_api
  require 'octokit'

  def index; end

  def list_of_repo
    @repo_list = @client.org_repos(@repo_name, { type: "#{params[:type]}" } )
  end

  def list_of_commits
      @commit_list = @client.list_commits("#{@repo_name}/#{params[:project]}",
                      query: { author: "#{params[:author]}"})
  end

  def list_of_branches
    @branch_list = @client.branches("#{@repo_name}/#{params[:project]}")
  end

  def list_of_pulls
    @pull_list = @client.pulls("#{@repo_name}/#{params[:project]}",
                                state: "#{params[:state]}")
  end

  def filter_commits
    @filter_commits = @client.list_commits("#{@repo_name}/#{params[:project]}",
                    query: { author: "#{params[:author]}"})
  end

  private

  def get_api
    @client = Octokit::Client.new(login: 'barkundsupriya-webonise',
                                  password: 'webonise123#')
    @repo_name = @client.user.company.downcase
  end
end
