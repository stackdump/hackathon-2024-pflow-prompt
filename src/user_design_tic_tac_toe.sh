#!/bin/bash

# Define the board as states
states=(
    "Cell_1:0"
    "Cell_2:0"
    "Cell_3:0"
    "Cell_4:0"
    "Cell_5:0"
    "Cell_6:0"
    "Cell_7:0"
    "Cell_8:0"
    "Cell_9:0"
)

# Define the transitions (player moves)
players=("X" "O")
current_player=0

# Print the current board state as a grid
function print_board() {
    echo "-------------"
    for i in {1..9}; do
        IFS=":" read -r name value <<<"${states[i-1]}"
        if [[ $value == "0" ]]; then
            echo -n " $i |"
        else
            echo -n " ${value} |"
        fi
        if (( i % 3 == 0 )); then
            echo -e "\n-------------"
        fi
    done
}

# Set the state of a given cell
function set_state() {
    for i in "${!states[@]}"; do
        IFS=":" read -r name value <<<"${states[$i]}"
        if [[ $name == "Cell_$1" && $value == "0" ]]; then
            states[$i]="$name:${players[$current_player]}"
            return 0
        fi
    done
    return 1
}

# Check if a player has won
function check_winner() {
    winning_combinations=(
        "1 2 3" "4 5 6" "7 8 9" # Rows
        "1 4 7" "2 5 8" "3 6 9" # Columns
        "1 5 9" "3 5 7"         # Diagonals
    )
    for combo in "${winning_combinations[@]}"; do
        read -r a b c <<<"$combo"
        IFS=":" read -r _ val_a <<<"${states[a-1]}"
        IFS=":" read -r _ val_b <<<"${states[b-1]}"
        IFS=":" read -r _ val_c <<<"${states[c-1]}"
        if [[ $val_a != "0" && $val_a == "$val_b" && $val_b == "$val_c" ]]; then
            echo "Player ${val_a} wins!"
            exit
        fi
    done

    # Check for a draw
    for state in "${states[@]}"; do
        IFS=":" read -r _ value <<<"$state"
        if [[ $value == "0" ]]; then
            return 1 # Game still ongoing
        fi
    done
    echo "It's a draw!"
    exit
}

# Main function to run the game
function main() {
    while true; do
        print_board
        echo "Player ${players[$current_player]}, choose a cell (1-9):"
        read -r cell

        if [[ $cell =~ ^[1-9]$ ]] && set_state "$cell"; then
            check_winner
            current_player=$((1 - current_player))
        else
            echo "Invalid move. Try again."
        fi
    done
}

main
