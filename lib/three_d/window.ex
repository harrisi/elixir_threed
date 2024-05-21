defmodule ThreeD.Window do
  def init() do
    opts = [size: {1200, 800}]

    wx = :wx.new()

    frame = :wxFrame.new(wx, :wx_const.wx_id_any, ~c"Elixir 3D OpenGL", opts)

    :wxWindow.connect(frame, :close_window)

    :wxFrame.show(frame)


    gl_attrib = [
      attribList: [
        :wx_const.wx_gl_core_profile,
        :wx_const.wx_gl_major_version, 4,
        :wx_const.wx_gl_minor_version, 1,
        :wx_const.wx_gl_doublebuffer,
        :wx_const.wx_gl_depth_size, 24,
        :wx_const.wx_gl_sample_buffers, 1,
        :wx_const.wx_gl_samples, 4,
        0
      ]
    ]

    canvas = :wxGLCanvas.new(frame, opts ++ gl_attrib)
    ctx = :wxGLContext.new(canvas)

    cursor = :wxCursor.new(:wx_const.wx_cursor_blank)
    :wxWindow.setCursor(canvas, cursor)

    :wxWindow.captureMouse(canvas)

    :wxGLCanvas.setFocus(canvas)

    :wxGLCanvas.setCurrent(canvas, ctx)

    :wxGLCanvas.connect(canvas, :key_down)
    :wxGLCanvas.connect(canvas, :key_up)
    :wxGLCanvas.connect(canvas, :motion)
    :wxGLCanvas.connect(canvas, :mousewheel, [:callback])
    # :wxGLCanvas.connect(canvas, :mousewheel, [callback: &cb/2])

    %{
      frame: frame,
      canvas: canvas,
      context: ctx,
    }
  end

  def cb(a, b) do
    IO.inspect(a)
    IO.inspect(b)
    IO.inspect(self())
  end

end
