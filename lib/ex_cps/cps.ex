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

  @type leaf :: {:leaf, any()}

  @type branch :: {:branch, tree(), tree()}

  @type tree :: leaf() | branch()

  @spec leaf_count(tree(), (any() -> any())) :: any()

  def leaf_count({:leaf, _}, k), do: k.(1)

  def leaf_count({:branch, l, r}, k) do
    leaf_count(l, fn x ->
      leaf_count(r, fn y ->
        k.(x + y)
      end)
    end)
  end

  @spec fib(non_neg_integer(), (any() -> any())) :: any()

  def fib(0, k), do: k.(0)

  def fib(1, k), do: k.(1)

  def fib(n, k) when n > 0 do
    fib(n - 1, fn x ->
      fib(n - 2, fn y ->
        k.(x + y)
      end)
    end)
  end

  @spec concat(maybe_improper_list(), (any() -> any())) :: any()

  def concat([], k), do: k.([])

  def concat([[] | _], _), do: []

  def concat([xs | xss], k), do: concat(xss, fn xss_ -> k.(xs ++ xss_) end)
end
