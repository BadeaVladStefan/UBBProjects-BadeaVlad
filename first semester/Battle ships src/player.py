from src.computer_board import ComputerBoard
from src.player_board import PlayerBoard
from src.ship import Ship

"""
This class will help the player set up his fleet and also allow him to attack the computer's fleet
"""


class HumanPlayer:
    # These are the formal names of the classic ships of size 3 and 2
    ships = {"Destroyer": 3, "Submarine": 2}

    def __init__(self, name):
        """
        fleet => your current fleet
        ocean => your board
        radar => computers board
        """
        self.fleet = []
        self.ocean = PlayerBoard()
        self.radar = ComputerBoard()
        self.name = name

    def show_both_boards(self):
        """
        Displays both boards at the same time
        """
        self.ocean.show_board()
        print("\n")
        self.radar.show_board()

    """
    This is the first part of the game where the player can choose where to place his ships
    """

    def place_all_ships(self):
        """
        Destroyer  - size 3
        Submarine - size 2
        """
        for typeofship, size in self.ships.items():
            flag = True
            while flag:
                self.show_both_boards()
                try:
                    # This will tell the player what kind of ship they need to place (Destroyer or Submarine)
                    print("Place your %s" % typeofship)
                    row = int(input("Please enter a row for the start of your ship (between 0-5):"))
                    column = int(input("Please enter a column for the start of your ship (between 0-5):"))
                    print("How should the ship be placed: vertically or horizontally?")
                    direction = input("v- for vertically, h- for horizontally:")

                    # We check the validators and then if no error raise, we can safely place a ship
                    if direction.lower() == "h":
                        try:
                            self.ocean.good_row(size, row, column)
                            self.ocean.place_ship_on_row(size, row, column)
                            good_ship = Ship(typeofship, size)
                            good_ship.put_ship_vertically(row, column)
                            self.fleet.append(good_ship)
                            flag = False
                        except Exception as ex:
                            print("Error -", ex)

                    elif direction.lower() == "v":
                        try:
                            self.ocean.good_column(size, row, column)
                            self.ocean.place_ship_on_column(size, row, column)
                            good_ship = Ship(typeofship, size)
                            good_ship.put_ship_horizontally(row, column)
                            self.fleet.append(good_ship)
                            flag = False
                        except Exception as ex:
                            print("Error -", ex)
                    else:
                        continue
                    self.show_both_boards()
                except Exception as ex:
                    print("Error -", ex)

    """
    After the shpis are placed starts the second part of the game - the striking part
    """

    def verify_strike(self, row, column):
        """
        Here we check to see if we hit a boat or not. If we hit a boat we check if the boat is destroyed
        """
        for boat in self.fleet:
            if (row, column) in boat.coords:
                boat.coords.remove((row, column))
                if boat.check_ship():
                    self.fleet.remove(boat)
                    print(str(self.name) + "'s " + str(boat.type) + " has been destroyed")

    def strike(self, target):
        self.show_both_boards()
        try:
            row = int(input("Please enter the row you are striking:"))
            column = int(input("Please enter the column you are striking:"))

            if self.ocean.check_coords_in_grid(row, column):
                if target.ocean[row,column] == "#":
                    print("Direct hit!")
                    target.ocean[row,column] = "X"
                    target.verify_strike(row, column)
                    self.radar[row,column] = "X"
                else:
                    if self.radar[row,column] == "O":
                        print("Place already hit")
                        self.strike(target)
                    else:
                        print("Missed")
                        self.radar[row,column] = "O"
            else:
                print("Coords outside the grid, please try again")
                self.strike(target)
        except Exception as ex:
            print("Error -", ex)
            self.strike(target)
