require_relative 'futurema'

module Kernel
  def future &block
    Futurema::Future.new &block
  end
end
