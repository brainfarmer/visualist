defmodule StoryMap.Application do
  use Application

  def start(_type, args) do
    StoryMap.Server.start_link
  end
end
