require 'test/test_helper'

class AdvanceDirectiveTest < Test::Unit::TestCase
  context 'An AdvanceDirective' do
    setup do
      @doc = Nokogiri::XML.parse(File.join(File.dirname(__FILE__), 'data/advance_directives/advance_directive1.xml'))
    end
    
    should 'create an instance from XML' do
      ad = AdvanceDirective.from_xml(@doc)
      assert_equal 'Resuscitation', ad.free_text_type
    end
  end
end