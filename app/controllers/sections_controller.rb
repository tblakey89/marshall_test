class SectionsController < ApplicationController
  def show
    @section = Section.find(params[ :id])
    respond_to do |format|
      format.json { render json: @section }
    end
  end
end
