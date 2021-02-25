class HomeController < ApplicationController
  def index
    messages = Message.all
    @today_message = messages.find_by(user_id: current_user.id, date: Date.today)
  end
end
