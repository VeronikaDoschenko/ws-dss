class WsSetModelRunsController < AuthController
  before_action :set_ws_set_model_run, only: [:show, :edit, :update, :destroy]

  # GET /ws_set_model_runs
  # GET /ws_set_model_runs.json
  def index
    @ws_set_model_runs = WsSetModelRun.accessible_by(current_ability)
  end

  # GET /ws_set_model_runs/1
  # GET /ws_set_model_runs/1.json
  def show
  end

  # GET /ws_set_model_runs/new
  def new
    @ws_set_model_run = WsSetModelRun.new
  end

  # GET /ws_set_model_runs/1/edit
  def edit
  end

  # POST /ws_set_model_runs
  # POST /ws_set_model_runs.json
  def create
    @ws_set_model_run = WsSetModelRun.new(ws_set_model_run_params)
    @ws_set_model_run.user = current_user
    respond_to do |format|
      if current_user.ws_set_model_runs.size < current_user.numjobs or can?( :create, WsModel )       
        if @ws_set_model_run.save
          format.html { redirect_to @ws_set_model_run, notice: 'Множетсво прогонов успешно создано.' }
          format.json { render :show, status: :created, location: @ws_set_model_run }
        else
          format.html { render :new }
          format.json { render json: @ws_set_model_run.errors, status: :unprocessable_entity }
        end
      else
          flash[:notice] = "Превышен лимит на число множеств #{current_user.numjobs}"
          format.html { render :new }
          format.json { render json: {error: "Превышен лимит на число множеств #{current_user.numjobs}"}, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ws_set_model_runs/1
  # PATCH/PUT /ws_set_model_runs/1.json
  def update
    params[:ws_set_model_run][:role_ids] ||= []
    respond_to do |format|
      if @ws_set_model_run.update(ws_set_model_run_params)
        format.html { redirect_to @ws_set_model_run, notice: 'Множетсво прогонов успешно обновлено.' }
        format.json { render :show, status: :ok, location: @ws_set_model_run }
      else
        format.html { render :edit }
        format.json { render json: @ws_set_model_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ws_set_model_runs/1
  # DELETE /ws_set_model_runs/1.json
  def destroy
    @ws_set_model_run.destroy
    respond_to do |format|
      format.html { redirect_to ws_set_model_runs_url, notice: 'Множетсво прогонов успешно удалено.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ws_set_model_run
      @ws_set_model_run = WsSetModelRun.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ws_set_model_run_params
      if params[:ws_set_model_run][:ws_model_runs_set_model_runs_attributes]      
        params[:ws_set_model_run][:ws_model_runs_set_model_runs_attributes].each do |k,v|
          if v[:ord].blank?
            params[:ws_set_model_run][:ws_model_runs_set_model_runs_attributes][k][:_destroy]=1
          end
        end
      end
      params.require(:ws_set_model_run).permit(:name, :descr,
        ((can? :set_model_permission, @ws_set_model_run)?({:role_ids => []}):nil),
        :ws_model_runs_set_model_runs_attributes => [:ws_model_run_id, :ord, :_destroy, :id]                             
                                               )
    end
end
