defmodule AlzhmrPhotoWeb.ArticlesLive do
  use AlzhmrPhotoWeb, :live_view

  alias AlzhmrPhotoWeb.LiveEncoder

  @topic "articles"

  @impl  Phoenix.LiveView
  def mount(_params, _session, socket) do
    AlzhmrPhotoWeb.Endpoint.subscribe(@topic)

    {:ok, assign_socket(socket), temporary_assigns: [articles: []]}
  end

  @impl  Phoenix.LiveView
  def handle_info(%{event: "update"}, socket) do
    {:noreply, assign_socket(socket)}
  end

  def render_article(socket, %{id: _id, slug: _slug} = article,counter ) do
    Phoenix.View.render(AlzhmrPhotoWeb.PageView, "article.html", socket: socket, article: article , counter: counter)
  end

  defp assign_socket(socket) do
    case fetch_articles() do
      {:ok, articles} ->
        socket
        |> assign(:page_title, "Display info: ")
        |> assign(:articles, articles)
        |> put_flash(:error, nil)

      _ ->
        socket
        |> assign(:page_title, "Display info:")
        |> assign(:articles, nil)
        |> put_flash(:error, "Error fetching data")
    end
  end

  defp fetch_articles do
    with {:ok, articles} <- AlzhmrPhoto.articles() do
      articles
      |> Enum.sort_by(& &1.published_at)
      |> LiveEncoder.articles()

      {:ok, articles}
    end
  end
end
