#!/bin/bash

id="$(xinput | grep Touchpad | awk ' {print $6} ' | awk -F '[=()]' ' {print $2} ')"

echo "Enabling Touchpad id=$id"

xinput enable $id

