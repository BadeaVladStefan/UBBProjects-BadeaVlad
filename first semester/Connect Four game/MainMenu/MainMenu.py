import tkinter as tk

from ConnectFourGui.ConnectFourGui import ConnectFourGUI
from Player.BotPlayer import BotPlayer
from Player.RealPlayer import RealPlayer


class MainMenu(tk.Toplevel):
    def __init__(self, master):
        super().__init__(master)
        self.title("Main Menu")
        self.geometry("500x400")
        self.config(bg="lightgray")

        self.player_choice = tk.StringVar(value="human")
        self.difficulty_choice = tk.StringVar(value="easy")

        main_frame = tk.Frame(self, bg="lightgray")
        main_frame.pack(expand=True, fill=tk.BOTH, padx=20, pady=20)

        player_frame = tk.Frame(main_frame, bg="lightgray")
        player_frame.pack(pady=10)

        tk.Label(player_frame, text="Select Player Type:", bg="lightgray").pack()
        tk.Radiobutton(player_frame, text="Human vs Human", variable=self.player_choice, value="human", bg="lightgray").pack(anchor=tk.W)
        tk.Radiobutton(player_frame, text="Human vs Bot", variable=self.player_choice, value="bot", bg="lightgray").pack(anchor=tk.W)

        difficulty_frame = tk.Frame(main_frame, bg="lightgray")
        difficulty_frame.pack(pady=10)

        tk.Label(difficulty_frame, text="Select Bot Difficulty:", bg="lightgray").pack()
        tk.Radiobutton(difficulty_frame, text="Easy", variable=self.difficulty_choice, value="easy", bg="lightgray").pack(anchor=tk.W)
        tk.Radiobutton(difficulty_frame, text="Medium", variable=self.difficulty_choice, value="medium", bg="lightgray").pack(anchor=tk.W)
        tk.Radiobutton(difficulty_frame, text="Hard", variable=self.difficulty_choice, value="hard", bg="lightgray").pack(anchor=tk.W)
        tk.Radiobutton(difficulty_frame, text="Impossible", variable=self.difficulty_choice, value="impossible", bg="lightgray").pack(anchor=tk.W)

        start_button = tk.Button(main_frame, text="Start Game", command=self.start_game, bg="lightblue", fg="black", relief=tk.RAISED)
        start_button.pack(pady=20)

    def start_game(self):
        player_choice = self.player_choice.get()
        difficulty = self.difficulty_choice.get()

        self.destroy()  # Close the menu window

        if player_choice == "human":
            self.master.start_human_vs_human_game()
        else:
            self.master.start_human_vs_bot_game(difficulty)

class ConnectFourApp(tk.Tk):
    def __init__(self):
        super().__init__()

        self.main_menu = MainMenu(self)
        self.game = None

    def start_human_vs_human_game(self):
        self.game = ConnectFourGUI(self, RealPlayer('R'), RealPlayer('B'))

    def start_human_vs_bot_game(self, difficulty):
        self.game = ConnectFourGUI(self, RealPlayer('R'), BotPlayer('B', difficulty))


