defmodule ThreeD.Mat4 do
  alias ThreeD.Vec3
  alias ThreeD.Vec4

  @type t :: {Vec4.t(), Vec4.t(), Vec4.t(), Vec4.t()}

  @spec flatten(matrix :: t()) ::
          {float(), float(), float(), float(), float(), float(), float(), float(), float(),
           float(), float(), float(), float(), float(), float(), float()}
  def flatten({{a0, a1, a2, a3}, {b0, b1, b2, b3}, {c0, c1, c2, c3}, {d0, d1, d2, d3}}) do
    {a0, a1, a2, a3, b0, b1, b2, b3, c0, c1, c2, c3, d0, d1, d2, d3}
  end

  @spec identity() :: t()
  def identity() do
    {
      {1.0, 0.0, 0.0, 0.0},
      {0.0, 1.0, 0.0, 0.0},
      {0.0, 0.0, 1.0, 0.0},
      {0.0, 0.0, 0.0, 1.0}
    }
  end

  @spec look_at(eye :: Vec3.t(), center :: Vec3.t(), up :: Vec3.t()) :: t()
  def look_at(eye, center, up) do
    f =
      center
      |> Vec3.subtract(eye)
      |> Vec3.normalize()

    s =
      f
      |> Vec3.cross(up)
      |> Vec3.normalize()

    u = Vec3.cross(s, f)

    {f0, f1, f2} = f
    {s0, s1, s2} = s
    {u0, u1, u2} = u

    {
      {s0, u0, -f0, 0.0},
      {s1, u1, -f1, 0.0},
      {s2, u2, -f2, 0.0},
      {-Vec3.dot(s, eye), -Vec3.dot(u, eye), Vec3.dot(f, eye), 1.0}
    }
  end

  @spec perspective(fov :: float(), aspect :: float(), near :: float(), far :: float()) :: t()
  def perspective(fov, aspect, near, far) do
    f = 1.0 / :math.tan(fov / 2)
    nf = 1 / (near - far)

    {
      {f / aspect, 0.0, 0.0, 0.0},
      {0.0, f, 0.0, 0.0},
      {0.0, 0.0, (far + near) * nf, -1.0},
      {0.0, 0.0, 2 * far * near * nf, 0.0}
    }
  end

  @spec to_binary(matrix :: t()) :: binary()
  def to_binary({a, b, c, d}) do
    Vec4.to_binary(a) <> Vec4.to_binary(b) <> Vec4.to_binary(c) <> Vec4.to_binary(d)
  end
end
