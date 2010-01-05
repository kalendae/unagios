#!/usr/bin/env ruby
require File.dirname(__FILE__) + '/../config/boot'
require RAILS_ROOT + '/config/environment'

@error_file = "log/monitor_error.log"
@log_file = "log/monitor.log"

def log str
    File.open(@log_file,'a') do |f|
        f.puts "[#{Time.now.strftime('%m/%d/%Y %H:%M:%S')}] #{str}"
    end
    puts "[#{Time.now.strftime('%m/%d/%Y %H:%M:%S')}] #{str}"
end

def log_error str
    File.open(@error_file,'a') do |f|
        f.puts "[#{Time.now.strftime('%m/%d/%Y %H:%M:%S')}] #{str}"
    end
    puts "[#{Time.now.strftime('%m/%d/%Y %H:%M:%S')}] #{str}"
end

def stop_int
  log "INT signal received. should shutdown soon."
  @stop = true
  @stop_reason = 'INT'
end

def stop_term
  log "TERM signal received. should shutdown soon."
  @stop = true
  @stop_reason = 'TERM'
end

@stop = false
@stop_reason = ''
Signal.trap 'INT' do
  stop_int
end
Signal.trap 'TERM' do
  stop_term
end

while !@stop
  checks = Check.find(:all)
  log "loaded #{checks.size} checks"
  checks.each do |check|
    fail = false
    last_check_time = Time.at(0)
    check.servers.each do |server|
      last_check_log = CheckLog.find(:first, :conditions => ["check_id = ? and server_id = ?",check.id, server.id], :order => "created_at desc", :limit => 1)
      if last_check_log
        last_check_time = last_check_log.created_at if last_check_log.created_at > last_check_time
        fail = true if last_check_log.failed
      end
    end
    need_check = false
    minutes_since_last_check = (Time.now - last_check_time) / 60
    if fail
      if check.time_between_failed_checks < minutes_since_last_check
        log "check #{check.nickname} triggering (last fail at #{last_check_time})"
        check.execute
      end
    else
      if check.time_between_normal_checks < minutes_since_last_check
        log "check #{check.nickname} triggering (last success at #{last_check_time})"
        check.execute
      end
    end
  end
  sleep 60
end
