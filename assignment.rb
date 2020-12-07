# Write a ruby program to get participant details as user input and ask questions related to study if participant 
# age is >= 18 and any combination of 3 questions answer is yes for the study then accept participant as eligible for the 
# trial ( print message in terminal with participant name that  he is eligible for the trial )
# module Questions
#     # write a code to get questions object ( call QuestionClass create method to get questions object )
# end
# class Participant
#    # write a code to take inputs and return participant object
# end
# module Study
#    # write a code to get study object ( call StudyClass create method to get study object )
# end
# class StudyConduct
#      def study_conduct
#            # write a code to take inputs from user
#       end
# end
# output:
# Welcome to #{ study_name } !
# Enter your full name:
# John Doe
# Enter your age ( or ask for dob and calculate age in your code ):
# 20
# Enter Gender:
# Male
# Question1?
# Yes
# Question 2?
# Yes
# Question 3?
# Yes
# Question 4?
# No
# Congratulations #{ participant_name } you are eligible for the clinical trial !!!
# Below is your captured details ( print participant information, questions answers and study information )
# If answer is No for more than 3 questions and participant age is less than 18 print a message something like below
# We regret to inform you that you are not eligible for this clinical trial.
# Below is your captured details ( print participant information, questions answers and study information )

module Questions
	class QuestionClass
		attr_accessor :question, :response
		
		def self.create 
			question=QuestionClass.new
		end

		def pose_question question
			@question=question
			puts "#{@question}"
			@response=gets.chomp
			self
		end
	
		def display_question_response
			puts "Question is : #{@question}"
			puts "Answer is : #{@response}"	
		end
		
		def validate_questions questions
			positive=0
			questions.each do|quest|
				if quest.response.downcase=="yes"
					positive+=1 
				end
			end
			positive
		end
	end
end

class Participant
	attr_accessor :name, :age, :gender
	
	def initialize
		puts "Enter your full name : "
		@name=gets.chomp
		puts "Enter your age : "
		@age=gets.chomp.to_i
		puts "Enter your gender : "
		@gender=gets.chomp
		self
	end

	def display_details 
		puts "Name : #{@name}"
		puts "Age : #{@age}"
		puts "Gender : #{@gender}"
	end

	def validate_age? 
		@age >=18? true:false
	end
end

module Study
	class StudyClass
		def self.create 
			study=StudyClass.new
		end

		def validate_study participant,questions
			if participant.validate_age? && Questions::QuestionClass.create.validate_questions(questions)>=3
				puts "Congratulations #{participant.name} you are eligible for the clinical trial !!!"
			else
				puts "We regret to inform you that you are not eligible for this clinical trial"
			end			
		end
	end
end

class StudyConduct
	include Questions, Study
	
	def initialize 
		@study_obj=Study::StudyClass.create
	end

	def set_study_name
		@study_name="Covid-19
	end

	def study_conduct
		set_study_name
		puts "Welcome to #{@study_name} study !"

		participant=Participant.new
		questions=[]
		questions << Questions::QuestionClass.create.pose_question("Do you know what this study entails ?")
		questions << Questions::QuestionClass.create.pose_question("Do you know the benefits and risks of this trial ?")
		questions << Questions::QuestionClass.create.pose_question("Can you be onsite for the trial ?")
		questions << Questions::QuestionClass.create.pose_question("Will you to take the medication that may be prescribed to you ?")

		@study_obj.validate_study participant,questions

		puts "Below are your captured details"
		participant.display_details
		questions.each{|quest| quest.display_question_response}
	end
end

study=StudyConduct.new 
study.study_conduct
