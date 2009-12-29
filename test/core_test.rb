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
  
  context 'A DateRange' do
    should 'create an instance from XML' do
      mock_date_range_element = {'high' => '2007-05-04T18:13:51.0Z',
                                 'low' => '2006-05-04T18:13:51.0Z'}
      dr = DateRange.from_xml(mock_date_range_element)
      assert_equal 2007, dr.high.year
      assert_equal 2006, dr.low.year
    end
    
    should 'return nil when passed nil to from_xml' do
      dr = DateRange.from_xml(nil)
      assert_nil dr
    end
  end
  
  context 'A Name' do
    should 'create an instance from XML' do
      doc = Nokogiri::XML.parse(File.new(File.join(File.dirname(__FILE__), 'fixtures/standalone/name.xml')))
      name = Name.from_xml(doc.root)
      assert_equal 'Dr.', name.title
      assert_equal 'Steve', name.given.first
      assert_equal 2, name.given.length
      assert_equal 'Jones', name.lastname
      assert_equal 'III', name.suffix
    end
    
    should 'return nil when passed nil to from_xml' do
      name = Name.from_xml(nil)
      assert_nil name
    end
  end
  
  context 'An Address' do
    should 'create an instance from XML' do
      doc = Nokogiri::XML.parse(File.new(File.join(File.dirname(__FILE__), 'fixtures/standalone/address.xml')))
      address = Address.from_xml(doc.root)
      assert_equal '100 Main St.', address.street_address[0]
      assert_equal 'Apt. 2', address.street_address[1]
      assert_equal 'Bedford', address.city
      assert_equal 'MA', address.state_or_province
      assert_equal '01730', address.zip
      assert_equal 'USA', address.country
    end
    
    should 'return nil when passed nil to from_xml' do
      address = Address.from_xml(nil)
      assert_nil address
    end
  end
  
  context 'A Telecom' do
    should 'create an instance from XML' do
      doc = Nokogiri::XML.parse(File.new(File.join(File.dirname(__FILE__), 'fixtures/standalone/telecom.xml')))
      telecom = Telecom.from_xml(doc.root.at_xpath('core:telecom[1]'))
      assert_equal '+1-781-217-3000', telecom.value
      assert_equal 'phone-landline', telecom.type
      assert_equal 'work', telecom.use
      assert telecom.preferred?
      
      telecom = Telecom.from_xml(doc.root.at_xpath('core:telecom[2]'))
      assert_equal 'something@somewhere.com', telecom.value
      assert_equal 'email', telecom.type
      assert_equal 'work', telecom.use
      assert !telecom.preferred?
    end
    
    should 'return nil when passed nil to from_xml' do
      telecom = Telecom.from_xml(nil)
      assert_nil telecom
    end
  end
  
  context 'A Person' do
    should 'create an instance from XML' do
      doc = Nokogiri::XML.parse(File.new(File.join(File.dirname(__FILE__), 'fixtures/standalone/person.xml')))
      person = Person.from_xml(doc.root)
      assert_equal 'Dr.', person.name.title
      assert_equal '100 Main St.', person.address[0].street_address[0]
      assert person.telecom[0].preferred?
    end
    
    should 'return nil when passed nil to from_xml' do
      person = Person.from_xml(nil)
      assert_nil person
    end
  end
  
  context 'An Organization' do
    should 'create an instance from XML' do
      doc = Nokogiri::XML.parse(File.new(File.join(File.dirname(__FILE__), 'fixtures/standalone/organization.xml')))
      organization = Organization.from_xml(doc.root)
      assert_equal 'Acme Industries', organization.name
      assert_equal 'Dr.', organization.points_of_contact[0].name.title
      assert_equal '100 Main St.', organization.address[0].street_address[0]
    end
    
    should 'return nil when passed nil to from_xml' do
      organization = Organization.from_xml(nil)
      assert_nil organization
    end
  end
end