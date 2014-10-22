import copy

######################################################
################   POINTER BEHAVIOR     ##############
######################################################

######################################################
##### Everything is a pointer
#y = [1,2,3]
#x = y
#x[2] = 0
#print "Everything is a pointer:"
#print "list x: ", x
#print "list y: ", y
######################################################

######################################################
### How to copy a list instead of copying its pointer?
# Method 1: List comprehension
#y = [1,2,3]
#x = [item for item in y]
#x[2] = 0
#print "Copied using list comprehension:"
#print "list x: ", x
#print "list y: ", y
######################################################

######################################################
#### However this will still run into trouble if
##### your list contains pointers.
#z = [1,2]
#y = [1,2,3, z]
#x = [item for item in y]
#print "Using comprehension to copy can fail too: "
#print "x before changing z: ", x
#x[3][1] = "Dead Parrot"
#print "x after changing z: ", x
######################################################

######################################################
#### Deep copy to the resque
#z = [1,2]
#y = [1,2,3, z]
#x = copy.deepcopy(y)
#print "Using deep copy, Dead Parrot doesn't mess us up"
#print "x before changing z: ", x
#z[1] = "Dead Parrot"
#print "x after changing z: ", x
######################################################

######################################################
#### How does this affect passing objects to functions
#y = [7,2,3]
#
#def fun1(z):
#    z.sort()
#
#fun1(y)
#print y
## This means:
# Good news! You're not creating unnecessary copies of huge
#     objects in memory all the time.
# But you should be careful when manipulating objects within functions.
######################################################