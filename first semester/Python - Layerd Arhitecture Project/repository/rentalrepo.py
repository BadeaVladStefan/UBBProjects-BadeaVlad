from src.repository.exceptionrepo import RepositoryException


class RentalRepo:
    def __init__(self):
        self._rentals = []

    def find(self, rental_id):
        for e in self._rentals:
            if rental_id == e.id:
                return e
        return None

    def store(self, rental):
        """
        adds a rental to the repo
        """
        if self.find(rental.id) is not None:
            raise RepositoryException("There is already a rental with this id stored")
        self._rentals.append(rental)

    def update(self, rental):
        """
        Update the instance given as a parameter. The provided instance replaces the one having the same id
        """
        el = self.find(rental.id)
        if el is None:
            raise RepositoryException("Client not found")
        idx = self._rentals.index(el)
        self._rentals.remove(el)
        self._rentals.insert(idx, rental)

    def delete(self, rental_id):
        """
        Removes the rental with the given id
        """
        rental = self.find(rental_id)
        if rental is None:
            raise RepositoryException("Rental not in repository!")
        self._rentals.remove(rental)
        return rental

    def get_all(self):
        return self._rentals

    def __len__(self):
        return len(self._rentals)

    def __str__(self):
        r = ""
        for e in self._rentals:
            r += str(e)
            r +="\n"
        return r
