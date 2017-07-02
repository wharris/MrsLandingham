import sys
from time import sleep

class Cmd_ui():
	def __init__(self):
            self.i=1
            pass

	def ask(self, prompt):
            if prompt is None:
                prompt = 'Confirm'
            prompt = '%s %s|%s: ' % (prompt, 'n', 'y')

            while True:
                ans = raw_input(prompt)
                if ans not in ['y', 'Y', 'n', 'N']:
                    self.tell('please enter y or n.')
                    continue
                if ans == 'y' or ans == 'Y':
                    return True
                if ans == 'n' or ans == 'N':
                    return False


	def do(self, task):
            pass

	def tell(self, statement):
            for char in statement:
                sleep(0.01)
                sys.stdout.write(char)
                sys.stdout.flush()
            print "\n"

	def choose(self,prompt,fundic):
            self.tell(prompt)
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
                except KeyboardInterrupt:
                    sys.exit()
                    print "Invalid input!"



