import sys
from time import sleep
import curses

class Cmd_ui():
	def __init__(self):
            self.win = curses.initscr()
            curses.cbreak()
            self.win.nodelay(True)

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

        def clear(self):
            print(chr(27) + "[2J")



	def do(self, task):
            self.win.border(0)
            self.win.addstr(10, 5,task)
            self.win.addstr(15, 5,"[D]one, [E]xpand, [P]roblem?")
            self.win.refresh()
            while True:
                key = self.win.getch()
                if key in  [ord('d'),ord('e'),ord('p')] :
                    curses.endwin()
                    return key
                sleep(0.01)

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



