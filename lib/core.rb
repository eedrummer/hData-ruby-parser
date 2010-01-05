class CoreHelper
  # If element is nil, then return nil
  # If the element is not nil, then pass obj to a block and
  # return obj when done
  def self.return_if_element_present(element, obj)
    if element
      yield obj
      obj
    else
      nil
    end
  end
  
  def attributes_to_element(builder, element_name, attributes)
    element_attributes = {}
    attributes.each do |attr|
      element_attributes[attr] = self.send(attr)
    end
    # remove keys that have nil values
    element_attributes = element_attributes.delete_if {|k, v| v.nil?}
    builder.tag!(element_name, element_attributes)
  end
end

class CodedValue < CoreHelper
  attr_accessor :code, :display_name, :version, :code_system, :code_system_name
  
  def self.from_xml(element)
    return_if_element_present(element, CodedValue.new) do |cv|
      cv.code = element['code']
      cv.display_name = element['displayName']
      cv.version = element['version']
      cv.code_system = element['codeSystem']
      cv.code_system_name = element['codeSystemName']
    end
  end
  
  def to_element(builder, element_name = :codedValue)
    attributes_to_element(builder, element_name, [:code, :display_name, :version, :code_system, :code_system_name])
  end
end

class DateRange < CoreHelper
  attr_accessor :high, :low
  
  def self.from_xml(element)
    return_if_element_present(element, DateRange.new) do |dr|
      high_text = element['high']
      if high_text
        dr.high = DateTime.parse(high_text)
      end
      
      low_text = element['low']
      if low_text
        dr.low = DateTime.parse(low_text)
      end
    end
  end
end

class Name < CoreHelper
  attr_accessor :title, :given, :lastname, :suffix
  
  def self.from_xml(element)
    return_if_element_present(element, Name.new) do |name|
      name.title = element.at_xpath('core:title').try(:text)
      name.given = element.xpath('core:given').map {|given| given.text}
      name.lastname = element.at_xpath('core:lastname').try(:text)
      name.suffix = element.at_xpath('core:suffix').try(:text)
    end
  end
end

class Address < CoreHelper
  attr_accessor :street_address, :city, :state_or_province, :zip, :country
  
  def self.from_xml(element)
    return_if_element_present(element, Address.new) do |address|
      address.street_address = element.xpath('core:streetAddress').map {|street_address| street_address.text}
      address.city = element.at_xpath('core:city').try(:text)
      address.state_or_province = element.at_xpath('core:stateOrProvince').try(:text)
      address.zip = element.at_xpath('core:zip').try(:text)
      address.country = element.at_xpath('core:country').try(:text)
    end
  end
end

class Telecom < CoreHelper
  attr_accessor :value, :use, :type
  attr_writer :preferred
  
  def preferred?
    @preferred
  end
  
  def self.from_xml(element)
    return_if_element_present(element, Telecom.new) do |telecom|
      telecom.value = element['value']
      telecom.use = element['use']
      telecom.type = element['type']
      preferred = element['preferred']
      if preferred.eql?('true') || preferred.eql?('1')
        telecom.preferred = true
      else
        telecom.preferred = false
      end
    end
  end
end

class Person < CoreHelper
  attr_accessor :name, :address, :telecom
  
  def self.from_xml(element)
    return_if_element_present(element, Person.new) do |person|
      person.name = Name.from_xml(element.at_xpath('core:name'))
      person.address = element.xpath('core:address').map {|a| Address.from_xml(a)}
      person.telecom = element.xpath('core:telecom').map {|t| Telecom.from_xml(t)}
    end
  end
end

class Organization < CoreHelper
  attr_accessor :name, :points_of_contact, :address
  
  def self.from_xml(element)
    return_if_element_present(element, Organization.new) do |organization|
      organization.name = element.at_xpath('core:name').try(:text)
      organization.points_of_contact = element.xpath('core:pointsOfContact/core:pointOfContact').map {|p| Person.from_xml(p)}
      organization.address = element.xpath('core:address').map {|a| Address.from_xml(a)}
    end
  end
end

class Informant < CoreHelper
  attr_accessor :contact, :organization
  
  def self.from_xml(element)
    return_if_element_present(element, Informant.new) do |informant|
      informant.contact = element.xpath('core:contact').map {|p| Person.from_xml(p)}
      informant.organization = Organization.from_xml(element.at_xpath('core:organization'))
    end
  end
end