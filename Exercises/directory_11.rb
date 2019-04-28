@students = [] # an empty array accessible to all methods
def save_students
  #open the file for writing
  file = File.open("students.csv", "w")
  #iterate over the array of students
  @students.each do |student|
    student_data = [
      student[:name], student[:country_of_birth], student[:age],
      student[:height], student[:hobbies], student[:cohort_choice]
              ]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
  @name, @country_of_birth, @age, @height, @hobbies, cohort_choice = line.chomp.split(",")
    @students << {
      name: @name, country_of_birth: @country_of_birth, age: @age,
      height: @height, hobbies: @hobbies, cohort_choice: cohort_choice.to_sym
    }
  end
  file.close
end

def input_students
  puts "Please enter the names of the students along their details"
  puts "To finish, just hit return twice when asked for name input\nEnter a name:"
  student_info
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def student_info
  @name = gets.chomp.capitalize
  while !@name.empty? do
    puts "Enter country of birth:"
    @country_of_birth = gets.chomp.capitalize
    puts "Enter student's age:"
    @age = gets.chomp
    puts "Enter student's height (e.g., 6'4\")"
    @height = gets.chomp
    puts "Enter a hobby:"
    @hobbies = gets.chomp
    puts "Enter student's cohort:"
    cohort(gets.chomp)
  end
end

def cohort(cohort_choice)
    cohorts = %w[red blue green]
    cohort_choice = "blue" if cohort_choice.size == 0
    while !cohorts.include?(cohort_choice)
      puts "incorrect cohort: please choose either 'red', 'blue' or 'green'\nEnter a cohort:"
      cohort_choice = gets.chomp
    end
    @students << {
      name: @name, cohort_choice: cohort_choice.to_sym, country_of_birth: @country_of_birth,
      age: @age, height: @height, hobbies: @hobbies
    }
    student_count
end

def student_count
    if @students.count == 1
      puts "Now we have details for 1 student"
    else
      puts "Now we have details for #{@students.count} students"
    end
    puts "Please enter the next student's name"
    @name = gets.chomp.capitalize
    @students
    interactive_menu if @name.empty?
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def print_students_list
  @students.each do |student|
    puts "name: #{student[:name]}; country of birth: #{student[:country_of_birth]}; age: #{student[:age]}; height: #{student[:height]}; hobbies: #{student[:hobbies]}; (#{student[:cohort_choice]} cohort)".center(50)
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(50)
end

interactive_menu
