require "test_helper"

class TurboClone::StreamsControllerTest < ActionDispatch::IntegrationTest
  test "create with respond_to?" do
    post articles_path, params: { article: { content: "content" } }
    assert_redirected_to articles_path
  end

  test "update with respond_to?" do
    article = Article.create! content: "content"

    patch article_path(article), params: { article: { content: "update" } }
    assert_redirected_to articles_path
  end

  test "destroy with respond_to?" do
    article = Article.create! content: "content"

    delete article_path(article)
    assert_redirected_to articles_path
  end
end
