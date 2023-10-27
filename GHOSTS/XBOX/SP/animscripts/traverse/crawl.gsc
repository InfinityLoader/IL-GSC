/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\crawl.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 35 ms
 * Timestamp: 10/27/2023 1:34:30 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	animscripts/setposemovement::func_6201();
	animscripts/utility::func_86CA();
	self endon("killanimscript");
	self method_820C("noclip");
	var_00 = self getnegotiationstartnode();
	self method_820E("face angle",var_00.angles[1]);
	self method_8268("",undefined,%body,1,0.1,1);
	lib_6372::func_6177("prone_crawl");
	self.a.var_5486 = "lanim";
	self.a.var_60B1 = "crawlanim";
}