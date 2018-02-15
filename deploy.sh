#!/bin/bash

ansible-playbook run_playbook.yml -i host -K --extra-vars "wallet=alqo data_path=/tmp/data"