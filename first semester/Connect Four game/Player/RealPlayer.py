from .Player import Player

class RealPlayer(Player):
    def __init__(self, color):
        super().__init__(color)

    def make_move(self, board, column):
        if board.check_valid_move(column):
            for i in range(board.rows - 1, -1, -1):
                if board.board[i][column] == ' ':
                    board.board[i][column] = self.color  # Corrected access to the board attribute
                    return True
        return False
