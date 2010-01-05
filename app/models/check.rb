require 'net/ssh'
require 'net/smtp'

class Check < ActiveRecord::Base
  has_and_belongs_to_many :servers
  has_and_belongs_to_many :contacts
  has_many :check_logs

  def execute
    self.servers.each do |server|
      @current_server = server
      r = ssh self.execution_code.split("\n")
      success = eval(self.check_regex)
      # make a log of it
      cl = CheckLog.new(:check_id => self.id, :server_id => server.id, :failed => !success, :output => r)
      cl.save!
      # notify if needed
      if !success
        cls = CheckLog.find(:all, :conditions => ["check_id = ? and server_id = ?",self.id,server.id], :order => "created_at desc", :limit => self.fails_before_notify)
        unless cls.any?{|c|c.failed == false}
          # notify
          notify_contact cls
        end
      end
    end
  end

  def ssh strs
    if @current_server.blank?
      return "ERROR: no server specified"
    end
    # if check needs su access have it goto root and su_password
    last_results = nil
    results = []
    session = Net::SSH.start(@current_server.address, @current_server.username, :password => @current_server.password, :port => @current_server.port)
      strs.each do |str|
        last_results = session.exec!(str.strip)
        results << last_results
      end
    session.close
    return last_results
  end

  def notify_contact cls
    to = self.contacts.collect{|c|c.email}
    to_display =  self.contacts.collect{|c|"#{c.email} <#{c.email}>"}.join(", ")
    from = "monitor@adrocket.com"
    from_display = "monitoring"
    subject = "Monitoring Alert - #{self.nickname}"
    content = "The alert #{self.nickname} for server #{cls.last.server.nickname} has failed #{cls.size} times.<br/><br/><br/>Output: <textarea cols='100' rows='50'>"
    cls.each do |cl|
      content += cl.to_email
    end
    content += "</textarea>"
    
    message = <<MESSAGE_END
From: #{from_display} <#{from}>
To: #{to_display}
MIME-Version: 1.0
Content-type: text/html
Subject: #{subject}

#{content}
MESSAGE_END
    Net::SMTP.start('localhost') do |smtp|
      smtp.send_message message, from, to
    end

  end

  
end

