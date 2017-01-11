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
  end

  def update
  end
end
