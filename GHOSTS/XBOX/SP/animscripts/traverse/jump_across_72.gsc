/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\jump_across_72.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 31 ms
 * Timestamp: 10/27/2023 1:35:49 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::dog_long_jump("wallhop",20);
		return;
	}

	self.desired_anim_pose = "stand";
	animscripts/utility::func_86CA();
	self endon("killanimscript");
	self method_820C("nogravity");
	self method_820C("noclip");
	var_00 = self getnegotiationstartnode();
	self method_820E("face angle",var_00.angles[1]);
	%body thread lib_006A::func_756D(1,0.1,1) method_8268();
	self waittillmatch("p_across_72","jumpanim");
	self method_820C("gravity on");
	lib_6772::func_6176("jumpanim");
}