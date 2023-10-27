/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_zmb\cp_zmb_escape.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 703 ms
 * Timestamp: 10/27/2023 12:08:13 AM
*******************************************************************/

//Function Number: 1
cp_zmb_escape_init()
{
	level.var_9A45 = 1;
	scripts\cp\_utility::coop_mode_enable(["loot"]);
	level.initial_active_volumes = ["underground_route"];
	level.var_6728 = "scripts/cp/maps/cp_zmb/cp_zmb_escape.csv";
	level.var_672A = 90;
	level.var_79A0 = ::func_79A0;
	level thread scripts\cp\zombies\zombies_spawning::func_6714();
}

//Function Number: 2
func_95CC()
{
	level thread func_5137();
	level thread func_106D7();
	level thread func_51A4();
	level thread func_E09A();
	var_00 = getentarray("escape_exit_path","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}
}

//Function Number: 3
func_79A0()
{
	return scripts\common\utility::getstructarray("escape_exit","script_noteworthy");
}

//Function Number: 4
func_51A4()
{
	var_00 = getentarray("first_gate_bollard","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}

	var_04 = getentarray("first_gate_bollard_clip","targetname");
	foreach(var_06 in var_04)
	{
		var_06 delete();
	}

	var_08 = getentarray("bollard_trigger","targetname");
	foreach(var_0A in var_08)
	{
		var_0A delete();
	}
}

//Function Number: 5
func_5137()
{
	var_00 = scripts\common\utility::getstructarray("interaction","targetname");
	foreach(var_02 in var_00)
	{
		if(!isdefined(var_02.target))
		{
			continue;
		}

		var_03 = scripts\common\utility::getstructarray(var_02.script_noteworthy,"script_noteworthy");
		foreach(var_05 in var_03)
		{
			if(!isdefined(var_05.target))
			{
				continue;
			}

			if(var_05.target == var_02.target && var_05 != var_02)
			{
				if(scripts\common\utility::func_2286(var_00,var_05))
				{
					var_00 = scripts\common\utility::func_22A9(var_00,var_05);
				}
			}
		}

		if(scripts\cp\_interaction::func_9A18(var_02))
		{
			if(!isdefined(var_02.script_noteworthy))
			{
				continue;
			}

			var_07 = strtok(var_02.script_noteworthy,"_");
			switch(var_07[0])
			{
				case "debris":
					func_5147(var_02);
					break;

				case "team":
					func_5197(var_02);
					break;
			}
		}

		wait(0.05);
	}
}

//Function Number: 6
func_5147(param_00)
{
	scripts\cp\_interaction::func_554F(param_00);
	var_01 = getentarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		if(var_03.classname == "script_brushmodel")
		{
			var_03 connectpaths();
		}

		var_03 delete();
	}
}

//Function Number: 7
func_5197(param_00)
{
	scripts\cp\_interaction::func_554F(param_00);
	var_01 = scripts\cp\_interaction::func_7A90(param_00);
	var_02 = getentarray(var_01[0].target,"targetname");
	foreach(var_04 in var_02)
	{
		if(var_04.var_2AF == 1)
		{
			var_04 connectpaths();
		}

		var_04 delete();
	}
}

//Function Number: 8
func_106D7()
{
	var_00 = getent("escape_1_blocker_brush","targetname");
	var_00 movez(-1024,0.1);
	var_00 waittill("movedone");
	var_00 disconnectpaths();
	var_01 = scripts\common\utility::getstructarray("escape_1_blocker","targetname");
	level.var_66C9 = [];
	foreach(var_05, var_03 in var_01)
	{
		var_04 = spawn("script_model",var_03.origin);
		if(isdefined(var_03.angles))
		{
			var_04.angles = var_03.angles;
		}

		var_04 setmodel(var_03.script_noteworthy);
		level.var_66C9[level.var_66C9.size] = var_04;
		if(var_05 % 3 == 0)
		{
			wait(0.05);
		}
	}

	var_06 = getentarray("escape_door","targetname");
	foreach(var_08 in var_06)
	{
		level thread func_F942(var_08);
	}

	level thread func_66C7();
}

//Function Number: 9
func_66C7()
{
	wait(5);
	level.var_B756 = 2;
	level.var_B46F = 5;
	level.var_5FCC = 1;
	level.var_2174 = 2;
	level.var_2175 = 0.25;
	for(;;)
	{
		level.players[0] scripts\cp\powers\coop_armageddon::func_2179();
		wait(randomintrange(3,10));
		level.var_5FCC = randomfloatrange(0.05,1);
		level.var_2174 = 2;
		level.var_2175 = randomfloatrange(0.15,0.25);
	}
}

//Function Number: 10
func_E09A()
{
	setomnvarbit("zombie_doors_progress",4,1);
	scripts\common\utility::func_136F7();
	setomnvarbit("zombie_doors_progress",14,1);
	scripts\common\utility::func_136F7();
	setomnvarbit("zombie_doors_progress",9,1);
}

//Function Number: 11
func_F942(param_00)
{
	param_00 movez(-1024,0.05);
	param_00 waittill("movedone");
	param_00 disconnectpaths();
	param_00.var_C898 = [];
	var_01 = scripts\common\utility::getstructarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		if(var_03.script_noteworthy == "waypoint_spot")
		{
			continue;
		}

		var_04 = spawn("script_model",var_03.origin);
		if(isdefined(var_03.angles))
		{
			var_04.angles = var_03.angles;
		}

		var_04 setmodel(var_03.script_noteworthy);
		param_00.var_C898[param_00.var_C898.size] = var_04;
	}
}