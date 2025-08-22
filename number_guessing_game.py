def play_guessing_game():
    player_name = input("Hello there! What's your name? ")
    print(f"Welcome, {player_name}! I'm thinking of a number between 1 and 100. Can you guess it?")

    secret_number = random.randint(1, 100)
    attempts = 0
    max_attempts = 7

    while attempts < max_attempts:
        try:
            guess = int(input(f"Attempt {attempts + 1}/{max_attempts}: Enter your guess: "))
            attempts += 1

            if guess < 1 or guess > 100:
                print("Oops! That number is outside the range. Stick to 1-100.")
            elif guess < secret_number:
                print("Too low! Think higher. 🔥")
            elif guess > secret_number:
                print("Too high! Aim lower. ❄️")
            else:
                print(f"🎉 Congratulations, {player_name}! You guessed the number {secret_number} in {attempts} attempts!")
                break
        except ValueError:
            print("That's not a valid number! Please enter an integer.")

    else:
        print(f"Game over, {player_name}! You ran out of attempts. The secret number was {secret_number}.")
        print("Better luck next time!")

if __name__ == "__main__":
    play_guessing_game()
