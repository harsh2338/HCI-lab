from tkinter import *
import time as clock
import random


randomAnimalList = [
    "Honey Bee",
    "Horse",
    "Iguana",
    "Jaguar",
    "Kangaroo",
    "Kiwi",
    "Lemming",
    "Leopard",
    "Eagle",
    "Scorpion",
    "Turkey",
    "Elephant",
    "Lion",
    "Cat",
    "Snake",
    "Rabbit",
    "Penguin",
    "Bear",
    "Squirrel",
    "Cow",
    "Peacock",
    "Cheetah",
    "Hippo",
    "Zebra",
]
correctAnimalsMap = {
    "Iguana": False,
    "Jaguar": False,
    "Kangaroo": False,
    "Kiwi": False,
    "Lemming": False,
    "Leopard": False,
    "Eagle": False,
    "Scorpion": False,
    "Turkey": False,
    "Cow": False,
}


def startExperiment():
    startExperimentButton.pack_forget()
    rulesFrame.pack_forget()
    startTimer()


def show_checkboxes():
    selectionFrame.pack()
    return


def startTimer():
    experimentListFrame.pack()
    remTimeValue = remTime.get()
    while remTimeValue > 0:
        remTimeValue -= 1
        remTime.set(remTimeValue)
        clock.sleep(1)
        root.update()

    if remTimeValue == 0:
        experimentListFrame.pack_forget()
        timerFrame.pack_forget()
        show_checkboxes()


def submit():
    correctAnswerCount = 0
    wrongAnswerCount = 0

    for i in range(len(randomAnimalList)):

        if selectedAnimal[i].get() == 1:
            if checkbuttons[i].cget("text") in correctAnimalsMap.keys():
                correctAnswerCount += 1
            else:
                wrongAnswerCount += 1

    label = Label(resultsFrame, text="Correct:\t" + str(correctAnswerCount))
    label.pack()
    label = Label(resultsFrame, text="Wrong:\t" + str(wrongAnswerCount))
    label.pack()
    label = Label(
        resultsFrame, text="Recall Frequency:\t" + str(correctAnswerCount / 10)
    )
    label.pack()
    selectionFrame.pack_forget()
    resultsFrame.pack()


root = Tk()
root.geometry("1000x1000")
root.title("Serial Positioning Effect Demonstration")
root.configure(background="yellow")

startExperimentButton = Button(root, text="Start", command=startExperiment)
timerFrame = LabelFrame(root, text="Timer", height=5, width=10, background="yellow")
remTime = IntVar()
remTime.set(10)
timeLabel = Label(timerFrame, textvariable=remTime)
rulesFrame = LabelFrame(
    root,
    text="Serial Positioning Effect",
)
rulesFrame.configure(background="red")
instructions = "Memorise the animal names before the time runs out"
instructionsLabel = Label(rulesFrame, text=instructions)

timeLabel.pack()
timerFrame.pack()
instructionsLabel.pack()
rulesFrame.pack()
startExperimentButton.pack(padx=5, pady=5)

# scene 2

experimentListFrame = LabelFrame(
    root, text="Memorise before the time runs out", background="yellow"
)
for word in correctAnimalsMap.keys():
    label = Label(experimentListFrame, text=word)
    label.pack()

# show the list of animals

# scene 3

selectionFrame = LabelFrame(root, text="Select the right ones.", background="yellow")
checkbuttons = []
selectedAnimal = []
for animal in randomAnimalList:
    selectedAnimal.append(IntVar())

for i in range(len(randomAnimalList)):
    c = Checkbutton(
        selectionFrame, text=randomAnimalList[i], variable=selectedAnimal[i]
    )
    c.pack()
    checkbuttons.append(c)

submitButton = Button(selectionFrame, text="Submit", command=submit)
submitButton.pack()

resultsFrame = LabelFrame(root, text="Score", background="yellow")

root.mainloop()