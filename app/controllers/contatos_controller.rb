class ContatosController < ApplicationController

  access_control do
    allow anonymous,      :to => [ :new, :create, :show ]
    allow :administrador, :to => [:index, :show, :new, :edit, :create, :update, :destroy ]
  end

  def index
    @contatos = Contato.all
  end

  def show
    @contato = Contato.find(params[:id])

    unless administrador?
      render :layout=> 'portal'
    end
  end

  def new
    @contato = Contato.new
    render :layout=> 'portal'
  end

  def edit
    @contato = Contato.find(params[:id])
  end

  def create
    @contato = Contato.new(params[:contato])

    respond_to do |format|
      if @contato.save
        format.html { redirect_to(@contato, :notice => 'Contato foi mandado com sucesso.'+
              "#{CountMail.enviar_email("Administrador", "tiagovtg@gmail.com", "Um contato novo foi registrado.",
            "Voce tem um novo contato mandando por #{@contato.nome} em #{@contato.created_at}, assunto: #{@contato.assunto}")}") }#manda email
      else
        format.html { render :action => "new", :layout=> 'portal'}
      end
    end
  end

  def update
    @contato = Contato.find(params[:id])

    respond_to do |format|
      if @contato.update_attributes(params[:contato])
        format.html { redirect_to(@contato, :notice => 'Contato alterado com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contato.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @contato = Contato.find(params[:id])
    @contato.destroy

    respond_to do |format|
      format.html { redirect_to(contatos_url) }
      format.xml  { head :ok }
    end
  end

end