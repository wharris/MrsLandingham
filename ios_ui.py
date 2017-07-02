import ui
import dialogs

class ios_ui():
	def __init__(self):
			self.v=None

	def ask(self, question):
		self.v= ui.load_view('do')
		self.v.present('fullscreen')
		self.v['top'].text=question
		self.v.wait_modal()
		if self.response =="Yes":
			return True
		else:
			return False

	def do(self, task):
		self.ask(task+"\nIs this complete?")

	def tell(self, text):
		self.v= ui.load_view('tell')
		self.v.present('fullscreen')
		self.v['mess'].text=text
		self.v.wait_modal()

	def okay(self,sender):
		self.v.close()


	def button_tapped(self,sender):
		print "called"

		self.response=sender.title
		print "xxx"+self.response
		self.v.close()

	def choose(self,prompt,fundic):
		ans=dialogs.list_dialog(prompt,fundic.keys())
		fundic[ans]()

