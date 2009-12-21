class AdvanceDirective
  attr_accessor :type, :free_text_type, :effective_date, :custodian_of_the_document, :status, :information_source, :narrative
  
  def self.from_xml(doc)
    root = doc.root
    root.add_namespace_definition('ad', 'http://projecthdata.org/hdata/schemas/2009/06/advance_directive')
    root.add_namespace_definition('core', 'http://projecthdata.org/hdata/schemas/2009/06/core')
    
    ad = AdvanceDirective.new
    ad.free_text_type = ( root / './ad:freeTextType').text
    
    ad
  end
end