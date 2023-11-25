import random

from src.player import HumanPlayer
from src.ship import Ship


class ComputerPlayer(HumanPlayer):
    """
    this class inherits the human player
    """

    def __init__(self):
        super().__init__(self)
        self.name = "Computer"
        self.hits = []

    """
    The computer will randomly strike somewhere on the grid
    """

    def computer_strike(self, target):
        row = random.randint(0, 5)
        column = random.randint(0, 5)
        point = row, column
        if point in self.hits:
            self.computer_strike(target)
        self.hits.append(point)
        self.hits.append((row, column))
        print("Computer attacks at [" + str(row) + "," + str(column) + "] and:")
        if self.radar[row, column] == ".":
            if target.ocean[row, column] == "#":
                print("Computer hits!")
                target.ocean[row, column] = "X"
                target.verify_strike(row, column)
                self.radar[row, column] = "X"
            else:
                print("Computer misses!")
                target.ocean[row, column] = "O"
        else:
            self.computer_strike(target)

    """
    The computer will automatically place it's own ships
    """

    def place_all_ships_computer(self):
        directions = ["v", "h"]
        for ship, size in self.ships.items():
            flag = True
            while flag is True:
                direction = random.choice(directions)
                row = random.randint(0, 5)
                column = random.randint(0, 5)

                if direction == "v":
                    if self.ocean.good_row(size, row, column):
                        self.ocean.place_ship_on_row(size, row, column)
                        boat = Ship(ship, size)
                        boat.put_ship_vertically(row, column)
                        self.fleet.append(boat)
                        flag = False
                    else:
                        row += 2

                elif direction == "h":
                    if self.ocean.good_column(size, row, column):
                        self.ocean.place_ship_on_column(size, row, column)
                        boat = Ship(ship, size)
                        boat.put_ship_horizontally(row, column)
                        self.fleet.append(boat)
                        flag = False
                    else:
                        column += 2
                else:
                    continue
