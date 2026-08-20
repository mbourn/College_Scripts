class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate!

  def authenticate!
    authenticate_user!

    if params[:controller] == 'ratings' && (params[:action] == 'edit' || params[:action] == 'update' || params[:action] == 'destroy' )
      current_rating = Rating.find(params[:id])
      if current_rating.user_id == current_user.id
        return
      else
        redirect_to root_url, notice: "Record not found"
      end
    end
  end
end
