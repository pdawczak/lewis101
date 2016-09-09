greeter = fn ->
  receive do
    name -> IO.puts "Hello, #{String.upcase(name)}"
  end
end
