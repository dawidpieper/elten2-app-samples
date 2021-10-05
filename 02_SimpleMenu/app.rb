=begin EltenAppInfo
Name=smp02simplemenu
Version=1.0
Author=pajper
=end EltenAppInfo

class Program_SMP02SimpleMenu < Program
  def main
    menu = Menu.new
    menu.option("Say hello to me") {
      alert("Hello!")
    }
    menu.option("Say bye to me") {
      alert("Bye!")
      finish
    }
    menu.show
  end
end
