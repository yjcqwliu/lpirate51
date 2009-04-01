function chgunivright(){
WinBox.alert("1");
var time_select= document.getElementById("time_select").getValue();
WinBox.alert("2");
document.setLocation("http://www.baidu.com");
//document.setLocation('/xuanjianghui?location=' + '<%= @act_location %>' + '&keywords=' + '<%= @keywords %>' + '&time_select=' + time_select);
WinBox.alert("3");
}
function reply_message(xid,commit_id){
	document.getElementById('commit[reply_xid]').setValue(xid);
}
function f1()
{
WinBox.alert("haha");
}