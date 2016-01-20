class RequestController < ApplicationController
  before_action :authenticate_user!

  def new
    @clinic = Clinic.new
  end

  def create
    @clinic = Clinic.new(permitted_params[:clinic])
    @clinic.requester = current_user
    @clinic.requested_at = Time.now
    if @clinic.save
      redirect_to clinic_path(@clinic)
    else
      render 'new'
    end
  end

  protected

  def permitted_params
    params.permit(clinic: [:title, :description])
  end
end
