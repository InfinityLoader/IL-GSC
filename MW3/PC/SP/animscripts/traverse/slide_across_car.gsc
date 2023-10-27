/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\slide_across_car.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 63 ms
 * Timestamp: 10/27/2023 2:17:26 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		func_4005();
		return;
	}

	func_4004();
}

//Function Number: 2
func_4004()
{
	var_00 = [];
	var_1C["interruptDeathAnim"] = 0;
	animscripts/traverse/shared::func_3FEB(var_1C);
}

//Function Number: 3
func_4005()
{
	self endon("killanimscript");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self clearanim(%root,0.1);
	self setflaggedanimrestart("traverse",level.var_3AF6["jump_up_40"],1,0.1,1);
	animscripts/shared::donotetracks("traverse");
	thread common_scripts\utility::play_sound_in_space("anml_dog_bark",self gettagorigin("tag_eye"));
	self clearanim(%root,0);
	self setflaggedanimrestart("traverse",level.var_3AF6["jump_down_40"],1,0,1);
	animscripts/shared::donotetracks("traverse");
	self traversemode("gravity");
	self.var_3B58 = 1;
}