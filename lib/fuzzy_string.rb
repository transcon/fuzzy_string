require "fuzzy_string/version"
require "fuzzy_string/levenshtein"
require "fuzzy_string/adjusted_score"

module FuzzyString
  def ^(other) AdjustedScore.rank(self,other) end
  def -(other) Levenshtein.distance(self,other) end
end
String.include(FuzzyString)