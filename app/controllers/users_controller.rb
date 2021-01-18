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
      redirect_to show_today_result_path
    else
      redirect_to edit_device_questions_path
    end
  end

  def show_today_result
    @message = Message.find_by(user_id: current_user.id, date: Date.today)
    d = Device.find_by(:user_id=>current_user.id)

    current_user.user_apps.each do |user_app|
      if user_app.q1 == 'No'
        if !@message.alerts.include? "Your " + App.find(user_app.app_id).name + " account is vulnerable to hacks. Please click here to learn how to set up a multi-factor authentication as soon as possible!"
          @message.alerts << "Your " + App.find(user_app.app_id).name + " account is vulnerable to hacks. Please click here to learn how to set up a multi-factor authentication as soon as possible!"   
        end
      elsif user_app.q1 == "I don't know"
        if !@message.reminders.include? "Your " + App.find(user_app.app_id).name + " account maybe vulnerable to hacks. Please click here to learn how to set up a multi-factor authentication as soon as possible!"
          @message.reminders << "Your " + App.find(user_app.app_id).name + " account maybe vulnerable to hacks. Please click here to learn how to set up a multi-factor authentication as soon as possible!"
        end
      end
      if user_app.q2 == 'No'
        if !@message.alerts.include? "Your " + App.find(user_app.app_id).name + " password is not strong enough against hacks. Please click here to learn how to set up strong password and update it as soon as possible! "
          @message.alerts << "Your " + App.find(user_app.app_id).name + " password is not strong enough against hacks. Please click here to learn how to set up strong password and update it as soon as possible! "  
        end
      elsif user_app.q1 == "I don't know"
        if !@message.reminders.include? "Your " + App.find(user_app.app_id).name + " password may not be strong enough against hacks. Please click here to learn how to set up strong password and update it as soon as possible!"
          @message.reminders <<  "Your " + App.find(user_app.app_id).name + " password may not be strong enough against hacks. Please click here to learn how to set up strong password and update it as soon as possible!"
        end
      end
      if user_app.q3 == 'Yes'
        if !@message.alerts.include? "Please ensure that the person/people you are sharing " + App.find(user_app.app_id).name + " account with are using this account and their devices securely."  
          @message.alerts << "Please ensure that the person/people you are sharing " + App.find(user_app.app_id).name + " account with are using this account and their devices securely."  
        end
      elsif user_app.q1 == "I don't know"
        if !@message.reminders.include? "Please ensure that the person/people you are sharing " + App.find(user_app.app_id).name + " account with are using this account and their devices securely."
          @message.reminders <<  "Please ensure that the person/people you are sharing " + App.find(user_app.app_id).name + " account with are using this account and their devices securely."
        end
      end
      if user_app.q4 == 'Yes, sometimes'
        if !@message.reminders.include? "You are doing well, but you may want to update your " + App.find(user_app.app_id).name + " password a bit more often (eg. every 30/60 days)"
          @message.reminders << "You are doing well, but you may want to update your " + App.find(user_app.app_id).name + " password a bit more often (eg. every 30/60 days)"  
        end
      elsif user_app.q4 == 'Yes, rarely'
        if !@message.reminders.include? "You have rooms to improve that you may need to update your " + App.find(user_app.app_id).name + " password a bit more often (eg. every 30/60 days)"
          @message.reminders << "You have rooms to improve that you may need to update your " + App.find(user_app.app_id).name + " password a bit more often (eg. every 30/60 days)"
        end  
      elsif user_app.q4 == "No"
        if !@message.alerts.include? "For your "  + App.find(user_app.app_id).name + " account's security, you may need to update the password every 30, 60, or 90 days"  
          @message.alerts << "For your "  + App.find(user_app.app_id).name + " account's security, you may need to update the password every 30, 60, or 90 days"  
        end
      elsif user_app.q4 == "I don't know"
        if !@message.reminders.include? "For your "  + App.find(user_app.app_id).name + " account's security, you may need to update the password every 30, 60, or 90 days"
          @message.reminders << "For your "  + App.find(user_app.app_id).name + " account's security, you may need to update the password every 30, 60, or 90 days"  
        end
      end
      if user_app.q5 == 'No'
        if !@message.alerts.include? "Please update your " + App.find(user_app.app_id).name + " account to the latest version as soon as possible!"
          @message.alerts << "Please update your " + App.find(user_app.app_id).name + " account to the latest version as soon as possible!" 
        end 
      elsif user_app.q5 == "I don't know"
        if !@message.alerts.include? "Please ensure that you are using the latest version of your " + App.find(user_app.app_id).name + " account."
          @message.alerts << "Please ensure that you are using the latest version of your " + App.find(user_app.app_id).name + " account."  
        end
      end
      if (user_app.q6.include? 'My mobile phone') || (user_app.q6.include? 'My tablet') || (user_app.q6.include? 'My laptop') || (user_app.q6.include? 'My desktop computer')
        if !@message.reminders.include? "You should check and make sure your devices are secure for the use of your " + App.find(user_app.app_id).name + " account. Click here for a security checklist." 
          @message.reminders << "You should check and make sure your devices are secure for the use of your " + App.find(user_app.app_id).name + " account. Click here for a security checklist." 
        end
      end
      if (user_app.q6.include? "My partner's mobile phone") || (user_app.q6.include? "My partner's tablet") || (user_app.q6.include? "My partner's laptop") || (user_app.q6.include? "My partner's desktop computer")
        if !@message.reminders.include? "You should check and make sure your partner's devices are secure for the use of your " + App.find(user_app.app_id).name + " account. Click here for a security checklist." 
          @message.reminders << "You should check and make sure your partner's devices are secure for the use of your " + App.find(user_app.app_id).name + " account. Click here for a security checklist." 
        end
      end
      if user_app.q6.include? "Devices from my workplace or public"
        if !@message.reminders.include? "You should log out " + App.find(user_app.app_id).name + " everytime you finish using and clear the cookies when neccessary."
          @message.reminders << "You should log out " + App.find(user_app.app_id).name + " everytime you finish using and clear the cookies when neccessary."
        end
      end
    end

    if d.q1.include? "Memorize them in mind"
      if !@message.device_reminders.include? "Memorizing passwords is not safe! You may consider using a password management system (eg. 1Password, LastPass) to improve the security of your accounts when you have more."
        @message.device_reminders << "Memorizing passwords is not safe! You may consider using a password management system (eg. 1Password, LastPass) to improve the security of your accounts when you have more."
      end
    end
    if d.q1.include? "Write them down"
      if !@message.device_reminders.include? "Writing down the password is not the optimal solution! You may consider using a password management system (eg. 1Password, LastPass) to improve the security of your accounts when you have more."
        @message.device_reminders << "Writing down the password is not the optimal solution! You may consider using a password management system (eg. 1Password, LastPass) to improve the security of your accounts when you have more."
      end
    end
    if d.q1.include? "Save it in a file on the computer"
      if !@message.device_reminders.include? "Saving the password on local computer is not the optimal solution! You may consider using a password management system (eg. 1Password, LastPass) to improve the security of your accounts when you have more."
        @message.device_reminders << "Saving the password on local computer is not the optimal solution! You may consider using a password management system (eg. 1Password, LastPass) to improve the security of your accounts when you have more."
      end
    end
    if d.q1.include? "Use the same password for multiple accounts"
      if !@message.device_alerts.include? "Using the same password for more than one account is not secure! You should generate different passwords for different accounts. You may also consider using a password management system (eg. 1Password, LastPass) to improve the security of your accounts when you have more."
        @message.device_alerts << "Using the same password for more than one account is not secure! You should generate different passwords for different accounts. You may also consider using a password management system (eg. 1Password, LastPass) to improve the security of your accounts when you have more."
      end
    end
    if d.q2 == "No"
      if !@message.device_alerts.include? "Please set up a PIN, passcode or fingerprint for your devices as soon as possible."
        @message.device_alerts << "Please set up a PIN, passcode or fingerprint for your devices as soon as possible."
      end
    elsif d.q2 == "I don't know"
      if !@message.device_reminders.include? "You may need to check if you have PIN, passcode or fingerprint for all your devices and set up one if neccessary."
        @message.device_reminders << "You may need to check if you have PIN, passcode or fingerprint for all your devices and set up one if neccessary."
      end
    end
    if d.q3 == "No"
      if !@message.device_alerts.include? "Please set up the auto-lock function in your device's settings as soon as possible."
        @message.device_alerts << "Please set up the auto-lock function in your device's settings as soon as possible."
      end
    elsif d.q3 == "I don't know"
      if !@message.device_reminders.include? "You may need to check if you have auto-lock for your devices and set up one if neccessary."
        @message.device_reminders << "You may need to check if you have auto-lock for your devices and set up one if neccessary."
      end
    end
    if d.q4 == "No"
      if !@message.device_alerts.include? "You should update your devices' operating systems as soon as possible!"
        @message.device_alerts << "You should update your devices' operating systems as soon as possible!"
      end
    elsif d.q4 == "I don't know"
      if !@message.device_reminders.include? "You may want to check and ensure that your devices' operating system are up-to-date. You can check in the About of your devices."
        @message.device_reminders << "You may want to check and ensure that your devices' operating system are up-to-date. You can check in the About of your devices."
      end
    end
    if d.q5 == "No"
      if !@message.device_alerts.include? "You should install anti-virus softwares on your devices as soon as possible."
        @message.device_alerts << "You should install anti-virus softwares on your devices as soon as possible."
      end
    elsif d.q5 == "I don't know"
      if !@message.device_reminders.include? "You may need to install anti-virus softwares for devices you haven't installed."
        @message.device_reminders << "You may need to install anti-virus softwares for devices you haven't installed."
      end
    elsif d.q5 == "Yes, some of them"
      if !@message.device_reminders.include? "You may need to install anti-virus softwares for those devices you haven't installed."
        @message.device_reminders << "You may need to install anti-virus softwares for those devices you haven't installed."
      end
    end
    if d.q6 == "No"
      if !@message.device_alerts.include? "You should check and make sure the people who use your devices are using them securely."
        @message.device_alerts << "You should check and make sure the people who use your devices are using them securely."
      end
    end

    if @message.device_reminders.empty? && @message.device_alerts.empty? && @message.reminders.empty? && @message.alerts.empty?
      @message.perfect = "Hooray! You are doing great! Your accounts and devices are very secure! Please ensure your partner is also doing well and help him/her out when nesseccary :)"
    else
      @message.perfect = ""
    end
    @message.update(alerts: @message.alerts)
  end

  def popup_user_apps_q1
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
      params.require(:user).permit(:id, :email, :partner_id, apps_attributes: [:id, :name], 
      user_apps_attributes: [:id, :accessed_today, :q1, :q2, :q3, :q4, :q5, {:q6=>[]}, 
      :q1_improved, :q2_improved, :q3_improved, :q4_improved, :q5_improved, 
      :q6_mine_improved, :q6_partner_improved, :q6_public_improved],
      messages_attributes: [:id, :user_id, :date, {:alerts=>[]}, {:reminders=>[]}, 
      {:device_alerts=>[]}, {:device_reminders=>[]}, :perfect], device_attributes: [:id, :user_id, {:q1=>[]}, 
      :q2, :q3, :q4, :q5, :q6, :q1_improved, :q1_improved_2, :q2_improved, :q3_improved, 
      :q4_improved, :q5_improved, :q6_improved])
    end
end

