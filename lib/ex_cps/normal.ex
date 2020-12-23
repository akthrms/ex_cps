defmodule ExCps.Normal do
  @spec add(number(), number()) :: number()

  def add(x, y), do: x + y

  @spec mul(number(), number()) :: number()

  def mul(x, y), do: x * y

  @spec sub(number(), number()) :: number()

  def sub(x, y), do: x - y

  @spec fact(non_neg_integer()) :: pos_integer()

  def fact(0), do: 1

  def fact(n) when n > 0, do: n * fact(n - 1)

  @type leaf :: {:leaf, any()}

  @type branch :: {:branch, tree(), tree()}

  @type tree :: leaf() | branch()

  @spec leaf_count(tree()) :: pos_integer()

  def leaf_count({:leaf, _}), do: 1

  def leaf_count({:branch, l, r}), do: leaf_count(l) + leaf_count(r)

  @spec fib(non_neg_integer()) :: non_neg_integer()

  def fib(0), do: 0

  def fib(1), do: 1

  def fib(n) when n > 0, do: fib(n - 1) + fib(n - 2)
end
