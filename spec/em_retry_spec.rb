$LOAD_PATH << File.join(File.expand_path(File.dirname(__FILE__)), '../lib')

require 'em_retry'

describe EventMachine do
  describe ".with_retries" do
    it "should retry the block" do
      EM.run do
        EM.add_timer(0.8){EM.stop}
        
        Kernel.should_receive(:puts).with("trial 1")
        Kernel.should_receive(:puts).with("trial 2")
        Kernel.should_receive(:puts).with("trial 3")
        Kernel.should_receive(:puts).with("trial 4")
        
        i = 0
        EM.with_retries 0.01, 0.02, 0.03 do
          Kernel.puts "trial #{i+=1}"
        end
      end
    end
    it "should use the given timers" do
      EM.run do
        EM.add_timer(0.1){EM.stop}
        
        EM.should_receive(:add_timer).with(0.01)
        EM.with_retries 0.01 do
          Kernel.puts "trial"
        end
      end
    end
  end
end

class A
  extend EMRetryMethod
  def foo; end
  retry_method :foo, 1,2,3
end

describe EMRetryMethod do
  describe "#retry_method" do
    before(:each) do
      @a = A.new
    end
    it "should description" do
      EM.should_receive(:with_retries).with(1,2,3)
      @a.foo
    end
  end
end
