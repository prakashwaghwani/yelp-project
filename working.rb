class YelpApi

attr_reader :client
  def initialize
    @client = Yelp::Client.new({
      consumer_key: ENV['CONSUMER_KEY'],
      consumer_secret:  ENV['CONSUMER_SECRET'],
      token: ENV['TOKEN'],
      token_secret:  ENV['TOKEN_SECRET']
    })
end

  def find_restaurants_by_location_type_rating(location, radius, cuisine, rating_input)
    # binding.pry
    new_array = client.search(location, {radius_filter: radius, category_filter: cuisine, rating: rating_input})
    new_array.businesses.collect.with_index(1) do |x, index|
      # if x.radius_filter >= rating_input
      if x.rating >= rating_input
        "#{index}.  #{x.name} => #{x.rating}."
      end
    end.compact
  end

  def find_restaurants_by_location_num_of_reviews(location, category, review)
    new_array = client.search(location, {category_filter: category, review_count: review})
    new_array.businesses.collect.with_index(1) do |x, index|
      if x.review_count >= review
        "#{index}.  #{x.name} => #{x.review_count} reviews."
      end
    end.compact
  end

  def find_restaurant_by_cuisine(location, cuisine)
    new_array = client.search(location, {category_filter: cuisine})
    new_array.businesses.collect.with_index(1) do |x, index|
      "#{index}.  #{x.name} => #{x.review_count} reviews."
      end
    end

  def help
    puts " Your options are as follows:
     1) ratings
     2) reviews
     3) cuisine
     4) help
     5) exit

     Please type your option: "
  end

  def exit_food
  puts "exit"
  exit
  end

  def call
    show_menu
    input = gets.chomp
    while input != "exit"
      case input
      when "ratings"

        puts "At what city are you in today?"
        location = gets.chomp.to_s
        puts "How many miles do you want to walk? (eg. 1 mile)?"
        radius = gets.chomp.to_i
        puts "What do you feel like eating today?"
        cuisine = gets.chomp.to_s
        puts "What's the lowest rating of restaurant you want to eat at?"
        rating_input = gets.chomp.to_f
        puts find_restaurants_by_location_type_rating(location, radius, cuisine, rating_input)

      when "reviews"

        puts "At what city do you want to dine in today?"
        location = gets.chomp.to_s
        puts "do you want to eat at a cafe or restaurant?"
        category = gets.chomp.to_s
        puts "How many reviews do you want the place to have?"
        review = gets.chomp.to_f
        puts find_restaurants_by_location_num_of_reviews(location, category, review)

      when "cuisine"
        puts "At what city do you want to dine in today?"
        location = gets.chomp.to_s
        puts "What kind of cuisine do you want to eat?"
        cuisine = gets.chomp.to_s
        puts find_restaurant_by_cuisine(location, cuisine)

      when "help"
        help

      when "exit"
        exit_food
      else

        puts "do nothing"
      end
      show_menu
      input = gets.chomp
    end
  end

  def show_menu
    puts "Welcome to Yelp.
    Your options are as follows:
     1) ratings
     2) reviews
     3) cuisine
     4) help
     5) exit
     Please type your option: "
  end

  def run
    # client
    call
    # binding.pry
  end
end
