

def do(task):
    print ""
    print "       "+ task
    print ""
    while ask("Is this complete?") is False:
       print "Why not?"
       print "1. I feel resistance to doing it"
       print "2. The algorithm is incomplete"
       print "3. The algorithm is complete, but there are special circumstances"
       ans = raw_input("choose...")
       if ans == '1':
          do("Write the smallest action to start this in your notes file")
       if ans == '2':
         do("rewrite scarface for this function")
       if ans == '3':
         do("Post to social media about the special circumstances and act as if it's been done.")
       print task


def morning(): 
    do("switch of all internet on phone")
    do("instant water")
    do("shower, teeth, floss")
    

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

def process_email():
    do("rewrite scarface for this function")

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
    print "here"

def startwork():
    print "Laptop Working"
    import datetime
    d = datetime.datetime.today()
    if d.hour > 12:
        if not ask("Have you processed your email?"):
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
