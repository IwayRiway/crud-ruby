class ProductReceivingsController < ApplicationController
  before_action :set_product_receiving, only: %i[ show edit update destroy ]

  # GET /product_receivings or /product_receivings.json
  def index
    @product_receivings = ProductReceiving.all
  end

  # GET /product_receivings/1 or /product_receivings/1.json
  def show
  end

  # GET /product_receivings/new
  def new
    @product_receiving = ProductReceiving.new
    @product_receiving.product_receiving_items.build
    @products = Product.all
    @number = (ProductReceiving.count + 1).to_s.rjust(4, "0")
  end

  # GET /product_receivings/1/edit
  def edit
    @edit = true
    @products = Product.all
  end

  # POST /product_receivings or /product_receivings.json
  def create
    @product_receiving = ProductReceiving.new(product_receiving_params)
    # @product_receiving.inspect
    respond_to do |format|
      if @product_receiving.save
        format.html { redirect_to product_receiving_url(@product_receiving), notice: "Product receiving was successfully created." }
        format.json { render :show, status: :created, location: @product_receiving }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product_receiving.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_receivings/1 or /product_receivings/1.json
  def update
    respond_to do |format|
      if @product_receiving.update(product_receiving_params)
        format.html { redirect_to product_receiving_url(@product_receiving), notice: "Product receiving was successfully updated." }
        format.json { render :show, status: :ok, location: @product_receiving }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product_receiving.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_receivings/1 or /product_receivings/1.json
  def destroy
    @product_receiving.destroy

    respond_to do |format|
      format.html { redirect_to product_receivings_url, notice: "Product receiving was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_receiving
      @product_receiving = ProductReceiving.find(params[:id])
    end

    # def set_product_receiving_with_product_receiving_items
    #   @product_receiving = ProductReceiving.includes(:product_receiving_items).find(params[:id])
    #   @product_receiving = ProductReceiving.includes(:product_receiving_items).where(product_receiving_items: {status: 'Active'}).find(params[:id])
    #     data = ProductReceiving.includes(:product_receiving_items).where(product_receiving_items: {status: 'Active'}).find_by(id: params[:id])
    #     @product_receiving = ProductReceiving.includes(:product_receiving_items).where(product_receiving_items: {status: 'Active'}).find_by(id: params[:id])
    #     if data
    #         @product_receiving = data
    #     else 
    #         self.set_product_receiving
    #         @product_receiving = ProductReceiving.find(params[:id])
    #     end
    # end

    # Only allow a list of trusted parameters through.
    def product_receiving_params
      params.require(:product_receiving).permit(:document_number, :document_date, :status, product_receiving_items_attributes: ProductReceivingItem.attribute_names.map(&:to_sym).push(:_destroy))
    #   params.require(:product_receiving).permit(:document_number, :document_date, :status, product_receiving_items_attributes: [:id, :_destroy, :product_receiving_id, :product_id, :quantity, :status])
    end
end
