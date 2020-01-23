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

        params[:items].each do |k, v|
          @order.order_items.create(plu: Plu.find(k.to_i), units: v.to_i) unless v == '0'
        end

        ActionCable.server.broadcast(
          'server_notifications',
          kind: :new_order,
          order_id: @order.id
        )

        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        @plus = Plu.all
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
    ActionCable.server.broadcast(
      'client_notifications',
      kind: :serviced_order,
      order_id: @order.id
    )

    @order.update(serviced: true)

    @orders = Order.not_serviced.order(:id)
    redirect_to orders_path
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:name)
  end
end
