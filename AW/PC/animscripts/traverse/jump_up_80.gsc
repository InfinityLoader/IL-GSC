/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\jump_up_80.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 27 ms
 * Timestamp: 4/22/2024 1:59:26 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	var_01 = var_00.traverse_height - var_00.origin[2];
	thread animscripts\traverse\shared::teleportthread(var_01 - 80);
	self clearanim(%animscript_root,0.2);
	self setflaggedanimrestart("jump_up_80",level.dogtraverseanims["jump_up_80"],1,0.2,1);
	animscripts\shared::donotetracks("jump_up_80");
}