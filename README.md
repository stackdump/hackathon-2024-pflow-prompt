# pflow-prompt

Method
------

Provided the same system prompt and a chat input,
the OpenAI 4o model and the Llama-3.2-90b-text model
were used to generate a model in the format of a petri net.

Here we compare the results of the two models.

See more notes in [./NOTES.md](https://github.com/stackdump/hackathon-2024-pflow-prompt/blob/main/NOTES.md).

NOTE: click on the images to view the models in the pflow.dev viewer.

## OpenAI 4o vs Llama-3.2-90b-text

System Prompt:

```
Answer by generating a model in this format

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

Chat Input: [./src/coffee_machine.sh](https://github.com/stackdump/hackathon-2024-pflow-prompt/blob/main/src/coffee_machine.sh)

## Llama-3.2-90b-text

[![pflow](https://pflow.dev/img/zb2rhXwpgiLJcCqWbwikXD2Krtg67QyngzzN1QFF4MMupnFgm.svg)](https://pflow.dev/p/zb2rhXwpgiLJcCqWbwikXD2Krtg67QyngzzN1QFF4MMupnFgm/)

## OpenAI 4o

[![pflow](https://pflow.dev/img/zb2rhoNTezoCdhLtVkWvtYfvFxbCJ16h5QJCbXZVTsRCCfcfH.svg)](https://pflow.dev/p/zb2rhoNTezoCdhLtVkWvtYfvFxbCJ16h5QJCbXZVTsRCCfcfH/)