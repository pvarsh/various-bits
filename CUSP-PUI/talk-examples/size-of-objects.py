### example of different size of string and integer
#   storing the same information

import sys

xnum = 12345
xstr = '12345'

print "Size of xnum: %d" %sys.getsizeof(xnum)
print "Size of xstr: %d" %sys.getsizeof(xstr)