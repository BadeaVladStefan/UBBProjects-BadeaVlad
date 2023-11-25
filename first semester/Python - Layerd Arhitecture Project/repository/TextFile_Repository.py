from src.domain.Students import Student
from src.repository.Memory_Repository import MemoryRepository


class TextfileRepository(MemoryRepository):
    def __init__(self, file_name):
        """
        Creates a repository of students in a text file
        """
        super(TextfileRepository, self).__init__()
        self._filename = file_name
        self._load_file()

    def _load_file(self):
        """
        Loads the text in the file
        """
        lines = []
        try:
            fin = open(self._filename, "rt")
            lines = fin.readlines()
            fin.close()
        except IOError:
            pass
        for line in lines:
            current_line = line.split(",")
            student = Student(int(current_line[0]),current_line[1],int(current_line[2]))
            super().add(student)

    def _save_file(self):
        """
        Saves to the text file all the students from memory
        """
        fout = open(self._filename, "wt")
        students = list(self.data.values())
        for student in students:
            student_string = str(student.student_id) + "," + student.student_name + "," + str(student.student_group) + \
                             "\n"
            fout.write(student_string)
        fout.close()

    def clear_file(self):
        """
        Deletes all the students from the file
        """
        fin = open(self._filename, "wt")
        fin.truncate(0)
        fin.close()

    def add(self, student: Student):
        """
        Adds a student to the text file
        """
        super().add(student)
        self._save_file()

    def delete(self, student_id: int):
        """
        Deletes a student from the text file
        """
        super().delete(student_id)
        self._save_file()

    def undo(self):
        super().undo()
        self.clear_file()
        self._save_file()
