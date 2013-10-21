FactoryGirl.define do
  factory :banner_content do
    sequence(:html_content) { |n| "html_content#{n}" }
  end
end
