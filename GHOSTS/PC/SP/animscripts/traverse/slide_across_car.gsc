/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\slide_across_car.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 60 ms
 * Timestamp: 10/27/2023 1:23:04 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(self.type == "dog")
	{
		func_75E3();
		return;
	}

	func_75E4();
}

//Function Number: 2
func_75E4()
{
	var_00 = [];
	var_00["traverseAnim"] = %slide_across_car;
	var_00["traverseToCoverAnim"] = %slide_across_car_2_cover;
	var_00["coverType"] = "Cover Crouch";
	var_00["traverseHeight"] = 38;
	var_00["interruptDeathAnim"][0] = animscripts/utility::func_ED8(%slide_across_car_death);
	var_00["traverseSound"] = "npc_car_slide_hood";
	var_00["traverseToCoverSound"] = "npc_car_slide_cover";
	animscripts/traverse/shared::func_2A1F(var_00);
}

//Function Number: 3
func_75E3()
{
	self endon("killanimscript");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self clearanim(%root,0.1);
	self setflaggedanimrestart("traverse",level.dogtraverseanims["jump_up_40"],1,0.1,1);
	animscripts/shared::func_2986("traverse");
	thread common_scripts\utility::func_5D1F("anml_dog_bark",self gettagorigin("tag_eye"));
	self clearanim(%root,0);
	self setflaggedanimrestart("traverse",level.dogtraverseanims["jump_down_40"],1,0,1);
	animscripts/shared::func_2986("traverse");
	self traversemode("gravity");
}