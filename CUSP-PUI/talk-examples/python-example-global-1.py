### Scoping example with global variables

def fun1():
    print "now we assigned 40 to x"
    x = 40

x = 42
print "x before running fun1():", x
fun1()
print "x after running fun1():", x
