/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\window_2.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 59 ms
 * Timestamp: 10/27/2023 2:17:32 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_3FF7("wallhop",40);
		return;
	}

	func_3FFD(%windowclimb,35);
}

//Function Number: 2
func_3FFD(param_00,param_01)
{
	self.desired_anim_pose = "crouch";
	animscripts/utility::func_247B();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_02 = self getnegotiationstartnode();
	self orientmode("face angle",var_02.angles[1]);
	var_03 = var_02.traverse_height - var_02.origin[2];
	self setflaggedanimknoballrestart("traverse",param_00,%body,1,0.15,1);
	wait 0.7;
	thread animscripts/traverse/shared::func_3FE7(var_03 - param_01);
	wait 0.9;
	self traversemode("gravity");
	animscripts/shared::donotetracks("traverse");
}