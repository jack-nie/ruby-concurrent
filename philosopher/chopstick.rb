class Chopstick
  def initialize
    @mutux = Mutex.new
  end

  def take
    @mutex.lock
  end

  def drop
    @mutex.unlock
  rescue ThreadError
    puts "Trying to drop a chopstick not acquired"
  end

  def in_use?
    @mutex.lock?
  end
end
