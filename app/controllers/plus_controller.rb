class PlusController < ApplicationController
  before_action :set_plu, only: [:show, :edit, :update, :destroy]

  # GET /plus
  # GET /plus.json
  def index
    @plus = Plu.all
  end

  # GET /plus/1
  # GET /plus/1.json
  def show
  end

  # GET /plus/new
  def new
    @plu = Plu.new
  end

  # GET /plus/1/edit
  def edit
  end

  # POST /plus
  # POST /plus.json
  def create
    @plu = Plu.new(plu_params)

    respond_to do |format|
      if @plu.save
        format.html { redirect_to @plu, notice: 'Plu was successfully created.' }
        format.json { render :show, status: :created, location: @plu }
      else
        format.html { render :new }
        format.json { render json: @plu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plus/1
  # PATCH/PUT /plus/1.json
  def update
    respond_to do |format|
      if @plu.update(plu_params)
        format.html { redirect_to @plu, notice: 'Plu was successfully updated.' }
        format.json { render :show, status: :ok, location: @plu }
      else
        format.html { render :edit }
        format.json { render json: @plu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plus/1
  # DELETE /plus/1.json
  def destroy
    @plu.destroy
    respond_to do |format|
      format.html { redirect_to plus_url, notice: 'Plu was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_plu
    @plu = Plu.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def plu_params
    params.require(:plu).permit(:name, :price)
  end
end
