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
