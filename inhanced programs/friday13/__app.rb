=begin EltenAppInfo
Author=bomberman29frompajper
Version=1.0
Name=friday_the_15th_searcher
=end EltenAppInfo
class ProgramFriday13 < Program
#function to return all months containing friday the 13ths. return value is an array

def friday13ret(year)
rval=[] #the return value array
for month in 1..12
#if this function errors, alert the user
begin
 ti = Time.local(year, month, 13)
rescue ArgumentError
alert("you entered wrong range of years. the year "+year.to_s+" is not available")
finish
return
end
 rval.push(month) if ti.wday == 5
end
return rval
end
#main function
def main
compairval=[0,2000]
w=""
#this is a little array to show when the friday 13th was the most times
startyear=input_text("enter the starting year from which to search",EditBox::Flags::Numbers,"2000").to_i
endyear=input_text("enter the ending year till which to search",EditBox::Flags::Numbers,"2030").to_i
if startyear>endyear
# alerting the stupid user to enter correct starting and ending year, because he entered so the starting year is >= then ending year.
alert("not valid numbers entered!")
finish
return
end
for year in startyear..endyear
#why the time local works till year 2038? i wanted to check till year 2050!
#saving an array of friday13s in the current year in this loop iteration
arr=friday13ret(year)
w+="in "+year.to_s+", friday the thirteenth "
if year<Time.now.year
w+="was in "
elsif year>Time.now.year
w+="will be in "
else
w+="is in "
end
#saving the english names of months in the output string to show in a text field
for i in arr
months=["nothing","january","february","march","april","may","june","july","august","september","october","november","december"]
#the first or zero element is "nothing" because the indexing of month in Time object is from 1 to 12, not from 0 to 11
#adding the english name of a month in the output string with the name w, and adding a comma at the end of every month
w+=months[i].to_s+", " if i!=nil
end
w+="\r\n" #this ads new line in the string
#this counts the highest numbers of friday13s in the compairval array, and the year when it happened
if arr.size>compairval[0]
compairval=[arr.size,year]
end
end
w+="and the hellest year is "+compairval[1].to_s+", it has "+compairval[0].to_s+" friday13s."
input_text("the statistic of friday13",EditBox::Flags::MultiLine|EditBox::Flags::ReadOnly,w)
finish
end
end