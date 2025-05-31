class HabitCheckinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit

  def create
    @habit.habit_checkins.create(checkin_date: Date.parse(params[:date]))
    redirect_to habit_path(@habit)
  end

  def destroy
    @habit.habit_checkins.find_by(checkin_date: Date.parse(params[:date]))&.destroy
    redirect_to habit_path(@habit)
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:habit_id])
  end
end
