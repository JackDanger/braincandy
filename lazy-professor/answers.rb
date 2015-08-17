# encoding: utf-8
TestsFile = File.expand_path('../test.txt', __FILE__)

Tests = File.readlines(TestsFile).map(&:chomp)

LineLength = Tests.first.size

# Encapsulates the logic necessary to find "correct" answers within the
# analyzed results.
class Lazy < Struct.new(:answers)

  def best
    answers.group_by(&:to_s).values.max_by(&:size).first
  end

  # Average absolute deviation
  def deviation
    sum_of_differences / mean
  end

  private

  def sum_of_differences
    answers.values.map { |count| (count - mean).abs }.reduce(&:+)
  end

  def mean
    answers.values.reduce(&:+) / answers.size.to_f
  end
end

Lazies = Tests.map(&:chars).transpose.map { |answers| Lazy.new(answers) }

#puts 'Sure, the correct answers are probably:'
puts Lazies.map(&:best).join
#puts "And I'm about this confident for each:"
#Lazies.each { |l| puts "#{l.best}: #{'%.2f' % l.deviation}" }
