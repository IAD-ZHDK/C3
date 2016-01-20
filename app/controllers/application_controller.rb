class ApplicationController < ActionController::Base
  include AuthenticationHelper
  include ProposalsHelper

  protect_from_forgery with: :exception
end
