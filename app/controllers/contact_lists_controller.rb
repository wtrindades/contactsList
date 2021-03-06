class ContactListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact_list, only: [:edit, :update, :destroy]
  before_action :set_custom_fields, only: [:index, :new, :edit]

  # GET /contact_lists
  # GET /contact_lists.json
  def index
    @contact_lists = current_user.contact_lists.all
  end


  # GET /contact_lists/new
  def new
    @contact_list = current_user.contact_lists.new
    @contact_list.fields.new
  end

  # GET /contact_lists/1/edit
  def edit
  end

  # POST /contact_lists
  # POST /contact_lists.json
  def create
    @contact_list = current_user.contact_lists.new(contact_list_params)

    respond_to do |format|
      if @contact_list.save
        format.html { redirect_to contact_lists_path, notice: 'Contato adicionado com sucesso.' }
        format.json { render :index, status: :created, location: contact_lists_path }
      else
        format.html { render :new }
        format.json { render json: @contact_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contact_lists/1
  # PATCH/PUT /contact_lists/1.json
  def update
    respond_to do |format|
      if @contact_list.update(contact_list_params)
        format.html { redirect_to contact_lists_path, notice: 'Contato atualizado com sucesso.' }
        format.json { render :index, status: :ok, location: contact_lists_path }
      else
        format.html { render :edit }
        format.json { render json: @contact_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_lists/1
  # DELETE /contact_lists/1.json
  def destroy
    @contact_list.destroy
    respond_to do |format|
      format.html { redirect_to contact_lists_url, notice: 'Contato apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact_list
      @contact_list = current_user.contact_lists.find(params[:id])
    end

    def set_custom_fields
      @custom_fields = current_user.custom_fields.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_list_params
      params.require(:contact_list).permit(:name, :email, :user_id, :fields_attributes => [:id, :content, :area_content, :combobox, :custom_field_id])
    end
end
