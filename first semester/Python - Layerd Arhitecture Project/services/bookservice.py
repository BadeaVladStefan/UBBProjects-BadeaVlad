from src.domain.book import Book


class BookService:
    def __init__(self, rental_service, validator, repository):
        self._validator = validator
        self._repository = repository
        self._rental_service = rental_service

    def create(self, book_id, title, author):
        book = Book(book_id, title, author)
        self._validator.validate(book)
        self._repository.store(book)
        return book

    def delete(self, book_id):
        book = self._repository.delete(book_id)
        rentals = self._rental_service.filter_rentals(None, book)
        for rent in rentals:
            self._rental_service.delete_rental(rent.id)
        return book

    def update(self, book_id, book_title, book_author):
        book = Book(book_id, book_title, book_author)
        self._repository.update(book)

    def get_all(self):
        return self._repository.get_all()

    def find(self,book_id):
        return self._repository.find(book_id)