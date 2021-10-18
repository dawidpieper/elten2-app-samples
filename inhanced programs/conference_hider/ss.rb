=begin EltenAppInfo
Name="conference_hider"
Author="bomberman29"
Version="1.0"
=end EltenAppInfo
class Program_confhider < Program
@ch=0
def main
if !Conference.opened?
alert("first create a conference before hiding it!")
finish
return
end

if Conference.channel.public
tocrpass=0
tocrpass=confirm("your conference is not passworded! do you want to add a strong password to your conference?") if Conference.channel.password==nil
hideconf(tocrpass)
else
unhideconf
end
delay(1)
finish
end
end
def hideconf(strongpassword=0, alerting=1)
conferencpass=Conference.channel.password
conferencpass=rand(1000000000).to_s if strongpassword==1
Conference.edit(Conference.channel.id, Conference.channel.name, false, Conference.channel.bitrate, Conference.channel.framesize, Conference.channel.vbr_type, Conference.channel.codec_application, Conference.channel.prediction_disabled, Conference.channel.fec, conferencpass, Conference.channel.spatialization, Conference.channel.channels, Conference.channel.lang, Conference.channel.width, Conference.channel.height, Conference.channel.key_len, Conference.channel.waiting_type, Conference.channel.permanent, Conference.channel.motd, Conference.channel.allow_guests)
#alert("your id of the conference has been copied. send it to the conference joiner if you want to invite him.")
alert("conference hidden! you can invite a user just by invite function.") if alerting==1
$hidconfid=Conference.channel.id
$hidconfpass=Conference.channel.password

end
def unhideconf(alerting=1)
Conference.edit(Conference.channel.id, Conference.channel.name, true, Conference.channel.bitrate, Conference.channel.framesize, Conference.channel.vbr_type, Conference.channel.codec_application, Conference.channel.prediction_disabled, Conference.channel.fec, Conference.channel.password, Conference.channel.spatialization, Conference.channel.channels, Conference.channel.lang, Conference.channel.width, Conference.channel.height, Conference.channel.key_len, Conference.channel.waiting_type, Conference.channel.permanent, Conference.channel.motd, Conference.channel.allow_guests)
#alert("your id of the conference has been copied. send it to the conference joiner if you want to invite him.")
alert("conference is no longer hidden! all people can find your room in the conference list") if alerting==1
$hidconfid=nil
$hidconfpass=nil
end
