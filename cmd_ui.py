import sys
from time import sleep
import curses
import pygame
import os

class Cmd_ui():
	def __init__(self):
            self.win = curses.initscr()
            curses.cbreak()
            self.win.nodelay(True)

	def ask(self, prompt):
            self.win.clear()
            self.win.border(0)
            self.win.addstr(10, 5,prompt)
            self.win.addstr(15, 5,"[y]es, [n]o?")
            self.win.refresh()
            while True:
                key = self.win.getch()
                if key == ord('y'):
                    return True
                if key == ord('n'):
                    return False
                sleep(0.01)


	def do(self, task,detail_method):
            pygame.init()
            pygame.mixer.init()
            self.count=6000
            self.win.clear()
            self.win.border(0)
            self.win.addstr(5, 5,str(self.count/10))
            self.win.addstr(10, 5,task[0:50])
            self.win.addstr(11, 5,task[50:100])
            self.win.addstr(12, 5,task[100:])
            self.win.refresh()
            results=[ord('d'),ord('p')]
            if detail_method==None:
                self.win.addstr(15, 5,"[D]one, [P]roblem?")
            else:
                results.append(ord('e'))
                self.win.addstr(15, 5,"[D]one, [E]xpand, [P]roblem?")
            while True:
                key = self.win.getch()
                if key in  results:
                    curses.endwin()
                    return chr(key)
                if key is ord('l'):
                    self.count=6000
                    pygame.mixer.music.stop()
                self.count=self.count-1
                if self.count==120:
#                    x=pygame.mixer.Sound("effects/done.wav")
#                    x.play()
                    pygame.mixer.music.load('effects/countdown.mp3')
                    pygame.mixer.music.play()
                self.win.addstr(5, 5,str(self.count/10))
                sleep(0.10)

	def tell(self, statement):
            for char in statement:
                sleep(0.01)
                sys.stdout.write(char)
                sys.stdout.flush()
            print "\n"



	def choose(self, prompt,fundic):
            self.win.clear()
            self.win.border(0)
            self.win.addstr(10, 3,prompt)
            counter =0
            results=[]
            for key in sorted(fundic.iterkeys()):
                self.win.addstr(8+counter,3, "{} - {}".format(counter,key))
                print "Y{}Y".format(counter)
                results.append(ord("{}".format(counter)))
                counter=counter+1
            self.win.refresh()
            while True:
                key = self.win.getch()
                if key in  results:
                    curses.endwin()
                    fundic[sorted(fundic.iterkeys())[int(chr(key))]]()
                    return

                sleep(0.01)




if __name__ == "__main__":
    import workflow
    ui=Cmd_ui()
    location = os.path.dirname(os.path.abspath(__file__))+'/log_files/ml_log_desktop.md'
    print location
    workflow.main(ui,location)
