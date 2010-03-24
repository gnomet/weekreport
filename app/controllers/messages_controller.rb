class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.xml
  def index
    redirect_to new_message_path
    # @messages = Message.all
    # 
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.xml  { render :xml => @messages }
    # end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }   
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    if params[:team] && !params[:team].eql?("")
      team = Team.find(params[:team])
      if team.has_message_for_this_week?
        redirect_to edit_message_path(team.messages.last, :team => team) and return
      end  
    end
    
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
    render :action => :new
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])
    
    @old_message = Message.find(:all, :conditions => ["team_id LIKE ? AND is_sent = 0", params[:message][:team_id]]).first

    respond_to do |format|
      if @message.save
        @old_message.destroy if @old_message
        flash[:notice] = 'Message was successfully created.'
        format.html { redirect_to(new_message_path(:team => @message.team)) }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        flash[:notice] = 'Message was successfully updated.'
        format.html { redirect_to(new_message_path(:team => @message.team)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end
end
