require 'test/test_helper'

class CoreTest < Test::Unit::TestCase
  context 'A CodedValue' do
    should 'create an instance from XML' do
      mock_cv_element = {'code' => 'red', 'codeSystem' => '1234',
                         'codeSystemName' => "Andy's Alert System",
                         'version' => '1.0',
                         'displayName' => 'ZOMG!'}
      cv = CodedValue.from_xml(mock_cv_element)
      assert_equal 'red', cv.code
      assert_equal '1234', cv.code_system
      assert_equal "Andy's Alert System", cv.code_system_name
      assert_equal '1.0', cv.version
      assert_equal 'ZOMG!', cv.display_name
    end
    
    should 'return nil when passed nil to from_xml' do
      cv = CodedValue.from_xml(nil)
      assert_nil cv
    end
  end
end