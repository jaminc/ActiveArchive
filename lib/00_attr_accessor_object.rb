class AttrAccessorObject
  def self.my_attr_accessor(*names)
    variables = names
    variables.each do |variable|
      define_method(variable) do
        self.instance_variable_get("@#{variable}".to_sym)
      end

      define_method("#{variable}=") do |value|
        instance_variable_set("@#{variable}", value)
      end
    end
  end
end
