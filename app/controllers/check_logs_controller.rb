class CheckLogsController < ApplicationController
  # GET /check_logs
  # GET /check_logs.xml
  def index
    @check_logs = CheckLog.all(:order => 'id desc', :limit => 100)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @check_logs }
    end
  end

  # GET /check_logs/1
  # GET /check_logs/1.xml
  def show
    @check_log = CheckLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @check_log }
    end
  end

end
