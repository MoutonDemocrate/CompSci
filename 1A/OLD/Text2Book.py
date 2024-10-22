##
import sys 
import textwrap

ch = input("Welcome to Mouton's Bookinator-3000X !\nWould you like to use a file or copy text directly ? (input f/t)")
if ch == "t" :
    text = input("Input your carefully written text :")
elif ch == "f" : 
    fileName = input("Input your file's name (without the .txt) :")
    try:
        file = open(fileName + ".txt", "r")
    except FileNotFoundError:
        print("Error: File '{}.txt' wasn't found. Make sure it is in the same directory as the script and that the name is spelled properly!".format(fileName))
        sys.exit()
    text = file.read()
else :
    print("You didn't input either 'f' (file) or 't' (text). Try again -_-")

lines = textwrap.wrap(text,19)
finalText = []
currentPage = ""
page = 0

for ind in range(len(lines)):
    pageChange = ind % 14
    if pageChange == 0 :
        print("Printing page {}...".format(page))
        print(currentPage)
        page += 1
        finalText.append(currentPage) if currentPage != "" else None
        currentPage = ""
    currentPage += lines[ind] + "\n" if ind != len(lines) else lines[ind]

finalText.append(currentPage) if currentPage != "" else None

print("Printing final text...")
print(finalText)
finalBook = "/give @p writable_book{{pages:{}}} 1".format(finalText)
print(finalBook)