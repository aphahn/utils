Just some Unix utilities

Currently, there's only one utility in here: `trigger`

`trigger` is kind of like `watch`, but more easily scriptable.

While `watch` displays the changing output to you, `trigger` will block until a change occurs in the output, optionally triggering the second positional argument.

Block until the current directory's contents changes:

    trigger ls

Ask YouTube every 30 seconds if a new Jeopardy! episode has been uploaded and tell you when to watch:

    trigger -n 30 "curl --silent http://gdata.youtube.com/feeds/api/users/Rashad8821/uploads\?v\=2\ | ack -i jeopardy | wc -l" "say 'Jeopardy is ready\!'"
