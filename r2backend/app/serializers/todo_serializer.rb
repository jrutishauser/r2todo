class TodoSerializer < ActiveModel::Serializer
  attributes :id, :task, :is_completed
end
