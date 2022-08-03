FactoryBot.define do
  factory :comment do
    comment       { 'テスト' }

    association   :user
    association   :article
  end
end
