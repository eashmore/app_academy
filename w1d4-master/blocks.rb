class Array
  def my_each(&prc)
    prc ||= Proc.new { |el| el }
    count = 0                     # index 0 of collection
    while count < self.length
       prc.call(self[count])      # overview: our block called here and expanded
       count += 1                 # self (array_collection) at [count]
                                  # (i.e. self[0] element) sent to block variable
                                  # of our block. mapping_prc called on block variable
     end
  end                             # Here, the self[count] element referenced by |obj|
                                  # which then has mapping block applied and stored in result


  def my_map(&mapping_proc)
    result = []
    self.my_each do |obj|           # between do and end sent as &mapping_prc to my_each
      result << mapping_proc.call(obj)
    end
    result
  end

  def my_select(&select_proc)
    result = []
    self.my_each do |obj|
      if select_proc.call(obj)
        result << obj
      end
    end
    result
  end

  def my_inject(&prc)
    memo = self[0]
    self.drop(1).my_each do |obj|
      memo = prc.call(memo, obj)
    end
    memo
  end

  def my_sort!(&prc)                                  #expects block
    sorted = false
    until sorted
      sorted = true
      self.each_index do |i|
        score = prc.call(self[i], self[i+1]) if self[i+1]
        if score ==  1
          self[i], self[i+1] = self[i+1], self[i]
          sorted = false
        end
      end
    end
    self
  end

  def my_sort(&prc)                                   #expects block
    duplicate = self.dup
    duplicate.my_sort!(&prc)                          #expands proc to block
  end

end



p [3,4,2,1].my_sort{|num, num2| num <=> num2}
