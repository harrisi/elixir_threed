defmodule ThreeD.Vec3 do
  @type t :: {float(), float(), float()}

  @spec new(x :: float(), y :: float(), z :: float()) :: t()
  def new(x, y, z) do
    {x + 0.0, y + 0.0, z + 0.0}
  end

  @spec add(vec1 :: t(), vec2 :: t()) :: t()
  def add({x1, y1, z1}, {x2, y2, z2}) do
    {x1 + x2, y1 + y2, z1 + z2}
  end

  @spec cross(vec1 :: t(), vec2 :: t()) :: t()
  def cross({x1, y1, z1}, {x2, y2, z2}) do
    {
      y1 * z2 - z1 * y2,
      z1 * x2 - x1 * z2,
      x1 * y2 - y1 * x2
    }
  end

  @spec dot(vec1 :: t(), vec2 :: t()) :: float()
  def dot({x1, y1, z1}, {x2, y2, z2}) do
    x1 * x2 + y1 * y2 + z1 * z2
  end

  @spec normalize(vec :: t()) :: t()
  def normalize({x, y, z}) do
    sum_of_squares = x * x + y * y + z * z
    len = :math.sqrt(sum_of_squares)
    {x / len, y / len, z / len}
  end

  @spec scale(vec :: t(), scale :: float()) :: t()
  def scale({x, y, z}, scale) do
    {x * scale, y * scale, z * scale}
  end

  @spec subtract(vec1 :: t(), vec2 :: t()) :: t()
  def subtract({x1, y1, z1}, {x2, y2, z2}) do
    {x1 - x2, y1 - y2, z1 - z2}
  end
end
