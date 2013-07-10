class StaticPagesController < ApplicationController

  def home
    if params[:static_pages]
      if params[:static_pages][:password] == Password.find_by_id(1).password
        session[:auth] = true
        redirect_to new_user_path
      end
    else
      reset_session
      cookies.delete(:remember_token)
    end
  end

  def about

  end

  def blitz_auth
  end

end
