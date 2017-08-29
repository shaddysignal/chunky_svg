defmodule ChunkySVG do
  def render(drawing) when is_tuple(drawing) do
    render([drawing])
  end

  def render(drawing) when is_list(drawing) do
    _render(%{viewBox: "0 0 100 100", xmlns: "http://www.w3.org/2000/svg"}, drawing)
  end

  def render(svg_attrs, drawing) when is_map(svg_attrs) and is_list(drawing) do
    _render(svg_attrs, drawing)
  end

  defp _render(svg_attrs, drawing) do
    drawing = drawing |>
      ChunkySVG.Builtin.expand |>
      ChunkySVG.InlineMacro.expand

    {:svg, svg_attrs, drawing} |> XmlBuilder.generate
  end
end
