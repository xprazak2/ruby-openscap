require 'openscap/xccdf/rule'
require 'openscap/exceptions'
require 'openscap/xccdf/group'

module OpenSCAP
  module Xccdf
    class ItemBuilder
      def build(pointer)
        raise OpenSCAP::OpenSCAPError, "Cannot initialize #{self.class.name} with #{pointer}" unless pointer.is_a?(FFI::Pointer)
        case OpenSCAP.xccdf_item_get_type pointer
        when :group
          OpenSCAP::Xccdf::Group.new pointer
        when :rule
          OpenSCAP::Xccdf::Rule.new pointer
        else
          raise OpenSCAP::OpenSCAPError, "Unknown #{self.class.name} type: #{OpenSCAP.xccdf_item_get_type pointer}"
        end
      end
    end
  end

  XccdfItemType = enum(:benchmark, 0x0100,
                       :profile, 0x0200,
                       :result, 0x0400,
                       :rule, 0x1000,
                       :group, 0x2000,
                       :value, 0x4000)

  attach_function :xccdf_item_get_type, [:pointer], XccdfItemType

  attach_function :xccdf_item_iterator_has_more, [:pointer], :bool
  attach_function :xccdf_item_iterator_next, [:pointer], :pointer
  attach_function :xccdf_item_iterator_free, [:pointer], :void
end
