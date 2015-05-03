require 'json'

class BitVector
  attr_reader :possibilities, :targets

  MAX_POWER = 30

  def initialize(possibilities)
    @possibilities = possibilities 
  end

  def targets_matching(*flags)
    expectations = bitvector_array(flags)

    results = []

    targets.each do |id, vectors|
      results << id if compare_vectors(expectations, vectors)
    end

    results
  end

  def targets=(ts)
    result = {}
    ts.each { |id, flags| result[id] = bitvector_array(flags) }
    @targets = result
  end

  def json(hash_dump_func = nil)
    h = {
      vectorLength: bitvector_array_length,
      possibilities: possibility_hash,
      targets: targets
    }

    hash_dump_func.nil? ? JSON.dump(h) : hash_dump_func.call(h)
  end

  private

  def bitvector_array_length
    @_bitvector_array_length ||= ((possibilities.count - 1) / MAX_POWER) + 1
  end

  def possibility_hash
    @_possibility_hash ||= Hash[possibilities.zip(vector_indices_and_values)]
  end

  def bitvector_array(flags)
    result = [0] * bitvector_array_length

    flags.each do |flag|
      flag_idx, flag_val = possibility_hash[flag]
      result[flag_idx] = result[flag_idx] | flag_val
    end

    result
  end

  def compare_vectors(expected, actual)
    actual.each_with_index do |act, idx|
      return false unless (act & expected[idx]) == expected[idx]
    end

    true
  end

  def vector_indices_and_values
    @_vector_indices_and_values ||= (0..MAX_POWER)
        .map { |n| 2 ** n }
        .cycle
        .take(possibilities.count)
        .map
        .with_index { |pow, idx| [idx / MAX_POWER, pow] }
  end
end  
