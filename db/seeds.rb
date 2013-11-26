50.times do |i|
  Post.create!(
    title: "Post №#{i.next}",
    content: "Content for post №#{i.next}"
  )
  print "."
end

puts "Posts created"