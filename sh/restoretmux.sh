#!/bin/sh
# This script works with tmux.
# it verify if a session does exist:
# if so, attach to it
# if not, create a new session
# with some windows and run an initial command on these.

SESSIONNAME="sess_name"
W1="dir1"
W2="dir2"
DIR="path/to/parent/folder/"
COMMAND="ls -la"
tmux has-session -t $SESSIONNAME 

if [ $? != 0 ] 
 then
	tmux new-session -s $SESSIONNAME -n $W1 -d
	tmux send-keys -t $SESSIONNAME "cd $DIR$W1 && $COMMAND" C-m
	tmux new-window -t $SESSIONNAME -n $W2 -c ${DIR}$W2
	tmux send-keys -t $SESSIONNAME "cd $DIR$W2 && $COMMAND" C-m
fi

tmux attach -t $SESSIONNAME
