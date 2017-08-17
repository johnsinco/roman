class Integer
   DIGITS = {
    1 =>  'I',
    5 =>  'V',
    10 => 'X',
    50 => 'L',
    100 => 'C',
    500 =>  'D',
    1000 => 'M'
  }

  def to_roman
    working = self
    DIGITS.keys.reverse.each_with_index.reduce('') do |converted, (arabic, idx)|
      count = working / arabic
      if(count == 0)
        next_smaller = next_smaller_base10(idx)
        if(next_smaller && next_smaller < working && (working + next_smaller) >= arabic)
          converted += DIGITS[next_smaller]
          count = 1
          working = working - (arabic  - next_smaller)
        end
      else
        working = working - arabic * count
      end
      next converted unless count > 0
      converted += DIGITS[arabic] * count
      converted
    end
  end

  def next_smaller_base10(idx)
    next_digit = DIGITS.keys.reverse[idx+1]
    return unless next_digit
    log10 = Math.log10(next_digit)
    if(log10 && log10 == log10.truncate)
      return next_digit
    else
      return next_smaller_base10(idx+1)
    end
  end
end
