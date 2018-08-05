defmodule VoteWeb.PollView do
  use VoteWeb, :view

  def option(value, text, selected) do
    active = if selected == value, do: "active", else: ""
    submit text, 
      class: "list-group-item list-group-item-action #{active}",
      name: "option",
      value: value
  end

  def progress(votes, option) do
    current = votes(votes, option)
    total = votes(votes)
    if total > 0, do: "width: #{current / total * 100}%;",
    else: "width: 0%;"
  end
  def votes(votes), do: Enum.count(votes)
  def votes(votes, option), do: Enum.count(votes, fn x -> x === option end)
end