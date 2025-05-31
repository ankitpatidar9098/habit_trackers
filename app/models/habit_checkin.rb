class HabitCheckin < ApplicationRecord
  belongs_to :habit
  validates :checkin_date, uniqueness: { scope: :habit_id }
end
