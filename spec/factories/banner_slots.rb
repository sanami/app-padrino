FactoryGirl.define do
  factory :banner_slot do
    sequence(:slot_name) { |n| "slot#{n}" }

    trait :with_banner_contents do
      after(:create) do |slot|
        slot.banner_contents << FactoryGirl.create(:banner_content)
        slot.banner_contents << FactoryGirl.create(:banner_content)
        slot.banner_contents << FactoryGirl.create(:banner_content)
      end
    end

    factory :banner_slot_with_content, traits: [:with_banner_contents]
  end
end
