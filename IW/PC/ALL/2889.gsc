/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2889.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:24:41 AM
*******************************************************************/

//Function Number: 1
func_83D5()
{
	function_01C5("cg_fovScale","1");
	function_01C5("sv_saveOnStartMap",!isdefined(level.var_4A3A));
	function_01C5("sm_roundRobinPrioritySpotShadows",4);
	function_01C5("sm_spotUpdateLimit",4);
	function_01C5("cg_hud_outline_colors_0","0.000 0.000 0.000 0.000");
	function_01C5("cg_hud_outline_colors_1","0.882 0.882 0.882 1.000");
	function_01C5("cg_hud_outline_colors_2","0.804 0.157 0.157 1.000");
	function_01C5("cg_hud_outline_colors_3","0.431 0.745 0.235 1.000");
	function_01C5("cg_hud_outline_colors_4","0.157 0.784 0.784 1.000");
	function_01C5("cg_hud_outline_colors_5","0.784 0.490 0.157 1.000");
	function_01C5("cg_hud_outline_colors_6","0.804 0.804 0.035 1.000");
	function_01C5("cg_hud_outline_colors_7","0.000 0.000 0.000 0.000");
}

//Function Number: 2
func_83DB()
{
	precacheshader("black");
	precacheshader("white");
	precachemodel("fx");
	precachemodel("tag_origin");
	precachemodel("tag_laser");
	precachemodel("tag_ik_target_left");
	precachemodel("tag_ik_target_right");
	precacheshellshock("default_nosound");
	precacheshellshock("victoryscreen");
	precacheshellshock("flashbang");
	precacheshellshock("deafened");
	precacherumble("damage_heavy");
	precacherumble("damage_light");
	precacherumble("grenade_rumble");
	precacherumble("artillery_rumble");
	precacherumble("slide_start");
	precacherumble("slide_loop");
	precacherumble("leap_end");
	precacheitem("defaultweapon");
	precacheitem("fraggrenade");
}

//Function Number: 3
func_83DD()
{
	level.var_241D = 1;
	scripts\sp\_utility::func_F44E(1);
	level.var_1307 = 1;
	if(!isdefined(level.var_7649))
	{
		level.var_7649 = [];
	}

	thread func_579A();
}

//Function Number: 4
func_B3CD()
{
	thread scripts\sp\_mgturret::func_263B();
	thread scripts\sp\_mgturret::func_EB7D();
	thread scripts\sp\_colors::func_957E();
}

//Function Number: 5
func_F7C2()
{
	var_00 = "1.0 1.0 1.0";
	var_01 = "0.9 0.9 0.9";
	var_02 = "0.85 0.85 0.85";
	function_01C5("con_typewriterColorBase",var_00);
}

//Function Number: 6
func_579A()
{
	level.var_6DC7 = 1;
	wait(0.05);
	level.var_6DC7 = -1;
}

//Function Number: 7
func_E810()
{
	scripts\common\utility::flag_set("load_finished");
	if(isdefined(level.var_D6D8))
	{
		foreach(var_01 in level.var_D6D8)
		{
			[[ var_01 ]]();
		}
	}
}

//Function Number: 8
func_51C4()
{
	scripts\sp\_utility::func_228A(getentarray("delete_on_load","targetname"));
	scripts\common\utility::func_5127(0.05,::scripts\sp\_utility::func_228A,getentarray("delete_on_firstframeend","targetname"));
	if(!scripts\sp\_utility::func_93A6())
	{
		scripts\sp\_utility::func_51D5("helmet_pickup","script_noteworthy");
		scripts\sp\_utility::func_51D5("nanoshot_pickup","script_noteworthy");
		var_00 = getentarray("specialist_mode_only","targetname");
		if(isdefined(var_00) && isarray(var_00) && var_00.size > 0)
		{
			scripts\sp\_utility::func_228A(var_00);
		}
	}
}