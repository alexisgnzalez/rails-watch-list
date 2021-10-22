require 'open-uri'
require 'json'

puts "Cleaning up database..."
Bookmark.destroy_all
Review.destroy_all
List.destroy_all
Movie.destroy_all
puts "Database cleaned"

url = "http://tmdb.lewagon.com/movie/top_rated"
10.times do |i|
  puts "Importing movies from page #{i + 1}"
  movies = JSON.parse(open("#{url}?page=#{i + 1}").read)['results']
  movies.each do |movie|
    puts "Creating #{movie['title']}"
    base_poster_url = "https://image.tmdb.org/t/p/original"
    Movie.create(
      title: movie['title'],
      overview: movie['overview'],
      poster_url: "#{base_poster_url}#{movie['backdrop_path']}",
      rating: movie['vote_average']
    )
  end
end
puts "Movies created"

file = URI.open('https://images.unsplash.com/photo-1538151790645-80dd86cda1ce?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=774&q=80')
article = List.new(name: 'Favorites')
article.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
article.save
