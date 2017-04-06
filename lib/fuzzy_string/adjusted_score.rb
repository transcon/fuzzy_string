class FuzzyString::AdjustedScore
  def self.rank(first,second) new(first,second).rank end
  def initialize(first,second)
    @first  = first.length < second.length ? first  : second
    @second = first.length < second.length ? second : first
  end
  def rank
    return 0              if (@first == @second)
    return @second.length if (@first.length == 0)
    return @first.length  if (@second.length == 0)
    adjusted_levenschtein_distance
  end
  def adjusted_levenschtein_distance
    special_chars = [")", "(", "]", "[", "}", "{", ".", "?", "+", "*"]
    regex = /#{@second.chars.to_a.map{|el| special_chars.includes?(el) ? "\\"+el : el}.join('(.*?)')}/i
    pieces = @first.split(regex)
    score  = pieces[0][-1] == ' ' ? -1 : 0
    score += pieces[0..@second.length - 1].uniq == [''] ? -@first.length.to_f / 2 : 0
    score += (pieces[@second.length] || [])[0] == ' ' ? -@first.length.to_f / 2 : 0
    score += cost(pieces.shift,0.5) + cost(pieces.pop,0.25) + cost(pieces.join,1)
    score += FuzzyString::Levenshtein.distance(@first,@second)
  end
  private
  def cost(piece,multiplier) piece.length * multiplier rescue(0) end
end
