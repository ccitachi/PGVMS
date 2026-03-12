#!/bin/bash
# train the model
python -m experiments --cmd train  --name "PGVMS" 

# test the model
python -m experiments --cmd test --name "PGVMS"

