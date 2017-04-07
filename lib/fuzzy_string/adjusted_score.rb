class FuzzyString::AdjustedScore
  def self.rank(first,second) new(first,second).rank end
  def initialize(first,second)
    @long  = first.length > second.length ? first  : second
    @short = first.length > second.length ? second : first
  end
  def rank
    return 0             if (@long == @short)
    return @short.length if (@long.length  == 0)
    return @long.length  if (@short.length == 0)
    adjusted_levenschtein_distance
  end
  def adjusted_levenschtein_distance
    special_chars = [")", "(", "]", "[", "}", "{", ".", "?", "+", "*"]
    regex = /#{@short.chars.to_a.map{|el| special_chars.include?(el) ? "\\"+el : el}.join('(.*?)')}/i
    pieces = @long.split(regex)
    score = FuzzyString::Levenshtein.distance(@short,@long)
    score *= pieces[0..@short.length - 1].uniq == [''] ? 0.75 : 1
    letter_ratio = score.to_f / @long.length
    score -= pieces[0][-1] == ' ' ? letter_ratio * 0.75 : 0
    score -= (pieces[@short.length] || [])[0]  == ' '  ? letter_ratio * @short.length * 0.75 : 0
    score -= letter_ratio * cost(pieces.shift,0.5)
    score -= letter_ratio * cost(pieces.pop,  0.9)
    score -= letter_ratio * cost(pieces.join, 0.1)
  end
  private
  def cost(piece,multiplier) piece.length * multiplier rescue(0) end
end
