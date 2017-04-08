class Auth::SessionsController < ApplicationController
  def new
    redirect_to '/auth/google_oauth2'
  end

  def destroy
    reset_session
    redirect_to root_url, info: 'Signed out!'
  end

  def failure
    redirect_to root_url, danger: "Authentication error: #{params[:message].humanize}"
  end
end
