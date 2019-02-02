require_relative "../models/post.rb"
require_relative "../views/posts_view.rb"

class PostsController
  def initialize
    @view = PostsView.new
  end

  def index
    posts = Post.all
    @view.display_all(posts)
  end

  def create
    title = @view.ask_user_for("title")
    url = @view.ask_user_for("url")
    post = Post.new(title: title, url: url)
    post.save
  end

  def update
    index
    id = @view.ask_user_for("id").to_i
    post = Post.find(id)
    title = @view.ask_user_for("new title")
    url = @view.ask_user_for("new url")
    post = Post.new(title: title, url: url, id: id)
    post.save
  end

  def destroy
    index
    id = @view.ask_user_for("id").to_i
    post = Post.find(id)
    post.destroy
  end

  def upvote
    index
    id = @view.ask_user_for("id").to_i
    post = Post.find(id)
    post.votes += 1
    post.save
  end
end
