from src.repository.exceptionrepo import RepositoryException


class ClientRepo:
    def __init__(self):
        self._clients = []

    def find(self, client_id):
        for e in self._clients:
            if client_id == e.id:
                return e
        return None

    def store(self, client):
        """
        adds a client to the repo
        """
        if self.find(client.id) is not None:
            raise RepositoryException("There is already a client with this id stored")
        self._clients.append(client)

    def update(self, client):
        """
        Update the instance given as a parameter. The provided instance replaces the one having the same id
        """
        el = self.find(client.id)
        if el is None:
            raise RepositoryException("Client not found")
        idx = self._clients.index(el)
        self._clients.remove(el)
        self._clients.insert(idx, client)

    def delete(self, client_id):
        """
        Removes the client with the given id
        """
        client = self.find(client_id)
        if client is None:
            raise RepositoryException("Client not in repository!")
        self._clients.remove(client)
        return client

    def get_all(self):
        return self._clients

    def __len__(self):
        return len(self._clients)

    def __str__(self):
        r = ""
        for e in self._clients:
            r += str(e)
            r += "\n"
        return r
