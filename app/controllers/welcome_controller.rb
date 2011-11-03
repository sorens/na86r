class WelcomeController < ApplicationController
  
  def index
    if params[:alert]
      flash.now[:alert] = params[:alert]
    end
    if params[:notice]
      flash.now[:notice] = params[:notice]
    end
    if params[:error]
      flash.now[:error] = params[:error]
    end
  end
end
