from datetime import date

from src.domain.rental import Rental
from src.domain.validatorexception import ValidatorException


class RentalValidator:
    """
    checks if a given rental is valid
    """

    def validate(self, rental: Rental):
        if isinstance(rental, Rental) is False:
            raise TypeError("Not a rental")
        _error_list = []
        # a valid date can't be less then now
        now = date(2000, 1, 1)
        if rental.start < now:
            _error_list.append("Rental start is not valid")
        if len(rental) < 1:
            _error_list.append("Rental can't be less then 1 day")
        if rental.end < rental.start:
            _error_list.append("The end date must be bigger then the start date")
        if len(_error_list) != 0:
            raise ValidatorException(_error_list)
        return True
