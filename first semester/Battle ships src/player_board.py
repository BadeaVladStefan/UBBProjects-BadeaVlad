# In game this is the so-called "ocean" - and here you can see your own ships

class PlayerBoard:
    """
    This class is used to create and represent the player's board ,and it contains the methods needed to place ships
    The board will be a 6x6 grid
    """

    def __init__(self):
        self.ocean = [["." for i in range(6)] for i in range(6)]
        # the board called "ocean" contains now only empty spaces (by convention we assume that "." represents an empty
        # space

    def __getitem__(self, point):
        """
        Returns the coordinates of a point
        """
        row, column = point
        return self.ocean[row][column]

    def __setitem__(self, point, new_value):
        """
        Sets to the point with the coordinates row,column a new value
        """
        row, column = point
        self.ocean[row][column] = new_value

    def show_board(self):
        """
        :return: The visual representation of your board
        """
        print("Your Board is :")
        for row in self.ocean:
            print("____________")
            print("|" + "|".join(row) + "|")
        print("____________")

    # The folllowing two functions will help us place ships of size "size" either horizontally or vertically
    # To denote that we have a ship we will use the # symbol

    def place_ship_on_column(self, size, row, column):
        for i in range(3):
            if row in [0,1,2,3,4,5]:
                self.ocean[row][column] = "#"
                row += 1
            else:
                return "Please enter a valid row"

    def place_ship_on_row(self, size, row, column):
        for i in range(size):
            if column in [0,1,2,3,4,5]:
                self.ocean[row][column] = "#"
                column += 1
            else:
                return "please enter a valid column"

    def check_coords_in_grid(self, row, column) -> bool:
        """
        Used to check if a set of given coordinates are inside the grid
        """
        if row in [0, 1, 2, 3, 4, 5] and column in [0, 1, 2, 3, 4, 5]:
            return True
        return False

    def good_row(self, size, row, column):
        """
        Checks if the row coords are available ,so we can place a ship of size "size" vertically there
        """
        # here we will save the good coords and see if we have the needed space
        good_coords = []
        for i in range(size):
            if self.check_coords_in_grid(row, column) is True:
                if self.ocean[row][column] == ".":
                    good_coords.append((row, column))
                    row += 1
                else:
                    row += 1
        if len(good_coords) == size:
            return True
        return False

    def good_column(self, size, row, column):
        """
        checks if the column coords are available so we can place a ship horizontally
        it is the same as before
        """
        good_coords = []
        for i in range(size):
            if self.check_coords_in_grid(row, column) is True:
                # we check if we have an empty space (denoted by ".")
                if self.ocean[row][column] == ".":
                    # if this set or coords are ok we add them to the list
                    good_coords.append((row, column))
                    column += 1
                else:
                    # This set of coords are not ok so we jump to the next column
                    column += 1
            else:
                return False
        if len(good_coords) == size:
            return True
        return False
