class Allergy < SectionBase
  section_namespace 'allergy', 'http://projecthdata.org/hdata/schemas/2009/06/allergy'
  namespace 'core', 'http://projecthdata.org/hdata/schemas/2009/06/core'
  
  attr_accessor :adverse_event_date, :adverse_event_type, :product, :reaction, :severity, :alert_status
  
  def self.create_object(root)
    allergy = Allergy.new
    allergy.adverse_event_date = DateRange.from_xml(root.at_xpath('allergy:adverseEventDate'))
    allergy.adverse_event_type = CodedValue.from_xml(root.at_xpath('allergy:adverseEventType'))
    allergy.product = CodedValue.from_xml(root.at_xpath('allergy:product'))
    allergy.reaction = CodedValue.from_xml(root.at_xpath('allergy:reaction'))
    allergy.severity = CodedValue.from_xml(root.at_xpath('allergy:severity'))
    allergy.alert_status = CodedValue.from_xml(root.at_xpath('allergy:alertStatus'))
    
    allergy
  end
end