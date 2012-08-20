module AttributeValidated
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_validated(name, &block)
      #define the setter
      define_method name do
        instance_variable_get(:"@#{name}")
      end

      #define the setter
      define_method "#{name}=" do |new_value|
        instance_variable_set(:"@#{name}", new_value) if block.call(new_value)
      end
    end
  end
end
