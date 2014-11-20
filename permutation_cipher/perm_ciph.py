import string
import random

alphabet = string.ascii_lowercase
print alphabet

vowels = list('aeiouy')
consonants = [x for x in list(alphabet) if x not in vowels]
print consonants

message = "Security update. Please refrain from using permutation ciphers. For a list of secure alternatives, please consult the interweb. The management"

message = message.lower()

list(message)

vowelsCipher = [ch for ch in vowels]
consonantsCipher = [ch for ch in consonants]
random.shuffle(vowelsCipher)
random.shuffle(consonantsCipher)

cipher = {}
for i in range(len(vowels)):
  cipher[vowels[i]] = vowelsCipher[i]
for i in range(len(consonants)):
  cipher[consonants[i]] = consonantsCipher[i]

codedMessage = []
for ch in list(message):
  print ch
  if ch in cipher:
    codedMessage.append(cipher[ch])
  else:
    codedMessage.append(ch)

print ''.join(codedMessage)
print vowels
print consonants
