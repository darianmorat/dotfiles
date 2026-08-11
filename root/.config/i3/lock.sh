#!/bin/bash
i3lock --nofork -c 000000 &
LOCK_PID=$!
(sleep 20 && kill -0 $LOCK_PID 2>/dev/null && xset dpms force off) &
wait $LOCK_PID
xset dpms 0 0 0
