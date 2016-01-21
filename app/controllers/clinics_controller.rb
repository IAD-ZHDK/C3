class ClinicsController < ApplicationController
  before_action :authenticate_user!, only: [:vote, :propose, :attend]

  def index
    @requested = Clinic.requested
    @proposed = Clinic.proposed
    @scheduled = Clinic.scheduled
  end

  def show
    @clinic = Clinic.find(params[:id])
  end

  def vote
    current_user.vote!(Clinic.find(params[:id]))
    redirect_to root_path
  end

  def attend
    current_user.attend!(Clinic.find(params[:id]))
    redirect_to root_path
  end
end
