FactoryGirl.define do
  factory :feed do
    name 'temperature'
    data_kind 'data_temperature'
  end


  factory :data_temperature do
    value 20
  end
end
