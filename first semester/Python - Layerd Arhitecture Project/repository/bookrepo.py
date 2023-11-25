from src.repository.exceptionrepo import RepositoryException

class BookRepo:
    def __init__(self):
        self._books = []

    def find(self,book_id):
        for e in self._books:
            if book_id == e.id:
                return e
        return None

    def store(self,book):
        if self.find(book.id) is not None:
            raise RepositoryException("There is already a book with this id stored")
        self._books.append(book)

    def update(self,book):
        """
        Update the instance given as a parameter. The provided instance replaces the one having the same id
        """
        el = self.find(book.id)
        if el is None:
            raise RepositoryException("Book not found")
        idx = self._books.index(el)
        self._books.remove(el)
        self._books.insert(idx, book)

    def delete(self,book_id):
        """
        Removes the book with the given id
        """
        book = self.find(book_id)
        if book is None:
            raise RepositoryException("Book not found!")
        self._books.remove(book)
        return book

    def get_all(self):
        return self._books

    def __len__(self):
        return len(self._books)

    def __str__(self):
        r = ""
        for e in self._books:
            r += str(e)
            r += "\n"
        return r