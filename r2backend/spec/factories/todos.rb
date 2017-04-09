FactoryGirl.define do
  factory :todo do
    task "This is a task"
    is_completed false
  end
end
