class NewslettersController < ApplicationController
  access_control do
    allow :administrador, :to => [:index, :show, :new, :edit, :create, :update, :destroy ]
  end

  def index
    if params[:query]=="Digitar..." or params[:query].nil? or params[:query].empty?
      @newsletters = Newsletter.paginate(:page => params[:page], :order => 'email')
    else
      if params[:filtro]=="Buscar por..." or params[:filtro].nil? or params[:filtro].empty?
        #        flash[:notice] = "Favor preencher o campo de busca por..."
      else
        @newsletters = Newsletter.paginate(:page => params[:page], :order => 'email', :conditions => ['newsletters.'+"#{params[:filtro]}"+' LIKE ?', "%#{params[:query]}%"])
      end
    end
  end

  # GET /newsletters/1
  # GET /newsletters/1.xml
  def show
    @newsletter = Newsletter.find(params[:id])
  end

  # GET /newsletters/new
  # GET /newsletters/new.xml
  def new
    @newsletter = Newsletter.new
  end

  # GET /newsletters/1/edit
  def edit
    @newsletter = Newsletter.find(params[:id])
  end

  # POST /newsletters
  # POST /newsletters.xml
  def create
    @newsletter = Newsletter.new(params[:newsletter])

    respond_to do |format|
      if @newsletter.save
        enviar
        
        format.html { redirect_to(@newsletter, :notice => 'Newsletter was successfully created.') }
        format.xml  { render :xml => @newsletter, :status => :created, :location => @newsletter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @newsletter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /newsletters/1
  # PUT /newsletters/1.xml
  def update
    @newsletter = Newsletter.find(params[:id])

    respond_to do |format|
      if @newsletter.update_attributes(params[:newsletter])
        format.html { redirect_to(@newsletter, :notice => 'Newsletter was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @newsletter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /newsletters/1
  # DELETE /newsletters/1.xml
  def destroy
    @newsletter = Newsletter.find(params[:id])
    @newsletter.destroy

    respond_to do |format|
      format.html { redirect_to(newsletters_url) }
      format.xml  { head :ok }
    end
  end

  #  def enviar_emails
  #    @newsletters = Newsletter.all
  #    NewsletterMailer.envia_email(@newsletters).deliver
  #  end

  #  def importar_emails

  #  end


  def enviar
    begin
      NewsletterMailer.envia_email(@newsletter).deliver
      #      redirect_to :action => 'index'
    rescue => e
      logger.info "\n\n=> meleca message: #{e.message}\n"
      #      flash.now[:notice] = e.message
      #      render :action => 'action'
    end
  end
end
