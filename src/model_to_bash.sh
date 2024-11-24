#!/bin/bash

# Define the places with initial states
places=(
	"place0:1" # place0 starts with an initial token
)

# Define the transitions
transitions=(
	"txn0"
	"txn1"
	"txn2"
	"txn3"
)

# Define the arcs connecting transitions and places
# Format: source > target [:inhibit]
arcs=(
	"txn0 > place0"
	"place0 > txn1"
	"txn2 > place0:inhibit"
	"place0 > txn3:inhibit"
)

# Print the current state as a set
function print_state() {
	local output="{"
	for place in "${places[@]}"; do
		IFS=":" read -r name value <<<"$place"
		if [[ $value == "1" ]]; then
			output+=" $name,"
		fi
	done
	output="${output%,} }"
	echo "$output"
}

# Check if a place has a token
function has_token() {
	for place in "${places[@]}"; do
		IFS=":" read -r name value <<<"$place"
		if [[ $name == "$1" && $value == "1" ]]; then
			return 0
		fi
	done
	return 1
}

# Set the state of a place
function set_token() {
	for i in "${!places[@]}"; do
		IFS=":" read -r name value <<<"${places[$i]}"
		if [[ $name == "$1" ]]; then
			places[$i]="$name:$2"
		fi
	done
	return 0
}

# Check if a transition is enabled
function is_enabled() {
	local transition="$1"
	for arc in "${arcs[@]}"; do
		IFS=" > :" read -r source target condition <<<"$arc"
		if [[ $target == "$transition" ]]; then
			if [[ $condition == "inhibit" ]]; then
				if has_token "$source"; then
					return 1 # Inhibited
				fi
			else
				if ! has_token "$source"; then
					return 1 # Not enabled
				fi
			fi
		fi
	done
	return 0
}

# Fire a transition and update the state
function fire_transition() {
	local transition="$1"
	for arc in "${arcs[@]}"; do
		IFS=" > :" read -r source target condition <<<"$arc"
		if [[ $source == "$transition" ]]; then
			set_token "$target" 1
		elif [[ $target == "$transition" ]]; then
			set_token "$source" 0
		fi
	done
	echo "Fired $transition"
}

# Main loop to process transitions
function main() {
	local step=0
	echo "Step #$step: Initial state"
	print_state

	while true; do
		local fired=false
		for transition in "${transitions[@]}"; do
			if is_enabled "$transition"; then
				fire_transition "$transition"
				fired=true
				step=$((step + 1))
				echo "Step #$step: After $transition"
				print_state
				break
			fi
		done
		if ! $fired; then
			break
		fi
	done
	echo "No more transitions possible."
}

main
