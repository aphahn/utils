## Just some Unix utilities.

# `trigger`

`trigger` is kind of like `watch`, but more easily scriptable.

While `watch` displays the changing output to you, `trigger` will block until a
change occurs in the output, optionally triggering the second positional
argument.

Block until the current directory's contents changes:

    trigger ls

Ask YouTube every 30 seconds if a new Jeopardy! episode has been uploaded and
tell you when to watch:

    trigger -n 30 "curl --silent http://gdata.youtube.com/feeds/api/users/Rashad8821/uploads\?v\=2\ | ack -i jeopardy | wc -l" "say 'Jeopardy is ready\!'"

# `random`

Returns a random line from the passed file(s). For example, printing a random line from two files:

    random foo.txt bar.txt

Choosing a random file in a directory:

    ls | random -

# `lns`

Never get confused by `ln -s`'s syntax again! Just pass two things you want to
symlink, and it is done. For example, these two outputs have the same effect
(assuming `foo` is a file and `bar` is the name of the symlink you want to
make).

    lns foo bar
    lns bar foo

# `pmp`

My fork of [Poor Man's Profiler](http://poormansprofiler.org). Just pass in a
pid and get consolidated stacktraces. Tested on OS X and Ubuntu.

For example, this runs 10 samples:

    pmp `pidof python`

Running 100 samples, pausing a tenth of a second between each sample:

    pmp `pidof python` 100 .1
