import ui
import dialogs
import sys

class Ios_ui():
	def __init__(self):
			self.v=ui.NavigationView(ui.View())
			self.v.present('fullscreen')

	def ask(self, question):
		self.questionview=ui.load_view('do')
		self.v.push_view(self.questionview)
		
		self.questionview['top'].text=question
		self.questionview.wait_modal()
		if self.response =="Yes":
			return True
		else:
			return False

	def do(self, task):
		self.ask(task+"\nIs this complete?")

	def tell(self, text):
		self.tellview=ui.load_view('tell')
		self.v.push_view(self.tellview)
		self.tellview['mess'].text=text
		self.tellview.wait_modal()

	def okay(self,sender):
		self.v.pop_view()

	def button_tapped(self,sender):
		print "called"

		self.response=sender.title
		print "xxx"+self.response
		self.v.pop_view()
		
	def exit(self,sender):
		self.v.close()
		sys.exit()

	def choose(self,prompt,fundic):
		ans=dialogs.list_dialog(prompt,fundic.keys())
		fundic[ans]()

