require 'eventmachine'

# Tries to evaluate the given block with the given timers
# until it's not nil or false.
# 
#   EM.with_retries(1,2,3){false}
# 
# is executed immediatelly, after 1 second,
# after another 2 secondes and after another 3 seconds.
# 
module EventMachine
  def self.with_retries(*timers, &block)
    block.call || !timers.empty? && EM.add_timer(timers.shift) do
      with_retries *timers, &block
    end
  end
end

# A convenience wrapper for existing methods to indicate they should be
# executed in a EM.with_retries block.
# 
module EMRetryMethod
  def retry_method(meth, *timers)
    orig_method = instance_method(meth)
    
    define_method meth do |*args, &block|
      EM.with_retries *timers do
        orig_method.bind(self).call *args, &block
      end
    end
  end
end
