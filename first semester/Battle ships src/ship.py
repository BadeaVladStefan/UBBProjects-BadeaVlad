class Ship:
    """
    The ships will be abel to have different sizes, for our game we are going to have ships of size 2 and 3
    """

    def __init__(self, type, size):
        self.type = type
        self.size = size
        self.coords = []

    def put_ship_horizontally(self, row, column):
        """
        places a ship horizontally(same row different column)
        """
        for i in range(self.size):
            self.coords.append((row, column))
            column += 1

    def put_ship_vertically(self, row, column):
        """
        places a ship vertically(same column different row)
        """
        for i in range(self.size):
            self.coords.append((row, column))
            row += 1

    def check_ship(self):
        if not self.coords:
            return True
        return False
