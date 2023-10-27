/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\jump_over_high_wall.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 31 ms
 * Timestamp: 10/27/2023 2:17:22 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.desired_anim_pose = "crouch";
	animscripts/utility::func_247B();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self clearanim(%stand_and_crouch,0.1);
	self setflaggedanimknoballrestart("diveanim",%jump_over_high_wall,%body,1,0.1,1);
	self playsound("dive_wall");
	self waittillmatch("gravity on","diveanim");
	self traversemode("nogravity");
	self waittillmatch("noclip","diveanim");
	self traversemode("noclip");
	self waittillmatch("gravity on","diveanim");
	self traversemode("gravity");
	animscripts/shared::donotetracks("diveanim");
}