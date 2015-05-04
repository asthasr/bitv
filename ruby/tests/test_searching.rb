require 'minitest/autorun'
require 'bitv'

class TestSearching < Minitest::Test
  def setup
    @flags = (:a..:az).to_a
    @bv = BitVector.new(@flags)

    @targets = Hash[(1..50).map do |n|
      ["target#{n}", @flags.sample(Random.rand(20))]
    end]

    @bv.targets = @targets
  end

  def test_find_matching_targets_simple
    targets = @targets.select { |k, v| v.include?(:a) }.keys
    assert_equal targets, @bv.targets_matching(:a)
  end

  def test_find_matching_targets_multiple
    targets = @targets.select { |k, v| [:a, :b].all? { |f| v.include? f } }.keys
    assert_equal targets, @bv.targets_matching(:a, :b)
  end
end
