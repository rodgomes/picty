defmodule Picty.FlickrAPIFake do
  alias Picty.FlickrAPI

  def search(cityName, period) do
    %{
      :url => FlickrAPI.mount_url(cityName, period), # added here for testing purpose, not part of real response
      :photos => %{
        :photo => [
          %{
            :farm => 1,
            :server => "fake",
            :id => 123,
            :secret => "secret",
            :owner => "456"
          }
        ]
      }
    }
  end
end
