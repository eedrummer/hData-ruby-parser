require 'test/test_helper'

class SectionBaseTest < Test::Unit::TestCase
  context 'SectionBase' do
    should 'properly return namespaces' do
      class Splat < SectionBase
        section_namespace 'foo', 'http://foo.com'
        namespace 'core', 'http://projecthdata.org/hdata/schemas/2009/06/core'
      end
      
      ns = Splat.namespace_hash
      assert_equal 'http://foo.com', ns['xmlns']
      assert_equal 'http://projecthdata.org/hdata/schemas/2009/06/core', ns['xmlns:core']
    end
  end
end