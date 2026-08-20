class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.save #This creates the order and gives us the order_id to use later
    @order.uid = params[:u_id]
    @order.promise_time = Time.now.localtime + 900 # 15 minutes from when the order is created 
    @order.public = false
    @order.req = params[:req]

    @price = 0 
    ctr = Item.count
    (1..ctr).each do |i|
      if( params[i.to_s].to_i > 0 )
        quant = params[i.to_s].to_i
        item_cost = Item.find(i)[:price]
        @price = @price + (item_cost * quant)

        @oi = OrderItem.new
        @oi.order_id = @order.id
        @oi.item_id = i
        @oi.quant = quant
        @oi.save
      end
    end

    @order.charge = @price

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:charge, :promise_time, :public, :req)
    end
end
