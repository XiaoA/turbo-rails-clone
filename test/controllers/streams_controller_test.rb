require "test_helper"

class TurboClone::StreamsControllerTest < ActionDispatch::IntegrationTest
  test "create with respond_to?" do
    post articles_path, params: { article: { content: "content" } }
    assert_redirected_to articles_path

    post articles_path, params: { article: { content: "content" } }, as: :turbo_stream
    assert_turbo_stream action: "prepend", target: "articles"
  end

  test "update with respond_to?" do
    article = Article.create! content: "content"

    patch article_path(article), params: { article: { content: "update" } }
    assert_redirected_to articles_path

    patch article_path, params: { article: { content: "update" } }, as: :turbo_stream
    assert_turbo_stream action: "replace", target: article
  end

  test "destroy with respond_to?" do
    article = Article.create! content: "content"

    delete article_path(article)
    assert_redirected_to articles_path

    article = Article.create! content: "content"

    delete article_path(article), as: :turbo_stream
    assert_turbo_stream action: "remove", target: article
  end

  test "show all turbo actions" do
    article = Article.create! content: "content"
    get article_path(article), as: :turbo_stream

    assert_dom_equal <<~HTML, @response.body
    <turbo-stream action="remove" target="#{dom_id(article)}"></turbo-stream>
    <turbo-stream action="update" target="#{dom_id(article)}"><template>#{render(article)}</template></turbo-stream>
    <turbo-stream action="replace" target="#{dom_id(article)}"><template>update</template></turbo-stream>
    <turbo-stream action="prepend" target="articles"><template>#{render(article)}</template></turbo-stream>
    <turbo-stream action="prepend" target="articles"><template>#{render(article)}</template></turbo-stream>
   HTML
  end
end
