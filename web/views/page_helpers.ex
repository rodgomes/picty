defmodule Picty.CssClassHelper do

  def active_class(conn, path) do
    current_path = Path.join(["/" | conn.path_info])
    if path == current_path do
      "current"
    else
      nil
    end
  end

  def header_class(conn) do
    current_path = Path.join(["/" | conn.path_info])
    if "/" == current_path do
      "alt"
    else
      nil
    end
  end

end
