/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\jump_across_72.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 41 ms
 * Timestamp: 10/27/2023 2:42:57 AM
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