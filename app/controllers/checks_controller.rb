class ChecksController < ApplicationController

  def login
      if request.post?
          session[:pw] = params[:pw]
          session[:expiry] = 1.hour.from_now
          redirect_to_stored
          return false
      end
      respond_to do |format|
        format.html
      end
  end

  # GET /checks
  # GET /checks.xml
  def index
    @checks = Check.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @checks }
    end
  end

  # GET /checks/1
  # GET /checks/1.xml
  def show
    @check = Check.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @check }
    end
  end

  # GET /checks/new
  # GET /checks/new.xml
  def new
    @check = Check.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @check }
    end
  end

  # GET /checks/1/edit
  def edit
    @check = Check.find(params[:id])
  end

  # POST /checks
  # POST /checks.xml
  def create
    @check = Check.new(params[:check])
    created = @check.save
    if created
      params.keys.each do |k|
        if k.starts_with? 'server_'
          s = Server.find(k.gsub('server_',''))
          @check.servers << s unless @check.servers.include?(s)
        end
        if k.starts_with? 'contact_'
          c = Contact.find(k.gsub('contact_',''))
          @check.contacts << c unless @check.contacts.include?(c)
        end
      end
      created = @check.save
    end
    respond_to do |format|
      if created
        flash[:notice] = 'Check was successfully created.'
        format.html { redirect_to(@check) }
        format.xml  { render :xml => @check, :status => :created, :location => @check }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @check.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /checks/1
  # PUT /checks/1.xml
  def update
    @check = Check.find(params[:id])
    updated = @check.update_attributes(params[:check])
    if updated
      @check.contacts.delete_all
      @check.servers.delete_all
      params.keys.each do |k|
        if k.starts_with? 'server_'
          s = Server.find(k.gsub('server_',''))
          @check.servers << s unless @check.servers.include?(s)
        end
        if k.starts_with? 'contact_'
          c = Contact.find(k.gsub('contact_',''))
          @check.contacts << c unless @check.contacts.include?(c)
        end
      end
      updated = @check.save
    end
    respond_to do |format|
      if updated
        flash[:notice] = 'Check was successfully updated.'
        format.html { redirect_to(@check) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @check.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /checks/1
  # DELETE /checks/1.xml
  def destroy
    @check = Check.find(params[:id])
    @check.destroy

    respond_to do |format|
      format.html { redirect_to(checks_url) }
      format.xml  { head :ok }
    end
  end
end
