# In game this is the so-called "radar" and is the same size as your grid, has the same type of ships as you do ,but you
# can't see them because this is the computer's board

class ComputerBoard:
    """
    This grid is the same with the player's one.
    We only need to make it empty because the computer player will have to automatically place it's own ships
    """

    def __init__(self):
        self.radar = [["." for i in range(6)] for i in range(6)]

    def __getitem__(self, point):
        """
        Returns the coordinates of a point
        """
        row, column = point
        return self.radar[row][column]

    def __setitem__(self, point, new_value):
        """
        Sets to the point with the coordinates row,column a new value
        """
        row, column = point
        self.radar[row][column] = new_value

    def show_board(self):
        """
        :return: The visual representation of your board
        """
        print("Computer's board is :")
        for row in self.radar:
            print("____________")
            print("|" + "|".join(row) + "|")
        print("____________")
