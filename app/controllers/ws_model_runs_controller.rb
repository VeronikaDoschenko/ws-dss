class WsModelRunsController < ApplicationController
  load_and_authorize_resource
  before_action :set_ws_model_run, only: [:show, :edit, :update, :destroy]

  # GET /ws_model_runs
  # GET /ws_model_runs.json
  def index
    @ws_model_runs = ( (params[:q]) ? WsModelRun.ransack(params[:q]).result : WsModelRun.all )
  end

  # GET /ws_model_runs/1
  # GET /ws_model_runs/1.json
  def show
  end

  # GET /ws_model_runs/new
  def new
    @ws_model_run = WsModelRun.new
  end

  # GET /ws_model_runs/1/edit
  def edit
  end

  # POST /ws_model_runs
  # POST /ws_model_runs.json
  def create
    @ws_model_run = WsModelRun.new(ws_model_run_params)
    @ws_model_run.user = current_user
    respond_to do |format|
      if @ws_model_run.save
        format.html { redirect_to @ws_model_run, notice: 'Ws model run was successfully created.' }
        format.json { render :show, status: :created, location: @ws_model_run }
      else
        format.html { render :new }
        format.json { render json: @ws_model_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ws_model_runs/1
  # PATCH/PUT /ws_model_runs/1.json
  def update
    respond_to do |format|
      if @ws_model_run.update(ws_model_run_params)
        format.html { redirect_to @ws_model_run, notice: 'Ws model run was successfully updated.' }
        format.json { render :show, status: :ok, location: @ws_model_run }
      else
        format.html { render :edit }
        format.json { render json: @ws_model_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ws_model_runs/1
  # DELETE /ws_model_runs/1.json
  def destroy
    @ws_model_run.destroy
    respond_to do |format|
      format.html { redirect_to ws_model_runs_url, notice: 'Ws model run was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ws_model_run
      @ws_model_run = WsModelRun.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ws_model_run_params
      params.require(:ws_model_run).permit(:name, :ws_model_id, :ws_model_status_id, :trace,
                                           :ws_param_values_attributes =>
                                              [:ws_param_id, :old_value, :new_value, :_destroy, :id]
                                          )
    end
end
