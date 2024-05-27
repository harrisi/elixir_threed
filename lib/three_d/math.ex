defmodule ThreeD.Math do
  @type degrees :: float()
  @type radians :: float()

  def cos(angle, kind \\ :degree)

  def cos(angle, :degree) do
    angle
    |> do_radian()
    |> do_cos()
  end

  def cos(angle, :radian) do
    do_cos(angle)
  end

  def radian(angle) do
    do_radian(angle)
  end

  def sin(angle, kind \\ :degree)

  def sin(angle, :degree) do
    angle
    |> do_radian()
    |> do_sin()
  end

  def sin(angle, :radian) do
    do_sin(angle)
  end

  ## Private

  @compile {:inline, do_cos: 1}
  defp do_cos(angle) do
    :math.cos(angle)
  end

  @compile {:inline, do_radian: 1}
  defp do_radian(angle) do
    angle * (180 / :math.pi())
  end

  @compile {:inline, do_sin: 1}
  defp do_sin(angle) do
    :math.sin(angle)
  end
end
