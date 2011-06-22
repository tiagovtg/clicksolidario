class CountMail < ActiveRecord::Base
  # by Tiago.
  validates :created_at, :uniqueness => true

  def self.verifica_limite?
    # verifica se existe dados para o dia atual.
    @limit = self.find_by_created_at(Date.today) rescue nil

    #limite sao 500 emails pelo gmail, ao dia.
    if !@limit.nil? and @limit.enviados <= 499
      return true
    else
      return false
    end
  end

  def self.cria!
    @limit = self.find_by_created_at(Date.today) rescue nil
    if @limit.nil?
      @limit = self.new
      @limit.enviados = 0
      @limit.created_at=Date.today
      if @limit.save
        return true
      else
        return false
      end
    else
      return false
    end
  end


  def self.adiciona_um!
    if cria!
      soma=@limit.enviados + 1
      @limit.update_attributes(:enviados=> soma)
      return true
    else
      if verifica_limite?
        soma=@limit.enviados + 1
        @limit.update_attributes(:enviados=> soma)
        return true
      end
      return false
    end
  end

  def self.remove_um!
    soma=@limit.enviados - 1
    @limit.update_attributes(:enviados=> soma)
  end

  def self.enviar_email(nome, email, subject, body)
    if adiciona_um!
      begin
        NewsletterMailer.envia_email(nome, email, subject, body).deliver
        return "E email, enviado!"
      rescue => e
        remove_um!
        logger.info "\n\n=> email error: #{e.message}\n"
        return 'error: '+e.message
      end
    else
      logger.info "\n\n=> limite de emails esgotado: #{@limit.enviados}\n"
      return 'erro: Ultrapassou limite do dia de '+ @limit.enviados.to_s
    end
  end

end
