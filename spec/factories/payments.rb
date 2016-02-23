FactoryGirl.define do

  factory :payment, class: Payment do
  	item Faker::Book.title
  	date Faker::Date.between(2.days.ago, Date.today)  
  	cost Faker::Number.number(2)
  	user_id Faker::Number.between(1, 10)
  end

end
