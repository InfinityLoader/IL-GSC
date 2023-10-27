/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\wall_dive.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 2:29:36 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.desired_anim_pose = "crouch";
	animscripts/utility::updateanimpose();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self setflaggedanimknoballrestart("diveanim",%jump_over_low_wall,%body,1,0.1,1);
	self playsound("dive_wall");
	self waittillmatch("gravity on","diveanim");
	self traversemode("gravity");
	animscripts/shared::donotetracks("diveanim");
	self.a.movement = "run";
}