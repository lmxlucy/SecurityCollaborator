class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @partners = User.alphabetical.map{|x| [x.email, x.id] }
  end

  # GET /users/1/edit
  def edit
    if current_user.possible_partners.empty?
      @partners = User.singles.map{|x| [x.email, x.id] }
    else
      @partners = current_user.possible_partners.map{|x| [x.email, x.id] }
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update_attributes(user_params)
      redirect_to authenticated_root_path
    else
      render action: 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit_apps
    n = 10 - current_user.user_apps.length
    n.times { current_user.apps.build }
    # 10.times do
    #   current_user.apps.build
    # end
  end

  def update_uapps
    apps = user_params['apps_attributes']
    existing = []
    apps.values.each do |app|
      if !app["name"].nil?
        record = App.find_or_create_by(name: app["name"])
        existing << record
      end
    end
    existing.each do |app|
      UserApp.find_or_create_by(user_id: current_user.id, app_id: app.id)
    end
    redirect_to edit_user_path(current_user)
  end

  def edit_user_apps_1
  end

  def update_uapps_1
    if @user.update_attributes(user_params)
      redirect_to edit_user_apps_2_path
    else
      redirect_to edit_user_apps_1
    end
  end

  def edit_user_apps_2
  end

  def update_uapps_2
    if @user.update_attributes(user_params)
      redirect_to authenticated_root_path
    else
      redirect_to edit_user_apps_2_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :partner_id, apps_attributes: [:id, :name], user_apps_attributes: [:id, :accessed_today, :q1, :q2, :q3, :q4, :q5, :q6])
    end
end
