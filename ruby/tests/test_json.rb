require 'minitest/autorun'
require 'bitv'

class TestJson < Minitest::Test
  def setup
    @flags = (:a..:az).to_a
    @bv = BitVector.new(@flags)
    @targets = { 'target1' => [:a, :b], 'target2' => [:c, :d], 'target3' => [] }
    @bv.targets = @targets
    @json_hash = JSON.load(@bv.json)
  end

  def test_basic_structure
    assert ['vectorLength', 'possibilities', 'targets'].all? do |k|
      @json_hash.keys.include? k
    end
  end

  def test_vector_length
    expected_length = @json_hash['possibilities'].values.map(&:first).max + 1
    assert_equal expected_length, @json_hash['vectorLength']
  end

  def test_possibilities
    assert_equal @flags.map(&:to_s), @json_hash['possibilities'].keys
  end

  def test_targets
    assert_equal @targets.keys, @json_hash['targets'].keys
  end

  def test_empty_target_flags
    empty_flags = [0] * @json_hash['vectorLength']
    assert_equal empty_flags, @json_hash['targets']['target3']
  end

  def test_set_target_flags
    flags = [0] * @json_hash['vectorLength']
    flags[0] = (2 ** 0) + (2 ** 1)
    assert_equal flags, @json_hash['targets']['target1']
  end
end
