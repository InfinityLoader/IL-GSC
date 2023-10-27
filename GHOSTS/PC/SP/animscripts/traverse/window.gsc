/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\window.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 34 ms
 * Timestamp: 10/27/2023 1:23:08 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self.desired_anim_pose = "crouch";
	animscripts/utility::func_86CA();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self setflaggedanimknoballrestart("diveanim",%windowclimb,%body,1,0.1,1);
	self waittillmatch("gravity on","diveanim");
	self traversemode("gravity");
	animscripts/shared::func_2986("diveanim");
}