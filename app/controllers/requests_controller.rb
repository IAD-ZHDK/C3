class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    @request = Request.new(permitted_params[:request])
    if @request.save
      redirect_to overview_path
    else
      render 'new'
    end
  end

  def vote
    @request = Request.find(params[:id])
    @request.votes.find_or_create_by(user_id: current_user.id)
    redirect_to overview_path
  end

  protected

  def permitted_params
    params.permit(request: [:title, :description])
  end
end
