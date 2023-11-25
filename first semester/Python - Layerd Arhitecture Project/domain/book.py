class Book:
    def __init__(self, _id, title, author):
        self._id = _id
        self._title = title
        self._author = author

    @property
    def id(self):
        return self._id

    @id.setter
    def id(self, new_id):
        self._id = new_id

    @property
    def title(self):
        return self._title

    @title.setter
    def title(self, new_title):
        self._title = new_title

    @property
    def author(self):
        return self._author

    @author.setter
    def author(self, new_author):
        self._author = new_author

    def __eq__(self, z):
        if not isinstance(z, Book):
            return False
        if self._id == z._id:
            return True
        else:
            return False

    def __str__(self):
        return "ID: " + str(self._id) + ", Title:" + str(self._title) + ", Author:" + str(self._author)

    def __repr__(self):
        return str(self)