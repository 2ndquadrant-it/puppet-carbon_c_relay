module Puppet::Parser::Functions
  newfunction(:carbon_c_relay_sorted, :type => :rvalue) do |args|
    obj = args[0] || {}
    order = args[1] || 0
    case obj
    when Hash

      obj.keys.sort {
        |a,b| (b.include? a) ? 1 : (a <=> b)
      }.each_with_index do |key, index|
        obj[key][:order] = order + index
      end

      return obj
    else
      raise Exception("Unable to handle object of type <%s>" % obj.class.to_s)
    end
  end
end
