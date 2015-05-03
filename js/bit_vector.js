/* 
================================================================================
BitVector - Blake Hyde, 2015
================================================================================

A simple library to handle filtering based on precomputed "expectations"
(presumably provided from a server-side framework in the form of JSON data).
Expects a constant BITVECTOR_DATA to be available to initialize the BitVector
object.  This constant should be of the structure:

{
  vectorLength: Index,
  possibilities: Map[ExpectationLabel, [Index, Flag]],
  targets: Map[TargetLabel, [FlagSet]]
}

Flag = Int32 n (where n is a perfect square)
FlagSet = Int32 (a sum of Flag)
Index = Number
ExpectationLabel = String
TargetLabel = String

Public API:

  - [addExpectation(String): Unit] Add the expectation that matching targets
    will have the given expectation flag.
  - [clearExpectations(): Unit] Remove all expectations that have been set.
  - [remExpectation(String): Unit] Remove the expectation that matching targets
    will have the given expectation flag.
  - [findMatchingTargets(): [TargetLabel]] Return the list of targets which
    match the expectations that have been set.
  - [findNonMatchingTargets(): [TargetLabel]] Return the list of targets which
    do *not* match the expectations that have been set.

Usage:

  - Bind filter operations (like checking a checkbox) to addExpectation using a
    data attribute to find the appropriate label.
  - Bind undoing a filter (like unchecking a checkbox) to remExpectation, once
    again using a data attribute to find the appropriate label.
  - After each of the above events, use findMatchingTargets to perform DOM
    operations to highlight matching targets, or...
  - Use findNonMatchingTargets() to hide targets that do not match.
*/

BitVector = BITVECTOR_DATA;

BitVector.zeroArray = function(n) {
  result = []

  for (i = 0; i < n; i++) {
    result.push(0);
  }

  return result;
}

BitVector.expectations = BitVector.zeroArray(BitVector.vectorLength);

BitVector.addExpectation = function(exLabel) {
  var idx = BitVector.possibilities[exLabel][0];
  var val = BitVector.possibilities[exLabel][1];
  BitVector.expectations[idx] = BitVector.expectations[idx] | val;
}

BitVector.clearExpectations = function() {
  BitVector.expectations = BitVector.zeroArray(BitVector.vectorLength);
}

BitVector.remExpectation = function(exLabel) {
  var idx = BitVector.possibilities[exLabel][0];
  var val = BitVector.possibilities[exLabel][1];
  BitVector.expectations[idx] = BitVector.expectations[idx] & ~val
}

BitVector.vectorsMatch = function(ex, act) {
  for (var i = 0; i < BitVector.vectorLength; i++) {
    if ((ex[i] & act[i]) !== ex[i]) {
      return false;
    }
  }

  return true;
}

BitVector.findMatchingTargets = function() {
  var matching = [];

  for (var key in BitVector.targets) {
    if (BitVector.targets.hasOwnProperty(key) &&
        BitVector.vectorsMatch(BitVector.expectations, BitVector.targets[key])) {
      matching.push(key);
    }
  }

  return matching;
}

BitVector.findNonMatchingTargets = function() {
  var nonMatching = [];

  for (var key in BitVector.targets) {
    if (BitVector.targets.hasOwnProperty(key) &&
        !BitVector.vectorsMatch(BitVector.expectations, BitVector.targets[key])) {
      nonMatching.push(key)
    }
  }

  return nonMatching;
}
