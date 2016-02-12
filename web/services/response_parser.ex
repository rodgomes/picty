defmodule Picty.HTTPotionJson do
  use HTTPotion.Base

  def process_response_body(body) do
    # json   = :jsx.decode body
    body |> IO.iodata_to_binary |> :jsx.decode
    |> Enum.map fn ({k, v}) -> { String.to_atom(k), v } end
    # |> :orddict.from_list
  end
end
