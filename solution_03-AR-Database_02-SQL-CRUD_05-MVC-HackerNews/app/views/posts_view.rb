class PostsView
  def ask_user_for(string)
    puts "#{string}?"
    print "> "
    gets.chomp
  end

  def display_all(posts)
    puts "---------------------------------"
    puts "----------- All Posts -----------"
    puts "---------------------------------"
    puts ""
    posts.each do |post|
      puts "#{post.id} - #{post.title} (#{post.votes} vote(s))"
    end
    puts ""
    puts "---------------------------------"
  end
end
