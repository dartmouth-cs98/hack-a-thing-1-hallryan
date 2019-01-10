import os
import random

def main():
    print "The Number Game!\n====================================="
    print "I am guessing a numer between 0 and 100, guess it"

    userName = raw_input("What's Your name?: ")

    randomNumber = random.randrange(100)
    userGuess = ""

    messagesFile = open("motivation.txt", "r")
    motivationList = messagesFile.read().splitlines()
    messagesFile.close()

    userMotivations = map(lambda motivation: "** " + motivation + ", "
                            + userName + "! **", motivationList)

    while userGuess != randomNumber:
        userGuess = int(raw_input("Your Guess:"))
        if userGuess < randomNumber:
            print "Your guess was too low"
            print random.choice(userMotivations)
        elif userGuess > randomNumber:
            print "Your guess was too high"
            print random.choice(userMotivations)

    print "Your guess was correct"

main()
