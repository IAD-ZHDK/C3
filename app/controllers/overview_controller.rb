class OverviewController < ApplicationController
  def index
    @requests = Clinic.requested
    @proposals = Clinic.proposed
  end
end
