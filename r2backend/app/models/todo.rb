class Todo < ApplicationRecord
  validates :task, presence: true


  def can_delete?
    !is_completed
  end

  def complete!
    is_completed = true
    save
  end

end
