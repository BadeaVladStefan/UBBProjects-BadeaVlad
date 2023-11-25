import copy

from src.domain.Students import Student
from src.domain.Students_validator import StudentValidator
from src.repository.Memory_Repository import MemoryRepository


class StudentService:
    def __init__(self, repository: MemoryRepository, validator: StudentValidator):
        self._repository = repository
        self._validator = validator
        self._undo_list = []

    def add(self, student_id: int, student_name: str, student_group: int):
        """
        Adds a student to the archive of students (see get archive)
        """
        self._undo_list.append(copy.deepcopy(self._repository))
        student = Student(student_id, student_name, student_group)
        self._validator.Validate(student)
        self._repository.add(student)

    def get_archive(self):
        """
        Returns the archive(dictionary) with all the students
        """
        return self._repository.get_all()

    def delete(self, student_id: int):
        """
        Deletes a student from the archive
        """
        self._repository.delete(student_id)

    def delete_group(self, group: int):
        """
        Deletes all the students from a group
        """
        if group < 0:
            raise ValueError("value of the group should be a positive integer!")
        self._undo_list.append(copy.deepcopy(self._repository))
        archive = self.get_archive().copy()
        for student_id in archive:
            current_student = archive[student_id]
            if current_student.get_group() == group:
                self.delete(student_id)

    def undo(self):
        """
        Does the undo operation
        """
        if len(self._undo_list) <= 0:
            raise ValueError("No more undo!")
        else:
            self._repository.data = self._undo_list.pop().data
            self._repository.undo()

