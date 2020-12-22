defmodule ExCpsTest do
  use ExUnit.Case
  doctest ExCps

  test "greets the world" do
    assert ExCps.hello() == :world
  end
end
