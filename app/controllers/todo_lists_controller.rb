class TodoListsController < ApplicationController
#   before_action :set_todo_list, only: %i[ show edit update destroy ]
  before_action :set_todo_list, only: %i[ edit update destroy ]

  # GET /todo_lists or /todo_lists.json
  def index
    @todo_lists = TodoList.includes(:tasks).all
  end

  # GET /todo_lists/1 or /todo_lists/1.json
  def show
    @todo_list = TodoList.includes(:tasks).find(params[:id])
  end

  # GET /todo_lists/new
  def new
    @todo_list = TodoList.new
    # 3.times do
    @todo_list.tasks.build
    # end
  end

  # GET /todo_lists/1/edit
  def edit
    @todo_list.tasks.build
  end

  # POST /todo_lists or /todo_lists.json
  def create
    @todo_list = TodoList.new(todo_list_params)

    respond_to do |format|
      if @todo_list.save
        format.html { redirect_to todo_list_url(@todo_list), notice: "Todo list was successfully created." }
        format.json { render :show, status: :created, location: @todo_list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todo_lists/1 or /todo_lists/1.json
  def update
    respond_to do |format|
      if @todo_list.update(todo_list_params)
        format.html { redirect_to todo_list_url(@todo_list), notice: "Todo list was successfully updated." }
        format.json { render :show, status: :ok, location: @todo_list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todo_lists/1 or /todo_lists/1.json
  def destroy
    @todo_list.destroy

    respond_to do |format|
      format.html { redirect_to todo_lists_url, notice: "Todo list was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_list_params
      # params.require(:todo_list).permit(:name, tasks_attributes: [:id, :_destroy, :todo_list_id, :name, :completed, :due])
      params.require(:todo_list).permit(:name, tasks_attributes: Task.attribute_names.map(&:to_sym).push(:_destroy))
    end
end
