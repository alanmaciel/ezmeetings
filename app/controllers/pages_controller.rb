class PagesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to controller: 'companies', action: 'index'
    end
  end
end
