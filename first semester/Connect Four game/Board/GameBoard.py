class Board:
    def __init__(self):
        self.rows = 6
        self.columns = 7
        self.board = [[' ' for _ in range(self.columns)] for _ in range(self.rows)]

    def is_full(self):
        for row in self.board:
            if ' ' in row:
                return False
        return True

    def check_winner(self,color):
        # Check horizontally
        for row in self.board:
            for j in range(self.columns - 3):
                if all(cell == color for cell in row[j:j + 4]):
                    return True

        # Check vertically
        for j in range(self.columns):
            for i in range(self.rows - 3):
                if all(self.board[i + k][j] == color for k in range(4)):
                    return True

        # Check diagonally (top-left to bottom-right)
        for i in range(self.rows - 3):
            for j in range(self.columns - 3):
                if all(self.board[i + k][j + k] == color for k in range(4)):
                    return True

        # Check diagonally (bottom-left to top-right)
        for i in range(3, self.rows):
            for j in range(self.columns - 3):
                if all(self.board[i - k][j + k] == color for k in range(4)):
                    return True

        return False

    def check_valid_move(self,column):
        return 0 <= column < self.columns and self.board[0][column] == ' '

    def get_next_empty_row(self, column):
        for i in range(self.rows - 1, -1, -1):
            if self.board[i][column] == ' ':
                return i
        return -1  # Column is full

    def get_opponent_color(self, current_color):
        if current_color == 'R':
            return 'B'
        elif current_color == 'B':
            return 'R'
        else:
            raise ValueError("Invalid player color")