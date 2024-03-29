class ApplicationController < ActionController::Base
    around_action :set_time_zone
                                                                                 
    private
                                                                                    
    def set_time_zone
        old_time_zone = Time.zone
        Time.zone = browser_timezone if browser_timezone.present?
        yield
    ensure
        Time.zone = old_time_zone
    end
                                                                                    
    def browser_timezone
        cookies["browser.timezone"]
    end
end

