class EduController < ApplicationController
  def index
    @subjects = Subject.all
  end
 
end