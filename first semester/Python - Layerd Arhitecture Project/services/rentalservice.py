from src.domain.rental import Rental
from src.services.bookrentalexception import BookRentalException
from src.domain.book import Book
from src.domain.client import Client


class ClientsRentalsDTO:
    def __init__(self,client:Client,rental_days:int):
        self._client = client
        self._rental_days = rental_days

    @property
    def days(self):
        return self._rental_days

    @days.setter
    def days(self, new_value):
        self._rental_days = new_value

    def __repr__(self):
         return str(self.days) + " days for -> " + str(self._client.name)

class AuthorRentalsDTO:
    def __init__(self,book:Book,times):
        self._book = book
        self._times = times

    @property
    def times(self):
        return self._times

    @times.setter
    def times(self, new_value):
        self._times = new_value

    def __repr__(self):
        return str(self._times) + " times for ->" + str(self._book.author)

class BooksRentalsDTO:
    def __init__(self,book:Book,times):
        self._book =book
        self._times = times

    @property
    def times(self):
        return self._times
    @times.setter
    def times(self,new_value):
        self._times = new_value

    def __repr__(self):
        return str(self._times) + " times for ->" + str(self._book.title)

class RentalService:
    def __init__(self, validator, rental_repo, book_repo, client_repo):
        self._validator = validator
        self._bookrepo = book_repo
        self._clientrepo = client_repo
        self._repository = rental_repo

    def is_book_available(self, book, start, end):
        rentals = self.filter_rentals(None, book)
        for rent in rentals:
            if start < rent.end or end > rent.start:
                continue
            return False
        return True

    def filter_rentals(self, client, book):
        """
        Return a list of rentals performed by the provided client for the provided book
        client - The client performing the rental. None means all clients
        book - The rented book. None means all books
        """
        result = []
        for rental in self._repository.get_all():
            if client is not None and rental.client != client:
                continue
            if book is not None and rental.book != book:
                continue
            result.append(rental)
        return result

    def delete_rental(self, rental_id):
        rental = self._repository.delete(rental_id)
        return rental

    def create_rental(self, rental_id, client, book, start, end):
        rental = Rental(rental_id, start, end, client, book)
        self._validator.validate(rental)
        if self.is_book_available(rental.book, rental.start, rental.end) is False:
            raise BookRentalException("Book is not available during this time")
        self._repository.store(rental)
        return rental

    #statistics
    def most_rented_book(self):
        """
        Most rented books. This will provide the list of books, sorted in descending order of the number of times they
        were rented.
        """
        rental_dict={}
        for rental in self._repository.get_all():
            title = rental.book.title
            if title in rental_dict:
                rental_dict[title].times +=1
            else:
                rental_dict[title] = BooksRentalsDTO(rental.book,1)

        result = list(rental_dict.values())
        result.sort(key=lambda x:x.times,reverse=True)
        return result

    def most_rented_author(self):
        """
        Most rented author. This provides the list of book authors, sorted in descending order of the number of rentals
        their books have.
        """
        rental_dict = {}
        for rental in self._repository.get_all():
            author = rental.book.author
            if author in rental_dict:
                rental_dict[author].times += 1
            else:
                rental_dict[author] = AuthorRentalsDTO(rental.book,1)

        result = list(rental_dict.values())
        result.sort(key=lambda x:x.times,reverse=True)

        return result



    def most_active_clients(self):
        """
        Most active clients. This will provide the list of clients, sorted in descending order of the number of book
        rental days they have (e.g. having 2 rented books for 3 days each counts as 2 x 3 = 6 days).
        """
        rental_dict = {}
        for rental in self._repository.get_all():
            name_of_client = rental.client.name
            if name_of_client in rental_dict:
                rental_dict[name_of_client].days +=len(rental)
            else:
                rental_dict[name_of_client] = ClientsRentalsDTO(rental.client,len(rental))

        result = list(rental_dict.values())
        result.sort(key=lambda x:x.days,reverse=True)
        return result

    def get_all(self):
        return self._repository.get_all()






