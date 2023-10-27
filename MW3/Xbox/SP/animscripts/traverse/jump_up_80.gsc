/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\jump_up_80.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 2:29:29 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	var_01 = var_00.var_1A98 - var_00.origin[2];
	thread animscripts/traverse/shared::func_3AEB(var_01 - 80);
	self clearanim(%root,0.2);
	self setflaggedanimrestart("jump_up_80",level.dogtraverseanims["jump_up_80"],1,0.2,1);
	animscripts/shared::donotetracks("jump_up_80");
	self.var_3682 = 1;
}