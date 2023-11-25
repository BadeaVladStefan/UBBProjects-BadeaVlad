class Student:
    def __init__(self, student_id: int, student_name: str, student_group: int):
        self._id = student_id
        self._name = student_name
        self._group = student_group

    @property
    def student_id(self):
        return self._id

    @student_id.setter
    def student_id(self, new_id: int):
        self._id = new_id

    @property
    def student_name(self):
        return self._name

    @student_name.setter
    def student_name(self, new_name):
        self._name = new_name

    @property
    def student_group(self):
        return self._group

    @student_group.setter
    def student_group(self, new_group):
        self._group = new_group

    def __str__(self):
        string_student = "ID:" + str(self.student_id) + " ,name:" + str(self.student_name) + " ,group:" + str(
            self.student_group)
        return string_student

    def get_group(self):
        return self._group


def test_student():
    s1 = Student(15,"Florin",911)
    assert 15 == s1.student_id
    s1.student_group = 912
    assert  s1.student_group == 912

