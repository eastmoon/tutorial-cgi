#!/usr/bin/python3
import os

## Execute script
print('Content-type: text/plain; charset=iso-8859-1')
print('')
for name, value in os.environ.items():
    print("{0}: {1}".format(name, value))
