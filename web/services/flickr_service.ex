defmodule Picty.FlickrAPI do

  @doc """
  Search the FlickrAPI for images taken in a specific period (typically one month)
  which contains the given keyword which should also be a city name

  As the API sometimes is slow the timeout is quite high, 20 seconds
  """
  def search(cityName, period) do
    response = HTTPotion.get(mount_url(cityName, period), [timeout: 20_000])
    #TODO check errors, etc
    response.body
  end

  def mount_url(cityName, {from, to}) do
    api_key = Application.get_env(:picty, :flickr_key)
    query_params = %{
      :method => "flickr.photos.search",
      :api_key => api_key,
      :tags => cityName,
      :min_taken_date => from,
      :max_taken_date => to,
      :format => "json",
      :nojsoncallback => 1,
      :sort => "interestingness-asc"
    }
    "https://api.flickr.com/services/rest/?" <> URI.encode_query(query_params)
  end

end
