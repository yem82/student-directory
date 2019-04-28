@students = [] # an empty array accessible to all methods
def save_students
  #open the file for writing
  file = File.open("students.csv", "w")
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

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  @name, @country_of_birth, @age, @height, @hobbies, @cohort_choice = line.chomp.split(",")
  store_data
  end
  file.close
end

def try_load_students
  filename = ARGV.first #first argument from the commmand line
  return if filename.nil? #get out of the method if no filename
  if File.exists?(filename) #if it exists
    load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def input_students
  puts "Please enter the names of the students along their details"
  puts "To finish, just hit return twice when asked for name input\nEnter a name:"
  student_info
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
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
  @name = STDIN.gets.chomp.capitalize
  while !@name.empty? do
    puts "Enter country of birth:"
    @country_of_birth = STDIN.gets.chomp.capitalize
    puts "Enter student's age:"
    @age = STDIN.gets.chomp
    puts "Enter student's height (e.g., 6'4\")"
    @height = STDIN.gets.chomp
    puts "Enter a hobby:"
    @hobbies = STDIN.gets.chomp
    student_cohort
  end
end

def student_cohort
    puts "Enter student's cohort:"
    @cohort_choice = STDIN.gets.chomp
    cohorts = %w[red blue green]
    @cohort_choice = "blue" if @cohort_choice.empty?
    while !cohorts.include?(@cohort_choice)
      puts "incorrect cohort: please choose either 'red', 'blue' or 'green'\nEnter a cohort:"
      @cohort_choice = STDIN.gets.chomp
    end
    store_data
    student_count
end

def store_data
  @students << {
    name: @name, cohort_choice: @cohort_choice.to_sym, country_of_birth: @country_of_birth,
    age: @age, height: @height, hobbies: @hobbies
  }
end

def student_count
    if @students.count == 1
      puts "Now we have details for 1 student"
    else
      puts "Now we have details for #{@students.count} students"
    end
    puts "Please enter the next student's name"
    @name = STDIN.gets.chomp.capitalize
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

try_load_students
interactive_menu
