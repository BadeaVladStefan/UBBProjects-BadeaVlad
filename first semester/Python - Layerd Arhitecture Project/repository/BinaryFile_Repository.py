import pickle

from src.domain.Students import Student
from src.repository.Memory_Repository import MemoryRepository


class BinaryfileRepository(MemoryRepository):
    def __init__(self, file_name):
        """
        Initialises a repository using a binary file
        """
        super(BinaryfileRepository, self).__init__()
        self._file_name = file_name
        self._load_file()

    def _load_file(self):
        """
        Loads the students from the binary file
        """
        fin = open(self._file_name, "rb")
        objects = pickle.load(fin)
        for student in objects:
            super().add(student)
        fin.close()



    def _save_file(self):
        """
        Saves the student to the file
        """
        fout = open(self._file_name, "wb")
        students = list(self.data.values())
        pickle.dump(students, fout)
        fout.close()

    def add(self, student: Student):
        """
        Adds a student to the file
        """
        super().add(student)
        self._save_file()

    def clear_file(self):
        """
        Deletes all the students from the file
        """
        fout = open(self._file_name, "wb")
        fout.truncate(0)
        fout.close()

    def delete(self, student_id: int):
        """
        Deletes a student from the file
        """
        super().delete(student_id)
        self._save_file()

    def undo(self):
        super().undo()
        self.clear_file()
        self._save_file()
