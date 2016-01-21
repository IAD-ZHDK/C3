class RequestController < ApplicationController
  before_action :authenticate_user!

  def new
    @clinic = prepare
  end

  def create
    @clinic = prepare
    @clinic.assign_attributes(permitted_params[:clinic])
    if @clinic.save
      current_user.vote!(@clinic)
      redirect_to clinic_path(@clinic)
    else
      render 'new'
    end
  end

  protected

  def prepare
    @clinic = Clinic.new
    @clinic.requester = current_user
    @clinic.requested_at = Time.now
    @clinic
  end

  def permitted_params
    params.permit(clinic: [:title, :description])
  end
end
