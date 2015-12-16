#!/bin/bash

# Delete all pods that are owned by this RC.
#  - Get the labels that the RC is selecting based on
#  - Delete all the pods with that set of labels.
#  - The RC will then recreate the pods.
#
# Do this so that the secrets can be remounted.

if [ -z "$RC_NAMES" ]; then
    echo "WARNING: RC_NAMES not provided. Secret changes may not be reflected."
    exit
fi

RC_NAMES=(${RC_NAMES})

for RC_NAME in "${RC_NAMES[@]}"
do

   LABELS=$(kubectl get rc $RC_NAME -o=template --template='{{range $index, $element := .spec.selector}}-l {{$index}}={{$element}} {{end}}')
   kubectl delete pods $LABELS
done
