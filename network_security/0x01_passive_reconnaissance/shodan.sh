#!/bin/bash

# Initialize Shodan
python -m shodan init 8RQd6qOTS4p3fFoVIOhxjQjjaTsGvfLq

# Query Shodan for holbertonschool.com
python -m shodan search hostname:holbertonschool.com
