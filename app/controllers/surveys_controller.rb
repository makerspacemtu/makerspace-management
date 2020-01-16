class SurveysController < ApplicationController
  # load_and_authorize_resource
  respond_to :html, :json

  #def index
  #  redirect_to checkin_path
  #end

  def edit
    @survey = Survey.find(params[:id])
  end

  def new
    @survey_user = User.where(id: Punch.all.last.user_id).first
    current_trainings = @survey_user.trainings
    current_user_surveys = Survey.where(user_id: @survey_user.id)
    ids = current_user_surveys.map{|x| x.tool_id.to_i} #ids are all the surveys that pertain to the user
    @available_trainings = current_trainings.reject{|x| ids.include? x.id.to_i} #find all the trainings that the user has not done a survey on
    #Go back to checkin path if you have already completed your surveys
    if @available_trainings.count == 0
      redirect_to checkin_path
    else
      @survey = Survey.new
      respond_modal_with @survey
   end
  end

  def create
    @survey_user = User.where(id: Punch.all.last.user_id).first
    current_trainings = @survey_user.trainings.where.not(training_type: "Paperwork")
    current_user_surveys = Survey.where(user_id: @survey_user.id)
    ids = current_user_surveys.map{|x| x.tool_id.to_i}
    @available_trainings = current_trainings.reject{|x| ids.include? x.id.to_i}

    @survey = Survey.new(survey_params)

    if @survey.save
      redirect_to checkin_path, notice: 'Survey Completed.'
    else
      render 'new'
    end
  end

  def destroy
    @survey = Survey.find(params[:id])

    if @survey.destroy
      redirect_to surveys_path, notice: 'Survey deleted.'
    else
      render 'edit', error: @survey.errors
    end
  end


  def update
    @survey = Survey.find(params[:id])

    if @survey.update(survey_params)
      redirect_to surveys_path, notice: 'survey updated.'
    else
      render 'edit'
    end
  end

private

  def survey_params
    params.permit(:tool_name, :tool_id, :competency, :user_id)
  end
end
