class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :signed_in_user, only: [:index, :edit, :update, :show]
  before_action :admin_user,     only: [:destroy, :new, :create]


end


