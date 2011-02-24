#!/usr/bin/env python

import subprocess
import sys

from optparse import OptionParser
from threading import Timer

def create_parser():
    parser = OptionParser(usage="Usage: %prog [options] WATCHED-COMMAND [TRIGGERED-COMMAND]")
    parser.add_option('-n', '--interval', type='float', default=2,
            help="interval in seconds between executions of the watched command, defaulting to 2")
    parser.add_option('-v', '--verbose', action='store_true')
    return parser

def timer_complete(options, old_output, watched, triggered):
    output = watch(watched)
    if output != old_output:
        if options.verbose:
            print "Got different output:\n%s" % output
        if triggered:
            subprocess.call(triggered, shell=True)
    else:
        if options.verbose:
            print "Got same output, will continue watching"
        start_timer(options, output, watched, triggered)

def watch(watched):
    return subprocess.Popen(watched, shell=True, stdout=subprocess.PIPE).communicate()[0]

def start_timer(options, output, watched, triggered):
    t = Timer(options.interval, timer_complete, [options, output, watched, triggered])
    t.start()

def main():
    parser = create_parser()
    options, args = parser.parse_args()

    num_args = len(args)
    if num_args == 2:
        watched, triggered = args
    elif num_args == 1:
        watched, triggered = args[0], None
    else:
        parser.print_help()
        sys.exit(2)
        
    output = watch(watched)

    if options.verbose:
        print "Watching for change from:\n%s" % output

    start_timer(options, output, watched, triggered)

if __name__ == '__main__':
    main()
