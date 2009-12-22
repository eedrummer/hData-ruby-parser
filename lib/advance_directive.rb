class AdvanceDirective < SectionBase
  section_namespace 'ad', 'http://projecthdata.org/hdata/schemas/2009/06/advance_directive'
  namespace 'core', 'http://projecthdata.org/hdata/schemas/2009/06/core'
  
  attr_accessor :type, :free_text_type, :effective_date, :custodian_of_the_document, :status, :information_source, :narrative
  
  def self.create_object(root)
    ad = AdvanceDirective.new
    ad.type = CodedValue.from_xml(root.at_xpath('ad:type'))
    ad.free_text_type = (root.at_xpath('ad:freeTextType')).text
    
    ad
  end
end