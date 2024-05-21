defmodule ThreeD.OpenGL do
  def init do
    do_enables()

    vertices = [
      # Front face
      -0.5, -0.5,  0.5,
       0.5, -0.5,  0.5,
       0.5,  0.5,  0.5,
      -0.5,  0.5,  0.5,
      # Back face
      -0.5, -0.5, -0.5,
       0.5, -0.5, -0.5,
       0.5,  0.5, -0.5,
      -0.5,  0.5, -0.5,
    ] |> Enum.reduce(<<>>, fn el, acc -> acc <> <<el::float-native-size(32)>> end)

    indices = [
      0, 2, 1, 2, 0, 3, # Front face
      4, 5, 6, 6, 7, 4, # Back face
      3, 4, 7, 4, 3, 0, # Left face
      2, 6, 5, 5, 1, 2, # Right face
      4, 1, 5, 1, 4, 0, # Bottom face
      7, 6, 2, 2, 3, 7, # Top face
    ] |> Enum.reduce(<<>>, fn el, acc -> acc <> <<el::unsigned-native-size(32)>> end)

    instance_offsets = for x <- 0..49, y <- 0..49, z <- 0..49 do
      [x, y, z]
    end
    |> List.flatten
    |> Enum.reduce(<<>>, fn el, acc -> acc <> <<el::float-native-size(32)>> end)

    [vao] = :gl.genVertexArrays(1)
    [vbo, ebo, instance_vbo] = :gl.genBuffers(3)

    :gl.bindVertexArray(vao)

    :gl.bindBuffer(:gl_const.gl_array_buffer, vbo)
    :gl.bufferData(:gl_const.gl_array_buffer, byte_size(vertices), vertices, :gl_const.gl_static_draw)

    :gl.bindBuffer(:gl_const.gl_element_array_buffer, ebo)
    :gl.bufferData(:gl_const.gl_element_array_buffer, byte_size(indices), indices, :gl_const.gl_static_draw)

    :gl.vertexAttribPointer(0, 3, :gl_const.gl_float, :gl_const.gl_false, 3 * byte_size(<<0.0::float-size(32)>>), 0)
    :gl.enableVertexAttribArray(0)

    :gl.bindBuffer(:gl_const.gl_array_buffer, instance_vbo)
    :gl.bufferData(:gl_const.gl_array_buffer, byte_size(instance_offsets), instance_offsets, :gl_const.gl_static_draw)

    :gl.vertexAttribPointer(1, 3, :gl_const.gl_float, :gl_const.gl_false, 3 * byte_size(<<0.0::float-size(32)>>), 0)
    :gl.enableVertexAttribArray(1)
    :gl.vertexAttribDivisor(1, 1)

    :gl.bindBuffer(:gl_const.gl_array_buffer, 0)
    :gl.bindVertexArray(0)

    %{vao: vao}
  end

  defp do_enables() do
    :gl.enable(:gl_const.gl_depth_test)
    :gl.enable(:gl_const.gl_multisample)
    :gl.enable(:gl_const.gl_cull_face)
  end

end
