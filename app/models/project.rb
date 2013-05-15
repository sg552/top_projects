class Project < ActiveRecord::Base
  include Fetcher
  def self.refresh_list
    self.new.fetch_github_search_results
  end
end
