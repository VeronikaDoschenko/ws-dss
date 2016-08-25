class WsMethodsController < ApplicationController
  load_and_authorize_resource
  before_action :set_ws_method, only: [:show, :edit, :update, :destroy, :test]

  # GET /ws_methods
  # GET /ws_methods.json
  def index
    @ws_methods = WsMethod.all
  end

  # GET /ws_methods/1
  # GET /ws_methods/1.json
  def show
  end

  def test
    a = @ws_method.do_calc(@ws_method.test_input)
    s = a[0]
    error_code = a[1]
    for_check = a[2]
    if s.gsub(/\s/,'') == @ws_method.test_output.gsub(/\s/,'')
        s += "\nРезультаты тестового запуска совпали с ожидаемыми! #{error_code} #{for_check}"
    else
        s += "\nРезультаты тестового запуска не совпали с ожидаемыми! #{error_code} #{for_check}"
    end
    render plain: s
  end
  
  # GET /ws_methods/new
  def new
    @ws_method = WsMethod.new
  end

  # GET /ws_methods/1/edit
  def edit
  end

  # POST /ws_methods
  # POST /ws_methods.json
  def create
    @ws_method = WsMethod.new(ws_method_params)

    respond_to do |format|
      if @ws_method.save
        format.html { redirect_to @ws_method, notice: 'Метод успешно создан.' }
        format.json { render :show, status: :created, location: @ws_method }
      else
        format.html { render :new }
        format.json { render json: @ws_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ws_methods/1
  # PATCH/PUT /ws_methods/1.json
  def update
    params[:ws_method][:role_ids] ||= []
    respond_to do |format|
      if @ws_method.update(ws_method_params)
        format.html { redirect_to @ws_method, notice: 'Метод успешно обновлен.' }
        format.json { render :show, status: :ok, location: @ws_method }
      else
        format.html { render :edit }
        format.json { render json: @ws_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ws_methods/1
  # DELETE /ws_methods/1.json
  def destroy
    @ws_method.destroy
    respond_to do |format|
      format.html { redirect_to ws_methods_url, notice: 'Метод успешно удален.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ws_method
      @ws_method = WsMethod.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ws_method_params
      params[:ws_method].permit(:name, :descr, :code, :test_input, :test_output,
                                :format_output, :input, :role_ids => []
                                )
    end
end
