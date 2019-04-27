def input_students
  puts "Please enter the names of the students along their details"
  puts "To finish, just hit return twice when asked for name input\nEnter a name:"
  #create an empty array
  students = []
  #get the first name
  name = gets.strip.capitalize

  #while the name is not empty, repeat this code
  while !name.empty? do
    puts "Enter country of birth:"
    country_of_birth = gets.strip.capitalize
    loop do
      puts "Enter a cohort:"
      cohort = gets.strip
      cohort = "blue" if cohort.size == 0
      cohorts = %w[red blue green]
      if cohorts.include?(cohort)
        puts "Enter student's age:"
        age = gets.strip
        puts "Enter student's height (e.g., 6'4\")"
        height = gets.strip
        puts "Enter a hobby:"
        hobbies = gets.strip
        #add the student hash to the array
        students << {
          name: name, cohort: cohort.to_sym, country_of_birth: country_of_birth,
          age: age, height: height, hobbies: hobbies
        }
        break
      else
        puts "incorrect cohort: please choose either 'red', 'blue' or 'green'"
      end
    end

    if students.count == 1
      puts "Now we have details for 1 student"
    else
      puts "Now we have details for #{students.count} students"
    end
    puts "Please enter the next student's name"
    name = gets.strip.capitalize
  end
  #return the array of students
  students
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def print(students)
  students.each do |student|
    puts "name: #{student[:name]}; country of birth: #{student[:country_of_birth]}; age: #{student[:age]}; height: #{student[:height]}; hobbies: #{student[:hobbies]}; (#{student[:cohort]} cohort)".center(50)
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(50)
end

students = input_students
#nothing happens until we call the methods
print_header
print(students)
print_footer(students)
