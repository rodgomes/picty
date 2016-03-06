defmodule Picty.SearchController do
  use Picty.Web, :controller
  alias Timex.Date
  @flickr_api Application.get_env(:picty, :flickr_api)

  def search(conn, params) do
    cityName = Dict.get(params, "city")
    month = Dict.get(params, "month")

    result = @flickr_api.search(cityName, get_period(month))
    render conn, "search.json", %{"result" => result}
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
      lastDay = Date.days_in_month(year, month)
      {to_string(year) <> "-" <> to_string(month) <> "-" <> "01",
      to_string(year) <> "-" <> to_string(month) <> "-" <> to_string(lastDay)}
  end
end
