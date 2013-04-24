class QuestionsController < ApplicationController
  def new
  end

  def show
    @question = Question.find(params[ :id])
    render :json => @question.to_json
  end
end
