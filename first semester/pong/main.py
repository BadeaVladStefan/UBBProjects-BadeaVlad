import pygame
import random
import pygame.mixer

pygame.init()
pygame.mixer.init()
paddle_hit_sound = pygame.mixer.Sound("1beep.mp3")
ball_hit_up_down_wall_sound = pygame.mixer.Sound("wallsupdown.mp3")
game_start_sound = pygame.mixer.Sound("gameStart.mp3")
end_game_sound = pygame.mixer.Sound("endGame.mp3")
goal_sound = pygame.mixer.Sound("goalSound.mp3")
ball_hit_up_down_wall_sound.set_volume(0.5)

ball_trail = []

screen_width = 800
screen_height = 600
screen = pygame.display.set_mode((screen_width, screen_height))
screen.set_alpha(None)
pygame.display.set_caption("Pong Game by Badea Vlad")

def screen_shake(screen, magnitude, duration):
    original_rect = screen.get_rect()
    start_time = pygame.time.get_ticks()

    while pygame.time.get_ticks() - start_time < duration:
        offset = (random.randint(-magnitude, magnitude), random.randint(-magnitude, magnitude))
        screen.blit(screen, offset)
        pygame.display.flip()

    screen.blit(screen, original_rect.topleft)

player1_score = 0
player2_score = 0

black = (0, 0, 0)
white = (255, 255, 255)

paddle_width = 15
paddle_height = 100

ball_size = 20

left_paddle_x = 50
left_paddle_y = screen_height // 2 - paddle_height // 2

right_paddle_x = screen_width - paddle_width - 50
right_paddle_y = screen_height // 2 - paddle_height // 2

ball_x = screen_width // 2 - ball_size // 2
ball_y = screen_height // 2 - ball_size // 2

paddle_speed = 5
ball_speed_x = 5
ball_speed_y = 5

ai_paddle_speed = 5

difficulty_levels = {
    "easy": {"ai_miss_probability": 0.8, "ai_responsiveness": 0.3},
    "medium": {"ai_miss_probability": 0.9, "ai_responsiveness": 0.5},
    "hard": {"ai_miss_probability": 1.0, "ai_responsiveness": 0.7}
}

clock = pygame.time.Clock()
is_running = True

start_font = pygame.font.Font(None, 48)

tutorial_messages = [
    "Welcome to Pong ~ Created by Badea Vlad!",
    "Player 1 controls:",
    "W: Move Up",
    "S: Move Down",
    "Player 2 is controlled by the computer.",
    "Score by hitting the ball past your opponent!",
    "First to 5 points wins.",
    "Press any key to start",
    "E - Easy",
    "M - Medium",
    "H - Hard"
]

tutorial_font = pygame.font.Font(None, 24)
tutorial_texts = [tutorial_font.render(msg, True, white) for msg in tutorial_messages]
tutorial_positions = [(screen_width // 2, y) for y in range(100, 600, 30)]

screen.fill(black)
for text, pos in zip(tutorial_texts, tutorial_positions):
    text_rect = text.get_rect(center=pos)
    screen.blit(text, text_rect)
pygame.display.flip()

waiting_for_start = True
while waiting_for_start:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
        if event.type == pygame.KEYDOWN:
            waiting_for_start = False
            game_start_sound.play()

difficulty_font = pygame.font.Font(None, 36)
difficulty_text = difficulty_font.render("Select Difficulty:", True, white)
easy_text = difficulty_font.render("Easy", True, white)
medium_text = difficulty_font.render("Medium", True, white)
hard_text = difficulty_font.render("Hard", True, white)

screen.fill(black)
screen.blit(difficulty_text, (screen_width // 2 - difficulty_text.get_width() // 2, 200))
screen.blit(easy_text, (screen_width // 2 - easy_text.get_width() // 2, 300))
screen.blit(medium_text, (screen_width // 2 - medium_text.get_width() // 2, 350))
screen.blit(hard_text, (screen_width // 2 - hard_text.get_width() // 2, 400))
pygame.display.flip()

waiting_for_difficulty = True
selected_difficulty = "medium"
while waiting_for_difficulty:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_e:
                selected_difficulty = "easy"
                waiting_for_difficulty = False
            elif event.key == pygame.K_m:
                selected_difficulty = "medium"
                waiting_for_difficulty = False
            elif event.key == pygame.K_h:
                selected_difficulty = "hard"
                waiting_for_difficulty = False

ai_miss_probability = difficulty_levels[selected_difficulty]["ai_miss_probability"]
ai_responsiveness = difficulty_levels[selected_difficulty]["ai_responsiveness"]

while is_running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            is_running = False

    keys = pygame.key.get_pressed()
    if keys[pygame.K_w] and left_paddle_y > 0:
        left_paddle_y -= paddle_speed
    if keys[pygame.K_s] and left_paddle_y < screen_height - paddle_height:
        left_paddle_y += paddle_speed
    predicted_intersection_y = ball_y + (right_paddle_x - ball_x) * (ball_speed_y / ball_speed_x)

    if predicted_intersection_y < right_paddle_y + paddle_height / 2:
        if right_paddle_y > 0:
            right_paddle_y -= ai_paddle_speed * ai_responsiveness
    elif predicted_intersection_y > right_paddle_y + paddle_height / 2:
        if right_paddle_y < screen_height - paddle_height:
            right_paddle_y += ai_paddle_speed * ai_responsiveness

    if random.random() < ai_miss_probability:
        pass
    else:
        if predicted_intersection_y < right_paddle_y + paddle_height / 2:
            if right_paddle_y > 0:
                right_paddle_y -= ai_paddle_speed * ai_responsiveness
        elif predicted_intersection_y > right_paddle_y + paddle_height / 2:
            if right_paddle_y < screen_height - paddle_height:
                right_paddle_y += ai_paddle_speed * ai_responsiveness

    ball_x += ball_speed_x
    ball_y += ball_speed_y

    ball_trail.append((ball_x, ball_y))

    if len(ball_trail) > 20:
        ball_trail.pop(0)

    if ball_y <= 0 or ball_y >= screen_height - ball_size:
        ball_speed_y = -ball_speed_y
        ball_hit_up_down_wall_sound.play()

    if ball_x <= 0:
        player2_score += 1
        screen_shake(screen, magnitude=5, duration=150)
        ball_speed_x = -ball_speed_x
        ball_x = screen_width // 2 - ball_size // 2
        ball_y = screen_height // 2 - ball_size // 2
        goal_sound.play()
    elif ball_x >= screen_width - ball_size:
        player1_score += 1
        screen_shake(screen, magnitude=5, duration=150)
        ball_speed_x = -ball_speed_x
        ball_x = screen_width // 2 - ball_size // 2
        ball_y = screen_height // 2 - ball_size // 2
        goal_sound.play()
        left_paddle_y = screen_height // 2 - paddle_height // 2
        right_paddle_y = screen_height // 2 - paddle_height // 2

    if (
            ball_x <= left_paddle_x + paddle_width and
            left_paddle_y <= ball_y + ball_size and
            left_paddle_y + paddle_height >= ball_y
    ) or (
            ball_x + ball_size >= right_paddle_x and
            right_paddle_y <= ball_y + ball_size and
            right_paddle_y + paddle_height >= ball_y
    ):
        ball_speed_x = -ball_speed_x
        paddle_hit_sound.play()

    screen.fill(black)

    for i, (tx, ty) in enumerate(ball_trail):
        alpha = int(255 * (1 - i / len(ball_trail)))
        trail_color = pygame.Color(128, 0, 128, alpha)
        trail_radius = ball_size // 2
        pygame.draw.circle(screen, trail_color, (tx + trail_radius, ty + trail_radius), trail_radius)

    middle_line_width = 2
    middle_line_height = screen_height
    middle_line_color = white
    middle_line_x = screen_width // 2 - middle_line_width // 2
    pygame.draw.rect(screen, middle_line_color, (middle_line_x, 0, middle_line_width, middle_line_height))

    pygame.draw.rect(screen, white, (left_paddle_x, left_paddle_y, paddle_width, paddle_height))
    pygame.draw.rect(screen, white, (right_paddle_x, right_paddle_y, paddle_width, paddle_height))
    pygame.draw.ellipse(screen, white, (ball_x, ball_y, ball_size, ball_size))

    font = pygame.font.Font(None, 36)
    player1_score_text = font.render(f"Player: {player1_score}", True, white)
    player2_score_text = font.render(f"Computer: {player2_score}", True, white)
    screen.blit(player1_score_text, (100, 20))
    screen.blit(player2_score_text, (screen_width - player2_score_text.get_width() - 100, 20))

    if player1_score >= 5 or player2_score >= 5:
        screen.fill(black)
        if player1_score >= 5:
            winner_text = start_font.render("Player wins!", True, white)
        else:
            winner_text = start_font.render("Computer wins!", True, white)
        end_game_sound.play()
        winner_text_rect = winner_text.get_rect(center=(screen_width // 2, screen_height // 2))
        screen.blit(winner_text, winner_text_rect)
        pygame.display.flip()

        waiting_for_restart = True
        while waiting_for_restart:
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    pygame.quit()
                if event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_SPACE:
                        player1_score = 0
                        player2_score = 0
                        ball_x = screen_width // 2 - ball_size // 2
                        ball_y = screen_height // 2 - ball_size // 2
                        waiting_for_restart = False

    pygame.display.flip()
    clock.tick(60)

pygame.quit()
pygame.mixer.quit()
