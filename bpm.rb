=begin

Script that will play a particular sound at a random bpm and prompt for my guess. 

1. I can specify how many times to test me before finishing.
2. I can specify how long each test interval is.
3. I can specify whether to test on multiples of 5 (e.g. 105, 145 bpm).
4. Script should print back bpm values and my guesses for each test, along with average accuracy.

https://books.google.com/books?id=93y-8DRUAz8C&pg=PA22&lpg=PA22&dq=ruby+music+metronome&source=bl&ots=503kps2pxF&sig=0-y1u2vUaKamWjIlzAEqe82_Ldc&hl=en&sa=X&ei=_mAxVcD-N6GwsAT9w4DwCA&ved=0CFUQ6AEwDA#v=onepage&q=ruby%20music%20metronome&f=false

This is for *me*, so I don't really care about making it prompt yet. For now, let's make a 
script that requires command-line args and then does a loop.

loop needs to iterate as many times as I've specified for tests. Easy, but inside the loop I need to 
generate a random bpm and then...hmm..

loop for # args
  generate random bpm value
  # there's a way to get loop+sleep time per bpm arg....formula is (bpm/60)*specified_seconds_of_test

Timing is inaccurate...try this in JS?

https://github.com/cwilso/metronome/tree/master/js

=end

clip_interval = ARGV[0].to_i
num_clips = ARGV[1].to_i
r = Random.new
(1..num_clips).each do |b|
  bpm = r.rand(8..40)*5.to_i #generate random beat of 40-200bpm, multiples of 5
  #cheatmode for testing
  #puts "Generating #{bpm} beat..."
  puts "Generating beat..."
  sleep 1
  spb = 60.0/bpm
  beats = 0
  while true do
    if beats < clip_interval
      beats += spb
      sleep spb
      Process.fork {`afplay sounds/kick_33.wav`}
    else
      break
    end
  end
  #add guess here
  print "What was the bpm?: "
  ans = STDIN.gets.strip.to_i
  if ans == bpm
    puts "CORRECT"
  else
    puts "Wrong, it was #{bpm}."
  end
end
