from src.domain.client import Client
from src.domain.validatorexception import ValidatorException


class ClientValidator:
    def validate(self, client):
        """
        Validate if provided Client instance is valid
        client - Instance of Client type
        Return List of validation errors.An empty list if instance is valid
        """
        if isinstance(client, Client) is False:
            raise TypeError("Not x Client")

        _errors = []
        if len(client.name) == 0:
            _errors.append("Name not valid")
        if int(client.id) <= 0:
            _errors.append("Id not valid")
        if len(_errors) != 0:
            raise ValidatorException(_errors)
        return True
