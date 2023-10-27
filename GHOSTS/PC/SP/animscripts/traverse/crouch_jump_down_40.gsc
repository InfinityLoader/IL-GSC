/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\crouch_jump_down_40.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 32 ms
 * Timestamp: 10/27/2023 1:22:54 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self.desired_anim_pose = "crouch";
	animscripts/utility::func_86CA();
	self endon("killanimscript");
	self.a.var_5486 = "walk";
	self traversemode("nogravity");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self setflaggedanimknoballrestart("stepanim",%jump_across_72,%body,1,0.1,1);
	wait(0.15);
	self traversemode("gravity");
	animscripts/shared::func_2986("stepanim");
}