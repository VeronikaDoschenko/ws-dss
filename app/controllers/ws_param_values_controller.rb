class WsParamValuesController < ApplicationController
  load_and_authorize_resource
  before_action :set_ws_param_value, only: [:show, :edit, :update, :destroy]

  # GET /ws_param_values
  # GET /ws_param_values.json
  def index
    if params[:q]
      @ws_param_values = WsParamValue.ransack(params[:q]).result
    else
      @ws_param_values = WsParamValue.joins([{ws_model_run: :ws_model}, :ws_param]).order('ws_models.name, ws_model_runs.name, ws_params.name') 
    end
  end

  # GET /ws_param_values/1
  # GET /ws_param_values/1.json
  def show
  end

  # GET /ws_param_values/new
  def new
    @ws_param_value = WsParamValue.new
  end

  # GET /ws_param_values/1/edit
  def edit
  end

  # POST /ws_param_values
  # POST /ws_param_values.json
  def create
    @ws_param_value = WsParamValue.new(ws_param_value_params)

    respond_to do |format|
      if @ws_param_value.save
        format.html { redirect_to @ws_param_value, notice: 'Ws param value was successfully created.' }
        format.json { render :show, status: :created, location: @ws_param_value }
      else
        format.html { render :new }
        format.json { render json: @ws_param_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ws_param_values/1
  # PATCH/PUT /ws_param_values/1.json
  def update
    params[:ws_param_value][:source_ws_param_ids] ||= []
    respond_to do |format|
      if @ws_param_value.update(ws_param_value_params)
        format.html { redirect_to @ws_param_value, notice: 'Ws param value was successfully updated.' }
        format.json { render :show, status: :ok, location: @ws_param_value }
      else
        format.html { render :edit }
        format.json { render json: @ws_param_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ws_param_values/1
  # DELETE /ws_param_values/1.json
  def destroy
    @ws_param_value.destroy
    respond_to do |format|
      format.html { redirect_to ws_param_values_url, notice: 'Ws param value was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ws_param_value
      @ws_param_value = WsParamValue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ws_param_value_params
      if params[:ws_param_value][:ws_param_values_params_attributes]      
        params[:ws_param_value][:ws_param_values_params_attributes].each do |k,v|
          if v[:ord].blank?
            params[:ws_param_value][:ws_param_values_params_attributes][k][:_destroy]=1
          end
        end
      end
      params.require(:ws_param_value).permit(:ws_param_id, :ws_model_run_id, :formula,
                    :old_value, :new_value,
                    :ws_set_model_run_id,
                    :ws_param_values_params_attributes => [:ws_param_id, :ord, :_destroy, :id])
    end
end
