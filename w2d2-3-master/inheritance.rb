class Employee
  attr_reader :name, :salary
  def initialize(name, salary, boss = nil)
    @name = name
    @salary = salary
    @boss = boss
    add_to_employee_list if @boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end

  def add_to_employee_list
    @boss.add_employee(self)
  end
end

class Manager < Employee
  attr_reader :employees
  def initialize(name, salary, boss = nil)
    super(name, salary, boss)
    @employees = []
  end

  def bonus(multiplier)
    employee_salary_sum = 0
    queue = employees
    until queue.empty?
      dequeue = queue.shift
      employee_salary_sum +=  dequeue.salary
      queue += dequeue.employees unless dequeue.class == Employee
    end
    employee_salary_sum * multiplier
  end

  def add_employee(employee)
    @employees << employee
  end
end

ned = Manager.new("Ned", 100)
darren = Manager.new("Darren", 50, ned)
shawna = Employee.new("Shawna", 12, darren)
david = Employee.new("David", 10, darren)
p ned.bonus(2)
