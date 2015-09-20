class StudentGroupsController < ApplicationController
  load_and_authorize_resource
  before_action :set_student_group, only: [:show, :edit, :update, :destroy]

  # GET /student_groups
  # GET /student_groups.json
  def index
    @student_groups = StudentGroup.order(:name)
  end

  # GET /student_groups/1
  # GET /student_groups/1.json
  def show
  end

  # GET /student_groups/new
  def new
    @student_group = StudentGroup.new
  end

  # GET /student_groups/1/edit
  def edit
  end

  # POST /student_groups
  # POST /student_groups.json
  def create
    @student_group = StudentGroup.new(student_group_params)

    respond_to do |format|
      if @student_group.save
        format.html { redirect_to @student_group, notice: 'Student group was successfully created.' }
        format.json { render :show, status: :created, location: @student_group }
      else
        format.html { render :new }
        format.json { render json: @student_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /student_groups/1
  # PATCH/PUT /student_groups/1.json
  def update
    respond_to do |format|
      if @student_group.update(student_group_params)
        format.html { redirect_to @student_group, notice: 'Student group was successfully updated.' }
        format.json { render :show, status: :ok, location: @student_group }
      else
        format.html { render :edit }
        format.json { render json: @student_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student_groups/1
  # DELETE /student_groups/1.json
  def destroy
    @student_group.destroy
    respond_to do |format|
      format.html { redirect_to student_groups_url, notice: 'Student group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student_group
      @student_group = StudentGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_group_params
      params.require(:student_group).permit(:name, :year)
    end
end
