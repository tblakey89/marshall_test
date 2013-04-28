class UserAnswersController < ApplicationController
  def create
    @user_answer = UserAnswer.new
    @user_answer.user_id = params[ :user_id]
    @user_answer.question_id = params[ :question_id]
    @user_answer.answer = params[ :answer]
    @user_answer.save
  end
end
