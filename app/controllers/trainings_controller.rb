class TrainingsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def edit
    @training = Training.find(params[:id])
  end

  def new
    @training = Training.new
  end

  def create
    @training = Training.new(training_params)

    if @training.save
      redirect_to trainings_path, notice: 'Training created.'
    else
      render 'new'
    end
  end

  def update
    @training = Training.find(params[:id])

    if @training.update(training_params)
      redirect_to trainings_path, notice: 'Training updated.'
    else
      render 'edit'
    end
  end

private

  def training_params
    params.require(:training).permit(:name, :icon, :training_type)
  end
end
