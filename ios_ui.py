import ui
import dialogs
import sys
import os

class Ios_ui():
	def __init__(self):
			self.v=ui.NavigationView(ui.View())
			self.v.present('fullscreen')

	def ask(self, question):
		self.questionview=ui.load_view('ask')
		self.v.push_view(self.questionview, False)

		self.questionview['top'].text=question
		self.questionview.wait_modal()
		if self.response =="Yes":
			return True
		else:
			return False

	def do(self, task,  detail_method):
		if detail_method==None:
			self.questionview=ui.load_view('do')
		else:
			self.questionview=ui.load_view('doex')
		self.v.push_view(self.questionview, False)
		self.questionview['top'].text=task+"\nIs this complete?"
		self.questionview.wait_modal()
		if self.response =="Done":
			return 'd'
		elif self.response=="Problem":
			return "p"
		elif self.response=="Expand":
			print "hellosndjf"
			return 'e'



	def tell(self, text):
		self.tellview=ui.load_view('tell')
		self.v.push_view(self.tellview,False)
		self.tellview['mess'].text=text
		self.tellview.wait_modal()

	def okay(self,sender):
		self.v.pop_view(False)

	def button_tapped(self,sender):
		print "called"

		self.response=sender.title
		print "xxx"+self.response
		self.v.pop_view(False)

	def exit(self,sender):
		self.v.close()
		sys.exit()

	def choose(self,prompt,fundic):
		ans=dialogs.list_dialog(prompt,fundic.keys())
		fundic[ans]()





if __name__ == "__main__":
    import workflow
    gui=Ios_ui()
    location = os.path.dirname(os.path.abspath(__file__))+'/log_files/ml_log_phone.md'
    workflow.main(gui,location)
