defmodule DataProcessor do
  defmodule ComplexData do
    defstruct [:id, :name, :values]

    def new(id, name) do
      values = Enum.map([id * 10, id * 20, id * 30], &(&1))
      %ComplexData{id: id, name: name, values: values}
    end

    def calculate(%ComplexData{values: values}) do
      Enum.sum(values) / length(values)
    end
  end

  def generate_data(count) do
    1..count
    |> Enum.map(fn id -> {id, ComplexData.new(id, "Item #{id}")} end)
    |> Enum.into(%{})
  end

  def save_to_file(filename, data) do
    File.write!(filename, Enum.map(data, fn {_, item} ->
      "ID: #{item.id}, Name: #{item.name}, Average Value: #{ComplexData.calculate(item)}"
    end) |> Enum.join("\n"))
  end

  def process_data(count) do
    IO.puts("Processing data...")
    Process.sleep(2000)

    data = generate_data(count)

    IO.puts("\nGenerated Data:")
    Enum.each(data, fn {_, item} ->
      IO.puts("#{item.id}: #{item.name} => Average: #{ComplexData.calculate(item)}")
    end)

    save_to_file("data_output.txt", data)
    IO.puts("\nData successfully saved to 'data_output.txt'.")

    IO.puts("\nSimulating async-like behavior...")
    Process.sleep(1000)
    IO.puts("Task completed!")
  end
end

DataProcessor.process_data(10)
