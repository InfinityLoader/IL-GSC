/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2911.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 6 ms
 * Timestamp: 10/27/2023 12:24:53 AM
*******************************************************************/

//Function Number: 1
func_96D7()
{
	func_965A();
	precacheshellshock("default_nosound");
	precachesuit("normal_sp");
	precachemodel("vm_hero_protagonist_helmet");
	precachemodel("hero_jackal_helmet_a");
	func_F5FF();
	lib_0B8E::func_977D();
	scripts\sp\_gameskill::func_95F9();
	scripts\sp\_gameskill::func_D3A6();
	lib_0B31::func_4FF0();
	lib_0B60::func_96DC();
	lib_0B70::func_1032A();
	function_01C5("cg_useplayerbreathsys",1);
	foreach(var_01 in level.players)
	{
		var_01.maxhealth = level.player.health;
		var_01.var_9B34 = 0;
		var_01 func_16BC(::func_FE41);
		var_01 thread scripts\sp\_gameskill::func_D3A5();
		var_01 thread func_D37B();
		level.player thread lib_0B2A::func_B9D3();
		lib_0E42::init();
	}

	if(!level.console)
	{
		level.player scripts\sp\_utility::func_65E0("script_allow_showviewmodel");
		if(!is_jackal_only_mission())
		{
			thread handle_fov_viewmodel();
		}
	}
}

//Function Number: 2
func_F5FF()
{
	level.player method_845A("normal_sp");
	switch(level.script)
	{
		case "shipcrib_moon":
		case "phstreets":
		case "phparade":
		case "shipcrib_epilogue":
		case "shipcrib_prisoner":
		case "shipcrib_rogue":
		case "shipcrib_titan":
		case "shipcrib_europa":
			function_01C5("spaceshipPilotModel","viewmodel_base_animated");
			level.player method_8573("nopack_nohelmet_shadow");
			level.player method_84C7("currentViewModel","viewmodel_base_viewhands_iw7_naval");
			level.player method_8369("viewmodel_base_viewhands_iw7_naval");
			level.player method_8574("body_hero_protagonist_vm_legs_naval");
			break;

		case "phspace":
			function_01C5("spaceshipPilotModel","viewmodel_base_animated_naval");
			level.player method_8573("default_character_shadow");
			level.player method_84C7("currentViewModel","viewmodel_base_viewhands_iw7_naval");
			level.player method_8369("viewmodel_base_viewhands_iw7_naval");
			level.player method_8574("body_hero_protagonist_vm_legs_naval");
			break;

		case "titanjackal":
		case "titan":
			function_01C5("spaceshipPilotModel","viewmodel_base_animated_desert");
			level.player method_8573("default_character_shadow");
			level.player method_84C7("currentViewModel","viewmodel_base_viewhands_iw7_desert");
			level.player method_8369("viewmodel_base_viewhands_iw7_desert");
			level.player method_8574("body_hero_protagonist_vm_legs_desert");
			break;

		case "sa_assassination":
			function_01C5("spaceshipPilotModel","viewmodel_body_mp_stryker_2");
			level.player method_8573("default_character_shadow");
			level.player method_84C7("currentViewModel","viewmodel_base_viewhands_iw7");
			level.player method_8369("viewmodel_base_viewhands_iw7");
			level.player method_8574("body_hero_protagonist_vm_legs");
			break;

		default:
			function_01C5("spaceshipPilotModel","viewmodel_base_animated");
			level.player method_8573("default_character_shadow");
			level.player method_84C7("currentViewModel","viewmodel_base_viewhands_iw7");
			level.player method_8369("viewmodel_base_viewhands_iw7");
			level.player method_8574("body_hero_protagonist_vm_legs");
			break;
	}
}

//Function Number: 3
func_FE41()
{
	self waittill("death");
	if(isdefined(self.var_10956))
	{
		return;
	}

	if(getdvar("r_texturebits") == "16")
	{
		return;
	}

	self shellshock("default_nosound",3);
}

//Function Number: 4
func_D37B()
{
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_03,var_03,var_03,var_03,var_05);
		if(isdefined(self.var_10954))
		{
			continue;
		}

		if(scripts\common\utility::func_7E5E(var_04) != "bullet")
		{
			var_06 = -32 * var_02 + self.origin;
		}

		if(isdefined(var_05) && getweaponbasename(var_05) == "iw7_sonic")
		{
			func_20B3();
		}
	}
}

//Function Number: 5
func_20B3()
{
	self shellshock("deafened",2.5);
}

//Function Number: 6
func_965A()
{
	if(!scripts\common\utility::func_16F3("level_players",::func_965A))
	{
		return;
	}

	level.var_B8D0 = 0;
	scripts\common\utility::flag_init("missionfailed");
	level.players = getentarray("player","classname");
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		level.players[var_00].var_12BA3 = "player" + var_00;
	}

	level.player = level.players[0];
	level.var_5012 = 190;
	function_01C5("g_speed",level.var_5012);
	thread func_CFF8();
}

//Function Number: 7
func_D023()
{
	for(;;)
	{
		var_00 = getdvarint("player_died_recently",0);
		if(var_00 > 0)
		{
			var_00 = var_00 - 5;
			setdvar("player_died_recently",var_00);
		}

		wait(5);
	}
}

//Function Number: 8
func_CFF8()
{
	setdvar("player_died_recently","0");
	thread func_D023();
	level scripts\sp\_utility::func_178D(::scripts\common\utility::flag_wait,"missionfailed");
	level.player scripts\sp\_utility::func_178D(::scripts\sp\_utility::func_137AA,"death");
	scripts\sp\_utility::func_57D6();
	var_00 = [];
	var_00[0] = 70;
	var_00[1] = 30;
	var_00[2] = 0;
	var_00[3] = 0;
	setdvar("player_died_recently",var_00[level.var_7683]);
}

//Function Number: 9
func_16BC(param_00)
{
	if(!isdefined(self.var_4E0E))
	{
		self.var_4E0E = [];
		thread func_4E0E();
	}

	self.var_4E0E = param_00;
}

//Function Number: 10
func_4E0E()
{
	foreach(var_01 in self.var_4E0E)
	{
		thread [[ var_01 ]]();
	}
}

//Function Number: 11
func_51E7()
{
}

//Function Number: 12
handle_fov_viewmodel()
{
	level.player endon("death");
	level.player scripts\sp\_utility::func_65E0("fov_vm_hide");
	if(!levelrequiresfovhandling())
	{
		return;
	}

	var_00 = 1.4;
	level.player scripts\sp\_utility::func_65E1("script_allow_showviewmodel");
	for(;;)
	{
		if(!level.player scripts\sp\_utility::func_65DB("script_allow_showviewmodel"))
		{
			level.player method_818A();
			level.player scripts\sp\_utility::func_65E1("fov_vm_hide");
			level.player scripts\sp\_utility::func_65E3("script_allow_showviewmodel");
		}

		var_01 = getdvarfloat("com_fovUserScale");
		if(var_01 >= var_00 && level.player getcurrentweapon() == "iw7_gunless")
		{
			if(!level.player scripts\sp\_utility::func_65DB("fov_vm_hide"))
			{
				level.player method_818A();
				level.player scripts\sp\_utility::func_65E1("fov_vm_hide");
			}
		}
		else if(level.player scripts\sp\_utility::func_65DB("fov_vm_hide"))
		{
			level.player method_8389();
			level.player scripts\sp\_utility::func_65DD("fov_vm_hide");
		}

		wait(0.05);
	}
}

//Function Number: 13
is_jackal_only_mission()
{
	return level.script == "phspace" || level.script == "moonjackal" || issubstr(level.script,"ja_");
}

//Function Number: 14
levelrequiresfovhandling()
{
	return level.script == "yard" || level.script == "prisoner" || level.script == "marsbase" || level.script == "marscrash" || level.script == "heist" || level.script == "phparade" || level.script == "moon_port" || issubstr(level.script,"shipcrib");
}