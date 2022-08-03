FactoryBot.define do
  factory :user do
    nickname              { '伊藤' }
    email                 { Faker::Internet.free_email }
    password              { '2w2w2w' }
    password_confirmation { password }
    introduction          { 'テスト文章' }
    
    after(:build) do |user|
      user.image.attach(io: File.open('public/images/default_icon.png'), filename: 'test_image.png')
    end
  end
end
