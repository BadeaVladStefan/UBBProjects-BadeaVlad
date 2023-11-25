from src.domain.Students import  Student

class StudentValidator:
    #checks if a student is valid
    def Validate(self, student:Student):
        error=""
        if student.student_group < 0:
            error += "The group must be a positive integer"
        if len(error) != 0:
            raise ValueError(error)