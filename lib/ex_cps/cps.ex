defmodule ExCps.Cps do
  @spec add(number, number, (number() -> any())) :: any()

  def add(x, y, k), do: k.(x + y)

  @spec mul(number, number, (number() -> any())) :: any()

  def mul(x, y, k), do: k.(x * y)

  @spec sub(number, number, (number() -> any())) :: any()

  def sub(x, y, k), do: k.(x - y)
end
