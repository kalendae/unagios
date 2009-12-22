class CheckLogsController < ApplicationController
  # GET /check_logs
  # GET /check_logs.xml
  def index
    @check_logs = CheckLog.all

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

  # GET /check_logs/new
  # GET /check_logs/new.xml
  def new
    @check_log = CheckLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @check_log }
    end
  end

  # GET /check_logs/1/edit
  def edit
    @check_log = CheckLog.find(params[:id])
  end

  # POST /check_logs
  # POST /check_logs.xml
  def create
    @check_log = CheckLog.new(params[:check_log])

    respond_to do |format|
      if @check_log.save
        flash[:notice] = 'CheckLog was successfully created.'
        format.html { redirect_to(@check_log) }
        format.xml  { render :xml => @check_log, :status => :created, :location => @check_log }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @check_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /check_logs/1
  # PUT /check_logs/1.xml
  def update
    @check_log = CheckLog.find(params[:id])

    respond_to do |format|
      if @check_log.update_attributes(params[:check_log])
        flash[:notice] = 'CheckLog was successfully updated.'
        format.html { redirect_to(@check_log) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @check_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /check_logs/1
  # DELETE /check_logs/1.xml
  def destroy
    @check_log = CheckLog.find(params[:id])
    @check_log.destroy

    respond_to do |format|
      format.html { redirect_to(check_logs_url) }
      format.xml  { head :ok }
    end
  end
end
