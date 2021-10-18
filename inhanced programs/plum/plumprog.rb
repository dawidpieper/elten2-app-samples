$plumhash={
0=>100,
1=>106,
2=>111,
3=>119,
4=>125,
5=>134,
6=>141,
7=>150,
8=>160,
9=>167,
10=>175,
11=>187,
12=>200,
-1=>95,
-2=>90,
-3=>85,
-4=>80,
-5=>75,
-6=>71,
-7=>66,
-8=>64,
-9=>60,
-10=>57,
-11=>53,
-12=>50}


class Program_plum < Program
	Name="plum"
	Author="bomberman29"
	Version="1.0"
def self.init
$theplumfile=Program_plum::appfile("plum.ogg")
$plumbas=Sound.new($theplumfile)
end
	def main
	@form=Form.new([
	playbtn=Button.new("play"),
	loadbtn=Button.new("load"),
	opnbtn=Button.new("open folder with melodies"),
	closbtn=Button.new("close!")])
	playbtn.on(:press){plummelody}
	loadbtn.on(:press){plumload}
	opnbtn.on(:press){executeprocess("explorer "+appfile("melodies"))}
	closbtn.on(:press){@form.resume
	finish}


@form.wait
	finish
	end

end
def plummelody
if !FileTest.exists?($theplumfile)
sound=getsound("feed_update")
writefile($theplumfile, sound)
end
$plumbas=Sound.new($theplumfile) if $plumbas==nil
$plummel=run(readfile(Program_plum::appfile("melodies/default.rbna"))) if !$plummel.is_a?(Array)
$plummel.each{|i| plumm(i[0],i[1])}
$plumbas.free
$plumbas=nil
end
def plumm(frq=100, lengh=500)
numtrys=0
begin
loop_update
numtrys+=1
if $plumbas==nil
$theplumfile=Program_plum::appfile("plum.ogg") if $theplumfile==nil
if !FileTest.exists?($theplumfile)
sound=getsound("feed_update")
writefile($theplumfile, sound)
end
$plumbas=Sound.new($theplumfile) if $plumbas!=nil
end
rescue Exception
$plumbas=Sound.new($theplumfile)
numtrys+=1
if numtrys<5
loop_update
plum
delay(0.5)
retry
end
end
begin
frq=($plumhash[frq])
frq=44100.0/100.0*frq.to_f
$plumbas.frequency=frq
$plumbas.position=0
$plumbas.play
delay(lengh/1000.0)
$plumbas.stop
rescue Exception=>e
alert("what is that! why you passed not a ruby array!"+e.class.name+"! "+e.message)
end
end
def plumload(getf="", playpl=false)
oldplummel=$plummel
getf=getfile("what to load",Program_plum::appfile("melodies"),false,nil,[".rbna"]) if getf==""
begin
$plummel=run(readfile(getf))
rescue Exception=>e
$plummel=oldplummel
playpl=false
return "error loading! "+e.class.name+"! "+e.message
end
if !$plummel.is_a?(Array)
$plummel=oldplummel
return "no! impossible format"
end
plummelody if playpl
end