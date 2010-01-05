class AdvanceDirective < SectionBase
  section_namespace 'ad', 'http://projecthdata.org/hdata/schemas/2009/06/advance_directive'
  namespace 'core', 'http://projecthdata.org/hdata/schemas/2009/06/core'

  attr_accessor :type, :free_text_type, :effective_date, :custodian_of_the_document, :status

  def self.create_object(root)
    ad = AdvanceDirective.new
    ad.type = CodedValue.from_xml(root.at_xpath('ad:type'))
    ad.free_text_type = (root.at_xpath('ad:freeTextType')).try(:text)
    ad.effective_date = DateRange.from_xml(root.at_xpath('ad:effectiveDate'))
    ad.custodian_of_the_document = Informant.from_xml(root.at_xpath('ad:custodianOfTheDocument'))
    ad.status = CodedValue.from_xml(root.at_xpath('ad:status'))

    ad
  end

  def to_xml(builder)
    builder ||= Builder::XmlMarkup.new(:indent => 2)

    builder.advanceDirective(AdvanceDirective.namespace_hash) do |ad|
      type.to_element(ad, :type) if type
    end
  end
end