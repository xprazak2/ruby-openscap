require 'openscap'
require 'openscap/source'
require 'openscap/xccdf/benchmark'
require 'openscap/xccdf/item'
require 'common/testcase'

class ItemTest < OpenSCAP::TestCase
  def test_destroy_items
    source = OpenSCAP::Source.new('../data/xccdf.xml')
    benchmark = OpenSCAP::Xccdf::Benchmark.new(source)
    items = benchmark.items
    refute items.values.empty?
    items.values.map(&:destroy) # segfault
    benchmark.destroy
    source.destroy
  end
end