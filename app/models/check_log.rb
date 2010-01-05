class CheckLog < ActiveRecord::Base
  belongs_to :check
  belongs_to :server

  def to_email
    email_text = "Monitor check #{check.nickname} at #{created_at} #{self.failed ? "failed" : "succeeded"}\r\n"
    if self.failed
      email_text += "\tCheck failed with response: #{self.output}\r\n"
    end
    email_text += "\r\n"
  end
end
