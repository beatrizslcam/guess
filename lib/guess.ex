defmodule Guess do
 use Application #behaviour

  def start(_,_) do
    run()
    {:ok, self()}
  end

 def run() do
    IO.puts("Vamos jogar Advinhe o Numero?")
    IO.gets("Escolha o nivel de dificuldade( 1, 2 ou 3):")
    |>parse_input()
    |>pickup_number()
    |>play()
    |>IO.inspect()
  end

  def pickup_number(level) do
    level
    |>get_range()
    |>Enum.random()
  end

  def parse_input(:error) do
    IO.puts("Valor Invalido!")
      run()
  end

  def parse_input({num, _}), do: num

  def parse_input(data) do
    data
    |>Integer.parse()
    |>parse_input()

  end

  def get_range(level) do
    case level do
      1-> 1..10
      2 -> 1..100
      3 -> 1..1000
      _ ->IO.puts("Nivel Invalido")
          run()
    end
  end

  def play(picked_num) do
    IO.gets("Ja escolhi o numero, Qual o seu palpite?")
    |>parse_input()
    |>guess(picked_num,0)
  end

  def guess(user_guess, picked_num,count)  when user_guess > picked_num do
    IO.gets("O numero que escolhi eh menor, tente outra vez")
    |>parse_input()
    |>guess(picked_num,count + 1)
  end

  def guess(user_guess, picked_num, count) when user_guess < picked_num do
    IO.gets("O numero que escolhi eh maior, tente outra vez")
    |>parse_input()
    |>guess(picked_num,count + 1)
  end

  def guess(user_guess, picked_num, count) do
    IO.gets("Parabens, voce acertou na #{count}a tentativa!")
  end

end
