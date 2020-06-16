module Shared::MailerModule
  def self.included( base )
    base.after_action :set_sendgrid_headers
  end

  private
  def set_sendgrid_headers
    mailer = self.class.name
    headers "X-SMTPAPI" => {
      to: mail.to,
      category:    [ mailer, "#{mailer}##{action_name}" ],
      unique_args: { environment: Rails.env }
    }.merge( @x_smtpapi_headers || {} ).to_json
  end
end
