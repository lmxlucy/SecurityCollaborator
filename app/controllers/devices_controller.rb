class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  # GET /devices
  # GET /devices.json
  def index
    if current_user && current_user.admin
      @devices = Device.all
    else
      redirect_to authenticated_root_path, :alert => "Access denied"
    end
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
    redirect_to authenticated_root_path, :alert => "Access denied"
  end

  # GET /devices/new
  def new
    redirect_to authenticated_root_path, :alert => "Access denied"
  end

  # GET /devices/1/edit
  def edit
    redirect_to authenticated_root_path, :alert => "Access denied"
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render :show, status: :created, location: @device }
      else
        format.html { render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { render :show, status: :ok, location: @device }
      else
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device.destroy
    respond_to do |format|
      format.html { redirect_to devices_url, notice: 'Device was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def device_params
      params.require(:device).permit(:user_id, {:q1=>[]}, :q2, :q3, :q4, :q5, 
      :q6, :q1_improved, :q1_improved_2, :q2_improved, :q3_improved, :q4_improved, 
      :q5_improved, :q6_improved)
    end
end
