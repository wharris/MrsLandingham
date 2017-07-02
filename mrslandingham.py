import pytz
import os
import datetime
import sys
import sys

LOG_LOC = os.path.dirname(os.path.abspath(__file__))+'/ml_log.md'


def write_to_file(toprint):
    __TIME_FORMAT = "%d/%m/%y %H:%M"
    with open(LOG_LOC, 'a') as actions_file:
	actions_file.write(datetime.datetime.now(pytz.timezone("Europe/London")).strftime("###### "+__TIME_FORMAT))
        actions_file.write('\n'+toprint+'\n\n')



def user_choose_function(prompt,fundic):
	ui.choose(prompt,fundic)

def clear():
    print(chr(27) + "[2J")

def tell(statement):
	ui.tell(statement)



def do(task):
    write_to_file(task) #we log when started
    while ask(task+"\nIs this complete?") is False:
       answers={}
       answers["I feel resistance to doing it"]=lambda:do("Write the smallest action to start this in your notes file")
       answers["The algorithm is incomplete"]=lambda:do("rewrite Mrs Landingham for this function")
       answers["The algorithm is complete, but there are special circumstances"]=lambda:do("Post to social media about the special circumstances and act as if it's been done.")
       answers["This task is would be better done at the same time as another appointment today"]=lambda:do("Post to social media about the special circumstances and act as if it's been done.")
       answers["I have made progress against this task and I want to replace it with a continuing task"]=lambda:do("Keep working on it. Write the smallest action down again")
       answers["I want to jump to another function"]=jump
       answers["Exit"]=sys.exit
       user_choose_function("Why not?",answers)


def morning():
    do("switch of all internet on phone")
    do("instant water")
    do("shower, teeth, floss")


def ask(prompt):
    return	ui.ask(prompt)



###############################################################################
#Now the actual instructions.


def jump():
    write_to_file("JUMP") #we log when started
    answers={}
    answers["process_email"]=process_email
    answers["project_work"]=project_work
    answers["work_on_a_project"]=work_on_a_project
    answers["jurgen_normal_form"]=jurgen_normal_form
    answers["work_on_next_actions"]=work_on_next_actions
    answers["startwork"]=startwork
    answers["planday"]=planday
    user_choose_function(answers)


def process_email():
    def deal_with_calendar_email():
        do("rewrite Mrs Landingham for this function")
        #If the event is to remind you to send an email, then leave for the next pass
        #if the event is to remind you to do a task that needs email, then do it if it's less than 2 minutes, otherwise pass
        #if the event is for transfer to the next action list, then transfer it now.
    clear()
    tell("Triage Email starting")
    while ask("are there more unread emails"):
        print "Is the top email...."
        answers={}
        answers["...from a human, directly to me"]=lambda:do("read and leave for next pass")
        answers["...an automated email that can be unsubscribed from"]=lambda:do("Unsubscribe")
        answers["a calendar event"]=lambda:deal_with_calendar_email()
        user_choose_function(answers)
    print "You are now doing the second pass"
    do("second page: reply to each email in order.")


def project_normal_form():
    do("Check that all cards are in columns")
    do("Close issues")
    do("Remove closed issues.")
    do("Check that every card is assigned")

def project_work():
    tell("Project work!")
    do("Check and respond to project notifications.")
    do("Open EQT projects file")
    project_normal_form()
    do("Open Jarvis projects file")
    project_normal_form()
    do("Choose the leftmost project with the soonest deadline //leftmost is highest priority on the chart")
    work_on_a_project()

def work_on_a_project():
    do("Open the file and add a datestamp to the comment (before mapping, you map later)")
    if(ask("Does the project need mapping?")):
        do("Map project")
    while (True):
        if(ask("Is the project finnished")):
            do("Close project")
            do("Write blog post about project")
        else:
            if(not ask("Does the project have an obvious next action")):
                do("Write a next action.")
            do("Do the next action.")
            do("Make a note of any filenames or commands you used")
            do("Write a short note saying what you did")


def jurgen_normal_form():
    clear()
    tell("## Put next actions in normal form")
    tell("First we make sure that the Next Actions List is complete, clear, consistent and public.")
    tell("This makes everything in the list easier to do.")

    tell("Capture section:")
    do("Add tasks from reminders")
    do("Add tasks from phone screenshots.")
    do("Check Voicemail and add any messages to Tasks.")
    do("Go thought Osprey bag - everything that isn't meant to be there is a task.")
    do("Sort the next actions file alphabetically, this will put the least defined tasks at the top.")
    do("Fill in the priority, context, and time,")
    do("Do any tasks that take less than five minutes (morning power hour!)")
    do("Check if some tasks have already been done")
    do("Rewrite tasks thinking about how public they are")
    do("Go thought all tasks and adjust the deadline for an urgent ones")


def work_on_next_actions():
## Working on the next actions list

    do("Start a relevant notes file")
    if ask("Are there any zeros in the next actions list?"):
        jurgen_normal_form()

    while True:
        do("Complete the action at the top of the list?")

def limitedinternet():
    do("pull next actions from github to work on locally")

def offlineworking():
    pass

def startwork():
    clear()
    tell("Laptop Working")
    import datetime
    d = datetime.datetime.today()
    if d.hour > 12:
       if d.isoweekday() in range(1, 6):
            if not ask("Have you processed your email?"):
                    do("Open personal email")
                    process_email()
                    do("Open professional email")
                    process_email()
       project_work()
    work_on_next_actions()

#process_email()

def planday():
    clear()
    tell("Open your calendar first - you need to know all your commitments and have planned them.")
    tell("Being late is awful and disrespectful, if you can, find the nearby Starbucks first.")
    while ask("do you have any unprocessed appointments?"):
        do("Write down any tasks you need to make about the outside appointment ('pack bag' for example).")
        do("Work out what time you need to leave/be ready for a call. And set an alarm. If it involves travel, then put the place into Google Maps (and save as a favourite)")
    do("Have guaranteed exercise (by watch reminder)")
    do("Have Guaranteed Food.  (by watch reminder)")
    do("Check what the night time temperature will be")

phone=True
ui=None
if phone:
    import ios_ui
    ui=ios_ui.Ios_ui()
else:
    import cmd_ui
    ui=cmd_ui.Cmd_ui()

if __name__ == "__main__":
    clear()
    ask("Are you ready for an awesome day?")
    statement= """

    This is the plan written by the version of you that wasn't afraid. You put your faith in the system and you will be okay.

I solve problems.

I do my work early so that I keep my time free and flexible.

The people I care about sometimes need someone. I keep my time free and flexible so I can be the right person in the right place at the right time to help.

I am a brother, I am a son, and I am a friend.


I accept no dogma. I do things because I believe they are right, or best, or natural, not because it is what is 'normally' done.

I believe love does not require, or even particularly benefit from, sex.


I want the world to change.

I have been disciplined for a decade.  For five years I have bettered myself. I have become more effective; I have caused change in the world.

Everything I am proud of, everything, has come out of me.

I will continue to better myself, continue to become more.  Change the world much more.

I have the perfect reason to fail, with no blame on me.

When I am tired, bored, angry, or sleepy, I validate that reason to fail.

Consuming accepts the world, creating will change it.

"""

    tell(statement)
    ask("Do you accept the mission statement")
    if ask("Are you at home?"):
        do("Go to the Doghouse - you set it up to be your perfect working area")
        do("Go and get full Water Bottle. Put in arm's reach")
        do("Put Phone on charge with mobile interent and wifi off.")
    else:
        answers={}
        answers["Remote location with limited internet"]=offlineworking
        answers["Train"]=offlineworking
        answers["Coffee Shop"]=limitedinternet
        user_choose_function("Where are you?", answers)

    do("Setup Laptop and open Jurgen. // because you are going to gather tasks.")
    do("Write what you had for breakfast in diet file and plan foods you will eat today (times of food is later)")

    planday()
    startwork()


    #todo
    #exit button
    #choose from list

