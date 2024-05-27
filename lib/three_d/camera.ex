defmodule ThreeD.Camera do
  alias ThreeD.Math
  alias ThreeD.Vec3

  @type t :: %__MODULE__{
          pos: Vec3.t(),
          front: Vec3.t(),
          up: Vec3.t(),
          yaw: float(),
          pitch: float()
        }
  defstruct pos: Vec3.new(0, 0, 5),
            front: Vec3.new(0, 0, -1),
            up: Vec3.new(0, 1, 0),
            yaw: -90.0,
            pitch: 0.0

  @spec point(camera :: t(), pitch :: Math.degrees(), yaw :: Math.degrees()) :: t()
  def point(%__MODULE__{} = camera, pitch, yaw) do
    front =
      Vec3.new(
        Math.cos(yaw) * Math.cos(pitch),
        Math.sin(pitch),
        Math.sin(yaw) * Math.cos(pitch)
      )

    front = Vec3.normalize(front)

    %__MODULE__{camera | front: front, pitch: pitch, yaw: yaw}
  end
end
