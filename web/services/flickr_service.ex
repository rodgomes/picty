defmodule Picty.FlickrAPI do

  def search(cityName, month) do
    response = HTTPotion.get(mount_url(cityName, month), [timeout: 20_000])
    #TODO check errors, etc
    response.body
  end

  def get_allowed_locations() do
    ["Amsterdam", "Paris", "Berlin", "Prague", "London", "Rio de Janeiro"]
  end

  defp mount_url(cityName, month) do
    api_key = Application.get_env(:picty, :flickr_key)
    "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=#{api_key}&text=#{cityName}&min_taken_date=2016-01-02&max_taken_date=2016-02-05&format=json&nojsoncallback=1"
  end


end
