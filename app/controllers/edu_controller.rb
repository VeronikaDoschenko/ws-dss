class EduController < ApplicationController
  def index
    @subjects = Subject.order(:name)
  end
 
end