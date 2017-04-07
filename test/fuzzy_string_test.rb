require 'minitest/autorun'
require 'fuzzy_string'
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class FuzzyStringTest < MiniTest::Unit::TestCase

  def test_levenshtein_distance_calculates_known_quantities
    assert_equal 3, 'kitten'   - 'sitting'
    assert_equal 3, 'Saturday' - 'Sunday'
    assert_equal 3, 'abc'      - ''
    assert_equal 0, 'string'   - 'string'
    assert_equal 2, 'Gumbo'    - 'Gambol'
  end

  def test_penalizes_gaps_between_string
    assert 'ZZmonaZ'^'mona' < 'mZoZnZa'^'mona'
  end

  def test_penalizes_distance_from_beginning
    assert 'ZmonaZ'^'mona' < 'ZZmona'^'mona'
  end

  def test_penalizes_excess_tailing_characters
    assert 'ZZmonaZ'^'mona' < 'ZZmonaZZ' ^ 'mona'
  end

  def test_penalizes_string_not_being_the_start_of_a_word
    assert 'ZZ mona' ^ 'mona' < 'Z Zmona' ^ 'mona'
  end

  def test_penalizes_unmatched_case
    assert 'ZZmonaZ'^'mona' < 'ZZMonaZ'^'mona'
  end

  def test_prioritizes_string_starting_with_exact_match
    assert 'escreen are where I am at' ^ 'escreen' < 'escreens are' ^ 'escreen'
  end
  def test_prioritizes_string_starting_with_match
    assert 'escreens are' ^ 'escreen' < 'I am a n escreen' ^ 'escreen'
  end
  def test_prioritizes_exact_sub_strings
    assert 'ACME' ^ 'ACME Utility' < 'ACME' ^ 'ACT Me 2'
  end
end
