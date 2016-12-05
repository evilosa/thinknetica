module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      raise TypeError, 'Name is not a symbol' unless name.is_a?(Symbol)
      var_name = "@#{name}".to_sym

      # Create getter
      define_method(name) { instance_variable_get(var_name) }

      # Create setter
      define_method("#{name}=") do |value|
        instance_variable_set(var_name, value)
        instance_variable_set("@#{name}_history", eval("#{name}_history") << value )
      end

      # History method
      define_method("#{name}_history") { instance_variable_get("@#{name}_history") || [] }
    end
  end

  def strong_attr_accessor(name, type)
    raise TypeError, 'Name is not a symbol' unless name.is_a?(Symbol)
    var_name = "@#{name}".to_sym

    # Create getter
    define_method(name) { instance_variable_get(var_name) }
    # Create setter
    define_method("#{name}=") do |value|
      raise TypeError, 'Type mismatch' unless value.is_a? type
      instance_variable_set(var_name, value)
    end
  end
end
