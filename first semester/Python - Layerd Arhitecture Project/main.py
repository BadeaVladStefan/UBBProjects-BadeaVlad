from datetime import date

from src.domain.bookvalidator import BookValidator
from src.domain.clientvalidator import ClientValidator
from src.domain.rentalvalidator import RentalValidator
from src.repository.bookrepo import BookRepo
from src.repository.clientrepo import ClientRepo
from src.repository.rentalrepo import RentalRepo
from src.services.bookservice import BookService
from src.services.clientservice import ClientService
from src.services.rentalservice import RentalService
from src.ui.ui import Ui

if __name__ == "__main__":
    client_repo = ClientRepo()
    book_repo = BookRepo()
    rental_repo = RentalRepo()

    client_validator = ClientValidator()
    book_validator = BookValidator()
    rental_validator = RentalValidator()

    rental_service = RentalService(rental_validator, rental_repo, book_repo, client_repo)
    client_service = ClientService(rental_service, client_validator, client_repo)
    book_service = BookService(rental_service, book_validator, book_repo)

    ui = Ui(client_service, book_service, rental_service)

    client_service.create(1, "Vlad")
    client_service.create(2, "Bianca")
    client_service.create(3, "Birou")
    client_service.create(4, "Doru")
    client_service.create(5, "Raul")
    client_service.create(6, "Bacau")
    client_service.create(7, "Ioana")
    client_service.create(8, "Beni")
    client_service.create(9, "Dayana")
    client_service.create(10, "Gabi")

    book_service.create(101, "Harap-Alb", "Creanga")
    book_service.create(102, "Plumb", "Bacovia")
    book_service.create(103, "John", "Rebreanu")
    book_service.create(104, "Luceafarul", "Eminescu")
    book_service.create(105, "Floare", "Albastra")

    rental_service.create_rental(1001, client_repo.find(1), book_repo.find(101), date(2001, 1, 1), date.today())
    rental_service.create_rental(1002, client_repo.find(2), book_repo.find(102), date(2003, 1, 1), date(2003, 2, 1))
    rental_service.create_rental(1003, client_repo.find(3), book_repo.find(102), date(2014, 2, 3), date(2017, 1, 1))
    rental_service.create_rental(1004, client_repo.find(2), book_repo.find(104), date(2004, 1, 1), date(2004, 2, 2))
    rental_service.create_rental(1005, client_repo.find(10), book_repo.find(105), date(2022, 12, 31), date.today())
    rental_service.create_rental(1006, client_repo.find(6), book_repo.find(102), date(2019, 12, 3), date(2020, 1, 1))

    ui.run_console()
