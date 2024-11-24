#!/bin/bash

# Define places with their initial state (1 = active, 0 = inactive)
places=(
  "place0:1"
)

# Define transitions
transitions=(
  "txn0"
  "txn1"
)

# Define arcs (connections between places and transitions)
arcs=(
  "txn0 > place0"
  "place0 > txn1"
)

# Print the current state
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

# Check if a place is active
function is_active() {
  for place in "${places[@]}"; do
    IFS=":" read -r name value <<<"$place"
    if [[ $name == "$1" && $value == "1" ]]; then
      return 0
    fi
  done
  return 1
}

# Set the state of a place
function set_state() {
  for i in "${!places[@]}"; do
    IFS=":" read -r name value <<<"${places[$i]}"
    if [[ $name == "$1" ]]; then
      places[$i]="$name:$2"
    fi
  done
}

# Perform a transition
function perform_transition() {
  local transition=$1
  local valid=true

  # Consume places required by the transition
  for arc in "${arcs[@]}"; do
    IFS=" > " read -r source target <<<"$arc"
    if [[ $target == "$transition" ]]; then
      if is_active "$source"; then
        set_state "$source" 0
      else
        valid=false
        break
      fi
    fi
  done

  # Produce places resulting from the transition
  if $valid; then
    for arc in "${arcs[@]}"; do
      IFS=" > " read -r source target <<<"$arc"
      if [[ $source == "$transition" ]]; then
        set_state "$target" 1
      fi
    done
  fi

  $valid && echo "Performed transition: $transition" || echo "Transition $transition failed"
  return $valid
}

# Main function to iterate through transitions
function main() {
  local step=0
  echo "Step #$step: Initial state"
  print_state

  while true; do
    local progressed=false
    for transition in "${transitions[@]}"; do
      if perform_transition "$transition"; then
        step=$((step + 1))
        echo "Step #$step: After $transition"
        print_state
        progressed=true
        break
      fi
    done
    if ! $progressed; then
      echo "No further transitions possible."
      break
    fi
  done
}

# Run the main function
main
