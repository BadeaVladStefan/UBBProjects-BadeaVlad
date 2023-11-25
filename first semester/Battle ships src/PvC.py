from src.computer import ComputerPlayer
from src.player import HumanPlayer


class PvC:
    def __init__(self):
        self.play()

    """
    The following 3 functions will help us set up the game
    """

    def check_fleets(self, player):
        ship_counter = 0
        """
        We are looking for '#' symbol on the grid
        """
        for row in range(len(player.ocean.ocean)):
            for column in range(len(player.ocean.ocean)):
                if player.ocean.ocean[row][column] == "#":
                    ship_counter += 1

        if ship_counter == 0:
            return True
        else:
         return False


    """
    Now we will structure the game
    """

    def play(self):
        name = input("To start the game type yes:")
        if name == "yes":
            p = HumanPlayer(name)
            # firstly the player need to place his ships:
            p.place_all_ships()

            c = ComputerPlayer()
            # now the computer will set up it's fleet
            print("The computer will place it's ships")
            c.place_all_ships_computer()

            # now the striking game will begin:
            while True:
                p.strike(c)
                if self.check_fleets(c) is True:
                    print("You Win")
                    print("Game over! :)")
                    return False

                c.computer_strike(p)
                if self.check_fleets(p) is True:
                    print("You lose + skill issue")
                    print("Game over! :)")
                    return False
        else:
            print("You didn't type yes")
            self.play()
