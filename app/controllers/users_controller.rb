class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_apps, 
                          :update_uapps, :edit_user_apps_1, :edit_user_apps_2,
                          :update_uapps_1, :update_uapps_2]
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
    if @user.update(user_params)
      redirect_to edit_user_apps_1_path
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
    if current_user.update(user_params)
      redirect_to edit_user_apps_2_path
    else
      redirect_to edit_user_apps_1_path
    end
  end

  def edit_user_apps_2
  end

  def update_uapps_2
    if current_user.update(user_params)
      redirect_to edit_device_questions_path
    else
      redirect_to edit_user_apps_2_path
    end
  end

  def edit_user_apps_3
    messages = Message.all
    message = messages.find_by(user_id: current_user.id, date: Date.today-1)
    if message.nil? || !message.perfect.empty?
      redirect_to edit_user_apps_1_path
    end
  end

  def update_uapps_3
    if current_user.update(user_params)
      redirect_to edit_user_apps_1_path
    else
      redirect_to edit_user_apps_3_path
    end
  end

  def edit_device_questions
    @device = Device.find_or_create_by(user_id: current_user.id)
  end

  def update_device_questions
    message = Message.find_or_create_by(user_id: current_user.id, date: Date.today)
    if current_user.update(user_params)
      redirect_to controller: 'messages', action: 'show', id: message.id
    else
      redirect_to edit_device_questions_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if @current_user
        @user = @current_user
      else
        @user = User.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :partner_id, apps_attributes: [:id, :name], 
      user_apps_attributes: [:id, :accessed_today, :q1, :q2, :q3, :q4, :q5, {:q6=>[]}, 
      :q1_improved, :q2_improved, :q3_improved, :q4_improved, :q5_improved, 
      :q6_mine_improved, :q6_partner_improved, :q6_public_improved],
      messages_attributes: [:id, :user_id, :date], device_attributes: [:user_id, :q1, 
      :q2, :q3, :q4, :q5, :q6, :q1_improved, :q1_improved_2, :q2_improved, :q3_improved, 
      :q4_improved, :q5_improved, :q6_improved])
    end
end
