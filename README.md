# OpenAI 4o vs Llamma 3.2

## CoffeeMachine

### Bash-to-Model
https://chatgpt.com/share/67430d03-d75c-800e-89f2-5c5221eca89b

Provides coffee_machine.sh asks to convert to petri-net

```
convert the program to this format

{
"modelType": "elementary",
"version": "v0",
"places": {
"place0": { "offset": 0, "initial": 1, "x": 102, "y": 182 }
},
"transitions": {
"txn0": { "role": "role0", "x": 22, "y": 102 },
"txn1": { "role": "role0", "x": 182, "y": 102 },
"txn2": { "role": "role0", "x": 22, "y": 262 },
"txn3": { "role": "role0", "x": 182, "y": 262 }
},
"arcs": [
{ "source": "txn0", "target": "place0" },
{ "source": "place0", "target": "txn1" },
{ "source": "txn2", "target": "place0", "inhibit": true },
{ "source": "place0", "target": "txn3", "inhibit": true }
]
}
```

[![pflow](https://pflow.dev/img/zb2rhj3rVm38rsqZkx3X4dZ3Szm1AyCAY2F7ea2xxx9VAEnEf.svg)](https://pflow.dev/p/zb2rhj3rVm38rsqZkx3X4dZ3Szm1AyCAY2F7ea2xxx9VAEnEf/)

This seems to work well (NOTE: ordered layout manually for illustration)

### Model-to-bash
https://chatgpt.com/share/6743107a-8af4-800e-847a-36213bef4840

```
convert this petri-net model into bash script using a similar style
```

This didn't work as well in this direction, the bash code doesn't seem to store state properly.

- It did an OK job inventing a way to express the inhibitor arcs on it's own.

### Simplified Counter Model

Remove the Inhibitor arcs, we get the same model as before.

[![pflow](https://pflow.dev/img/zb2rhfbHomhz8rhs8y2m5KoZca8oPT4WNkzDTqwGG5skMUuLg.svg)](https://pflow.dev/p/zb2rhfbHomhz8rhs8y2m5KoZca8oPT4WNkzDTqwGG5skMUuLg/)

### Model-to-bash

Didn't produce working code


## TicTacToe

### bash-to-bash
Passed in the coffee_machine.sh and asked for tic-tac-to design

```
here's a petri-net in bash - I want to make a game of tic-tac-toe in the same format
it should interact w/ a user from CLI and display the state set as a board
```

This works!!

### bash-to-model

It did a good job using inhibitor arcs in the model!!!

```
output the tic-tac-toe game in this format

{
  "modelType": "petriNet",
  "version": "v0",
  "places": {
    "place0": { "offset": 0, "initial": 3, "capacity": 3, "x": 102, "y": 182 }
  },
  "transitions": {
    "txn0": { "role": "role0", "x": 22, "y": 102 },
    "txn1": { "role": "role0", "x": 182, "y": 102 },
    "txn2": { "role": "role0", "x": 22, "y": 262 },
    "txn3": { "role": "role0", "x": 182, "y": 262 }
  },
  "arcs": [
    { "source": "txn0", "target": "place0" },
    { "source": "place0", "target": "txn1", "weight": 3 },
    { "source": "txn2", "target": "place0", "weight": 3, "inhibit": true },
    { "source": "place0", "target": "txn3", "inhibit": true }
  ]
}
```

[![pflow](https://pflow.dev/img/zb2rhcGhKPa1vEmzx2ktsV8G7m9uqw3zJSy9NEuuamijV7kHw.svg)](https://pflow.dev/p/zb2rhcGhKPa1vEmzx2ktsV8G7m9uqw3zJSy9NEuuamijV7kHw/)
