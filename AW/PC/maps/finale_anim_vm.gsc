/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: finale_anim_vm.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 115 ms
 * Timestamp: 4/22/2024 2:28:56 AM
*******************************************************************/

//Function Number: 1
anim_single_solo_vm(param_00,param_01,param_02)
{
	param_00 notify("kill_duplicate_anim_single_solo_vm");
	param_00 endon("kill_duplicate_anim_single_solo_vm");
	param_00 endon("die");
	if(!isdefined(param_02))
	{
		param_02 = "stop_nonloop";
	}

	if(!assert_existance_of_anim_vm(param_01))
	{
		return;
	}

	var_03 = getanimlength(param_00 getanim_vm(param_01)) - 0.05;
	var_04 = gettime() + var_03 * 1000;
	thread anim_single_solo_internal_vm(param_00,param_01,param_02);
	param_00 common_scripts\utility::waittill_any_timeout(var_03,param_02);
	if(gettime() < var_04 - 50)
	{
		param_00 setviewmodelanimtime(1);
	}
}

//Function Number: 2
anim_single_solo_internal_vm(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = "stop_nonloop";
	}

	param_00 endon("kill_duplicate_anim_single_solo_vm");
	param_00 endon(param_02);
	var_03 = getanimlength(param_00 getanim_vm(param_01));
	param_00 setviewmodelanim(getanim_vm_index(param_01));
	wait(var_03 - 0.05);
}

//Function Number: 3
anim_loop_solo_vm(param_00,param_01,param_02,param_03)
{
	param_00 notify("kill_duplicate_anim_loop_solo_vm");
	param_00 endon("kill_duplicate_anim_loop_solo_vm");
	if(!isdefined(param_02))
	{
		param_02 = "stop_loop";
	}

	if(!assert_existance_of_anim_vm(param_01))
	{
		return;
	}

	thread hack_fake_loop_because_you_cant_play_looping_vm_anims(param_00,param_01,param_02);
	for(;;)
	{
		if(isdefined(param_03))
		{
			param_00 common_scripts\utility::waittill_any_timeout(param_03,param_02);
		}
		else
		{
			param_00 waittill(param_02);
		}

		if(!isdefined(param_00.viewmodel_hidden) || !param_00.viewmodel_hidden)
		{
			param_00 setviewmodelanimtime(1);
		}

		break;
	}
}

//Function Number: 4
getanim_vm(param_00)
{
	return level.scr_anim_vm[param_00];
}

//Function Number: 5
getanim_vm_index(param_00)
{
	return level.scr_anim_vm_index[param_00];
}

//Function Number: 6
hack_fake_loop_because_you_cant_play_looping_vm_anims(param_00,param_01,param_02)
{
	param_00 endon("kill_duplicate_anim_loop_solo_vm");
	param_00 endon(param_02);
	var_03 = getanimlength(param_00 getanim_vm(param_01));
	for(;;)
	{
		param_00 setviewmodelanim(getanim_vm_index(param_01));
		wait(var_03 - 0.05);
		param_00 setviewmodelanimtime(1);
	}
}

//Function Number: 7
assert_existance_of_anim_vm(param_00)
{
	if(!isdefined(level.scr_anim_vm_index) || !isdefined(level.scr_anim_vm_index[param_00]))
	{
		return 0;
	}

	return 1;
}