require 'securerandom'

N = 10_000
inside = N.times.select do
  x = SecureRandom.random_number
  y = SecureRandom.random_number
  Math.sqrt(x*x + y*y) < 1.0
end.size

p inside * 4.0 / N





