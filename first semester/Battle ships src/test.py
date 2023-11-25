import unittest

from src.computer_board import ComputerBoard
from src.player_board import PlayerBoard


class Test(unittest.TestCase):
    def test_show_board(self):
        pb = PlayerBoard()
        pb.show_board()

    def test_ok_coords(self):
        pb = PlayerBoard()
        self.assertEqual(False, pb.check_coords_in_grid(6, 6))

    def test_place_ships(self):
        pb = PlayerBoard()
        pb.place_ship_on_row(3, 0, 0)
        pb.place_ship_on_column(2, 1, 1)
        pb.show_board()

    def test_show_computers_board(self):
        cb = ComputerBoard()
        cb.show_board()
