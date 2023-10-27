/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\step_down.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 47 ms
 * Timestamp: 10/27/2023 2:29:33 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_3AFC(40,3);
		return;
	}

	step_down_human();
}

//Function Number: 2
step_down_human()
{
	self.desired_anim_pose = "crouch";
	animscripts/utility::updateanimpose();
	self endon("killanimscript");
	self.a.movement = "walk";
	self traversemode("nogravity");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self setflaggedanimknoballrestart("stepanim",%step_down_low_wall,%body,1,0.1,1);
	self waittillmatch("gravity on","stepanim");
	self traversemode("gravity");
	animscripts/shared::donotetracks("stepanim");
}