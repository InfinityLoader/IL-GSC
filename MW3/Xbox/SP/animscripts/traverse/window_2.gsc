/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\window_2.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 44 ms
 * Timestamp: 10/27/2023 2:29:38 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_3AFB("wallhop",40);
		return;
	}

	func_3B01(%windowclimb,35);
}

//Function Number: 2
func_3B01(param_00,param_01)
{
	self.desired_anim_pose = "crouch";
	animscripts/utility::updateanimpose();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_02 = self getnegotiationstartnode();
	self orientmode("face angle",var_02.angles[1]);
	var_03 = var_02.var_1A98 - var_02.origin[2];
	self setflaggedanimknoballrestart("traverse",param_00,%body,1,0.15,1);
	wait 0.7;
	thread animscripts/traverse/shared::func_3AEB(var_03 - param_01);
	wait 0.9;
	self traversemode("gravity");
	animscripts/shared::donotetracks("traverse");
}