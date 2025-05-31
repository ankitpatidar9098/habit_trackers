module HabitsHelper
    def current_streak(habit)
      streak = 0
      today = Date.today
      loop do
        break unless habit.habit_checkins.exists?(checkin_date: today - streak)
  
        streak += 1
      end
      streak
    end
  
    def longest_streak(habit)
      dates = habit.habit_checkins.order(checkin_date: :asc).pluck(:checkin_date)
      return 0 if dates.empty?
  
      max_streak = streak = 1
      dates.each_cons(2) do |d1, d2|
        if d2 == d1 + 1
          streak += 1
        else
          max_streak = [max_streak, streak].max
          streak = 1
        end
      end
      [max_streak, streak].max
    end
  end  