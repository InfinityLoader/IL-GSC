/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\crouch_jump_down_40.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 33 ms
 * Timestamp: 10/27/2023 2:42:41 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.desired_anim_pose = "crouch";
	animscripts\utility::updateanimpose();
	self endon("killanimscript");
	self.a.movement = "walk";
	self traversemode("nogravity");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self setflaggedanimknoballrestart("stepanim",%jump_across_72,%body,1,0.1,1);
	wait(0.15);
	self traversemode("gravity");
	animscripts\shared::donotetracks("stepanim");
}