class StudentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    @students = Student.includes(:student_group).references(:student_group).order("student_groups.name", :lname, :name)
    @users_empty = User.where("email not in (select email from students)").order(:email)  
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    a = params[:input].split("\n")
    a = a.collect{|r| r.gsub("\r","").split("\t")}
    a.each do |r|
      s = Student.new(serial: r[0], lname: r[1], name: r[2], mname: r[3], email: r[4].downcase)
      sg = StudentGroup.find_by_name(r[5])
      if sg.nil?
        sg = StudentGroup.new(name: r[5], year: Time.now.year)
        sg.save
      end
      s.student_group = sg
      s.save
    end
    redirect_to :students
  end
  
  def export
    buf = ''
    Student.includes(:student_group).references(:student_group).order("student_groups.name", :lname, :name).all.each do |s|
      u = s.get_user
      sl = u.get_sloved if u
      buf += "#{s.student_group.name}\t#{s.serial}\t#{s.lname}\t#{s.name}\t#{s.email}\t#{sl}\n"
    end
    render text: "<pre>#{buf}</pre>", :layout => true
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :mnane, :lname, :serial, :email, :student_group_id)
    end
end
