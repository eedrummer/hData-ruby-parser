class SectionBase
  attr_accessor :information_source, :narrative
  
  # Adds a namespace and prefix to Nokogiri, also used
  # to record the main namespace of an hData section
  def self.section_namespace(prefix, uri)
    @section_namespace_prefix = prefix
    @section_namespace_uri = uri
    namespace(prefix, uri)
  end
  
  # Add a namespace that will be registered with Nokogiri when
  # doing processing
  def self.namespace(prefix, uri)
    @namespaces ||= []
    @namespaces << {:prefix  => prefix, :uri => uri}
  end
  
  # Returns a hash of namespaces that can be used for building the root
  # element of a section document
  #
  # The section namespace will be set to the default namespace. It is
  # assumed the the builder will not be using a prefix for elements
  # in the section namespace
  def self.namespace_hash
    namespaces = {}
    
    @namespaces.each do |ns_pair|
      if ns_pair[:uri].eql? @section_namespace_uri
        namespaces['xmlns'] = @section_namespace_uri
      else
        namespaces["xmlns:#{ns_pair[:prefix]}"] = ns_pair[:uri]
      end
    end
    
    namespaces
  end
  
  # This is an abstract method. It is assumed that a subclass will implement
  # a create_object method
  def self.from_xml(doc)
    root_element = doc.root
    
    @namespaces.each do |ns_hash|
      root_element.add_namespace_definition(ns_hash[:prefix], ns_hash[:uri])
    end
    
    obj = create_object(root_element)
    
    obj.information_source = root_element.xpath("#{@section_namespace_prefix}:informationSource").map {|i| Informant.from_xml(i)}
    obj.narrative = root_element.at_xpath("#{@section_namespace_prefix}:narrative").try(:text)
    
    obj
  end
end