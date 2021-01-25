class EmailReminderMailer < ApplicationMailer
    def notify_partner(partner)
        @partner=partner
        mail(to: @partner.email, subject: "Security Collaborator: Your Partner Finished Today's Evaluation!")
    end
end
