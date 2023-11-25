from src.domain.client import Client


class ClientService:
    def __init__(self, rental_service, validator, repository):
        self._validator = validator
        self._repository = repository
        self._rental_service = rental_service

    def create(self, client_id, client_name):
        client = Client(client_id, client_name)
        self._validator.validate(client)
        self._repository.store(client)
        return client

    def delete(self, client_id):
        # Need to delete the client & their rentals
        client = self._repository.delete(client_id)
        rentals = self._rental_service.filter_rentals(client, None)
        for rent in rentals:
            self._rental_service.delete_rental(rent.id, False)
        return client

    def get_all(self):
        return self._repository


    def get_client_count(self):
        return len(self._repository)

    def update(self, client_id, client_name):
        client = Client(client_id, client_name)
        self._repository.update(client)
