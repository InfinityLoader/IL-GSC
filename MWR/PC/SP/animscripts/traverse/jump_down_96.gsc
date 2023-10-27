/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\jump_down_96.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 45 ms
 * Timestamp: 10/27/2023 2:42:58 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "human")
	{
		jump_down_human();
		return;
	}

	if(self.type == "dog")
	{
		animscripts\traverse\shared::dog_jump_down(96,7);
	}
}

//Function Number: 2
jump_down_human()
{
	self.desired_anim_pose = "crouch";
	animscripts\utility::updateanimpose();
	self endon("killanimscript");
	self.a.movement = "walk";
	self.a.alertness = "alert";
	self traversemode("nogravity");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self setflaggedanimknoballrestart("stepanim",%jump_down_96,%body,1,0.1,1);
	self waittillmatch("gravity on","stepanim");
	self traversemode("gravity");
	animscripts\shared::donotetracks("stepanim");
	self.a.pose = "crouch";
}