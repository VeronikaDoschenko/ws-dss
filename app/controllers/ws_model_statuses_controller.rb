class WsModelStatusesController < ApplicationController
  load_and_authorize_resource
  before_action :set_ws_model_status, only: [:show, :edit, :update, :destroy]

  # GET /ws_model_statuses
  # GET /ws_model_statuses.json
  def index
    @ws_model_statuses = WsModelStatus.all
  end

  # GET /ws_model_statuses/1
  # GET /ws_model_statuses/1.json
  def show
  end

  # GET /ws_model_statuses/new
  def new
    @ws_model_status = WsModelStatus.new
  end

  # GET /ws_model_statuses/1/edit
  def edit
  end

  # POST /ws_model_statuses
  # POST /ws_model_statuses.json
  def create
    @ws_model_status = WsModelStatus.new(ws_model_status_params)

    respond_to do |format|
      if @ws_model_status.save
        format.html { redirect_to @ws_model_status, notice: 'Ws model status was successfully created.' }
        format.json { render :show, status: :created, location: @ws_model_status }
      else
        format.html { render :new }
        format.json { render json: @ws_model_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ws_model_statuses/1
  # PATCH/PUT /ws_model_statuses/1.json
  def update
    respond_to do |format|
      if @ws_model_status.update(ws_model_status_params)
        format.html { redirect_to @ws_model_status, notice: 'Ws model status was successfully updated.' }
        format.json { render :show, status: :ok, location: @ws_model_status }
      else
        format.html { render :edit }
        format.json { render json: @ws_model_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ws_model_statuses/1
  # DELETE /ws_model_statuses/1.json
  def destroy
    @ws_model_status.destroy
    respond_to do |format|
      format.html { redirect_to ws_model_statuses_url, notice: 'Ws model status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ws_model_status
      @ws_model_status = WsModelStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ws_model_status_params
      params.require(:ws_model_status).permit(:name)
    end
end
