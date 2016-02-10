class ScheduleController < ApplicationController
  before_action :authenticate_user!

  def edit
    @clinic = fetch
  end

  def update
    @clinic = fetch
    @clinic.assign_attributes(permitted_params[:clinic])
    @clinic.scheduled_at = Time.now
    if @clinic.save
      current_user.confirm!(@clinic)
      SchedulingNotificationJob.perform_later(@clinic)
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
    params.permit(clinic: [:title, :description, :appointment])
  end
end
