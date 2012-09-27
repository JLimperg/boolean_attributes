module BooleanAttributes

  def self.append_features(mod)

    mod.module_eval <<-END
      def self.b_attr_accessor(*attrs)
        attrs.each do |a|
          b_attr_writer a
          b_attr_reader a
        end
      end

      def self.b_attr(*attrs); b_attr_accessor *attrs; end

      private_class_method :b_attr_accessor, :b_attr
    END

    mod.module_eval <<-END
      def self.b_attr_writer(*attrs)
        attrs.each do |a|
          attr_writer a
        end
      end

      private_class_method :b_attr_writer
    END

    mod.module_eval <<-END
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
