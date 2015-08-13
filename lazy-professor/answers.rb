# encoding: utf-8
TestsFile = File.expand_path('../test.txt', __FILE__)
# Inefficient: This loads everything into memory. Not worth peeking into the
# file and scanning for the newline character for this exercise.
Tests = File.readlines(TestsFile).map(&:chomp)
LineLength = Tests.first.size

# Encapsulates the logic necessary to find "correct" answers within the
# analyzed results.
class Lazy < Struct.new(:answers)

  def best
    answers.max_by(&:last).first
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

Questions = LineLength.times.map { Hash.new { |h, k| h[k] = 0 } }
Tests.each do |test|
  test.chars.each_with_index do |answer, question|
    Questions[question][answer] += 1
  end
end

Lazies = Questions.map { |answers| Lazy.new(answers) }

#puts 'Sure, the correct answers are probably:'
puts Lazies.map(&:best).join
#puts "And I'm about this confident for each:"
#Lazies.each { |l| puts "#{l.best}: #{'%.2f' % l.deviation}" }
