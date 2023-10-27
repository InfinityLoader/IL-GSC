/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_zombie_nest_ee_hc_true_voice.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 234 ms
 * Timestamp: 10/27/2023 3:19:35 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	common_scripts\utility::func_3C87("flag_nest_hc_ee_true_voice_entered");
	wait(1);
	lib_0557::func_4BC9("true voice of god","unlocking true voice","CONST_HC_ANALYTICS_TRUE_VOICE_OF_GOD");
	lib_0557::func_4BC9("barbarossa gem reveal","revealing barb gem","CONST_HC_ANALYTICS_BARB_GEM_REVEAL");
	var_00 = func_52EF();
	common_scripts\utility::func_3C9F("flag_nest_hc_ee_pub_kills_collected");
	var_00 func_A6DB();
	level.var_357F common_scripts\utility::func_9D9F();
	var_00 func_A646();
	var_00 func_6A7B();
}

//Function Number: 2
func_855C()
{
	level.var_797 = 1;
}

//Function Number: 3
func_744B()
{
	return common_scripts\utility::func_562E(level.var_797);
}

//Function Number: 4
func_6A7B()
{
	self["god_gem"] method_805B();
	level notify("end hilt grabbed",self["god_gem"].var_5AFC.var_116);
	foreach(var_01 in level.var_744A)
	{
		if(var_01 maps/mp/mp_zombie_nest_ee_util::func_7403())
		{
			var_01 thread func_2EAA();
		}
	}

	self["god_gem"] moveto(self["god_gem"].var_5AFC.var_116,5,1,1);
	playfxontag(level.var_611["nest_ee_hc_gem_fx"],self["god_gem"],"tag_origin");
	lib_0557::func_4BC8("barbarossa gem reveal");
	common_scripts\utility::func_3C8F("flag_nest_hc_ee_true_voice_entered");
	wait(5);
	lib_0557::func_4BC8("true voice of god");
	self["god_gem"] delete();
	if(isdefined(level.var_4D74))
	{
		var_03 = common_scripts\utility::func_46B5("raven_progress","targetname");
		level.var_4D74 delete();
		level.var_4D74 = lib_0547::func_8FBA(var_03,"zmb_hilt_sphere_hc");
		triggerfx(level.var_4D74);
	}

	func_855C();
	voicereward();
}

//Function Number: 5
func_2EAA()
{
	wait(3);
	lib_0367::func_8E3C("gemdiscovered_both");
}

//Function Number: 6
func_42EE()
{
	return "flag_nest_hc_ee_true_voice_entered";
}

//Function Number: 7
func_A6DB()
{
	common_scripts\utility::func_3C9F(lib_0557::func_7838("7 Voice paintings","enter code pieces"));
	var_00 = maps/mp/mp_zombie_nest_ee_paintings::func_43CC();
	common_scripts\utility::func_3C7B(var_00);
	wait(3);
	maps/mp/mp_zombie_nest_ee_paintings::func_3664(1);
	level.var_357F sethintstring(&"ZOMBIE_NEST_AMP_CONFIRM_CODE");
	common_scripts\utility::func_3C9F(var_00);
}

//Function Number: 8
func_A646()
{
	self["chandelier_trig"] func_A726(["teslagun_zm_moon","teslagun_zm_blood","teslagun_zm_storm","teslagun_zm_death"]);
}

//Function Number: 9
func_A726(param_00)
{
	var_01 = [];
	var_02 = 0;
	playfx(level.var_611["chandeleier_raven_idle"],self.var_116);
	while(!var_02)
	{
		self waittill("damage",var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C);
		level thread common_scripts\_exploder::func_88E(216);
		if(common_scripts\utility::func_F79(param_00,var_0C))
		{
			var_0D = func_40EF(var_0C);
			lib_0378::func_8D74("aud_shoot_chandelier");
			level thread common_scripts\_exploder::func_88E(var_0D);
			var_0E = func_9E14(param_00,var_0C);
			var_02 = common_scripts\utility::func_562E(var_0E);
			wait(0.5);
			level thread common_scripts\_exploder::func_88E(227);
		}
	}
}

//Function Number: 10
func_40EF(param_00)
{
	var_01 = "";
	switch(param_00)
	{
		case "teslagun_zm_moon":
			var_01 = 223;
			break;

		case "teslagun_zm_blood":
			var_01 = 224;
			break;

		case "teslagun_zm_death":
			var_01 = 225;
			break;

		case "teslagun_zm_storm":
			var_01 = 226;
			break;
	}

	return var_01;
}

//Function Number: 11
func_9E14(param_00,param_01,param_02)
{
	self endon("chandelier_timed_out");
	if(isdefined(param_02))
	{
		thread func_20B1(param_02);
	}

	var_03 = [param_01];
	while(var_03.size < param_00.size)
	{
		self waittill("damage",var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D);
		if(common_scripts\utility::func_F79(param_00,var_0D) && !common_scripts\utility::func_F79(var_03,var_0D))
		{
			var_03 = common_scripts\utility::func_F6F(var_03,var_0D);
			var_0E = func_40EF(var_0D);
			lib_0378::func_8D74("aud_shoot_chandelier");
			level thread common_scripts\_exploder::func_88E(var_0E);
		}
	}

	self notify("chandelier_success_shot");
	return 1;
}

//Function Number: 12
voicereward()
{
	foreach(var_01 in level.var_744A)
	{
		var_01 maps\mp\zombies\_zombies_rank::func_AC23("truevoice");
	}
}

//Function Number: 13
func_20B1(param_00)
{
	wait(param_00);
	self notify("chandelier_timed_out");
}

//Function Number: 14
func_52EF()
{
	var_00 = [];
	var_01 = common_scripts\utility::func_46B5("nest_hc_mural_challenge","targetname");
	var_02 = getentarray(var_01.var_1A2,"targetname");
	var_00["chandelier_trig"] = getent("nest_hc_mural_chandelier","script_noteworthy");
	var_00["god_gem"] = undefined;
	var_03 = common_scripts\utility::func_46B5("klauses_stone","script_noteworthy");
	var_00["god_gem"] = spawn("script_model",var_03.var_116);
	var_00["god_gem"] setmodel("zmb_hilt_sword_gem_01");
	var_00["god_gem"] method_805C();
	var_00["god_gem"].var_5AFC = common_scripts\utility::func_46B5(var_03.var_1A2,"targetname");
	return var_00;
}