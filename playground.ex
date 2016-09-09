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
end

# iex(26)> pid = spawn(Play, :greeter, [])
# #PID<0.116.0>
# iex(27)> send pid, "Lewis"
# Hello, LEWIS
# "Lewis"
# iex(28)> send pid, "Paweł"
# Hello, PAWEŁ
# "Paweł"
