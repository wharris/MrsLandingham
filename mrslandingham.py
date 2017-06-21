def hope(string,x):
    print string

def test_function_dic():
    def hello():
        print "hello"
    def bye():
        print "bye"
    fundic={}
    fundic['hello']= lambda: do("say hello")
    fundic['bye']= bye
    x=user_choose_function(fundic)


def user_choose_function(fundic):
    counter =0
    for key in sorted(fundic.iterkeys()):
        print "{} - {}".format(counter,key)
        counter=counter+1
    while True:
        try:
            ans = int(raw_input("choose..."))
            options=[[str(x) for x in range(counter)]]
            options=range(counter)
            fundic[sorted(fundic.iterkeys())[ans]]()
            return
        except:
            print "Invalid input!"

def do(task):
    print ""
    print "       "+ task
    print ""
    while ask("Is this complete?") is False:
       print "Why not?"
       answers={}
       answers["I feel resistance to doing it"]=lambda:do("Write the smallest action to start this in your notes file")
       answers["The algorithm is incomplete"]=lambda:do("rewrite scarface for this function")
       answers["The algorithm is complete, but there are special circumstances"]=lambda:do("Post to social media about the special circumstances and act as if it's been done.")
       answers["I have made progress against this task and I want to replace it with a continuing task"]=lambda:do("Keep working on it. Write the smallest action down again")
       user_choose_function(answers)
       print task


def read(task):
    print task


def ask(prompt):
    #from http://code.activestate.com/recipes/541096-prompt-the-user-for-confirmation/
    if prompt is None:
        prompt = 'Confirm'
    prompt = '%s %s|%s: ' % (prompt, 'n', 'y')

    while True:
        ans = raw_input(prompt)
        if ans not in ['y', 'Y', 'n', 'N']:
            print 'please enter y or n.'
            continue
        if ans == 'y' or ans == 'Y':
            return True
        if ans == 'n' or ans == 'N':
            return False


###############################################################################
#Now the actual instructions.

def process_email():
    print "Trigage Email starting"
#    while ask("are there more unread emails"):
#     each email in inbox it will be one of these:
#    from a human directly to me: read #leave replying for the next pass
#    it is an automated email that can be unsubscribed from: unsubscribe
#    it is a calendar event:
#    If the event is to remind you to send an email, then leave for the next pass
#    if the event is to remind you to do a task that needs email, then do it if it's less than 2 minutes, otherwise pass
#    if the event is for transfer to the next action list, then transfer it now.
#    second page: reply to each email in order.
#    Send all emails from calendar events
#    Do all calendar tasks.
#    If inbox isn't empty, rewrite this task.


def project_work():
    do("rewrite scarface for this function")

def jurgen_normal_form():
    print(chr(27) + "[2J")
    print "## Put next actions in normal form"
    print "First we make sure that the Next Actions List is complete, clear, consistent and public."
    print "This makes everything in the list easier to do."

    print "Capture section:"
    do("Add tasks from reminders")
    do("Add tasks from phone screenshots.")
    do("Check Voicemail and add any messages to Tasks.")
    do("Go thought Osprey bag - everything that isn't meant to be there is a task.")
    do("Sort the next actions file alphabetically, this will put the least defined tasks at the top.")
    do("Fill in the priority, context, and time,")
    do("Do any tasks that take less than five minutes (morning power hour!)")
    do("Rewrite tasks thinking about how public they are")
    do("Go thought all tasks and adjust the deadline for an urgent ones")


def work_on_next_actions():
## Working on the next actions list

    do("Start a relevant notes file")
    if ask("Are there any zeros in the next actions list?"):
        jurgen_normal_form()

    while True:
        do("Complete the action at the top of the list?")

def startwork():
    print "Laptop Working"
    import datetime
    d = datetime.datetime.today()
    if d.hour > 12:
        if not ask("Have you processed your email?"):
                do("Open personal email")
                process_email()
                do("Open processional email")
                process_email()
        do(project_work())
    work_on_next_actions()

#work_on_next_actions()
if __name__ == "__main__":
    print(chr(27) + "[2J")
    print """Good morning Joe.

    This is the plan written by the version of you that wasn't afraid. You put your faith in the system and you will be okay."""

    do("read your mission statement to keep the right reasons in the front of your mind.")
    do("Go to the Doghouse - you set it up to be your perfect working area")
    do("Go and get full Water Bottle. Put in arm's reach")
    do("Setup Laptop and open Jurgen. // because you are going to gather tasks.")
    do("Write what you had for breakfast in diet file and plan foods you will eat today (times of food is later)")
    do("Put Phone on charge with mobile interent and wifi off.")


    print "# Initialise Workday!"
    read("//Being late is awful and disrespectful, if you can, find the nearby Starbucks first.")
    read("1. Calendar first - you need to know all your commitments and have planned them.")
    while ask("do you have any unprocessed appointments?"):
        do("Write down any tasks you need to make about the outside appointment ('pack bag' for example).")
        do("Work out what time you need to leave/be ready for a call. And set an alarm. If it involves travel, then put the place into Google Maps (and save as a favourite)")
    do("Have guaranteed exercise (by watch reminder)")
    do("Have Guaranteed Food.  (by watch reminder)")
    startwork()
