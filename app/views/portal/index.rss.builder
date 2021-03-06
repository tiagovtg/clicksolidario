xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Emergencias"
    xml.description "Ultimas emergencias do portal clicksolidario"
    xml.link root_url
    unless @emergencias.nil? or @emergencias.empty?
      @emergencias.each do |emergencia|
        xml.item do
          xml.title emergencia.titulo
          xml.description emergencia.resumo
          xml.pubDate emergencia.updated_at.to_s(:rfc822)
          xml.link root_url+"#emergencias"+"/#{emergencia.id}"
          xml.guid root_url
        end
      end
    end
  end
end
