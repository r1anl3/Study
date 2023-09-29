txt = """Gurer ner gjb xvaqf bs crbcyr va guvf jbeyq: gubfr jub ner ybbxvat
 sbe n ernfba naq gubfr jub ner svaqvat fhpprff. Gubfr jub ner
ybbxvat sbe n ernfba nyjnlf frrxvat gur ernfbaf jul gur jbex vf
abg svavfurq. Naq crbcyr jub svaq fhpprff ner nyjnlf ybbxvat sbe
ernfbaf jul gur jbex pna or pbzcyrgrq.
"""
flag = 1
key = 1
print(txt)
while flag:
    eMessage = ""
    test = txt
    for char in test:
        if char.isalpha():  # Check if the character is alphabetic
            if char.islower():
                char_code = ord(char) - ord('a')  # Calculate the character code relative to 'a'
                char_code = (char_code - key) % 26  # Apply the Caesar cipher shift
                encr_code = chr(char_code + ord('a'))  # Convert back to a character
                eMessage += encr_code
            elif char.isupper():
                char_code = ord(char) - ord('A')  # Same for uppercase characters
                char_code = (char_code - key) % 26
                encr_code = chr(char_code + ord('A'))
                eMessage += encr_code
        else:
            eMessage += char  # If it's not alphabetic, keep it unchanged
    print(f"KEY {key}: {eMessage}", end='\n')
    chose = input("Again? ")
    if chose == 'n':
        flag = 0
        break
    key += 1
