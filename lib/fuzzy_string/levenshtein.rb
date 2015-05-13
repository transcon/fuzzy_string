class FuzzyString::Levenshtein
  def self.distance(first,second) new(first,second).distance end
  def initialize(first,second)
    @first = first
    @second = second
  end
  def distance
    v0 = (0..@second.length).map{|a| a}
    @first.length.times {|i| v0 = new_row(v0,i) }
    return v0[@second.length]
  end
  private
  def new_row(old,i)
    row = [i + 1]
    @second.length.times {|j| row[j + 1] = [row[j] + 1, old[j + 1] + 1, old[j] + cost(old,i,j)].min}
    return row
  end
  def cost(old,i,j) cost = @first[i] == @second[j] ? 0 : @first[i].downcase == @second[j].downcase ? 0.75 : 1 end
end