FactoryBot.define do
  factory :article do
    title                 { 'テストタイトル' }
    genre_id              { 2 }
    country_id            { 9 }
    text                  { 'テスト本文' }
    association :user

    after(:build) do |article|
      article.image.attach(io: File.open('public/images/default_icon.png'), filename: 'test_imag.png')
    end
  end
end
