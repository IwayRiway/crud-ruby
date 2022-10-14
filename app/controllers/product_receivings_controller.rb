class ProductReceivingsController < ApplicationController
  include ApplicationHelper
  before_action :permission, only: [:index, :show, :new, :edit, :destroy]
  before_action :set_product_receiving, only: %i[ edit update destroy delete print ]
  before_action :get_product_all, only: %i[ new edit ]
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: %i[ get_data ]

  # GET /product_receivings or /product_receivings.json
  def index
    get_product_receivings_all()
  end

  # GET /product_receivings/1 or /product_receivings/1.json
  def show
    @product_receiving = ProductReceiving.includes(product_receiving_items: [:product]).find(params[:id])
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

    if params[:id] == 'header'
        table = [['No', 'Document Number', 'Document Date', 'Status']];
        get_product_receivings_all()

        @product_receivings.map do |db|
            table.push([no=no+1, db.document_number, db.document_date, db.status])
        end

        pdf.text "Product Receivings by Header", size: 14, style: :bold, align: :center
    else
        table = [['No', 'Document Number', 'Document Date', 'Status', 'Product', 'Qty', 'Status']];
        get_product_receiving_items_all()

        @data.map do |db|
            table.push([no=no+1, db.product_receiving.document_number, db.product_receiving.document_date, db.product_receiving.status, db.product.part_name, db.quantity, db.status])
        end

        pdf.text "Product Receivings by Item", size: 14, style: :bold, align: :center
    end
    
    pdf.move_down 20
    pdf.table (table) do
        row(0).font_style = :bold
        self.row_colors = ["8D99AE", "FFFFFF"]
        self.width = 550
        self.header = true
        self.cell_style = { :size => 8 }
    end

    send_data(pdf.render, filename: "produk receivings.pdf", type: "application/pdf")
  end

  def excel
    xls = Axlsx::Package.new
    workbook = xls.workbook
    no = 0

    if params[:id] == 'header'
      get_product_receivings_all()
      workbook.add_worksheet(name: "Product Receiving") do |sheet|
        sheet.add_row ['Product Receivings']
        sheet.add_row ['']
        sheet.add_row ['No', 'Document Number', 'Document Date', 'Status']
        @product_receivings.each do |db|
          sheet.add_row [no=no+1, db.document_number, db.document_date, db.status]
        end
      end

    else
      get_product_receiving_items_all()
      workbook.add_worksheet(name: "Product Receiving") do |sheet|
        sheet.add_row ['No', 'Document Number', 'Document Date', 'Status', 'Product', 'Qty', 'Status']
        @data.each do |db|
          sheet.add_row [no=no+1, db.product_receiving.document_number, db.product_receiving.document_date, db.product_receiving.status, db.product.part_name, db.quantity, db.status]
        end
      end
    end

    xls.serialize("Product Receivings.xlsx")
    send_file File.open('Product Receivings.xlsx')
  end

  def print
    pdf = Prawn::Document.new
    no = 0
    row = 5
    data = @product_receiving.product_receiving_items
    total_data = data.count
    page = total_data>row ? (total_data%row != 0 ? total_data%row + 1 : total_data/row) : 1
    product_receiving = data.each_slice(row).to_a

    page_start = 0
    product_receiving.each do |product_receiving_items|
      table = [['No', 'Product', 'Qty', 'Status']]

      product_receiving_items.each do |db|
        table.push([no=no+1, db.product.part_name, db.quantity, db.status])
      end

      pdf.text "Product Receivings by Header", size: 14, style: :bold, align: :center
      pdf.move_down 20
      pdf.text "No : #{@product_receiving.document_number}", size: 8
      pdf.move_down 5
      pdf.text "Tgl : #{@product_receiving.document_date}", size: 8
      pdf.move_down 5
      pdf.text "Status : #{@product_receiving.status}", size: 8
      pdf.move_down 20
      pdf.table (table) do
          row(0).font_style = :bold
          self.row_colors = ["8D99AE", "FFFFFF"]
          self.width = 550
          self.header = true
          self.cell_style = { :size => 8 }
      end
      pdf.move_down 20
      pdf.text "Halaman #{page_start = page_start+1} dari #{page}", size: 8, align: :right
      
      if product_receiving_items != product_receiving.last
        pdf.start_new_page
      end
    end

    send_data(pdf.render, filename: "produk receivings.pdf", type: "application/pdf")
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

    def get_product_receiving_items_all
      @data = ProductReceivingItem.includes(:product_receiving, :product).all
    end

    # Only allow a list of trusted parameters through.
    def product_receiving_params
      params.require(:product_receiving).permit(:document_number, :document_date, :status, product_receiving_items_attributes: ProductReceivingItem.attribute_names.map(&:to_sym).push(:_destroy))
    #   params.require(:product_receiving).permit(:document_number, :document_date, :status, product_receiving_items_attributes: [:id, :_destroy, :product_receiving_id, :product_id, :quantity, :status])
    end
end
