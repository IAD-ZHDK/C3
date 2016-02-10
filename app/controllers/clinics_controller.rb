class ClinicsController < ApplicationController
  before_action :authenticate_user!, only: [:vote, :propose, :confirm]

  def index
    @requested = Clinic.requested
    @proposed = Clinic.proposed
    @scheduled = Clinic.scheduled
  end

  def show
    @clinic = fetch
    @comments = @clinic.comments.order_by(created_at: :desc)
    @comment = Comment.new
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

  def confirm
    current_user.confirm!(fetch)
    redirect_to root_path
  end

  def comment
    @clinic = fetch
    @comment = Comment.new(user: current_user, clinic: @clinic)
    @comment.text = params[:comment][:text]
    if @comment.save
      CommentWorker.perform_async(@comment.id)
      redirect_to clinic_path(@clinic)
    else
      render 'show'
    end
  end

  protected

  def fetch
    Clinic.find(params[:id])
  end
end
