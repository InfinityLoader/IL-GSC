/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\fence_climb.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 31 ms
 * Timestamp: 10/27/2023 2:17:20 AM
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
	self setflaggedanimknoballrestart("diveanim",%fenceclimb,%body,1,0.1,1);
	animscripts/shared::donotetracks("diveanim");
	self traversemode("gravity");
}