class ClinicsController < ApplicationController
  def index
    @requested = Clinic.requested
    @proposed = Clinic.proposed
    @scheduled = Clinic.scheduled
  end

  def show
    @clinic = Clinic.find(params[:id])
  end

  def vote
    @clinic = Clinic.find(params[:id])
    @clinic.votes.find_or_create_by!(user_id: current_user.id)
    redirect_to root_path
  end

  def propose
    @clinic = Clinic.find(params[:id])
    @clinic.proposer = current_user
    @clinic.proposed_at = Time.now
    @clinic.save!
    redirect_to clinic_path(@clinic)
  end

  def attend
    @clinic = Clinic.find(params[:id])
    @clinic.attendances.find_or_create_by!(user_id: current_user.id)
    redirect_to root_path
  end
end
