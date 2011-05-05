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

end
