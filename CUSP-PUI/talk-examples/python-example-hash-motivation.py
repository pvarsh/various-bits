### MOTIVATING A HASH TABLE

string1 = "CUSP"
asciiSum = 0
for ch in string1:
    asciiSum += ord(ch)
print asciiSum

def asciiSum(stringIn):
    sm = sum([ord(ch) for ch in stringIn])
    print "ASCII sum of %s is %d" %(stringIn, sm)
    return sm
    
sumCusp = asciiSum("CUSP")
sumPython = asciiSum("Python")

hashLength = 23

print "hashed 'CUSP': ", sumCusp % hashLength
print "hashed 'Python': ", sumPython % hashLength