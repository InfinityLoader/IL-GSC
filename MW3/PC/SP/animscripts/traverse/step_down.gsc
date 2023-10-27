/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\step_down.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 49 ms
 * Timestamp: 10/27/2023 2:17:27 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_3FF8(40,3);
		return;
	}

	func_3FFA();
}

//Function Number: 2
func_3FFA()
{
	self.desired_anim_pose = "crouch";
	animscripts/utility::func_247B();
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