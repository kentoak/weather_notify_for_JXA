var app = Application.currentApplication()
app.includeStandardAdditions = true
var baseURL = '"https://weather.tsukumijima.net/api/forecast/city/'
var cityChoice = app.displayDialog("都市を選択", {withIcon:Path('/Users/kt/Downloads/kanako.icns'), buttons: ["Cancel", "Tokyo", "Sapporo"], cancelButton: 'Cancel', defaultButton:"Tokyo"}).buttonReturned
var city="130010"//都市コードはhttps://weather.tsukumijima.net/primary_area.xml を参照
if(cityChoice==="Tokyo"){
	city="130010"
}else if (cityChoice==="Sapporo"){
	city="016010"
}
var URL = baseURL + city + '"'
var ans = app.doShellScript('curl -s ' + URL)
var jsonData = JSON.parse(ans)
var describeToday = jsonData['forecasts'][0]['date'] + '：' + jsonData['forecasts'][0]['detail']['weather']+"\n"+'最高気温：' + jsonData['forecasts'][0]['temperature']['max']['celsius'] + '度，'+'最低気温：' + jsonData['forecasts'][0]['temperature']['min']['celsius'] + '度'//通常当日の最低気温は５～６時頃に出ることが多いため、当日の予報が発表されたときには、ちょうど外の気温が最低気温あたり（５時予報）、もしくは、すでに最低気温が記録された後（１１時、１７時予報）ということが多いので、今の気温、もしくは過去の気温では、予報になりません
var describeTomorrow = jsonData['forecasts'][1]['date'] + '：'+ jsonData['forecasts'][1]['detail']['weather']+"\n"+'最高気温：' + jsonData['forecasts'][1]['temperature']['max']['celsius'] + '度，'+'最低気温：' + jsonData['forecasts'][1]['temperature']['min']['celsius'] + '度'
app.displayNotification(describeToday+"\n\n"+describeTomorrow,{withTitle:'＜'+jsonData['location']['city'] + 'の天気＞'})
app.displayDialog('＜'+jsonData['location']['city'] + 'の天気＞\n'+describeToday+"\n\n"+describeTomorrow,{withIcon:Path("./Tenki_svg/"+JSON.stringify(jsonData['forecasts'][0]['image']['url']).substr(-8,3)+".png"),buttons: ["OK"],defaultButton:"OK"})

