/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\jump_across_72.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 28 ms
 * Timestamp: 10/27/2023 2:17:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_176("wallhop",20);
		return;
	}

	self.desired_anim_pose = "stand";
	animscripts/utility::func_247B();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self setflaggedanimknoballrestart("jumpanim",%jump_across_72,%body,1,0.1,1);
	self waittillmatch("gravity on","jumpanim");
	self traversemode("gravity");
	animscripts/shared::donotetracks("jumpanim");
}