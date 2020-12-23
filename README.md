# 継続渡しスタイル（CPS） in Elixir

## 足し算・掛け算・引き算

```elixir
iex> import ExCps.Normal
ExCps.Normal

iex> sub(mul(add(1, 2), 3), 4)
5
```

```elixir
# CPS

iex> import ExCps.Cps
ExCps.Cps

iex> add(1, 2, fn x ->
...>   mul(x, 3, fn y ->
...>     sub(y, 4, fn z -> z end)
...>   end)
...> end)
5
```

## 階乗

```elixir
iex> import ExCps.Normal
ExCps.Normal

iex> fact(3)
6
```

```elixir
# CPS

iex> import ExCps.Cps
ExCps.Cps

iex> fact(3, fn x -> x end)
6

fact(3, fn x -> x end)
=> fact(2, fn x -> (fn x -> x end).(3 * x))
=> fact(1, fn x -> (fn x -> (fn x -> x end).(3 * x)).(2 * x))
=> fact(0, fn x -> (fn x -> (fn x -> (fn x -> x end).(3 * x)).(2 * x)).(1 * x))
=> (fn x -> (fn x -> (fn x -> (fn x -> x end).(3 * x)).(2 * x)).(1 * x)).(1)
=> (fn x -> (fn x -> (fn x -> x end).(3 * x)).(2 * x)).(1)
=> (fn x -> (fn x -> x end).(3 * x)).(2)
=> (fn x -> x end).(6)
=> 6
```

## 木の葉の数を数える

```elixir
iex> tree = {:branch, {:branch, {:leaf, 1}, {:leaf, 2}}, {:branch, {:leaf, 3}, {:branch, {:leaf, 4}, {:leaf, 5}}}}
{:branch, {:branch, {:leaf, 1}, {:leaf, 2}}, {:branch, {:leaf, 3}, {:branch, {:leaf, 4}, {:leaf, 5}}}}
```

```elixir
iex> import ExCps.Normal
ExCps.Normal

iex> leaf_count(tree)
5
```

```elixir
# CPS

iex> import ExCps.Cps
ExCps.Cps

iex> leaf_count(tree, fn x -> x end)
5

leaf_count({:branch, {:leaf, 1}, {:leaf, 2}}, fn x -> x end)
=> leaf_count({:leaf, 1}, fn l -> leaf_count({:leaf, 2}, fn r -> (fn x -> x end).(l + r) end) end)
=> (fn l -> leaf_count({:leaf, 2}, fn r -> (fn x -> x end).(l + r) end) end).(1)
=> leaf_count({:leaf, 2}, fn r -> (fn x -> x end).(1 + r) end)
=> (fn r -> (fn x -> x end).(1 + r) end).(1)
=> (fn x -> x end).(2)
=> 2
```

## フィボナッチ数

```elixir
# CPS

iex> import ExCps.Cps
ExCps.Cps

iex> fib(7, fn x -> x end)
13
```

## リストの平坦化

```elixir
# CPS

iex> import ExCps.Cps
ExCps.Cps

iex> concat([[1, 2], [3, 4], [5, 6]], fn x -> x end)
[1, 2, 3, 4, 5, 6]

iex> concat([[1, 2], [3, 4], [], [5, 6]], fn x -> x end)
[]

concat([[1, 2], [3, 4], [5, 6]], fn x -> x end)
=> concat([[3, 4], [5, 6]], fn xss -> (fn x -> x end).([1, 2] ++ xss) end)
=> concat([[5, 6]], fn xss -> (fn xss -> (fn x -> x end).([1, 2] ++ xss) end).([3, 4] ++ xss) end)
=> concat([], fn xss -> (fn xss -> (fn xss -> (fn x -> x end).([1, 2] ++ xss) end).([3, 4] ++ xss) end).([5, 6] ++ xss) end)
=> (fn xss -> (fn xss -> (fn xss -> (fn x -> x end).([1, 2] ++ xss) end).([3, 4] ++ xss) end).([5, 6] ++ xss) end).([])
=> (fn xss -> (fn xss -> (fn x -> x end).([1, 2] ++ xss) end).([3, 4] ++ xss) end).([5, 6])
=> (fn xss -> (fn x -> x end).([1, 2] ++ xss) end).([3, 4, 5, 6])
=> (fn x -> x end).([1, 2, 3, 4, 5, 6])
=> [1, 2, 3, 4, 5, 6]
```

## 参考サイト

- [Haskell で継続渡しスタイル (CPS) | すぐに忘れる脳みそのためのメモ](https://jutememo.blogspot.com/2011/05/haskell-cps.html)
