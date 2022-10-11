class ProductReceivingsController < ApplicationController
  include ApplicationHelper
  before_action :permission, only: [:index, :show, :new, :edit, :destroy]
  before_action :set_product_receiving, only: %i[ show edit update destroy delete ]
  before_action :get_product_all, only: %i[ new edit ]
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: %i[ get_data ]

  # GET /product_receivings or /product_receivings.json
  def index
    get_product_receivings_all()
  end

  # GET /product_receivings/1 or /product_receivings/1.json
  def show
  end

  # GET /product_receivings/new
  def new
    @product_receiving = ProductReceiving.new
    @product_receiving.product_receiving_items.build
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
        @data = get_product_receivings_all()
        render json: @data
    else
        @data = ProductReceivingItem.all
        render json: @data.to_json(:include => [:product_receiving, :product])
    end
  end

  def delete
    @product_receiving.destroy

    respond_to do |format|
      format.html { redirect_to product_receivings_url, notice: "Product receiving was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def pdf
    pdf = Prawn::Document.new
    no = 0

    if params[:type] == 'header'
        table = [['No', 'Document Number', 'Document Date', 'Status']];
        get_product_receivings_all()

        @product_receivings.map do |db|
            table.push([no=no+1, db.document_number, db.document_date, db.status])
        end

        pdf.text "Product Receivings by Header", size: 12, style: :bold, align: :center
    else
        pdf.text "Product Receivings by Item"
    end
    
    pdf.move_down 20
    pdf.table (table)
    send_data(pdf.render, filename: "test.pdf", type: "application/pdf")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_receiving
      @product_receiving = ProductReceiving.find(params[:id])
    end

    def get_product_all
      @products = Product.all
    end

    def get_product_receivings_all
        @product_receivings = ProductReceiving.all
    end

    # Only allow a list of trusted parameters through.
    def product_receiving_params
      params.require(:product_receiving).permit(:document_number, :document_date, :status, product_receiving_items_attributes: ProductReceivingItem.attribute_names.map(&:to_sym).push(:_destroy))
    #   params.require(:product_receiving).permit(:document_number, :document_date, :status, product_receiving_items_attributes: [:id, :_destroy, :product_receiving_id, :product_id, :quantity, :status])
    end
end
