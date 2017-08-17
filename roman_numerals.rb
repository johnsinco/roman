class Integer
  ARABIC = [ 1000, 500,  100,  50,   10,   5,    1]
  ROMAN =  [ 'M', 'D', 'C', 'L', 'X', 'V', 'I' ]

  def to_roman(index = 0)
    index = 0 if index < 0
    arabic, roman = ARABIC[index], ROMAN[index]
    return '' unless arabic
    if((count = (self/arabic)) == 0)
      next_smaller_arabic, next_smaller_roman = next_smaller_base10(index)
      if(next_smaller_arabic && (self + next_smaller_arabic)/arabic >= 1)
        return next_smaller_roman + (self + next_smaller_arabic).to_roman(index - 1)
      else
        return self.to_roman(index+1)
      end
    end
    return roman*count + (self-arabic*count).to_roman(index + 1)
  end

  def next_smaller_base10(idx)
    return unless next_digit = ARABIC[idx+1]
    log10 = Math.log10(next_digit)
    if(log10 && log10 == log10.truncate)
      return [ARABIC[idx+1], ROMAN[idx+1]]
    else
      return next_smaller_base10(idx+1)
    end
  end
end
