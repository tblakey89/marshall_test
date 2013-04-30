class ExamsController < ApplicationController

  after_filter  :set_csrf_cookie_for_ng

  def show
    if session[:auth] == true
      if signed_in?
        @exam = Exam.find(params[ :id])
        @section = @exam.sections.first
      else
        redirect_to new_user_path
      end
    else
      redirect_to root_path
    end
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected

    def verified_request?
      super || form_authenticity_token == request.headers['X_XSRF_TOKEN']
    end
end
