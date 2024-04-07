from random import choice
from .Player import Player

class BotPlayer(Player):
    def __init__(self, color, difficulty):
        super().__init__(color)
        self.difficulty = difficulty

    def make_move(self, board, column):
        if self.difficulty == 'easy':
            return self.make_random_move(board)
        elif self.difficulty == 'medium':
            return self.make_medium_move(board)
        elif self.difficulty == 'hard':
            return self.make_hard_move(board, max_depth=1)
        elif self.difficulty == 'impossible':
            return self.make_impossible_move(board, max_depth=3)
        else:
            raise ValueError("Invalid difficulty level")

    def make_random_move(self, board):
        while True:
            column = choice(range(board.columns))
            if board.check_valid_move(column):
                for i in range(board.rows - 1, -1, -1):
                    if board.board[i][column] == ' ':
                        board.board[i][column] = self.color
                        return True

    def make_medium_move(self,board):
        # Check if bot can win in the next move
        for col in range(board.columns):
            if board.check_valid_move(col):
                row = board.get_next_empty_row(col)
                board.board[row][col] = self.color
                if board.check_winner(self.color):
                    return True
                else:
                    board.board[row][col] = ' '  # Undo move

        # Check if opponent can win in the next move and block
        for col in range(board.columns):
            if board.check_valid_move(col):
                row = board.get_next_empty_row(col)
                # Simulate opponent's move
                board.board[row][col] = board.get_opponent_color(self.color)
                if board.check_winner(board.get_opponent_color(self.color)):
                    # If opponent wins, block the move
                    board.board[row][col] = self.color
                    return True
                else:
                    board.board[row][col] = ' '  # Undo move

        # If no winning moves are possible, make a random move
        return self.make_random_move(board)

    def make_hard_move(self, board, max_depth):
        best_score = float("-inf")
        best_col = None

        for col in range(board.columns):
            if board.check_valid_move(col):
                row = board.get_next_empty_row(col)
                board.board[row][col] = self.color
                score = self.minimax(board, 0, False, max_depth)
                board.board[row][col] = ' '  # Undo move

                if score > best_score:
                    best_score = score
                    best_col = col

        if best_col is not None:
            row = board.get_next_empty_row(best_col)
            board.board[row][best_col] = self.color
            return True
        else:
            return False

    def make_impossible_move(self, board, max_depth):
        best_score = float("-inf")
        best_col = None

        for col in range(board.columns):
            if board.check_valid_move(col):
                row = board.get_next_empty_row(col)
                board.board[row][col] = self.color
                score = self.minimax(board, 0, False, max_depth)
                board.board[row][col] = ' '  # Undo move

                if score > best_score:
                    best_score = score
                    best_col = col

        if best_col is not None:
            row = board.get_next_empty_row(best_col)
            board.board[row][best_col] = self.color
            return True
        else:
            return False

    def minimax(self, board, depth, is_maximizing, max_depth):
        if board.check_winner(self.color):
            return 10 - depth
        elif board.check_winner(board.get_opponent_color(self.color)):
            return depth - 10
        elif board.is_full() or depth == max_depth:
            return 0

        if is_maximizing:
            best_score = float("-inf")
            for col in range(board.columns):
                if board.check_valid_move(col):
                    row = board.get_next_empty_row(col)
                    board.board[row][col] = self.color
                    score = self.minimax(board, depth + 1, False, max_depth)
                    board.board[row][col] = ' '  # Undo move
                    best_score = max(score, best_score)
            return best_score
        else:
            best_score = float("inf")
            for col in range(board.columns):
                if board.check_valid_move(col):
                    row = board.get_next_empty_row(col)
                    board.board[row][col] = board.get_opponent_color(self.color)
                    score = self.minimax(board, depth + 1, True, max_depth)
                    board.board[row][col] = ' '  # Undo move
                    best_score = min(score, best_score)
            return best_score