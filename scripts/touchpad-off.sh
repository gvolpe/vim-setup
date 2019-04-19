#!/bin/bash

id="$(xinput | grep Touchpad | awk ' {print $6} ' | awk -F '[=()]' ' {print $2} ')"

echo "Disabling Touchpad id=$id"

xinput disable $id

