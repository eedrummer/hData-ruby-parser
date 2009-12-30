require 'test/test_helper'

class AllergyTest < Test::Unit::TestCase
  context 'An Allergy' do
    setup do
      @doc = Nokogiri::XML.parse(File.new(File.join(File.dirname(__FILE__), 'fixtures/1234/adverse_reactions/allergies/allergy1.xml')))
    end
    
    should 'create an instance from XML' do
      allergy = Allergy.from_xml(@doc)
      assert_equal '420134006', allergy.adverse_event_type.code
      assert_equal 'code3', allergy.product.code
      assert_equal 'code5', allergy.reaction.code
      assert_equal '255604002', allergy.severity.code
      assert_equal '55561003', allergy.alert_status.code
      assert_equal 'Allergic to bee stings', allergy.narrative
    end
  end
end