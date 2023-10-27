/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_mgturret_auto_nonai.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 63 ms
 * Timestamp: 10/27/2023 2:48:22 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01)
{
	thread set_up_auto_non_ai_turret(self,param_00,param_01);
}

//Function Number: 2
stop_turret_on_gunner_death(param_00,param_01,param_02)
{
	param_01 waittill("death");
	if(!isdefined(param_00))
	{
		return;
	}

	if(isremovedentity(param_00))
	{
		return;
	}

	param_00 setmode("manual");
	param_00 cleartargetentity();
	param_00 stopfiring();
}

//Function Number: 3
keep_gunner_oriented_with_turret(param_00,param_01)
{
	param_01 endon("death");
	for(;;)
	{
		var_02 = param_00 gettagangles("tag_aim_pivot");
		param_01 orientmode("face angle",var_02[1]);
		wait(0.05);
	}
}

//Function Number: 4
set_up_auto_non_ai_turret(param_00,param_01,param_02)
{
	param_01 endon("death");
	param_00 endon("death");
	param_00 setmode("auto_nonai");
	param_01 linkto(param_00,param_02.sittag,(0,0,0),(0,0,0));
	thread stop_turret_on_gunner_death(param_00,param_01,param_02);
	thread keep_gunner_oriented_with_turret(param_00,param_01);
	var_03 = param_00 gettagorigin(param_02.sittag);
	var_04 = param_00 gettagangles(param_02.sittag);
	param_00 maps\_vehicle_aianim::animontag(param_01,param_02.sittag,param_02.idle);
}