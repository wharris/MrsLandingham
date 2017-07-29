import pytz
import os
import datetime
import sys

# To add: food prep

#LOG_LOC = os.path.dirname(os.path.abspath(__file__))+'/log_files/ml_log.md'


def write_to_file(toprint):
    __TIME_FORMAT = "%d/%m/%y %H:%M"
    with open(LOG_LOC, 'a') as actions_file:
	actions_file.write(datetime.datetime.now(pytz.timezone("Europe/London")).strftime("###### "+__TIME_FORMAT))
        actions_file.write('\n'+toprint+'\n\n')



def user_choose_function(prompt,fundic):
	ui.choose(prompt,fundic)


def tell(statement):
	ui.tell(statement)



def do(task,detail_method=None):
    while True:
        response=ui.do(task,detail_method)
        if response == "e":
            detail_method()
            return
        if response == ('p'):
           problem()
        if response == ("d"):
            write_to_file("Did: "+task)
            return

def meeting():
# Design a meeting process that is most effective for both you and the other
# person.
#Start either with the list, or by creating a list with the other person.
# Aggree a finnish time.
# Start the one-mintue minutes document
# For each item work out who is responsibility and what will happen (and by
# when, you forget that a lot
    pass


def problem():
       answers={}
       answers["I feel resistance to doing it"]=lambda:do("Write the smallest action to start this in your notes file")
       answers["The algorithm is incomplete"]=lambda:do("rewrite Mrs Landingham for this function")
       answers["The algorithm is complete, but there are special circumstances"]=lambda:do("Post to social media about the special circumstances and act as if it's been done.")
       answers["This task is would be better done at the same time as another appointment today"]=lambda:do("Post to social media about the special circumstances and act as if it's been done.")
       answers["I have made progress against this task and I want to replace it with a continuing task"]=lambda:do("Keep working on it. Write the smallest action down again")
       answers["This is a cron and I've run out of resource"]=lambda:do("Order it online, Tesco or Amazon")
       answers["I want to jump to another function"]=jump
       answers["There are two of the same task in a row"]=lambda:do("Extend Mrs Landingham for this")
       answers["Interruption"]=interruption
       answers["Exit"]=sys.exit
       user_choose_function("Why not?",answers)



def interruption():
       answers={}
       answers["Phone Call"]=phonecall
       answers["Food"]=lambda:do("rewrite Mrs Landingham for this function")
       user_choose_function("What happened",answers)


def phonecall():
    do("fix the ML for phonecalls")

def timed_task():
    do("Timed task")

def morning():
    do("switch off all internet on phone")
    do("Take photo of the clock")
    do("bathroom")
    do("weigh self")
    do("immediate water")
    do("make tea (get washing)")#will be cool after shower
    do("Take vitamin tablet")
    do("put wash on")
    do("Set alarm for putting washing out")
    if  not ask("Did you make your last exercise reminder?"):
        do("Set of pullups")
        do("Set of pushup")
    do("shower, teeth, floss,dress")
    do("food prep")


def evening():
    do("glasses")
    do("switch off all internet on phone")
    do("Set out tea, tablets and water glass")
    do("Pack Osprey bag")
    do("Unpack shed bag")

def nosell():
    #Should be able to 'no sell' things
    pass


def ask(prompt):
    return	ui.ask(prompt)



###############################################################################
#Now the actual instructions.


def jump():
    write_to_file("JUMP") #we log when started
    answers={}
    answers["process email"]=process_email
    answers["project sprint"]=project_sprint
    answers["jurgen_normal_form"]=jurgen_normal_form
    answers["work_on_next_actions"]=work_on_next_actions
    answers["osprey"]=osprey
    answers["startwork"]=startwork
    answers["hotel room"]=hotel_room
    answers["planday"]=planday
    user_choose_function("Where to go?",answers)


def process_email():
    def deal_with_calendar_email():
        do("rewrite Mrs Landingham for this function")
        #If the event is to remind you to send an email, then leave for the next pass
        #if the event is to remind you to do a task that needs email, then do it if it's less than 2 minutes, otherwise pass
        #if the event is for transfer to the next action list, then transfer it now.

    def triage():
        while ask("are there more unread emails"):
            answers={}
            answers["...from a human, directly to me"]=lambda:do("read and leave for next pass")
            answers["...an automated email that can be unsubscribed from"]=lambda:do("Unsubscribe")
            answers["a calendar event"]=lambda:deal_with_calendar_email()
            user_choose_function("Is the top email...", answers)
    do("Triage Email",triage)
    do("second page: reply to the top email until there are NO emails.")


def osprey():
    do("check doors are all locked")
    do("Clothes for tomorrow are laid out")
    do("Osprey check: Laptop, Keys, Glasses, Food, Pens, notebook")
    do("Osprey check2: Battery (with charger), MacBook charger, plug")
    do("headphones on charge")
    do("todays clothes are in the wash")
    do("phone away")

def review_projects():
    def project_normal_form():
        do("Open the project board")
        do("Check that all cards are in columns")
        do("Close issues")
        do("Remove closed issues.")
        do("Check that every card is assigned")

    do("Check and respond to project notifications.")
    do("Review EQT projects board",project_normal_form)
    do("Review Jarvis projects board",project_normal_form)


def map_project():
    do("Make sure that the project has a SMART goal")
    do("Write down why you are going to do it")
    do("Work out roughtly how long it will take")
    do("Can you think of cool things that you can do to make the project awesome")
    do("Write down the list of ten things to do (not in order, things to do)")
    do("Write down the next action")

def project_sprint():
    do("Create an issue if necessary")
    do("Open the file and add a datestamp to the comment (before mapping, you map later)")
    if(ask("Does the project need mapping?")):
        do("Map project",map_project)
    while (True):
        if(ask("Is the project finnished")):
            do("Close project")
            do("Write blog post about project")
            return
        else:
            if(not ask("Does the project have an obvious next action")):
                do("Write a next action.")
            do("Do the next action.")
            do("Make a note of any filenames or commands you used")
            do("Write a short note saying what you did")


def jurgen_normal_form():
#    tell("First we make sure that the Next Actions List is complete, clear, consistent and public.")
 #   tell("This makes everything in the list easier to do.")
    def capture():
        do("Add tasks from reminders")
        do("Add tasks from phone screenshots.")
        do("Check Voicemail and add any messages to Tasks.")
        do("Go thought Osprey bag - everything that isn't meant to be there is a task.")


    def fill_out_action_points():
        do("Sort the next actions file alphabetically, this will put the least defined tasks at the top.")
        do("Fill in the priority, context, and time (mark off done tasks)")
        do("Note now much time for the full list")
        do("Do any tasks that take less than five minutes (morning power hour!)")
        do("Check if some tasks have already been done")
        do("Rewrite tasks thinking about how public they are")
        do("Go thought all tasks and adjust the deadline for an urgent ones")

    do("Capture actions from reminders, voicemail and bag:", capture)
    do("Make sure there are NO '0's in the file and that completed tasks have been removed",fill_out_action_points)


def work_on_next_actions():
## Working on the next actions list
    def single_action():
            answers={}
            answers["A sprint - an action taking 40 minutes or more"]=project_sprint
            answers["An action dependant on something else"]=lambda:do("rewrite ML for this 2039424")
            answers["A project review"]=review_projects
            user_choose_function("What sort of action is this", answers)

    do("Start a relevant notes file")
    if ask("Are there any zeros in the next actions list?"):
        do("Put Jurgen in Normal form",jurgen_normal_form)

    while True:
        do("Complete the action at the top of the list?", single_action)




def limitedinternet():
    do("pull next actions from github to work on locally")

def offlineworking():
    pass

def emailiftime():
#    if email_processed:
#        return
    import datetime
    d = datetime.datetime.today()
    if d.hour > 12:
       if d.isoweekday() in range(1, 6):
            if not ask("Have you processed your email?"):
                    do("Open personal email")
                    process_email()
                    do("Open professional email")
                    process_email()
#                    email_processed=True
def startwork():
    do("Put the thing you are most worried about into your todo or project list")
    emailiftime()
    do("Work on next actions",work_on_next_actions)


def planday():
  #  tell("Open your calendar first - you need to know all your commitments and have planned them.")
  #  tell("Being late is awful and disrespectful, if you can, find the nearby Starbucks first.")
 #   do("Write what you had for breakfast in diet file and plan foods you will eat today (times of food is later)")
    while ask("Do you have any unprocessed appointments?"):
        if ask("Can this apointment be changed into a Skype call?"):
            do("message about changing it")
        do("Write down any tasks you need to make about the outside appointment ('pack bag' for example).")
        do("Work out what time you need to leave/be ready for a call. And set an alarm. If it involves travel, then put the place into Google Maps (and save as a favourite)")

    do("Have guaranteed exercise (by watch reminder)")



def state_of_mind():
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


def away():
        answers={}
        answers["Remote location with limited internet"]=offlineworking
        answers["Train"]=offlineworking
        answers["Coffee Shop"]=limitedinternet
        user_choose_function("Where are you?", answers)


def setup_doghouse():
    do("Go and get full Water Bottle. Put in arm's reach")
    do("Put Phone on charge.")
    do("Put everything lose into the bag")


def shutdown_doghouse():
    pass


def onlaptop():
    do("Open Jurgen (you are going to gather tasks") #// because you are going to gather tasks.")
    import datetime
    d = datetime.datetime.today()
    if d.hour < 15:
        do("Plan your day",planday)
    startwork()


def hotel_room():
    do("put everything you can on charge")#Working remotely is normally a sign that you will be away from power for a little while
    do("Take shoes off")
    do("Get drink")
    do("Pull next actions from server")#You might want it later
    onlaptop()

ui=None

def main(ui_in,log):
    global ui
    ui=ui_in
    global LOG_LOC
    LOG_LOC = log
    do("Morning Routine",morning)
 #   do("Get mentally ready to work for several hours",state_of_mind)
    do("Go to the Doghouse - you set it up to be your perfect working area - and open laptop")
    do("Setup Doghouse", setup_doghouse)
    onlaptop()

    #todo
    #exit button
    #choose from list

