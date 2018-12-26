class DailyReportsController < ApplicationController
  def index
    @daily_reports = DailyReport.order(created_at: :desc)

  end

  def new
    @daily_report = DailyReport.new
    @daily_report.user = current_user
    @users = User.where(user_type: ['Admin', 'Staff']).order(first_name: :asc)
    @daily_report.shift_start = Time.new
    @daily_report.shift_end = Time.new + 1000
  end

  def create
    @daily_report = DailyReport.new(daily_report_params)
    @users = User.where(user_type: ['Admin', 'Staff']).order(first_name: :asc)
    @daily_report.shift_start = Time.new
    @daily_report.shift_end = Time.new + 1000
    if @daily_report.save

      redirect_to daily_reports_path, notice: 'Daily report created.'
    else
      render 'new'
    end
  end

  def edit
    @daily_report = DailyReport.find(params[:id])
    @users = User.where(user_type: ['Admin', 'Staff']).order(first_name: :asc)
  end

  def update
    @daily_report = DailyReport.find(params[:id])
    @daily_report.update(daily_report_params)
    @users = User.where(user_type: ['Admin', 'Staff']).order(first_name: :asc)

    if @daily_report.save
      redirect_to daily_reports_path, notice: 'Daily report updated.'
    else
      render 'edit'
    end
  end

private

  def daily_report_params
    params.require(:daily_report).permit(:user_id, :shift_start, :shift_end, :notes)
  end
end
