require 'helper'

class ProbabilisticTrackTest < Test::Unit::TestCase
  
  def setup
    @test_tracks  = {
      :blank         => ProbabilisticTrack.new("bass", ""),
      :solo          => ProbabilisticTrack.new("bass", "1"),
      :solo_never    => ProbabilisticTrack.new("bass", "0"),
      :with_overflow => ProbabilisticTrack.new("bass", "0 0 0 1"),
      :with_barlines => ProbabilisticTrack.new("bass", "| 1 0 1 0 | 1 0 1 0 |"),
      :placeholder   => ProbabilisticTrack.new("bass", "0 0 0 0"),
      :complicated   => ProbabilisticTrack.new("bass", "0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 1")
    }
  end
  
  def test_initialize
    assert_equal [0], @test_tracks [:blank].beats
    assert_equal "bass", @test_tracks [:blank].name
    assert_equal "", @test_tracks [:blank].rhythm
    
    assert_equal [0, 1], @test_tracks [:solo].beats
    assert_equal "bass", @test_tracks [:solo].name
    assert_equal "X", @test_tracks [:solo].rhythm
    
    assert_equal [1], @test_tracks [:solo_never].beats
    assert_equal "bass", @test_tracks [:solo_never].name
    assert_equal ".", @test_tracks [:solo_never].rhythm
    
    assert_equal [3, 1], @test_tracks [:with_overflow].beats
    assert_equal "...X", @test_tracks [:with_overflow].rhythm
    
    assert_equal [0, 2, 2, 2, 2], @test_tracks [:with_barlines].beats
    assert_equal "X.X.X.X.", @test_tracks [:with_barlines].rhythm
    
    assert_equal [4], @test_tracks [:placeholder].beats
    assert_equal "....", @test_tracks [:placeholder].rhythm
    
    assert_equal [2, 4, 4, 4, 2, 1], @test_tracks [:complicated].beats
    assert_equal "..X...X...X...X.X", @test_tracks [:complicated].rhythm
  end
  
  def test_step_count
    assert_equal 0,  @test_tracks [:blank].step_count
    assert_equal 1,  @test_tracks [:solo].step_count
    assert_equal 1,  @test_tracks [:solo_never].step_count
    assert_equal 4,  @test_tracks [:with_overflow].step_count
    assert_equal 8,  @test_tracks [:with_barlines].step_count
    assert_equal 4,  @test_tracks [:placeholder].step_count
    assert_equal 17, @test_tracks [:complicated].step_count
  end
  
  def test_valid
    assert_equal true,  ProbabilisticTrack.valid?('1 .2 0 | 1 .2')
    assert_equal false, ProbabilisticTrack.valid?('X...X..')
  end

end