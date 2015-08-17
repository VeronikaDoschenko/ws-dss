class WsJobsController < ApplicationController

  before_action :set_ws_job, only: [:show, :edit, :update, :destroy]

  # GET /ws_jobs
  # GET /ws_jobs.json
  def index
    if current_user.admin? and params[:user_id]
      @ws_jobs = WsJob.where(user_id: params[:user_id].to_i).order('updated_at  desc')
    else
      @ws_jobs = current_user.ws_jobs.order('updated_at  desc')
    end
  end

  # GET /ws_jobs/1
  # GET /ws_jobs/1.json
  def show
    if current_user.admin? and params[:do_check] == '1'
      @ws_job.do_check += 1
      @ws_job.save
    end
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
          system "rake ws_dss:process_ws_jobs --trace 2>&1 >> #{Rails.root.join('log',"#{Rails.env}.log")} &"
          sleep 2
          @ws_job.reload
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
    if @ws_job.do_check==0 or current_user.admin?
      respond_to do |format|
        if @ws_job.update(ws_job_params)
          @ws_job.update(output: nil)
          system "rake ws_dss:process_ws_jobs --trace 2>&1 >> #{Rails.root.join('log',"#{Rails.env}.log")} &"
          sleep 2
          @ws_job.reload
          format.html { redirect_to @ws_job, notice: 'Задача успешно обновлена' }
          format.json { render :show, status: :ok, location: @ws_job }
        else
          format.html { render :edit }
          format.json { render json: @ws_job.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to ws_jobs_url, notice: "Изменение задачи заблокировано" 
    end
  end

  # DELETE /ws_jobs/1
  # DELETE /ws_jobs/1.json
  def destroy
      if @ws_job.do_check==0 or current_user.admin?
        @ws_job.destroy
        respond_to do |format|
          format.html { redirect_to ws_jobs_url, notice: 'Задача успешно удалена' }
          format.json { head :no_content }
        end
      else
        redirect_to ws_jobs_url, notice: 'Удаление задачи заблокировано' 
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ws_job
      @ws_job = WsJob.find(params[:id])
      if not current_user.admin? and @ws_job.user.id != current_user.id
        redirect_to ws_jobs_url, notice: 'Нет прав на чужие задачи' 
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ws_job_params
      params[:ws_job].permit(:ws_method_id, :input )
    end
end
