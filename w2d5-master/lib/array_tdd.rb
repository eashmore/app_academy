class Array
  def my_uniq
    result = []
    self.each do |el|
      result << el unless result.include?(el)
    end
    result
  end

  def two_sum
    result = []
    self.each_with_index do |outer, outer_idx|
      self.each_with_index do |inner, inner_idx|
        if outer_idx < inner_idx && outer + inner == 0
          result << [outer_idx, inner_idx]
        end
      end
    end
    result
  end

  def my_transpose
    result = []
    i = 0
    while i < self.length
      sub_result = []
      self.each do |row|
        sub_result << row[i]
      end
      i += 1
      result << sub_result
    end
    result
  end

  def stock_picker
    result = []
    best_buy_day = 0
    best_sell_day = 0
    max_diff = 0

    self.each_with_index do |buy, idx1|
      self.each_with_index do |sell, idx2|
        if idx1 < idx2 && sell - buy > max_diff
          max_diff = sell - buy
          best_buy_day = idx1
          best_sell_day = idx2
        end
      end
    end
    result << best_buy_day << best_sell_day
  end
end
