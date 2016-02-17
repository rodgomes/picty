defmodule Picty.FlickrAPI do
  alias Timex.Date

  def search(cityName, month) do
    response = HTTPotion.get(mount_url(cityName, get_period(month)), [timeout: 20_000])
    #TODO check errors, etc
    response.body
  end

  def get_allowed_locations() do
    ["Amsterdam", "Paris", "Berlin", "Prague", "London", "Rio de Janeiro"]
  end

  defp mount_url(cityName, period) do
    api_key = Application.get_env(:picty, :flickr_key)
    from = elem(period, 0)
    to = elem(period, 1)
    "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=#{api_key}&text=#{cityName}&min_taken_date=#{from}&max_taken_date=#{to}&format=json&nojsoncallback=1"
  end

  defp get_period(month) do
    # check the month. If it is before the current month, the period should be related
    # to last year, otherwise use the current year
    today = Date.now
    selected_month = elem(Integer.parse(month), 0)
    current_year = today.year
    previous_year = current_year - 1

    cond do
      selected_month < today.month ->
        get_tuple_date(current_year, selected_month)
      selected_month >= today.month ->
        get_tuple_date(previous_year, selected_month)
    end
  end

  defp get_tuple_date(year, month) do
      {to_string(year) <> "-" <> to_string(month) <> "-" <> "01",
      to_string(year) <> "-" <> to_string(month) <> "-" <> "28"}
  end


end
