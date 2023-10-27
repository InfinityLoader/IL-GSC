/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\duck_under_56.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 1:22:54 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self.desired_anim_pose = "stand";
	animscripts/utility::func_86CA();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self setflaggedanimknoballrestart("jumpanim",%gulag_pipe_traverse,%body,1,0.1,1);
	self waittillmatch("finish","jumpanim");
	self traversemode("gravity");
	animscripts/shared::func_2986("jumpanim");
}