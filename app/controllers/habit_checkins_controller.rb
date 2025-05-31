class HabitCheckinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit

  def create
    @habit_checkin = @habit.habit_checkins.create(checkin_date: Date.parse(params[:date]))
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to habit_path(@habit) }
    end
  end
  
  def destroy
    @habit_checkin = @habit.habit_checkins.find_by(checkin_date: Date.parse(params[:date]))
    @habit_checkin.destroy if @habit_checkin
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to habit_path(@habit) }
    end
  end
  
  private

  def set_habit
    @habit = current_user.habits.find(params[:habit_id])
  end
end
