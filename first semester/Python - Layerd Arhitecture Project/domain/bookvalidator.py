from src.domain.book import Book
from src.domain.validatorexception import ValidatorException


class BookValidator:
    def validate(self, book):
        """
        Validate if provided Book instance is valid
        :param book: an instance of Book type
        :return: List of valudation errors. An empty list if instance is valid
        """
        if isinstance(book, Book) == False:
            raise TypeError("Can only validate Book objects!")
        _errors = []
        if len(book.title) == 0:
            _errors.append("Book must have x title")
        if len(book.author) == 0:
            _errors.append("Book must have x author")
        if int(book.id) <= 0:
            _errors.append("Id needs to be a positive integer")
        if len(_errors) > 0:
            raise ValidatorException(_errors)
        return True
