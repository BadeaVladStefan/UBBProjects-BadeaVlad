import tkinter as tk
from tkinter import messagebox

from Board.GameBoard import Board


class ConnectFourGUI:
    BOARD_WIDTH = 800
    BOARD_HEIGHT = 600

    def __init__(self, master, player1, player2):
        self.master = master
        self.player1 = player1
        self.player2 = player2
        self.current_player = player1
        self.board = Board()
        self.canvas = tk.Canvas(master, width=self.BOARD_WIDTH, height=self.BOARD_HEIGHT, bg='yellow')
        self.canvas.pack()
        self.draw_board()
        self.canvas.bind('<Button-1>', self.handle_click)

    def draw_board(self):
        self.canvas.delete('all')
        cell_width = self.BOARD_WIDTH / self.board.columns
        cell_height = self.BOARD_HEIGHT / self.board.rows

        for row in range(self.board.rows):
            for col in range(self.board.columns):
                x0 = col * cell_width
                y0 = row * cell_height
                x1 = x0 + cell_width
                y1 = y0 + cell_height
                self.canvas.create_oval(x0 + cell_width * 0.1, y0 + cell_height * 0.1,
                                        x1 - cell_width * 0.1, y1 - cell_height * 0.1,
                                        fill='white', outline='black')
                if self.board.board[row][col] == 'R':
                    self.canvas.create_oval(x0 + cell_width * 0.1 + 2, y0 + cell_height * 0.1 + 2,
                                            x1 - cell_width * 0.1 - 2, y1 - cell_height * 0.1 - 2,
                                            fill='red')
                elif self.board.board[row][col] == 'B':
                    self.canvas.create_oval(x0 + cell_width * 0.1 + 2, y0 + cell_height * 0.1 + 2,
                                            x1 - cell_width * 0.1 - 2, y1 - cell_height * 0.1 - 2,
                                            fill='blue')

    def handle_click(self, event):
        column = int(event.x / (self.BOARD_WIDTH / self.board.columns))

        if self.board.check_valid_move(column):
            if self.current_player.make_move(self.board, column):
                self.draw_board()
                if self.board.check_winner(self.current_player.color):
                    messagebox.showinfo("Game Over", f"{self.current_player.color} wins!")
                    self.master.quit()
                if self.board.is_full():
                    messagebox.showinfo("Game Over", "The board is full")
                    self.master.quit()
                self.current_player = self.player2 if self.current_player == self.player1 else self.player1
        else:
            messagebox.showerror("Invalid Move", "Invalid move! Try again.")
