# Use Adapt Parameter when you can't use Extract Interface on a parameter's 
# class or when a parameter is difficult to fake - M. Feathers
#
# In Ruby Extract Interface does not really apply due to dynamic typing.
# Adapt Parameter is very similar to Extract Interface


# original snippet. We would like to change 'parameter_values' into a method
# 'parameter_for_name' which returns only 1 value as oppose to an array.
# the 'request' object is an instance of an external library that we don't 
# own. This makes difficult improving the code without being able to define
# 'parameter_for_name' directly in the Request class.
class ArmDispatcher
  def populate(request)
    values = request.parameter_values(page_state_name)
    if values && values.any?
      market_bindings.put(page_state_name + date_stamp, values[0])
    end
  end
end

# fake used in testing and passed as parameter to #populate method
class ParameterSourceFake
  def parameter_for_name(name)
    'test_value'
  end
end

# new wrapper of the original request parameter which contains an 
# optimized code
class ServletParameterSource
  def initialize(request)
    @request = request
  end

  def parameter_for_name(name)
    values = request.parameter_values(name)
    values[0] if values && values.any?
  end
end

# refactored snippet
class ArmDispatcher
  def populate(source)
    value = source.parameter_for_name(page_state_name)
    if value
      market_bindings.put(page_state_name + date_stamp, value)
    end
  end
end