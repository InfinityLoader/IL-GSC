/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\duck_under_56.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 27 ms
 * Timestamp: 4/22/2024 1:59:16 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.desired_anim_pose = "stand";
	animscripts\utility::updateanimpose();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self setflaggedanimknoballrestart("jumpanim",%gulag_pipe_traverse,%body,1,0.1,1);
	self waittillmatch("finish","jumpanim");
	self traversemode("gravity");
	animscripts\shared::donotetracks("jumpanim");
}