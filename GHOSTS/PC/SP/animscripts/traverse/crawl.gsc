/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\crawl.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 1:22:53 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	animscripts/setposemovement::func_6201();
	animscripts/utility::func_86CA();
	self endon("killanimscript");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self setflaggedanimknoballrestart("crawlanim",%prone_crawl,%body,1,0.1,1);
	animscripts/shared::func_2986("crawlanim");
	self.a.var_5486 = "run";
	self.a.var_60B1 = "crouch";
}