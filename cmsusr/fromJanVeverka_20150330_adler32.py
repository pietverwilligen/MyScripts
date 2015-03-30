#!/bin/env python
import sys
import zlib

def main():
    for fname in sys.argv[1:]:
        try:
            source = open(fname)
            check_sum = zlib.adler32(source.read())
            # http://stackoverflow.com/questions/20766813/how-to-convert-signed-to-unsigned-integer-in-python
            if check_sum < 0:
                check_sum += 2**32
            print hex(check_sum)[2:], fname
        finally:
            source.close()

if __name__ == '__main__':
    main()

