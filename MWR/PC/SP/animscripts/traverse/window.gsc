/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\window.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 39 ms
 * Timestamp: 10/27/2023 2:43:19 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.desired_anim_pose = "crouch";
	animscripts\utility::updateanimpose();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self setflaggedanimknoballrestart("diveanim",%windowclimb,%body,1,0.1,1);
	self waittillmatch("gravity on","diveanim");
	self traversemode("gravity");
	animscripts\shared::donotetracks("diveanim");
}