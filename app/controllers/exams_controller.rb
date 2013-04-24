class ExamsController < ApplicationController

  def show
    @exam = Exam.find(params[ :id])
    @section = @exam.sections.first
  end

end
