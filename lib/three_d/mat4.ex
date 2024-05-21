defmodule ThreeD.Mat4 do
  def identity do
    [
      [1.0, 0.0, 0.0, 0.0],
      [0.0, 1.0, 0.0, 0.0],
      [0.0, 0.0, 1.0, 0.0],
      [0.0, 0.0, 0.0, 1.0]
    ]
  end

  def lookAt(eye, center, up) do
    f = normalize(subtract(center, eye))
    s = normalize(cross(f, up))
    u = cross(s, f)

    [f0, f1, f2] = f
    [s0, s1, s2] = s
    [u0, u1, u2] = u

    [
      [s0, u0, -f0, 0.0],
      [s1, u1, -f1, 0.0],
      [s2, u2, -f2, 0.0],
      [-dot(s, eye), -dot(u, eye), dot(f, eye), 1.0]
    ]
  end

  def perspective(fov, aspect, near, far) do
    f = 1.0 / :math.tan(fov / 2)
    nf = 1 / (near - far)

    [
      [f / aspect, 0.0, 0.0, 0.0],
      [0.0, f, 0.0, 0.0],
      [0.0, 0.0, (far + near) * nf, -1.0],
      [0.0, 0.0, (2 * far * near) * nf, 0.0]
    ]
  end

  def to_binary(matrix) do
    matrix
    |> Enum.flat_map(& &1)
    |> Enum.reduce(<<>>, fn el, acc -> acc <> <<el::float-native-size(32)>> end)
  end

  defp subtract([x1, y1, z1], [x2, y2, z2]), do: [x1 - x2, y1 - y2, z1 - z2]

  defp normalize(vec) do
    len = :math.sqrt(Enum.reduce(vec, 0, fn x, acc -> acc + x * x end))
    Enum.map(vec, &(&1 / len))
  end

  defp cross([x1, y1, z1], [x2, y2, z2]) do
    [y1 * z2 - z1 * y2, z1 * x2 - x1 * z2, x1 * y2 - y1 * x2]
  end

  defp dot([x1, y1, z1], [x2, y2, z2]), do: x1 * x2 + y1 * y2 + z1 * z2
end

defmodule ThreeD.Vec3 do
  def new(x, y, z), do: [x, y, z] |> Enum.map(& &1 + 0.0)

  def add([x1, y1, z1], [x2, y2, z2]), do: [x1 + x2, y1 + y2, z1 + z2]

  def normalize(vec) do
    len = :math.sqrt(Enum.reduce(vec, 0, fn x, acc -> acc + x * x end))
    Enum.map(vec, &(&1 / len))
  end

  def scale([x, y, z], s) do
    [x * s, y * s, z * s]
  end

  def subtract([x1, y1, z1], [x2, y2, z2]) do
    [x1 - x2, y1 - y2, z1 - z2]
  end

  def cross([x1, y1, z1], [x2, y2, z2]) do
    [y1 * z2 - z1 * y2, z1 * x2 - x1 * z2, x1 * y2 - y1 * x2]
  end
end
