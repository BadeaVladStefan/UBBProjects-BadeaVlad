import unittest
from datetime import date

from src.domain.book import Book
from src.domain.client import Client
from src.domain.clientvalidator import ClientValidator
from src.domain.rental import Rental
from src.domain.rentalvalidator import RentalValidator
from src.repository.bookrepo import BookRepo
from src.repository.clientrepo import ClientRepo
from src.repository.rentalrepo import RentalRepo
from src.services.clientservice import ClientService
from src.services.rentalservice import RentalService


class Tests(unittest.TestCase):
    def test_new_client(self):
        new_client = Client(14, "Marian")
        self.assertEqual(new_client.id, 14)
        self.assertEqual(new_client.name, "Marian")
        new_client.name = "Sorin"
        self.assertEqual(new_client.name, "Sorin")

    def test_new_book(self):
        new_book = Book(20, "Spiridusul", "Dragonu47")
        self.assertEqual(new_book.id, 20)
        self.assertEqual(new_book.title, "Spiridusul")
        self.assertEqual(new_book.author, "Dragonu47")
        new_book.title = "Doru"
        self.assertEqual(new_book.title, "Doru")
        new_book2 = Book(21, "Indepartare", "Kazi-Ploae")
        self.assertNotEqual(new_book, new_book2)

    def test_new_rental(self):
        new_client = Client(15, "Haralambie")
        new_book = Book(209, "Anatomia lui Bogdan", "Bogdan de la Cluj")
        new_rental = Rental(40, date(1999, 1, 21), date(2222, 7, 29), new_client, new_book)
        self.assertEqual(new_rental._id, 40)
        self.assertEqual(new_rental._start, date(1999, 1, 21))
        self.assertEqual(new_rental._end, date(2222, 7, 29))
        self.assertEqual(new_rental._client, new_client)
        self.assertEqual(new_rental._book, new_book)
        # print(new_rental)
        # print(len(new_rental))
        self.assertEqual(len(new_rental), 81639)
        self.assertEqual(new_rental.client.name, "Haralambie")

    def test_client_repo(self):
        new_client = Client(14, "Marian")
        repo = ClientRepo()
        repo.store(new_client)
        self.assertEqual(1, len(repo))
        repo.update(Client(14, "Haralambie"))
        # print(repo.get_all())
        repo.delete(14)
        self.assertEqual(0, len(repo))

    def test_book_repo(self):
        new_book = Book(209, "Anatomia lui Bogdan", "Bogdan de la Cluj")
        repo = BookRepo()
        repo.store(new_book)
        self.assertEqual(1, len(repo))
        repo.update(Book(209, "Bacau", "Botezatu"))
        # print(repo.get_all())
        repo.delete(209)
        self.assertEqual(0, len(repo))

    def test_rental_repo(self):
        client = Client(14, "Marian")
        book = Book(209, "Anatomia lui Bogdan", "Bogdan de la Cluj")
        rental = Rental(1, date(2013, 3, 15), date.today(), client, book)
        repo = RentalRepo()
        repo.store(rental)
        self.assertEqual(1, len((repo)))
        repo.update(Rental(1, date(2022, 12, 31), date.today(), client, book))
        # print((repo.get_all()))
        repo.delete(1)
        self.assertEqual(0, len(repo))

    def test_rental_services(self):
        client = Client(14, "Marian")
        book = Book(209, "Anatomia lui Bogdan", "Bogdan de la Cluj")
        rental = Rental(40, date(2010, 12, 2), date(2222, 7, 29), client, book)
        client_repo = ClientRepo()
        book_repo = BookRepo()
        rental_repo = RentalRepo()
        rental_validator = RentalValidator()

        client_repo.store(client)
        book_repo.store(book)
        rental_repo.store(rental)

        book2 = Book(1, "A", "A")
        book3 = Book(2, "Badea", "Vlad")

        book_repo.store(book3)
        book_repo.store(book2)

        rental_service = RentalService(rental_validator, rental_repo, book_repo, client_repo)
        rental_service.create_rental(100, client, book2, date(2023, 1, 1), date(2023, 1, 5))
        # print(rental_service.filter_rentals(None, None))
        # print()
        # rental_service.delete_rental(100)
        # print(rental_service.filter_rentals(None, None))
        # print(rental_service.filter_rentals(client,None))
        client2 = Client(3, "Eftimie bajan")
        rental2 = Rental(9, date(2005, 2, 2), date(2007, 2, 2), client2, book)
        rental_repo.store(rental2)
        # print(rental_service.most_rented_book())
        # print(rental_service.most_active_clients())
        # print(rental_service.most_rented_author())

    def test_client_services(self):
        client = Client(14, "Marian")
        book = Book(209, "Anatomia lui Bogdan", "Bogdan de la Cluj")
        rental = Rental(40, date(2010, 12, 2), date(2222, 7, 29), client, book)

        client_repo = ClientRepo()
        book_repo = BookRepo()
        rental_repo = RentalRepo()
        client_validator = ClientValidator()
        rental_validator = RentalValidator()

        client_repo.store(client)
        book_repo.store(book)
        rental_repo.store(rental)

        rental_service = RentalService(rental_validator, rental_repo, book_repo, client_repo)
        client_service = ClientService(rental_service, client_validator, client_repo)
        self.assertEqual(1, client_service.get_client_count())
        client_service.create(99, "Asimov")
        self.assertEqual(2, client_service.get_client_count())
        client_service.update(99, "AWP")
        # print(client_repo.get_all())
        client_service.delete(99)
        self.assertEqual(1, client_service.get_client_count())
