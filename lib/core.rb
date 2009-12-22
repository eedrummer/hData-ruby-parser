class CodedValue
  attr_accessor :code, :display_name, :version, :code_system, :code_system_name
  
  def self.from_xml(element)
    if element
      cv = CodedValue.new

      cv.code = element['code']
      cv.display_name = element['displayName']
      cv.version = element['version']
      cv.code_system = element['codeSystem']
      cv.code_system_name = element['codeSystemName']

      cv
    else
      nil
    end
  end
end

class DateRange
  attr_accessor :high, :low
  
  def self.from_xml(element)
    if element
      dr = DateRange.new
      
      high_text = element['high']
      if high_text
        dr.high = DateTime.parse(high_text)
      end
      
      low_text = element['low']
      if low_text
        dr.low = DateTime.parse(low_text)
      end
      
      dr
    else
      nil
    end
  end
end

class Name
end