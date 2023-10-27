/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\jump_up_80.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 29 ms
 * Timestamp: 10/27/2023 1:22:59 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	var_01 = var_00.var_82CB - var_00.origin[2];
	thread animscripts/traverse/shared::func_8022(var_01 - 80);
	self clearanim(%root,0.2);
	self setflaggedanimrestart("jump_up_80",level.dogtraverseanims["jump_up_80"],1,0.2,1);
	animscripts/shared::func_2986("jump_up_80");
}