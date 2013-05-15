module Fetcher

  # https://github.com/search?l=JavaScript&q=stars:%22%3E+500%22&type=Repositories
  def fetch_github_search_results options = {}
    options = options.reverse_merge({"stars" => "> 500"})
    query_string = ""
    options.each_pair {|key, value | query_string = "stars: #{value}" if key == 'stars' }
    url = URI.encode "https://github.com/search?q=#{query_string}&type=Repositories"

    response = HTTParty.get(url)
    logger.info "== response: #{response.body}"
    doc = Nokogiri::HTML(response)
    item = doc.css('.next_page')
    logger.info "==item: #{item.inspect}"
  end

  def logger
    Rails.logger
  end
end
