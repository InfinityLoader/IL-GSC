/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\trench_jumpout.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 2:29:35 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.desired_anim_pose = "crouch";
	animscripts/utility::updateanimpose();
	self endon("killanimscript");
	self.a.movement = "walk";
	self traversemode("nogravity");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self setflaggedanimknoballrestart("stepanim",%gully_trenchjump,%body,1,0.1,1);
	self waittillmatch("gravity on","stepanim");
	self traversemode("gravity");
	animscripts/shared::donotetracks("stepanim");
	self setanimknoballrestart(animscripts/run::getcrouchrunanim(),%body,1,0.1,1);
}