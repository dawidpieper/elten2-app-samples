load(Dirs.apps+"\\bopit\\testmode.rb")
=begin EltenAppInfo
  Name="bop_it"
  Author="bomberman29"
  Version="1.0"
=end EltenAppInfo
#program bop it, by deniz sincar
# declaring a class for our elten program and setting its values
class Program_bopit < Program
Beta=5
@@passit=0
    
@@boptime=0.0
@@stayscore=0
@@vol=100
  @@highscore=[0,0,0]
@@hsdir=Dirs.eltendata+"/high.score"
$hscdir=@@hsdir
# main function that starts just when you open the program.
@@level=0
@@ulevel=0
@@sounds=nil
@@clos=nil
juststarted=false
@@loaded=nil
def main
@@clos=escape
@@score=0
if readini(@@hsdir,"bopit","iknow")=="0"
    form = Form.new([
      edt_text = EditBox.new("welcome to bop it!", EditBox::Flags::ReadOnly | EditBox::Flags::MultiLine, readfile(appfile("readme.txt")), true),
      btn_close = Button.new(p_("Documentation", "Close"))
    ], 0, false, true)
    btn_close.on(:press) { form.resume
writeini(@@hsdir,"bopit","iknow","1")
Audio.se_play(appfile("sounds/youcanplaybopit.wav"))

delay(4)
}
    form.cancel_button = form.accept_button = btn_close
    form.wait

end

finsh if escape
maingame
finsh if @@clos
end
  def maingame(togo=0)

for i in 0..2
@@highscore[i]=readini(@@hsdir, "bopit", "hs"+i.to_s).to_i
#alert(@@highscore[i].to_s)
end
@@ulevel=0
for i in 0..2
@@highscore[i+3]=readini(@@hsdir, "passit", "hs"+i.to_s).to_i
#alert(@@highscore[i].to_s)
end

@@ulevel=1 if @@highscore[0]==100 or @@highscore[3]==100
@@ulevel=2 if @@highscore[1]==100 or @@highscore[4]==100

if @@sounds==nil
@@clos=false
  @@sounds=Hash.new
end

#making a variable passit with integral value. 0 meens solo, 1 meens pass it mode.
    @@topassitt=6
    @@speed=250 #speed in milliseconds. speed of beets.
#say "bop it to start!"

#load sounds

begin
soundishash=false
begin
soundishash=@@sounds["bopittostart.wav"]!=nil
rescue
end
thefiles=Dir.entries(appfile("sounds"))
thenumbers=Dir.entries(appfile("sounds/numbers"))
thefiles.each{|the|
@@sounds[the]=Bass::Sound.new(appfile("sounds/"+the)) if File.extname(the)==".wav" and the.length<20
}
thenumbers.each{|the|
@@sounds[the]=Bass::Sound.new(appfile("sounds/numbers/"+the)) if File.extname(the)==".wav" and the.length<20
}
fail("no sound length!", "contact developer!") if thenumbers.length==0
setvol(@@vol) if @@vol<1.0
rescue Exception=>e
alert("error loading sounds! "+e.class.name+"! "+e.message)
@@clos=true
return
end
@@loaded=true if @@loaded==nil 
finsh if @@clos
    pl("bopittostart.wav") if togo==0
pl("bopittogo.wav") if togo==1
    delay(0.3)
#making a loop and updating elten's events. without updating elten's events, you cannot get elten's notifications, and elten will be disconnected from server. so it must update in loop.
@@boptime=Time.now.to_f
    while !@@clos and Time.now.to_f-@@boptime<=20.0
      loop_update
return if @@clos
if $key[82]
@@boptime=Time.now.to_f
alert("reset")
tt=Time.now.to_f
btp=""
begin
while Time.now.to_f-tt<5.0
loop_update
btp+="b" if bop
btp+="t" if twist
btp+="p" if pull
break if escape
if btp=="pbttt"
sayscore(Beta)
t=Time.now.to_f
while Time.now.to_f-t<15.0
loop_update
if bop
pl("bopit2.wav")
t=Time.now.to_f
end
if pull
pl("poolit2.wav")
t=Time.now.to_f
end
if twist
pl("twistit2.wav")
t=Time.now.to_f
end
if escape
tt=nil
break
end
end
if tt!=nil
@@testmode=testmode
@@testmode.each{|i| pl(i+".wav",1)}
@@boptime=Time.now.to_f
break
end
end
end
rescue Exception
break
end
end

#if bop it button, space key, is pressed, start game. bop is a function that returns true if space is pressed
      if bop
        game
      end
      # pull is also a function that returns if tab key is pressed.
      # if pull it is pulled, toggle between pass it mode and solo mode.
      if pull
@@boptime=Time.now.to_f
        if @@passit==0
          @@passit=1
          pl("passit.wav")
else
          @@passit=0
          pl("solo.wav")
        end
        #pl is a function that plays sound.
      end
if twist
@@boptime=Time.now.to_f
if @@vol==100
@@vol=33
setvol(@@vol)
pl("quiet.wav")
elsif @@vol==33
@@vol=66
setvol(@@vol)
pl("loud.wav")
elsif @@vol=66
@@vol=100
setvol(@@vol)
pl("blasting.wav")
end



end


if levelbtn
@@boptime=Time.now.to_f
@@level+=1
@@level=0 if @@level>@@ulevel
pl("level"+@@level.to_s+".wav")
while twist
loop_update
end
end


      # if escape, then finsh the program.
      if escape
        @@clos=true
finsh
        return
      end

    end
@@clos=false
pl("amgoinasleep.wav",1)
finsh(1)

end
  # game function.
  def game
    #declaring variables.
    @@score=0
    @@speed=250    # speed in milliseconds.
@@topassit=0
sayscore(@@highscore[@@level],true) if @@passit==0
#playing beet
    beet(0)
    # it will do the game sequence 100 times. from 0 to 99
@@score=0
@@topassit=rand(4)+3
@@stayscore=0 if @@passit==0
    for i in (@@stayscore)..99
main if @@clos
#alert(i.to_s)

      loop_update()

if @@passit==1
if @@topassit<=0
beet(1)

@@topassit=rand(4)+3
end
end


@@speed=250-i
      # fact of that the bop it game starts with bop it, then twist it, then pull it, then random action is known. so let's do this
      # if the score number is 0 1 or 2, the number of the action is 0 1 or 2. otherwise, making a random number from 0 to 2, 0 meens bop it, 1 meens twist it, 2 meens pull it
      r=0
      r=i if i<=2
      r=rand(3) if i>2
rr=0
rr=1 if @@level==1
rr=rand(2) if @@level==2
@@topassit-=1 if @@passit==1
      pl("bopit"+rr.to_s+".wav") if r==0
      pl("twistit"+rr.to_s+".wav") if r==1
      pl("poolit"+rr.to_s+".wav") if r==2
      if !checkkey(r,@@speed)
@@score=i
@@stayscore=i if @@passit==1
        lose(@@score)
        return maingame(@@passit)
      end
      if @@speed==nil
        alert("error")
        @@clos=true
return

      end
      #@@speed=250-i if @@speed!=nil


      if escape
        delay(0.5)
        return if escape==false
      end
    end
@@stayscore=0
pl("win.wav",1)
pl("wow.wav",1) if @@level==2
pl("youbeet.wav",1)
pl("level"+@@level.to_s+".wav") if @@level<=1
pl("bopit0.wav") if @@level==2
@@ulevel+=1 if @@ulevel==@@level and @@ulevel<2
@@highscore[@@level]=100
if @@passit==0
writeini(@@hsdir,"bopit","hs"+@@level.to_s,"100")
else
writeini(@@hsdir,"passit","hs"+@@level.to_s,"100")
end

@@level=@@ulevel
return maingame(1) if @@level<2
  end
  def checkkey(thekey,thespeed)
beett=0
    checktime=Time.now.to_f
    thespeed=thespeed/1000.to_f
    while Time.now.to_f-checktime<thespeed*5
return if @@clos
      loop_update
      if thekey==0
        if bop
          pl("bopit2.wav") 
          littlebit(@@speed)
          return true
        end
        return false if pull or twist
      end
      if thekey==2
        if pull
          pl("poolit2.wav") 
          littlebit(@@speed)
          return true
        end
        return false if bop or twist
      end
      if thekey==1
        if twist
          pl("twistit2.wav") 
          littlebit(@@speed)
          return true
        end
        return false if pull or bop
      end
return main if escape



      if Time.now.to_f-checktime>=thespeed*2 and Time.now.to_f-checktime<=thespeed*2.3 and beett==0
pl("beets21.wav") 
beett=1
end
      if Time.now.to_f-checktime>=thespeed*3.0 and Time.now.to_f-checktime<=thespeed*3.3 and beett==1
pl("beetw.wav") 
beett=2
end

    end
return false
  end
def littlebit(spd)
return  if @@clos
spd=spd/1000.to_f
if @@speed==nil
alert("error")
@@clos=true
return

end
delay(spd*2.0)
pl("beets21.wav")
delay((spd))
pl("beetw.wav")
delay((spd))
return if @@clos
end

  def lose(scor)
return  if @@clos or escape
if scor>@@highscore[@@level]
@@highscore[@@level]=scor
if @@passit==0
writeini(@@hsdir,"bopit","hs"+@@level.to_s,scor.to_s)
else
writeini(@@hsdir,"passit","hs"+@@level.to_s,scor.to_s)
end
end
pl("yaw"+rand(4).to_s+".wav",1)
pl("lose"+rand(5).to_s+".wav",1)
if @@passit==0
sayscore(scor)
else
pl("yourout.wav")
end
return
end
  def beet(topass=0)
return if @@clos
if topass==1
pl("passit.wav")
if checkesc(@@speed*2)
finsh
return
end
for ii in 1..6
pl("pass"+ii.to_s+".wav")
if checkesc(@@speed)
finsh
return
end
end

end
    pl("beets1"+rand(4).to_s+".wav")
    if checkesc(@@speed)
      finsh
      return main
    end
    pl("beetw.wav")
    if checkesc(@@speed)
      finsh
      return main
    end
    pl("beets2"+rand(2).to_s+".wav")
    if checkesc(@@speed)
      finsh
      return main
    end
    pl("beets10.wav")
    if checkesc(@@speed)
      finsh
      return main
    end
    pl("beets1"+rand(3).to_s+".wav")
    if checkesc(@@speed)
      finsh
      return main
    end
    pl("beetw.wav")
    if checkesc(@@speed)
      finsh
      return main
    end
    pl("beets20.wav")
    if checkesc(@@speed)
      finsh
      return main
    end
    pl("beetw.wav")
    if checkesc(@@speed*0.9)
      finsh
      return main
    end
  end
  def checkesc(vall)
main if @@clos
vall=vall/1000.to_f
    thechecktime=Time.now.to_f
    while Time.now.to_f-thechecktime<vall-0.02
sleep(0.005)
#return if @@clos
      return true if escape
    end
    return false
  end
def setvol(thevol)
@@sounds.values.each{|i| i.volume=1.0*thevol.to_f/100.0}
end


def levelbtn
getkeychar=="m"
end
def bop
space
end
def twist
enter
end
def pull
$key[0x9]
end
def finsh(goinasleep=0)
alert("thanks for playing bop it!") if $scene.class.name=="Program_bopit" and goinasleep==0
close
#input_text("scen",0,$scene.class.name)
$scene=Scene_Main.new
#input_text("scen",0,$scene.class.name)

end

  def pl(soundname, wayt=0, wvalue=0)
    return if @@clos
    if @@sounds[soundname].is_a?(Bass::Sound)
      begin
        @@sounds[soundname].play
        if wayt==1
          while @@sounds[soundname].position<@@sounds[soundname].length+wvalue
          delay(0.05)

        end
        end
      rescue Exception=>e
        bt=""
        e.backtrace.each{|bta|bt+=bta+"\r\n"}
        input_text("error playing sound "+soundname+"! "+e.class.name+"! "+e.message, EditBox::Flags::ReadOnly|EditBox::Flags::MultiLine, bt)
finsh
      end
else
alert("error! the sound "+soundname+" is not playing! don't know why!")
    end
  end

  def pn(soundname, wvalue=0)
    return if @@clos
soundname=soundname+".wav"
    if @@sounds[soundname].is_a?(Bass::Sound)
      begin
        @@sounds[soundname].play
        wayt=1
        if wayt==1
          while @@sounds[soundname].position<@@sounds[soundname].length+wvalue
          delay(0.05)

        end
        end
      rescue Exception=>e
        bt=""
        e.backtrace.each{|bta|bt+=bta+"\r\n"}
        input_text("error playing sound "+soundname+"! "+e.class.name+"! "+e.message, EditBox::Flags::ReadOnly|EditBox::Flags::MultiLine, bt)
finsh
      end
else
alert("error! the sound is not playing! this is an incorrect soundname! "+soundname)
    end
  end



  def close
#@@clos=true
if @@sounds!=nil
begin
@@sounds.values.each{|thet|
thet.close}
thet=nil
rescue
end
end

$scene=Scene_Main.new if $scene=Program_bopit
  end
def sayscore(score, high=false, ss=true)
return if score==0
pl("high.wav",1) if high
pl("score.wav",1) if ss
pn(score.to_s) if score<=12
pn("twen") if score.between?(20,29)

pn("thir") if score==13 or score.between?(30,39)
pn("fif") if score==15 or score.between?(50,59)

if score>13 and score<=19 and score!=15
pn((score-10).to_s)
end
if score.between?(13,19)
pn("teen")
end

if score.between?(40,49) or score.between?(60,99)
pn((score/10).to_s)
end
if score.between?(20,99)
pn("tee")
pn((score%10).to_s) if score%10>0
end
if score==100
pn("1")
pn("hundred")
end

end
end
def bopitreset
return "ok! i don't reset!" if confirm("do you really really want to reset your bop it high scores?")==0
writefile($hscdir, "[bopit]
hs0=0
hs1=0
hs2=0
iknow=0")
return "your bop it high score reset!"
end
def bopithelp
    form = Form.new([
      edt_text = EditBox.new("welcome to bop it!", EditBox::Flags::ReadOnly | EditBox::Flags::MultiLine, readfile(Program_bopit::appfile("readme.txt")), true),
      btn_close = Button.new(p_("Documentation", "Close"))
    ], 0, false, true)
    btn_close.on(:press) { form.resume
Audio.se_play(Program_bopit::appfile("sounds/youcanplaybopit.wav"))
delay(4)
}
    form.cancel_button = form.accept_button = btn_close
    form.wait

end
