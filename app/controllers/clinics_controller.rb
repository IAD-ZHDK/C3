class ClinicsController < ApplicationController
  before_action :authenticate_user!, only: [:vote, :propose, :attend]

  def index
    @requested = Clinic.requested
    @proposed = Clinic.proposed
    @scheduled = Clinic.scheduled
  end

  def show
    @clinic = fetch
  end

  def timeline
    @timeline = TimelineService.new(fetch)
  end

  def destroy
    redirect_to root_path unless admin?
    fetch.destroy!
    redirect_to root_path
  end

  def vote
    current_user.vote!(fetch)
    redirect_to root_path
  end

  def attend
    current_user.attend!(fetch)
    redirect_to root_path
  end

  protected

  def fetch
    Clinic.find(params[:id])
  end
end
