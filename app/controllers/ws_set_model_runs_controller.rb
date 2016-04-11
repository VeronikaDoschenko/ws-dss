class WsSetModelRunsController < ApplicationController
  load_and_authorize_resource
  before_action :set_ws_set_model_run, only: [:show, :edit, :update, :destroy]

  # GET /ws_set_model_runs
  # GET /ws_set_model_runs.json
  def index
    @ws_set_model_runs = WsSetModelRun.all
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

    respond_to do |format|
      if @ws_set_model_run.save
        format.html { redirect_to @ws_set_model_run, notice: 'Множетсво прогонов успешно создано.' }
        format.json { render :show, status: :created, location: @ws_set_model_run }
      else
        format.html { render :new }
        format.json { render json: @ws_set_model_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ws_set_model_runs/1
  # PATCH/PUT /ws_set_model_runs/1.json
  def update
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
      params.require(:ws_set_model_run).permit(:name, :descr)
    end
end
