/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\jump_across_72.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 32 ms
 * Timestamp: 10/27/2023 2:29:28 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_8116("wallhop",20);
		return;
	}

	self.desired_anim_pose = "stand";
	animscripts/utility::updateanimpose();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self setflaggedanimknoballrestart("jumpanim",%jump_across_72,%body,1,0.1,1);
	self waittillmatch("gravity on","jumpanim");
	self traversemode("gravity");
	animscripts/shared::donotetracks("jumpanim");
}