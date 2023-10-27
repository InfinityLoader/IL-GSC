/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\slide_across_car.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 78 ms
 * Timestamp: 10/27/2023 2:43:08 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		slide_across_car_dog();
		return;
	}

	slide_across_car_human();
}

//Function Number: 2
slide_across_car_human()
{
	var_00 = [];
	var_00["traverseAnim"] = %slide_across_car;
	var_00["traverseToCoverAnim"] = %slide_across_car_2_cover;
	var_00["coverType"] = "Cover Crouch";
	var_00["traverseHeight"] = 38;
	var_00["interruptDeathAnim"][0] = animscripts\utility::array(%slide_across_car_death);
	var_00["traverseSound"] = "npc_car_slide_hood";
	var_00["traverseToCoverSound"] = "npc_car_slide_cover";
	animscripts\traverse\shared::dotraverse(var_00);
}

//Function Number: 3
slide_across_car_dog()
{
	self endon("killanimscript");
	self traversemode("noclip");
	var_00 = self getnegotiationstartnode();
	self orientmode("face angle",var_00.angles[1]);
	self clearanim(%animscript_root,0.1);
	self setflaggedanimrestart("traverse",level.dogtraverseanims["jump_up_40"],1,0.1,1);
	animscripts\shared::donotetracks("traverse");
	thread common_scripts\utility::play_sound_in_space("anml_dog_bark",self gettagorigin("tag_eye"));
	self clearanim(%animscript_root,0);
	self setflaggedanimrestart("traverse",level.dogtraverseanims["jump_down_40"],1,0,1);
	animscripts\shared::donotetracks("traverse");
	self traversemode("gravity");
}