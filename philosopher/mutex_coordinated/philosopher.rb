require_relative "../lib/chopstick"
require_relative "../lib/table"
require_relative "waiter"

class Philosopher
  def initialize name
    @name = name
  end

  def dine table, position, waiter
    @left_chopstick = table.left_chopstick_at position
    @right_chopstick = table.right_chopstick_at position

    loop do
      think
      waiter.serve(table, self)
    end
  end

  def think
    puts "#{@name} is thinking"
  end

  def eat
    puts "#{@name} is eating"

    drop_chopsticks
  end

  def drop_chopsticks
    @left_chopstick.drop
    @right_chopstick.drop
  end

  def take_chopsticks
    @left_chopstick.take
    @right_chopstick.take
  end
end

names = %w{Heraclitus Aristotle Epictetus Schopenhauer Popper}

philosophers = names.map { |name| Philosopher.new(name) }
table        = Table.new(philosophers.size)
waiter       = Waiter.new(philosophers.size - 1)

threads = philosophers.map.with_index do |philosopher, i|
  Thread.new { philosopher.dine(table, i, waiter) }
end

threads.each(&:join)
sleep
