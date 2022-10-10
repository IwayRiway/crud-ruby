class ProductReceivingsController < ApplicationController
  include ApplicationHelper
  before_action :permission, only: [:index, :show, :new, :edit, :destroy]
  before_action :set_product_receiving, only: %i[ show edit update destroy ]
  before_action :get_product_all, only: %i[ new edit ]
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: %i[ get_data ]

  # GET /product_receivings or /product_receivings.json
  def index
    @product_receivings = ProductReceiving.all
    # @data = ProductReceivingItem.includes(:product_receiving).all
    # @data.each do |d|
    #     abort d.product_receiving.inspect
    # end
    # abort @data.product_receiving
  end

  # GET /product_receivings/1 or /product_receivings/1.json
  def show
  end

  # GET /product_receivings/new
  def new
    @product_receiving = ProductReceiving.new
    @product_receiving.product_receiving_items.build
    # @number = (ProductReceiving.count + 1).to_s.rjust(5, "0")
    # @number = ProductReceiving.where("MONTH(document_date) = 10", "YEAR(document_date) = 2022").count
    # abort @number.to_s
  end

  # GET /product_receivings/1/edit
  def edit
    @edit = true
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
    document_date_old = @product_receiving.document_date
    document_date_now = Date.parse(product_receiving_params[:document_date])

    if document_date_old.strftime("%m") != document_date_now.strftime("%m")
        flash[:fail] = "month and year on the date of the document cannot be changed"
        redirect_to edit_product_receiving_path(@product_receiving)
    else
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
  end

  # DELETE /product_receivings/1 or /product_receivings/1.json
  def destroy
    @product_receiving.destroy

    respond_to do |format|
      format.html { redirect_to product_receivings_url, notice: "Product receiving was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def get_data
    type = params[:type]

    if type == 'header'
        @data = ProductReceiving.all
        render json: @data
    else
        @data = ProductReceivingItem.all
        render json: @data.to_json(:include => :product_receiving)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_receiving
      @product_receiving = ProductReceiving.find(params[:id])
    end

    def get_product_all
      @products = Product.all
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
