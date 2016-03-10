defmodule Picty.FlickrAPIFake do

  def search(cityName, period) do
    [
          %{
            :farm => 1,
            :server => "fake",
            :id => elem(period,1),
            :secret => cityName,        # doing this, so I can check in the controller if the right values were passed
            :owner => elem(period,0)    # to the api
          }
    ]

  end
end
