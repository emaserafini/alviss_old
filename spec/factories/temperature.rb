FactoryGirl.define do
  factory :temperature, class: Datapoint::Temperature do
    association :stream, factory: :stream
    value 20
    scale 'C'
  end
end
