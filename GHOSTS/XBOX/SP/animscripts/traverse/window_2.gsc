/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\window_2.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 38 ms
 * Timestamp: 10/27/2023 1:35:58 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_2933("wallhop",40);
		return;
	}

	%windowclimb;
}

//Function Number: 2
func_09BD(param_00,param_01)
{
	self.desired_anim_pose = "crouch";
	animscripts/utility::func_86CA();
	self endon("killanimscript");
	self method_820C("nogravity");
	self method_820C("noclip");
	var_02 = self getnegotiationstartnode();
	self method_820E("face angle",var_02.angles[1]);
	var_03 = var_02.var_82CB - var_02.origin[2];
	self method_8268(%body,1,0.15,1);
	wait(0.7);
	thread lib_7472::func_6176(var_03 - param_01);
	wait(0.9);
	self method_820C("erse");
	lib_0061::func_6E69("");
}