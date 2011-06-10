module ApplicationHelper
  # metodo usado para deletar uma div, usada em nested forms
  def add_child_link(name, form_builder, association)
    object = form_builder.object.class.reflect_on_association(association).klass.new
    partial = "generals/#{association.to_s}"
    template = content_tag(:div, :id => "#{association}_fields_template", :style => "display: none") do
      form_builder.fields_for(association, object, :child_index => "new_#{association}") do |f|
        render(:partial => partial, :locals => { :f => f })
      end
    end
    template + link_to(name, "javascript:void(0)", :class => "add_child", :"data-association" => association)
  end

  # metodo usado para adicionar um campo, dentro do nested forms.
  def remove_child_link(name, f)
    f.hidden_field(:_destroy) + link_to(name, "javascript:void(0)", :class => "remove_child")
  end


  #obtem cep via webservice.
  def obter_cep(cep)
    url = URI.parse("http://cep.republicavirtual.com.br/web_cep.php?cep=#{cep}&formato=query_string")
    consulta = Net::HTTP.get_response(url)
    pesquisa = CGI::parse(consulta.body)

    # o CGI::parse retorna um hash cujos valores são arrays de um elemento só.
    # para facilitar tratamento posterior vamos retirar os valores destes arrays
    # exemplo:  'tipo_logradouro' => ['Rua']  vira  'tipo_logradouro' => 'Rua'
    pesquisa = Hash[*pesquisa.map { |k, v| [k, v[0]] }.flatten]

    case pesquisa['resultado'].to_i
    when 1:
       # puts "Cidade com logradouro completo:"
      puts "Tipo: \t\t" + pesquisa['tipo_logradouro']
      puts "Logradouro: \t" + pesquisa['logradouro']
      puts "Bairro: \t" + pesquisa['bairro']
      puts "Cidade: \t" + pesquisa['cidade']
      puts "UF: \t\t" + pesquisa['uf']
    when 2:
        #puts "Cidade com logradouro único:"
      puts "Cidade: \t" + pesquisa['cidade']
      puts "UF: \t\t" + pesquisa['uf']
    else
      puts "Falha ao procurar o CEP #{cep}"
    end
  end

end
