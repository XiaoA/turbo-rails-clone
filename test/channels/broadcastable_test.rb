require "test_helper"

class TurboClone::BroadcastableTest < ActionCable::Channel::TestCase
  include TurboClone::ActionHelper

  test "#broadcast_append_to" do
    article = Article.create! content: "content"

    assert_broadcast_on "stream", turbo_stream_action_tag(:append, target: "articles", template: render(article)) do
      article.broadcast_append_to "stream"      
    end
  end
end
