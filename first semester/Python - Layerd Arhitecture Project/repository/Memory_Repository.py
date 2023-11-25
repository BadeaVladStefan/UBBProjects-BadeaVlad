from src.domain.Students import Student


class RepositoryException(Exception):
    pass


class MemoryRepository:
    def __init__(self):
        """
        Creates a repository that stores the students
        """
        self._data = {}

    def add(self, new_student: Student):
        """
        Adds a student to the repo
        """
        #if new_student.student_id in self._data:
        #    raise RepositoryException("This id is already used")
        self._data[new_student.student_id] = new_student

    def delete(self, student_id: int):
        """
        Deletes a student from the repo

        """
        if student_id not in self._data:
            raise RepositoryException("This student does not exist")
        self._data.pop(student_id)

    def get(self, student_id: int) -> Student:
        """
        Returns the student with the given id from the repo
        """
        if student_id not in self._data:
            raise RepositoryException("This student does not exist")
        return self._data[student_id]

    def __len__(self):
        """
        Returns the number of students in the repo
        """
        return len(self._data)

    def get_all(self):
        """
        Returns all the students
        """
        return self._data

    @property
    def data(self):
        return self._data

    @data.setter
    def data(self, new_data: dict):
        self._data = new_data

    def copy(self):
        """
        Creates a copy of the repo
        """
        copy_of_data = self._data.copy()
        copy_of_repository = MemoryRepository
        copy_of_repository.data = copy_of_data
        return copy_of_repository

    def undo(self):
        x = None


def test_memoryrepo():
    repo = MemoryRepository()
    repo.add(Student(15, "Florin", 911))
    assert repo.__len__() == 1
    repo.delete(15)
    assert repo.__len__() == 0
