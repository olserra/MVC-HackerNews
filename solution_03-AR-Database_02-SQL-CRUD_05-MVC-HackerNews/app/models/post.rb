class Post
  attr_reader :id, :text
  attr_accessor :title, :url, :votes

  def initialize(attributes = {})
    @id = attributes[:id]
    @text = attributes[:text]
    @url = attributes[:url]
    @votes = attributes[:votes] || 0
    @title = attributes[:title]
  end

  def self.find(id)
    DB.results_as_hash = true
    results = DB.execute("SELECT * FROM posts WHERE posts.id LIKE ?", id)
    if results == []
      nil
    else
      post_data = results.first
      Post.new(id: post_data["id"].to_i,
               title: post_data["title"],
               url: post_data["url"],
               votes: post_data["votes"],
               text: post_data["title"])
    end
  end

  def self.all
    DB.results_as_hash = true
    results = DB.execute("SELECT * FROM posts")
    results.map do |result|
      Post.new(id: result["id"].to_i,
               title: result["title"],
               url: result["url"],
               votes: result["votes"],
               text: result["title"])
    end
  end

  def destroy
    DB.execute("DELETE FROM posts WHERE id = ? ", @id)
  end

  def save
    @id.nil? ? create : update
  end

  private

  def update
    DB.execute("UPDATE posts SET url = ?, title = ?, votes = ? WHERE id = ?", @url, @title, @votes, @id)
  end

  def create
    DB.execute("INSERT INTO posts (title, url, votes) VALUES (?, ?, ?)", @title, @url, @votes)
    @id = DB.last_insert_row_id
  end
end
