defmodule ExCps.Cps do
  @spec add(number, number, (number() -> any())) :: any()

  def add(x, y, k), do: k.(x + y)

  @spec mul(number, number, (number() -> any())) :: any()

  def mul(x, y, k), do: k.(x * y)

  @spec sub(number, number, (number() -> any())) :: any()

  def sub(x, y, k), do: k.(x - y)

  @spec fact(non_neg_integer(), (non_neg_integer() -> any())) :: any()

  def fact(0, k), do: k.(1)

  def fact(n, k) when n > 0, do: fact(n - 1, fn x -> k.(n * x) end)
end
