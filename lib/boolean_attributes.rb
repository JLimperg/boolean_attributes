# Central module of the `boolean_attributes` gem. Include this module in any
# class you want to define boolean attributes for.
#
# Note that this module does not use the usual Ruby mixin mechanism. For more
# information see {append_features}.
module BooleanAttributes

  # Defines helper methods for boolean attributes on `klass`. In particular,
  # this method adds three private class methods to `klass`:
  #
  # 1. `b_attr_accessor` -- creates a boolean attribute with setter and getter
  #    methods. `b_attr` is also added as an alias.
  # 2. `b_attr_writer` -- creates a write-only boolean attribute.
  # 3. `b_attr_reader` -- creates a read-only boolean attribute.
  #
  # Note that by redefining this method, the default inheritance mechanism of
  # Ruby is overwritten. Consequently, `object.include(BooleanAttributes)` will
  # not 'copy' any instance methods or variables you might define for
  # `BooleanAttributes` -- it won't do anything but add the class methods
  # mentioned above. This hack is necessary because classes don't inherit a
  # module's class methods (or module methods) by default.
  #
  # @param [Class] klass A `Class`. Technically, `klass` can also be a `Module`.
  # @return [void]
  def self.append_features(mod)

    klass.module_eval <<-END
      def self.b_attr_accessor(*attrs)
        attrs.each do |a|
          b_attr_writer a
          b_attr_reader a
        end
      end

      def self.b_attr(*attrs); b_attr_accessor *attrs; end

      private_class_method :b_attr_accessor, :b_attr
    END

    klass.module_eval <<-END
      def self.b_attr_writer(*attrs)
        attrs.each do |a|
          attr_writer a
        end
      end

      private_class_method :b_attr_writer
    END

    klass.module_eval <<-END
      def self.b_attr_reader(*attrs)
        attrs.each do |a|
          define_method(a.to_s + '?') do
            val = instance_variable_get('@' + a.to_s)
            (val == false || val == nil) ? false : true
          end
        end
      end

      private_class_method :b_attr_reader
    END

  end

end
