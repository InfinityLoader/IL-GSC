/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\jump_down_56.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 2:42:58 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.desired_anim_pose = "crouch";
	animscripts\utility::updateanimpose();
	self endon("killanimscript");
	self.a.movement = "walk";
	self.a.alertness = "alert";
	self traversemode("nogravity");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self setflaggedanimknoballrestart("stepanim",%jump_down_56,%body,1,0.1,1);
	self waittillmatch("gravity on","stepanim");
	self traversemode("gravity");
	animscripts\shared::donotetracks("stepanim");
	self setanimknoballrestart(%crouch_fastwalk_f,%body,1,0.1,1);
}