class WsJobsController < ApplicationController

  before_action :set_ws_job, only: [:show, :edit, :update, :destroy]

  # GET /ws_jobs
  # GET /ws_jobs.json
  def index
    @ws_jobs = current_user ? current_user.ws_jobs : []
  end

  # GET /ws_jobs/1
  # GET /ws_jobs/1.json
  def show
  end

  # GET /ws_jobs/new
  def new
    @ws_job = WsJob.new
  end

  # GET /ws_jobs/1/edit
  def edit
  end

  # POST /ws_jobs
  # POST /ws_jobs.json
  def create
    @ws_job = WsJob.new(ws_job_params)
    @ws_job.user = current_user
    respond_to do |format|
      if current_user.ws_jobs.size < current_user.numjobs or current_user.admin?
        if @ws_job.save
          @ws_job.do_job
          format.html { redirect_to @ws_job, notice: 'Задача успешно создана' }
          format.json { render :show, status: :created, location: @ws_job }
        else
          format.html { render :new }
          format.json { render json: @ws_job.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new, notice: "Превышен лимит на число задач #{current_user.numjobs}" }
      end
    end
  end

  # PATCH/PUT /ws_jobs/1
  # PATCH/PUT /ws_jobs/1.json
  def update
    respond_to do |format|
      if @ws_job.update(ws_job_params)
        @ws_job.update(output: nil)
        system "rake ws_dss:process_ws_jobs --trace 2>&1 >> #{Rails.root}/log/rake.log &"
        format.html { redirect_to @ws_job, notice: 'Задача успешно обновлена' }
        format.json { render :show, status: :ok, location: @ws_job }
      else
        format.html { render :edit }
        format.json { render json: @ws_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ws_jobs/1
  # DELETE /ws_jobs/1.json
  def destroy
      @ws_job.destroy
      respond_to do |format|
        format.html { redirect_to ws_jobs_url, notice: 'Задача успешно удалена' }
        format.json { head :no_content }
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ws_job
      @ws_job = WsJob.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ws_job_params
      params[:ws_job].permit(:ws_method_id, :input)
    end
end
