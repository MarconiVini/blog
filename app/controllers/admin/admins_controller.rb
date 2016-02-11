class Admin::AdminsController < Admin::BaseAdminController
  def index
    @admins = Admin.page(params[:page])
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new admin_params
    if @admin.save
      flash[:notice] = "O Admin \"#{@admin.name}\" foi criado com sucesso !"
      redirect_to action: :index
    else
      render :new
    end
  end

  def edit
    @admin = Admin.find params[:id]
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.update_attributes(admin_params)
      flash[:notice] = "O Admin \"#{@admin.name}\" foi editado com sucesso !"
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    flash[:notice] = "O Admin \"#{@admin.name}\" foi deletado !"
    redirect_to :action => :index
  end
  
  private
  def set_header
    @header = "Administradores - #{action_name}"
  end

  def admin_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation)
  end
end
