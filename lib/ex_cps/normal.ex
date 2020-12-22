defmodule ExCps.Normal do
  @spec add(number(), number()) :: number()

  def add(x, y), do: x + y

  @spec mul(number(), number()) :: number()

  def mul(x, y), do: x * y

  @spec sub(number(), number()) :: number()

  def sub(x, y), do: x - y
end
