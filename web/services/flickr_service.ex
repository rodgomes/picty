defmodule Picty.FlickrAPI do
  # use HTTPotion.Base
  alias Picty.HTTPotionJson

  def search(cityName, month) do
    HTTPotionJson.get(mount_url(cityName, month), [timeout: 20_000])
  end

  defp mount_url(cityName, month) do
    api_key = Application.get_env(:picty, :flickr_key)
    "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=#{api_key}&text=#{cityName}&min_taken_date=2016-01-02&max_taken_date=2016-02-05&format=json&nojsoncallback=1"
  end


end
