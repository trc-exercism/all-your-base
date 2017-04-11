defmodule AllYourBase do
  @doc """
  Given a number in radix a, represented as a sequence of digits, converts it to radix b,
  or returns nil if either of the radixs are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert(digits, radix_a, radix_b) do
    cond do
      Enum.empty?(digits) or
      radix_a <= 1 or
      radix_b <= 1 or
      Enum.any?(digits,
        fn(d) ->
          d < 0 or
          d >= radix_a
        end) -> nil
      Enum.sum(digits) == 0 -> [0]
      true -> digits
              |> Enum.reverse
              |> Enum.with_index
              |> Enum.map(fn({digit, index}) -> digit * :math.pow(radix_a, index) |> round end)
              |> Enum.sum
              |> _decimal_to_radix(radix_b, [])
    end

  end

  defp _decimal_to_radix(0, _radix, acc), do: acc
  defp _decimal_to_radix(decimal_value, radix, acc) do
    _decimal_to_radix(Integer.floor_div(decimal_value, radix), radix, [rem(decimal_value, radix)] ++ acc)
  end

end
