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

## 参考サイト

- [Haskell で継続渡しスタイル (CPS) | すぐに忘れる脳みそのためのメモ](https://jutememo.blogspot.com/2011/05/haskell-cps.html)
