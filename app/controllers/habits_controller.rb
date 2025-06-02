class HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit, only: [:show, :edit, :update, :destroy]

  def index
    @habits = current_user.habits.includes(:habit_checkins)
  end

  def show
    @habit = Habit.find(params[:id])
  end

  def new
    @habit = current_user.habits.new
  end

  def create
    @habit = current_user.habits.new(habit_params)
    if @habit.save
      redirect_to @habit, notice: "Habit created!"
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @habit.update(habit_params)
      redirect_to @habit, notice: "Habit updated!"
    else
      render :edit
    end
  end

  def destroy
    @habit.destroy
    redirect_to habits_path, notice: "Habit deleted!"
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:id])
  end

  def habit_params
    params.require(:habit).permit(:name, :description)
  end
end
