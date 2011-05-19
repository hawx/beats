# A track which fires each event based on the probabality listed, eg.
#
#   bass: .5 0 0 0 1 0 0 0 .5 0 0 0 1 0 0 0
#
# has a 1 in 2 chance of playing the first and third drum beat, but 
# will always play the second and fourth beat. This is actually 
# compiled to a static rhythm with the probabilities being
# worked out beforehand.
class ProbabilisticTrack < Track

  def initialize(name, rhythm)
    @name = name
    self.rhythm = rhythm
  end
  
  def self.valid?(rhythm)
    # Add a space to make the regexp less complex, otherwise you have to account 
    # for space at the end!
    if (rhythm + ' ') =~ /^((\d+|\.\d|0\.\d|1\.0)\s+|\s*\|\s*)+$/
      true
    else
      false
    end
  end
  
  def rhythm=(rhythm)
    beats = []
    
    beat_length = 0
    rhythm.delete(BARLINE).split(' ').map {|i| i.strip }.each do |ch|
      prob = Float(ch) rescue raise("Invalid character '#{ch}' in track #{@name}")
      
      test = case ch
        when /1(\.0)?/ then true  # always play
        when /0(\.0)?/ then false # never play
      else
        prob >= rand # play if probability is gte to random number
      end
        
      if test == true
        beats << beat_length
        beat_length = 1
      else
        beat_length += 1
      end
    end

    if beat_length > 0
      beats << beat_length
    end
    
    counter = 0
    indexes = beats.map do |i|
      n = counter + i
      counter += i
      n
    end
        
    @rhythm = REST * counter
    indexes.each do |i|
      @rhythm[i] = BEAT
    end
    @rhythm.chop!
    
    if beats == []
      beats = [0]
    end    

    @beats = beats
  end

end
