class OrdersController < ApplicationController
  def index
    @orders = Order.not_serviced.order(:id)
  end

  def new
    @order = Order.new
    @plus = Plu.all
  end

  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Plu was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def serviced
    @order = Order.find(params[:order_id])
    # TODO: notify to customer
    @order.update_attributes(serviced: true)

    @orders = Order.not_serviced.order(:id)
    redirect_to orders_path
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:name)
  end
end
