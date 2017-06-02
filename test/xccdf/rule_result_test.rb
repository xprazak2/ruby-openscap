require 'openscap'
require 'openscap/source'
require 'openscap/xccdf/benchmark'
require 'openscap/xccdf/testresult'
require 'common/testcase'

class RuleResultTest < OpenSCAP::TestCase
  def test_destroy_rule_results
    source = OpenSCAP::Source.new('../data/testresult.xml')
    test_result = OpenSCAP::Xccdf::TestResult.new(source)
    refute test_result.rr.empty?
    test_result.rr.values.map(&:destroy) # invalid pointer
    test_result.destroy
    source.destroy
  end
end