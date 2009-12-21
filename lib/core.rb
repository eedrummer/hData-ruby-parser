class CodedValue
  attr_accessor :code, :display_name, :version, :code_system, :code_system_name
  
  def self.from_xml(element)
    cv = CodedValue.new

    cv.code = element['code']
    cv.display_name = element['displayName']
    cv.version = element['version']
    cv.code_system = element['codeSystem']
    cv.code_system_name = element['codeSystemName']
    
    cv
  end
end