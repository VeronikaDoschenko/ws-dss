class WsModelsController < ApplicationController
  load_and_authorize_resource
  before_action :set_ws_model, only: [:show, :edit, :update, :destroy]

  # GET /ws_models
  # GET /ws_models.json
  def index
    @ws_models = WsModel.all
  end

  # GET /ws_models/1
  # GET /ws_models/1.json
  def show
  end

  # GET /ws_models/new
  def new
    @ws_model = WsModel.new
  end

  # GET /ws_models/1/edit
  def edit
  end

  # POST /ws_models
  # POST /ws_models.json
  def create
    @ws_model = WsModel.new(ws_model_params)

    respond_to do |format|
      if @ws_model.save
        format.html { redirect_to @ws_model, notice: 'Модель успешно создана' }
        format.json { render :show, status: :created, location: @ws_model }
      else
        format.html { render :new }
        format.json { render json: @ws_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ws_models/1
  # PATCH/PUT /ws_models/1.json
  def update
    respond_to do |format|
      if @ws_model.update(ws_model_params)
        format.html { redirect_to @ws_model, notice: 'Модель успешно изменена' }
        format.json { render :show, status: :ok, location: @ws_model }
      else
        format.html { render :edit }
        format.json { render json: @ws_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ws_models/1
  # DELETE /ws_models/1.json
  def destroy
    @ws_model.destroy
    respond_to do |format|
      format.html { redirect_to ws_models_url, notice: 'Модель успешно удалена' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ws_model
      @ws_model = WsModel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ws_model_params
      params.require(:ws_model).permit(:name, :descr, :url,
        :ws_param_models_attributes => [:ws_param_id, :is_required, :_destroy, :id])
    end
end
