greeter = fn ->
  receive do
    name -> IO.puts "Hello, #{String.upcase(name)}"
  end
end

defmodule Play do
  def greeter do
    receive do
      name -> IO.puts "Hello, #{String.upcase(name)}"
    end

    greeter
  end

  def calc do
    receive do
      {:add, a, b, caller} -> send caller, a + b
      {:sub, a, b, caller} -> send caller, a - b
    end

    calc
  end

  def handle_message do
    receive do
      val -> val
    end
  end

  def stack(current_stack \\ []) do
    new_stack =
      receive do
        {:push, element} -> [element | current_stack]

        {:pop, caller} ->
          [to_return | rest] = current_stack
          send caller, to_return
          rest
      end

    stack(new_stack)
  end
end

# iex(26)> pid = spawn(Play, :greeter, [])
# #PID<0.116.0>
# iex(27)> send pid, "Lewis"
# Hello, LEWIS
# "Lewis"
# iex(28)> send pid, "Paweł"
# Hello, PAWEŁ
# "Paweł"


# The Stack
# iex(55)> s = spawn(Play, :stack, [[23]])
# #PID<0.172.0>
# iex(56)> send s, {:pop, self}
# {:pop, #PID<0.56.0>}
#  iex(57)> flush
#  23
#  :ok
#  iex(58)> send s, {:push, 12}
#  {:push, 12}
#  iex(59)> send s, {:push, 15}
#  {:push, 15}
#  iex(60)> send s, {:push, 18}
#  {:push, 18}
#  iex(61)> send s, {:pop, self}
#  {:pop, #PID<0.56.0>}
#   iex(62)> flush
#   18
#   :ok
#   iex(63)>
