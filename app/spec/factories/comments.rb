FactoryBot.define do
  factory :comment do
    comment       { 'ใในใ' }

    association   :user
    association   :article
  end
end
