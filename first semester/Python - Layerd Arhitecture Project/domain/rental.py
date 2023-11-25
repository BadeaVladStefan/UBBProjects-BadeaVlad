from src.domain.book import Book
from src.domain.client import Client
from datetime import *

class Rental:
    def __init__(self, _id, start, end, client: Client, book: Book):
        self._id = _id
        self._start = start
        self._end = end
        self._client = client
        self._book = book

    @property
    def id(self):
        return self._id

    @id.setter
    def id(self, new_id):
        self._id = new_id

    @property
    def start(self):
        return self._start

    @start.setter
    def start(self, new_start):
        self._start = new_start

    @property
    def end(self):
        return self._end

    @end.setter
    def end(self, new_end):
        self._end = new_end

    @property
    def client(self):
        return self._client

    @client.setter
    def client(self, new_client: Client):
        self._client = new_client

    @property
    def book(self):
        return self._book

    @book.setter
    def book(self, new_book: Book):
        self._book = new_book

    def __len__(self):
        """
        :return: The number of rented days:
        """
        if self._end is not None:
            return (self._end - self._start).days + 1
        today = date.today()
        return (today - self._start).days + 1

    def __str__(self):
        return "\n"+"Rental id: " + str(self._id) + "\nBook: " + str(self.book) + "\nClient:" + str(
            self.client) + "\nPeriod: " + self._start.strftime("%Y-%m-%d") + " to " + self._end.strftime(
            "%Y-%m-%d")

    def __repr__(self):
        return str(self)
