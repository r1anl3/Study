def toCharCode(char):
    return ord(char) - ord('a')

def toChar(charCode):
    char = charCode + ord('a')
    return chr(char)

text = "hello world".strip()
key = "UIT".lower()
keyStep = []
flag = 1

for char in key:
    charCode = toCharCode(char)
    keyStep.append(charCode)
keySize = len(keyStep)

keyStepIdx = 0
eMessage = ""

for char in text:
    if (char.isalpha()):
        charCode = toCharCode(char)
        charCode += keyStep[keyStepIdx%keySize]
        eMessage += toChar(charCode%26)
        keyStepIdx += 1
    else:
        eMessage += char
    
print(f"Encripted message: {eMessage}")