@students = [] # an empty array accessible to all methods
def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
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
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def input_students
  puts "Please enter the names of the students along their details"
  puts "To finish, just hit return twice when asked for name input\nEnter a name:"
  #get the first name
  name = gets.chomp.capitalize

  #while the name is not empty, repeat this code
  while !name.empty? do
    puts "Enter country of birth:"
    country_of_birth = gets.chomp.capitalize
    loop do
      puts "Enter a cohort:"
      cohort = gets.chomp
      cohort = "blue" if cohort.size == 0
      cohorts = %w[red blue green]
      if cohorts.include?(cohort)
        puts "Enter student's age:"
        age = gets.chomp
        puts "Enter student's height (e.g., 6'4\")"
        height = gets.chomp
        puts "Enter a hobby:"
        hobbies = gets.chomp
        #add the student hash to the array
        @students << {
          name: name, cohort: cohort.to_sym, country_of_birth: country_of_birth,
          age: age, height: height, hobbies: hobbies
        }
        break
      else
        puts "incorrect cohort: please choose either 'red', 'blue' or 'green'"
      end
    end

    if @students.count == 1
      puts "Now we have details for 1 student"
    else
      puts "Now we have details for #{@students.count} students"
    end
    puts "Please enter the next student's name"
    name = gets.chomp.capitalize
  end
  #return the array of students
  @students
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def print_students_list
  @students.each do |student|
    puts "name: #{student[:name]}; country of birth: #{student[:country_of_birth]}; age: #{student[:age]}; height: #{student[:height]}; hobbies: #{student[:hobbies]}; (#{student[:cohort]} cohort)".center(50)
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(50)
end

interactive_menu
