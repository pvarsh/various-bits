### Example due to user: kindall on stackoverflow.com
### http://stackoverflow.com/questions/4693120/use-of-global-keyword-in-python
value = 42

def doit():
    print value
    value = 0

doit()
print value