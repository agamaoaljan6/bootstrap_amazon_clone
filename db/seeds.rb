
# To run your seeds, do:
# rails db:seed

Product.destroy_all

NUM_QUESTIONS = 1000

NUM_QUESTIONS.times do
  created_at = Faker::Date.backward(365 * 5)
  q=Product.create(
    # Faker is a ruby module. We access classes
    # or other modules inside of it with ::.
    # Here, Hacker is a class inside of the
    # Faker module
    title: Faker::Hacker.say_something_smart,
    description: Faker::ChuckNorris.fact,
    price: Faker::Commerce.price(range=0...2000.0),
    created_at: created_at,
    updated_at: created_at
  )
    if q.valid?
      q.reviews = rand(0..15).times.map do
        Review.new({
          rating: Faker::Commerce.price(range=1..5.0),
          body: Faker::GreekPhilosophers.quote})
      end
    end
end

product = Product.all
review=Review.all

puts Cowsay.say("Generated #{product.count} product", :frogs)
puts Cowsay.say("Generated #{review.count} reviews", :tux)