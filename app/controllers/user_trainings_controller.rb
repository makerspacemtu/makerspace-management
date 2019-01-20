class UserTrainingsController < ApplicationController
  load_and_authorize_resource

  def new

    @user_trainings = Training.all
    @user_training = UserTraining.new
    @user = User.find(params[:user_id])

  end

  def create
    user = User.find(params[:user_id])
    training = Training.find(user_training_params[:training_id])

    if UserTraining.exists?(user: user, training: training)
      redirect_to new_user_user_training_path(user), notice: 'User training already exists.'
      return
    end

    @user_training = UserTraining.new
    @user_training.training = training
    @user_training.user = user
    @user_training.created_by = current_user

    if @user_training.save
      redirect_to new_user_user_training_path(user), notice: "User trained on #{training.name}."
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @user_training = @user.trainings.find(params[:training_id])
    @user_training.destroy

    if @user_training.destroyed?
      redirect_to user_path(@user), notice: 'User training removed.'
      return
    else
      redirect_to user_path(@user), notice: 'An error occurred trying to remove the user training.'
      return
    end
  end



private

  def user_training_params
    params.require(:user_training).permit(:training_id)
  end
end
