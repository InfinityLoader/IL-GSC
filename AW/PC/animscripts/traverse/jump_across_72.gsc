/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\jump_across_72.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 36 ms
 * Timestamp: 4/22/2024 1:59:26 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts\traverse\shared::dog_long_jump("wallhop",20);
		return;
	}

	self.desired_anim_pose = "stand";
	animscripts\utility::updateanimpose();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self setflaggedanimknoballrestart("jumpanim",%jump_across_72,%body,1,0.1,1);
	self waittillmatch("gravity on","jumpanim");
	self traversemode("gravity");
	animscripts\shared::donotetracks("jumpanim");
}