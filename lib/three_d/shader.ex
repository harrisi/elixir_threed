defmodule ThreeD.Shader do
  def init(vertex_path, fragment_path) do
    vertex_code = File.read!(vertex_path)
    fragment_code = File.read!(fragment_path)

    vertex_shader = compile_shader(vertex_code, :gl_const.gl_vertex_shader)
    fragment_shader = compile_shader(fragment_code, :gl_const.gl_fragment_shader)

    shader_program = :gl.createProgram()
    :gl.attachShader(shader_program, vertex_shader)
    :gl.attachShader(shader_program, fragment_shader)
    :gl.linkProgram(shader_program)
    check_program_linking(shader_program)

    :gl.deleteShader(vertex_shader)
    :gl.deleteShader(fragment_shader)

    shader_program
  end

  defp compile_shader(source, type) do
    shader = :gl.createShader(type)
    :gl.shaderSource(shader, [source <> <<0>>])
    :gl.compileShader(shader)
    check_shader_compilation(shader)
    shader
  end

  defp check_shader_compilation(shader) do
    status = :gl.getShaderiv(shader, :gl_const.gl_compile_status)
    unless status == :gl_const.gl_true do
      buf_size = :gl.getShaderiv(shader, :gl_const.gl_info_log_length)
      info_log = :gl.getShaderInfoLog(shader, buf_size)
      raise "Shader compilation error: #{info_log}"
    end
  end

  defp check_program_linking(program) do
    status = :gl.getProgramiv(program, :gl_const.gl_link_status)
    unless status == :gl_const.gl_true do
      buf_size = :gl.getProgramiv(program, :gl_const.gl_info_log_length)
      info_log = :gl.getProgramInfoLog(program, buf_size)
      raise "Program linking error: #{info_log}"
    end
  end
end
