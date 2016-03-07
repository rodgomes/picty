defmodule Picty.FlickrAPI do

  @doc """
  Search the FlickrAPI for images taken in a specific period (typically one month)
  which contains the given keyword which should also be a city name

  As the API sometimes is slow the timeout is quite high, 20 seconds
  """
  def search(cityName, period) do
    do_search(cityName, period, [], 1)
  end

  defp do_search(_cityName, _period, result, _page) when length(result) >= 50 do
    result
  end

  defp do_search(cityName, period, result, page) do
    response = HTTPotion.get(mount_url(cityName, period, page), [timeout: 20_000])
      |> keep_only_unique_owners
      |> Enum.concat(result)
      do_search(cityName, period, response, page+1)
  end

  defp keep_only_unique_owners(response) do

    parsed = Poison.Parser.parse!(response.body)
    
    parsed["photos"]["photo"]
     |> Enum.group_by(%{}, fn(item) -> item["owner"] end)
     |> Enum.map(fn({_k, v}) -> hd(v) end)
  end

  def mount_url(cityName, {from, to}, page \\ 1) do
    api_key = Application.get_env(:picty, :flickr_key)
    query_params = %{
      :method => "flickr.photos.search",
      :api_key => api_key,
      :tags => cityName,
      :min_taken_date => from,
      :max_taken_date => to,
      :format => "json",
      :nojsoncallback => 1,
      :per_page => 500,
      :page => page,
      :sort => "interestingness-asc"
    }
    "https://api.flickr.com/services/rest/?" <> URI.encode_query(query_params)
  end

end
