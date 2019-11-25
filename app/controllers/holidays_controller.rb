class HolidaysController < ApplicationController
  before_action :set_holiday, only: [:show, :edit, :update, :destroy]

  def index
    @holidays = Holiday.all
  end

  def show
  end

  def new
    @holiday = Holiday.new
  end

  def edit
  end

  def create
    @holiday = Holiday.new(holiday_params)
    if @holiday.save
      redirect_to holidays_path
    else
      render :new
    end
  end

  def update
    if @holiday.update
      redirect_to holiday_path(@holiday)
    else
      render :edit
    end
  end

  def destroy
  end

  private
  def set_holiday
    @holiday = Holiday.find(params[:id])
  end

  def holiday_params
    params.require(:employee).permit!
  end
end