class TrainingsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json

  def index
  end

  def show
    @training = Training.find(params[:id])
  end

  def edit
    @training = Training.find(params[:id])
  end

  def new
    @training = Training.new
    respond_modal_with @training
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

  def nullifyagreements

    @training = Training.where(name: params[:name])
    if @training.exists? == true
      if @training.first.id == Training.all.last.id
        maker_agree_id = Training.all.last.id.to_i + 1
        #puts "IF STATE TRUE: #{maker_agree_id}"
        @training.first.delete
      else
        @training.first.delete
        maker_agree_id = Training.all.last.id.to_i + 1
        #puts "IF STATE FALSE: #{maker_agree_id}"
      end
      @training2 = Training.new(id: (maker_agree_id).to_s, name: params[:name], training_type: "Paperwork", icon: "")
      @training2.save
      redirect_to coaches_users_path, notice: "All Current #{params[:name]}s Nullified."
    else
      @training2 = Training.new(id: (Training.all.last.id.to_i + 1).to_s,name: params[:name], training_type: "Paperwork", icon: "")
      @training2.save
      redirect_to coaches_users_path, notice: "Created new Paperwork training."
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
    user = User.all.find(droptraining_params[:user_id])
    if UserTraining.all.where(training_id: droptraining_params[:training_id]).where(user_id: droptraining_params[:user_id]).exists?
      user_training = UserTraining.all.where(training_id: droptraining_params[:training_id]).where(user_id: droptraining_params[:user_id])
      user_training.first.delete
      redirect_to user_path(droptraining_params[:user_id]), notice: "User training deleted."
    else
      redirect_to user_path(droptraining_params[:user_id]), notice: "Could not delete user training."
    end
  end

private

  # def nullifyagreements_params
  #   params.permit(:training_id,:user_id, :utf8, :authenticity_token, :commit)
  # end
  def droptraining_params
    params.permit(:training_id,:user_id, :utf8, :authenticity_token, :commit)
  end

  def training_params
    params.require(:training).permit(:name, :icon, :training_type)
  end
end
