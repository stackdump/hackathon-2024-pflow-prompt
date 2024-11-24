#!/bin/bash

# Initialize the game board
board=(" " " " " " " " " " " " " " " " ")

# Function to display the board
display_board() {
  echo " ${board[0]} | ${board[1]} | ${board[2]} "
  echo "---|---|---"
  echo " ${board[3]} | ${board[4]} | ${board[5]} "
  echo "---|---|---"
  echo " ${board[6]} | ${board[7]} | ${board[8]} "
}

# Check for a win
check_winner() {
  winning_positions=(
    "0 1 2" "3 4 5" "6 7 8"  # Rows
    "0 3 6" "1 4 7" "2 5 8"  # Columns
    "0 4 8" "2 4 6"          # Diagonals
  )
  for pos in "${winning_positions[@]}"; do
    set -- $pos
    if [[ "${board[$1]}" != " " && "${board[$1]}" == "${board[$2]}" && "${board[$2]}" == "${board[$3]}" ]]; then
      echo "Player ${board[$1]} wins!"
      exit
    fi
  done
}

# Check for a draw
check_draw() {
  for cell in "${board[@]}"; do
    if [[ "$cell" == " " ]]; then
      return
    fi
  done
  echo "It's a draw!"
  exit
}

# Main game loop
player="X"
while true; do
  display_board
  echo "Player $player, enter your move (1-9): "
  read -r move

  # Validate the move
  if [[ ! "$move" =~ ^[1-9]$ ]] || [[ "${board[$((move-1))]}" != " " ]]; then
    echo "Invalid move. Try again."
    continue
  fi

  # Update the board
  board[$((move-1))]="$player"

  # Check for win or draw
  check_winner
  check_draw

  # Switch player
  if [[ "$player" == "X" ]]; then
    player="O"
  else
    player="X"
  fi
done
