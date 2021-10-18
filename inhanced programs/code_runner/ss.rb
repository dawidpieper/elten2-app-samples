class Program_runner < Program
  Name="code_runner"
  Author="bomberman29"
  Version="1.0"
  AppID=156196659
  CTR=appfile("codes.txt")
  @ch=0
  def self.init
    runcode(readfile(CTR),1)
  end
  def main
    helpdoc if readini(appfile("__app.ini"),"doc","iknow")!="1"
    index=0
    #@o=OnlineDB.new(AppID,:public,"hideconf")
    nt = srvproc("notes", { "get" => "1" })
    if nt[0].to_i < 0
      alert(_("Error"))
      finish
      return
    end
whaterror 
    t = 0
    @notes = []
    d = 0
    for i in 2..nt.size - 1
      case t
      when 0
        @notes[d] = Struct_Note.new(nt[i].to_i)
        t += 1
      when 1
        @notes[d].name = nt[i].delete("\r\n")
        t += 1
      when 2
        @notes[d].author = nt[i].delete("\r\n")
        t += 1
      when 3
        @notes[d].created = Time.at(nt[i].delete("\r\n").to_i)
        t += 1
      when 4
        @notes[d].modified = Time.at(nt[i].delete("\r\n").to_i)
        t += 1
      when 5
        if nt[i].delete("\r\n") == "\004END\004"
          t = 0
          d += 1
        else
          @notes[d].text += nt[i]
        end
      end
    end
    selt = []
    for n in @notes
      selt.push(n.name + "\r\n#{p_("Notes", "Author")}: " + n.author + "\r\n#{p_("Notes", "Modified")}: " + format_date(n.modified, false, false))
    end
alert("choose your code note")
    @sel = ListBox.new(selt, p_("Notes", "Notes"), index)
    @sel.add_tip("press alt to open context menu, open help section in context menu to get help")
    @sel.bind_context { |menu| context(menu) }
    loop do
      loop_update
      @sel.update
      if escape
        finish
        return
      end
      if enter and @notes.size > 0
        runcode(@notes[@sel.index].text)
        @sel.focus if @refresh != true
      end
      if @refresh == true
        @refresh = false
        main(@sel.index)
        return
      end
      break if $scene != self
    end


  end
def helpdoc
input_text("welcome to code runner",EditBox::Flags::ReadOnly|EditBox::Flags::MultiLine,readfile(appfile("readme.txt")))
writeini(appfile("__app.ini"),"doc","iknow","1")
end
  def context(menu)
    menu.option("run from clipboard"){runcode(Clipboard.data)
    return}
    menu.option("run some code on elten startup"){
      c=input_text("enter a code to execute on elten startup",EditBox::Flags::MultiLine,readfile(CTR))
alert("checking for errors!")
      cc=runcode(c)
      if cc!=""
        File.delete(CTR)
        writefile(CTR,c)
        alert("ok, this code will be executed on elten start up. it has no errors")
      end
    }
    if $crexcs!=nil
      menu.option("what is my error?"){whaterror}
    end
    menu.option("help"){helpdoc}
  end
end

def runcode(cod, ex=0)
  concode=""
  begin
    #input_text("cod",EditBox::Flags::ReadOnly|EditBox::Flags::MultiLine,cod)
    con=Console.new
    concode=con.run(cod)
  rescue Exception
    if ex==0
      input_text("error",EditBox::Flags::ReadOnly|EditBox::Flags::MultiLine,$!.to_s+"! "+$@.to_s)
    else
      $crexcs="error in program code runner, in start up settings:\r\n"+$!.to_s+"\r\n"+$@.to_s
      #speak("error in code runner!")
    end
  end
  return concode.inspect
end
def whaterror
  return if $crexcs==nil
  input_text("code runner error",EditBox::Flags::MultiLine|EditBox::Flags::ReadOnly,$crexcs)
  $crexcs=nil
end
