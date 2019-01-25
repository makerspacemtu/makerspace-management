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

  def destroy
    @training = Training.find(params[:id])

    if @training.destroy
      redirect_to trainings_path, notice: 'Training deleted.'
    else
      render 'edit', error: @training.errors
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

  def droptraining

    if UserTraining.all.where(training_id: droptraining_params[:training_id]).where(user_id: droptraining_params[:user_id]).exists?
      user_training = UserTraining.all.where(training_id: droptraining_params[:training_id]).where(user_id: droptraining_params[:user_id])
      user_training.first.delete
      redirect_to trainings_path, notice: "User training deleted."
    else
      redirect_to trainings_path, notice: "Could not delete user training."
    end
  end

private
  def droptraining_params
    params.permit(:training_id,:user_id, :utf8, :authenticity_token, :commit)
  end

  def training_params
    params.require(:training).permit(:name, :icon, :training_type)
  end
end
