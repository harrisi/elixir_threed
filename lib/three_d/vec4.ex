defmodule ThreeD.Vec4 do
  @type t :: {float(), float(), float(), float()}

  @spec new(x :: float(), y :: float(), z :: float(), w :: float()) :: t()
  def new(x, y, z, w) do
    {x + 0.0, y + 0.0, z + 0.0, w + 0.0}
  end

  @spec add(vec1 :: t(), vec2 :: t()) :: t()
  def add({x1, y1, z1, w1}, {x2, y2, z2, w2}) do
    {x1 + x2, y1 + y2, z1 + z2, w1 + w2}
  end

  @spec normalize(vec :: t()) :: t()
  def normalize({x, y, z, w}) do
    sum_of_squares = x * x + y * y + z * z + w * w
    len = :math.sqrt(sum_of_squares)
    {x / len, y / len, z / len, w / len}
  end

  @spec scale(vec :: t(), scale :: float()) :: t()
  def scale({x, y, z, w}, scale) do
    {x * scale, y * scale, z * scale, w * scale}
  end

  @spec subtract(vec1 :: t(), vec2 :: t()) :: t()
  def subtract({x1, y1, z1, w1}, {x2, y2, z2, w2}) do
    {x1 - x2, y1 - y2, z1 - z2, w1 - w2}
  end

  @spec to_binary(vec :: t()) :: binary()
  def to_binary({x, y, z, w}) do
    <<x::float-native-size(32), y::float-native-size(32), z::float-native-size(32),
      w::float-native-size(32)>>
  end
end
