class WsParamsController < AuthController
  before_action :set_ws_param, only: [:show, :edit, :update, :destroy]

  # GET /ws_params
  # GET /ws_params.json
  def index
    wp = WsParam.accessible_by(current_ability)
    @ws_params = ( (params[:q]) ? wp.ransack(params[:q]).result : wp )
  end

  # GET /ws_params/1
  # GET /ws_params/1.json
  def show
  end

  # GET /ws_params/new
  def new
    @ws_param = WsParam.new
  end

  # GET /ws_params/1/edit
  def edit
  end

  # POST /ws_params
  # POST /ws_params.json
  def create
    @ws_param = WsParam.new(ws_param_params)
    @ws_param.user = current_user
    
    respond_to do |format|
      if @ws_param.save
        format.html { redirect_to @ws_param, notice: 'Ws param was successfully created.' }
        format.json { render :show, status: :created, location: @ws_param }
      else
        format.html { render :new }
        format.json { render json: @ws_param.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ws_params/1
  # PATCH/PUT /ws_params/1.json
  def update
    respond_to do |format|
      if @ws_param.update(ws_param_params)
        format.html { redirect_to @ws_param, notice: 'Ws param was successfully updated.' }
        format.json { render :show, status: :ok, location: @ws_param }
      else
        format.html { render :edit }
        format.json { render json: @ws_param.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ws_params/1
  # DELETE /ws_params/1.json
  def destroy
    @ws_param.destroy
    respond_to do |format|
      format.html { redirect_to ws_params_url, notice: 'Ws param was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ws_param
      @ws_param = WsParam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ws_param_params
      params.require(:ws_param).permit(:name, :descr, :is_int, :dim, :min_val, :max_val)
    end
end
