defmodule Picty.FlickrAPI do

  @doc """
  Search the FlickrAPI for images taken in a specific period (typically one month)
  which contains the given keyword which should also be a city name

  As the API sometimes is slow the timeout is quite high, 20 seconds
  """
  def search(cityName, period) do

    # not ideal yet, because i can make unnecessary calls when one page result
    # is enough (and might be the case 4 pages is still not enough as well)
    # ideally each page should be called by the script if needed.
    # later I'll implement that
    # and I know HTTPotion has support for async calls, but I wanted to play
    # with Elixir async/await
    tasks = [
      Task.async(fn -> do_search(cityName, period, 1) end),
      Task.async(fn -> do_search(cityName, period, 2) end),
      Task.async(fn -> do_search(cityName, period, 3) end),
      Task.async(fn -> do_search(cityName, period, 4) end),
    ]
    List.flatten for resp <- tasks, do: Task.await(resp, 20_000)
  end

  defp do_search(cityName, period, page) do

    HTTPotion.get(mount_url(cityName, period, page), [timeout: 20_000])
      |> keep_only_unique_owners
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
