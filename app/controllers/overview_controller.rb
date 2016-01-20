class OverviewController < ApplicationController
  def index
    @proposals = Proposal.all
  end
end
