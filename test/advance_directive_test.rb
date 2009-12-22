require 'test/test_helper'

class AdvanceDirectiveTest < Test::Unit::TestCase
  context 'An AdvanceDirective' do
    setup do
      @doc = Nokogiri::XML.parse(File.new(File.join(File.dirname(__FILE__), 'fixtures/1234/advanced_directives/advance_directive1.xml')))
    end
    
    should 'create an instance from XML' do
      ad = AdvanceDirective.from_xml(@doc)
      assert_equal '304251008', ad.type.code
      assert_equal 'Resuscitation', ad.free_text_type
      assert_equal 2006, ad.effective_date.high.year
    end
  end
end