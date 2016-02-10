class AdoptController < ApplicationController
  before_action :authenticate_user!

  def edit
    @clinic = fetch
  end

  def update
    @clinic = fetch
    @clinic.proposer = current_user
    @clinic.proposed_at = Time.now
    @clinic.assign_attributes(permitted_params[:clinic])
    if @clinic.save
      current_user.vote!(@clinic)
      AdoptionNotificationJob.perform_later(@clinic)
      redirect_to clinic_path(@clinic)
    else
      render 'edit'
    end
  end

  protected

  def fetch
    Clinic.find(params[:id])
  end

  def permitted_params
    params.permit(clinic: [:title, :description, :required_votes])
  end
end
