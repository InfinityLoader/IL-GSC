/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\window_2.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 50 ms
 * Timestamp: 10/27/2023 1:23:08 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_2933("wallhop",40);
		return;
	}

	func_09BD(%windowclimb,35);
}

//Function Number: 2
func_09BD(param_00,param_01)
{
	self.desired_anim_pose = "crouch";
	animscripts/utility::func_86CA();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_02 = self getnegotiationstartnode();
	self orientmode("face angle",var_02.angles[1]);
	var_03 = var_02.var_82CB - var_02.origin[2];
	self setflaggedanimknoballrestart("traverse",param_00,%body,1,0.15,1);
	wait(0.7);
	thread animscripts/traverse/shared::func_8022(var_03 - param_01);
	wait(0.9);
	self traversemode("gravity");
	animscripts/shared::func_2986("traverse");
}