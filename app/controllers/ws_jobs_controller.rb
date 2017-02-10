class WsJobsController < AuthController
  before_action :set_ws_job, only: [:show, :edit, :update, :destroy,
                                    :file_form, :file_save, :show_content]

  def show_content
    if @ws_job.file_contents and @ws_job.file_contents.size>0
        send_data(@ws_job.file_contents,
            type: @ws_job.content_type,
            filename: @ws_job.filename)
    else
      redirect_to :back
    end
  end

  # GET /ws_jobs
  # GET /ws_jobs.json
  def index
    user_id = params[:user_id] || current_user.id
    @ws_jobs = WsJob.accessible_by(current_ability).where(user_id: user_id).order('updated_at  desc')
  end

  def file_form
    
  end
  
  def file_save    
    respond_to do |format|
      if params[:ws_job] and @ws_job.update(ws_job_params)
        format.html { redirect_to @ws_job, notice: 'Вложение к задаче успешно сохранено' }
        format.json { render :show, status: :ok, location: @ws_job }
      else
        format.html { render :file_form }
        format.json { render json: @ws_job.errors, status: :unprocessable_entity }
      end
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
    @json_edit = nil
    @ws_job = WsJob.new
  end

  # GET /ws_jobs/1/edit
  def edit
    @json_edit = nil
    if @ws_job.input
      begin
        h = JSON.parse(@ws_job.input)
        if h['schema']
          @json_edit = '{ schema:' + JSON.generate(h['schema'])
          @json_edit +=  ",\nstartval:" + JSON.generate(h['startval']) if h['startval']
          @json_edit += "}"
        end
      rescue Exception => msg
        puts msg
      end
    end
  end

  # POST /ws_jobs
  # POST /ws_jobs.json
  def create
    @ws_job = WsJob.new(ws_job_params)
    @ws_job.user = current_user
    if (@ws_job.input.nil? or @ws_job.input == '') and not @ws_job.ws_method.input.nil? 
      @ws_job.input = @ws_job.ws_method.input
      @ws_job.output = '{}'
      @ws_job.save
      redirect_to edit_ws_job_path(@ws_job) 
    else
      respond_to do |format|
        if current_user.ws_jobs.size < current_user.numjobs or current_user.admin?
          if @ws_job.save
            CalcWsJobWorker.perform_async( @ws_job.id )
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
  end

  # PATCH/PUT /ws_jobs/1
  # PATCH/PUT /ws_jobs/1.json
  def update
    if @ws_job.do_check==0 or current_user.admin?
      respond_to do |format|
        if @ws_job.update(ws_job_params)
          @ws_job.update(output: nil, output_data: nil)
          CalcWsJobWorker.perform_async( @ws_job.id )
          sleep 3
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ws_job_params
      params[:ws_job].permit(:ws_method_id, :input, :file)
    end
end
