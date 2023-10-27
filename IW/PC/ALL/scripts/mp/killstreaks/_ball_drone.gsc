/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_ball_drone.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 65
 * Decompile Time: 3119 ms
 * Timestamp: 10/27/2023 12:28:16 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\mp\killstreaks\_killstreaks::func_DEFB("ball_drone_radar",::func_128DB);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("ball_drone_backup",::func_128DB);
	level._effect["kamikaze_drone_explode"] = loadfx("vfx/iw7/_requests/mp/killstreak/vfx_vulture_exp_vari.vfx");
	level.var_27F0 = [];
	level.var_27F0["ball_drone_radar"] = spawnstruct();
	level.var_27F0["ball_drone_radar"].var_11901 = 60;
	level.var_27F0["ball_drone_radar"].health = 999999;
	level.var_27F0["ball_drone_radar"].maxhealth = 500;
	level.var_27F0["ball_drone_radar"].var_110EA = "ball_drone_radar";
	level.var_27F0["ball_drone_radar"].var_13260 = "ball_drone_mp";
	level.var_27F0["ball_drone_radar"].var_B91A = "veh_mil_air_un_pocketdrone_mp";
	level.var_27F0["ball_drone_radar"].var_115EB = "used_ball_drone_radar";
	level.var_27F0["ball_drone_radar"].var_7638 = loadfx("vfx/core/mp/killstreaks/vfx_ims_sparks");
	level.var_27F0["ball_drone_radar"].var_7630 = loadfx("vfx/core/expl/vehicle/ball/vfx_exp_ball_drone.vfx");
	level.var_27F0["ball_drone_radar"].var_1045F = "ball_drone_explode";
	level.var_27F0["ball_drone_radar"].var_13523 = "nowl_destroyed";
	level.var_27F0["ball_drone_radar"].var_13553 = "nowl_gone";
	level.var_27F0["ball_drone_radar"].var_EC44 = "destroyed_ball_drone_radar";
	level.var_27F0["ball_drone_radar"].var_D483 = ::func_DBD4;
	level.var_27F0["ball_drone_radar"].var_7632 = [];
	level.var_27F0["ball_drone_radar"].var_7633 = [];
	level.var_27F0["ball_drone_radar"].var_7634 = [];
	level.var_27F0["ball_drone_radar"].var_7635 = [];
	level.var_27F0["ball_drone_radar"].var_7632["enemy"] = loadfx("vfx/core/mp/killstreaks/vfx_light_detonator_blink");
	level.var_27F0["ball_drone_radar"].var_7633["enemy"] = loadfx("vfx/core/mp/killstreaks/vfx_light_detonator_blink");
	level.var_27F0["ball_drone_radar"].var_7634["enemy"] = loadfx("vfx/core/mp/killstreaks/vfx_light_detonator_blink");
	level.var_27F0["ball_drone_radar"].var_7635["enemy"] = loadfx("vfx/core/mp/killstreaks/vfx_light_detonator_blink");
	level.var_27F0["ball_drone_radar"].var_7632["friendly"] = loadfx("vfx/misc/light_mine_blink_friendly");
	level.var_27F0["ball_drone_radar"].var_7633["friendly"] = loadfx("vfx/misc/light_mine_blink_friendly");
	level.var_27F0["ball_drone_radar"].var_7634["friendly"] = loadfx("vfx/misc/light_mine_blink_friendly");
	level.var_27F0["ball_drone_radar"].var_7635["friendly"] = loadfx("vfx/misc/light_mine_blink_friendly");
	level.var_27F0["ball_drone_radar"].var_10B83 = 110;
	level.var_27F0["ball_drone_radar"].var_4AB0 = 70;
	level.var_27F0["ball_drone_radar"].var_DA90 = 36;
	level.var_27F0["ball_drone_radar"].var_2732 = 124;
	level.var_27F0["ball_drone_radar"].var_101BA = 55;
	level.var_27F0["ball_drone_backup"] = spawnstruct();
	level.var_27F0["ball_drone_backup"].var_11901 = 60;
	level.var_27F0["ball_drone_backup"].health = 999999;
	level.var_27F0["ball_drone_backup"].maxhealth = 200;
	level.var_27F0["ball_drone_backup"].var_110EA = "ball_drone_backup";
	level.var_27F0["ball_drone_backup"].var_13260 = "backup_drone_mp";
	level.var_27F0["ball_drone_backup"].var_B91A = "veh_mil_air_un_pocketdrone_mp";
	level.var_27F0["ball_drone_backup"].var_115EB = "used_ball_drone_backup";
	level.var_27F0["ball_drone_backup"].var_7630 = loadfx("vfx/iw7/core/mp/killstreaks/vfx_apex_dest_exp.vfx");
	level.var_27F0["ball_drone_backup"].var_1045F = "ball_drone_explode";
	level.var_27F0["ball_drone_backup"].var_13523 = "ball_drone_backup_destroy";
	level.var_27F0["ball_drone_backup"].var_13553 = "ball_drone_backup_timeout";
	level.var_27F0["ball_drone_backup"].var_EC44 = "destroyed_ball_drone";
	level.var_27F0["ball_drone_backup"].var_39B = "ball_drone_gun_mp";
	level.var_27F0["ball_drone_backup"].var_13CA8 = "veh_mil_air_un_pocketdrone_gun_mp";
	level.var_27F0["ball_drone_backup"].var_13CD8 = "tag_turret";
	level.var_27F0["ball_drone_backup"].var_10474 = "weap_p99_fire_npc";
	level.var_27F0["ball_drone_backup"].var_10472 = "ball_drone_targeting";
	level.var_27F0["ball_drone_backup"].var_10465 = "ball_drone_lockon";
	level.var_27F0["ball_drone_backup"].var_F267 = "sentry";
	level.var_27F0["ball_drone_backup"].var_1349E = 1440000;
	level.var_27F0["ball_drone_backup"].var_32C1 = 15;
	level.var_27F0["ball_drone_backup"].var_32C0 = 9;
	level.var_27F0["ball_drone_backup"].var_C9D3 = 0.3;
	level.var_27F0["ball_drone_backup"].var_C9D1 = 1.3;
	level.var_27F0["ball_drone_backup"].var_AF30 = 0.075;
	level.var_27F0["ball_drone_backup"].var_D483 = ::func_273C;
	level.var_27F0["ball_drone_backup"].var_7632 = [];
	level.var_27F0["ball_drone_backup"].var_7632["enemy"] = loadfx("vfx/core/mp/killstreaks/vfx_light_detonator_blink");
	level.var_27F0["ball_drone_backup"].var_7632["friendly"] = loadfx("vfx/misc/light_mine_blink_friendly");
	level.var_27F0["ball_drone_backup"].var_10B83 = 110;
	level.var_27F0["ball_drone_backup"].var_4AB0 = 70;
	level.var_27F0["ball_drone_backup"].var_DA90 = 36;
	level.var_27F0["ball_drone_backup"].var_2732 = 124;
	level.var_27F0["ball_drone_backup"].var_101BA = 55;
	level.var_27F0["ball_drone_ability_pet"] = spawnstruct();
	level.var_27F0["ball_drone_ability_pet"].var_11901 = undefined;
	level.var_27F0["ball_drone_ability_pet"].health = 999999;
	level.var_27F0["ball_drone_ability_pet"].maxhealth = 500;
	level.var_27F0["ball_drone_ability_pet"].var_110EA = undefined;
	level.var_27F0["ball_drone_ability_pet"].var_13260 = "ball_drone_ability_pet_mp";
	level.var_27F0["ball_drone_ability_pet"].var_B91A = "veh_mil_air_un_pocketdrone_mp";
	level.var_27F0["ball_drone_ability_pet"].var_115EB = undefined;
	level.var_27F0["ball_drone_ability_pet"].var_7638 = loadfx("vfx/core/mp/killstreaks/vfx_ims_sparks");
	level.var_27F0["ball_drone_ability_pet"].var_7630 = loadfx("vfx/core/expl/vehicle/ball/vfx_exp_ball_drone.vfx");
	level.var_27F0["ball_drone_ability_pet"].var_1045F = "ball_drone_explode";
	level.var_27F0["ball_drone_ability_pet"].var_13523 = undefined;
	level.var_27F0["ball_drone_ability_pet"].var_13553 = undefined;
	level.var_27F0["ball_drone_ability_pet"].var_EC44 = undefined;
	level.var_27F0["ball_drone_ability_pet"].var_54CE = 1;
	level.var_27F0["ball_drone_ability_pet"].var_D483 = ::func_151B;
	level.var_27F0["ball_drone_ability_pet"].var_7632 = [];
	level.var_27F0["ball_drone_ability_pet"].var_7633 = [];
	level.var_27F0["ball_drone_ability_pet"].var_7634 = [];
	level.var_27F0["ball_drone_ability_pet"].var_7635 = [];
	level.var_27F0["ball_drone_ability_pet"].var_7632["enemy"] = loadfx("vfx/core/mp/killstreaks/vfx_ball_drone_ability_1");
	level.var_27F0["ball_drone_ability_pet"].var_7633["enemy"] = loadfx("vfx/core/mp/killstreaks/vfx_ball_drone_ability_2");
	level.var_27F0["ball_drone_ability_pet"].var_7634["enemy"] = loadfx("vfx/core/mp/killstreaks/vfx_ball_drone_ability_3");
	level.var_27F0["ball_drone_ability_pet"].var_7635["enemy"] = loadfx("vfx/core/mp/killstreaks/vfx_ball_drone_ability_4");
	level.var_27F0["ball_drone_ability_pet"].var_7632["friendly"] = loadfx("vfx/core/mp/killstreaks/vfx_ball_drone_ability_1");
	level.var_27F0["ball_drone_ability_pet"].var_7633["friendly"] = loadfx("vfx/core/mp/killstreaks/vfx_ball_drone_ability_2");
	level.var_27F0["ball_drone_ability_pet"].var_7634["friendly"] = loadfx("vfx/core/mp/killstreaks/vfx_ball_drone_ability_3");
	level.var_27F0["ball_drone_ability_pet"].var_7635["friendly"] = loadfx("vfx/core/mp/killstreaks/vfx_ball_drone_ability_4");
	level.var_27F0["ball_drone_ability_pet"].var_E192 = 1;
	level.var_27F0["ball_drone_ability_pet"].var_10B83 = 95;
	level.var_27F0["ball_drone_ability_pet"].var_4AB0 = 60;
	level.var_27F0["ball_drone_ability_pet"].var_DA90 = 36;
	level.var_27F0["ball_drone_ability_pet"].var_2732 = 124;
	level.var_27F0["ball_drone_ability_pet"].var_101BA = 20;
	level.var_27EF = [];
	level.balldronepathnodes = function_0076();
	var_00 = ["passive_guard","passive_no_radar","passive_self_destruct","passive_decreased_health","passive_seeker","passive_decreased_speed"];
	scripts\mp\_killstreak_loot::func_DF07("ball_drone_backup",var_00);
}

//Function Number: 2
func_128DB(param_00)
{
	return func_13047(param_00.var_110EA,param_00);
}

//Function Number: 3
func_13047(param_00,param_01)
{
	var_02 = 1;
	if(scripts\mp\_utility::func_9FC6())
	{
		return 0;
	}
	else if(func_68C0())
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}
	else if(scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2() || level.var_6BAA + var_02 >= scripts\mp\_utility::func_B4D2())
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}
	else if(isdefined(self.var_27D3))
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_COMPANION_ALREADY_EXISTS");
		return 0;
	}
	else if(isdefined(self.var_5CC4))
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_UNAVAILABLE");
		return 0;
	}

	scripts\mp\_utility::func_93FA();
	var_03 = func_4986(param_00,param_01);
	if(!isdefined(var_03))
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_UNAVAILABLE");
		scripts\mp\_utility::func_4FC1();
		return 0;
	}

	self.var_27D3 = var_03;
	thread func_10D6E(var_03);
	self.var_27D3 thread func_CA50();
	var_04 = level.var_27F0[param_00].var_115EB;
	var_05 = scripts\mp\_killstreak_loot::getrarityforlootitem(param_01.var_1318B);
	if(var_05 != "")
	{
		var_04 = var_04 + "_" + var_05;
	}

	level thread scripts\mp\_utility::func_115DE(var_04,self);
	if(param_00 == "ball_drone_backup" && lib_0D65::func_8011(self,"dog") > 0)
	{
		scripts\mp\_missions::func_D992("ch_twiceasdeadly");
	}

	return 1;
}

//Function Number: 4
func_4986(param_00,param_01)
{
	var_02 = self.angles;
	var_03 = anglestoforward(self.angles);
	var_04 = self.origin + var_03 * 100 + (0,0,90);
	var_05 = self.origin + (0,0,90);
	var_06 = bullettrace(var_05,var_04,0);
	var_07 = 3;
	while(var_06["surfacetype"] != "none" && var_07 > 0)
	{
		var_04 = self.origin + vectornormalize(var_05 - var_06["position"]) * 5;
		var_06 = bullettrace(var_05,var_04,0);
		var_07--;
		wait(0.05);
	}

	if(var_07 <= 0)
	{
		return;
	}

	var_08 = anglestoright(self.angles);
	var_09 = self.origin + var_08 * 20 + (0,0,90);
	var_06 = bullettrace(var_04,var_09,0);
	var_07 = 3;
	while(var_06["surfacetype"] != "none" && var_07 > 0)
	{
		var_09 = var_04 + vectornormalize(var_04 - var_06["position"]) * 5;
		var_06 = bullettrace(var_04,var_09,0);
		var_07--;
		wait(0.05);
	}

	if(var_07 <= 0)
	{
		return;
	}

	var_0A = level.var_27F0[param_00].var_B91A;
	var_0B = level.var_27F0[param_00].maxhealth;
	var_0C = &"KILLSTREAKS_HINTS_VULTURE_SUPPORT";
	var_0D = scripts\mp\_killstreak_loot::getrarityforlootitem(param_01.var_1318B);
	if(var_0D != "")
	{
		var_0A = var_0A + "_" + var_0D;
	}

	if(scripts\mp\killstreaks\_utility::func_A69F(param_01,"passive_self_destruct"))
	{
		var_0B = int(var_0B / 1.1);
	}

	if(scripts\mp\killstreaks\_utility::func_A69F(param_01,"passive_guard"))
	{
		var_0C = &"KILLSTREAKS_HINTS_VULTURE_GUARD";
	}

	var_0E = spawnhelicopter(self,var_04,var_02,level.var_27F0[param_00].var_13260,var_0A);
	if(!isdefined(var_0E))
	{
		return;
	}

	var_0E method_80C7();
	var_0E method_8317(1);
	var_0E method_81FA(1);
	var_0E.health = level.var_27F0[param_00].health;
	var_0E.maxhealth = var_0B;
	var_0E.var_E1 = 0;
	var_0E.var_2B3 = 140;
	var_0E.var_7247 = 140;
	var_0E.var_222 = self;
	var_0E.team = self.team;
	var_0E.var_27F1 = param_00;
	var_0E.var_BC = "ASSAULT";
	var_0E.var_4C08 = var_0C;
	var_0E.var_110E8 = param_01;
	var_0E method_83E5(var_0E.var_2B3,16,16);
	var_0E method_8378(120,90);
	var_0E method_8316(16);
	var_0E method_82F6(30,10,5);
	var_0E method_856A(50,1.3,30,20);
	var_0E method_831F(self);
	var_0E method_84E1(1);
	var_0E method_84E0(1);
	var_0E.var_130AC = spawn("script_model",var_0E.origin);
	var_0E.var_130AC linkto(var_0E,"tag_origin");
	var_0E scripts\mp\killstreaks\_utility::func_1843(var_0E.var_27F1,"Killstreak_Ground",var_0E.var_222,1);
	if(level.teambased)
	{
		var_0E scripts\mp\_entityheadicons::func_F877(var_0E.team,(0,0,25));
	}
	else
	{
		var_0E scripts\mp\_entityheadicons::func_F7F2(var_0E.var_222,(0,0,25));
	}

	var_0F = 45;
	var_10 = 45;
	switch(param_00)
	{
		case "ball_drone_radar":
			var_0F = 90;
			var_10 = 90;
			var_11 = spawn("script_model",self.origin);
			var_11.team = self.team;
			var_11 method_81F3(self);
			var_0E.var_DBBF = var_11;
			var_0E thread func_DBD6();
			var_0E.var_1E2D = 99999;
			var_0E.var_37C5 = distance(var_0E.origin,var_0E gettagorigin("camera_jnt"));
			var_0E thread scripts\mp\_trophy_system::func_1282B();
			var_0E thread func_27DD();
			break;

		case "ball_drone_backup":
			var_0E method_8378(150,90);
			var_0E method_856A(100,1.3,30,20);
			var_0E.var_7247 = 140;
			var_12 = spawnturret("misc_turret",var_0E gettagorigin(level.var_27F0[param_00].var_13CD8),level.var_27F0[param_00].var_39B);
			var_12 linkto(var_0E,level.var_27F0[param_00].var_13CD8);
			var_12 setmodel(level.var_27F0[param_00].var_13CA8);
			var_12.angles = var_0E.angles;
			var_12.var_222 = var_0E.var_222;
			var_12.team = self.team;
			var_12 method_81F5();
			var_12 makeunusable();
			var_12.var_131A0 = var_0E;
			var_12.var_110E8 = param_01;
			var_12.health = level.var_27F0[param_00].health;
			var_12.maxhealth = level.var_27F0[param_00].maxhealth;
			var_12.var_E1 = 0;
			var_13 = self.origin + var_03 * -100 + (0,0,40);
			var_12.var_92FD = spawn("script_origin",var_13);
			var_12.var_92FD.var_336 = "test";
			thread func_92FE(var_12.var_92FD);
			if(level.teambased)
			{
				var_12 method_835E(self.team);
			}
	
			var_12 method_830F(level.var_27F0[param_00].var_F267);
			var_12 method_8336(self);
			var_12 method_82FB(180);
			var_12 method_8330(180);
			var_12 method_82B6(50);
			var_12 thread func_27D4();
			var_12 method_835A(1,"buddy_turret");
			var_12 method_82C8(0.8);
			var_14 = var_0E.origin + anglestoforward(var_0E.angles) * -10 + anglestoright(var_0E.angles) * -10 + (0,0,6);
			var_12.var_A63A = spawn("script_model",var_14);
			var_12.var_A63A setscriptmoverkillcam("explosive");
			var_12.var_A63A linkto(var_0E);
			var_0E.var_129B9 = var_12;
			var_12.parent = var_0E;
			var_0E thread func_27D5();
			var_0E.var_129B9 thread func_27D6();
			break;

		case "alien_ball_drone_4":
		case "alien_ball_drone_3":
		case "alien_ball_drone_2":
		case "alien_ball_drone_1":
		case "alien_ball_drone":
		case "ball_drone_eng_lethal":
			var_12 = spawnturret("misc_turret",var_0E gettagorigin(level.var_27F0[param_00].var_13CD8),level.var_27F0[param_00].var_39B);
			var_12 linkto(var_0E,level.var_27F0[param_00].var_13CD8);
			var_12 setmodel(level.var_27F0[param_00].var_13CA8);
			var_12.angles = var_0E.angles;
			var_12.var_222 = var_0E.var_222;
			var_12.team = self.team;
			var_12 method_81F5();
			var_12 makeunusable();
			var_12.var_131A0 = var_0E;
			var_12.health = level.var_27F0[param_00].health;
			var_12.maxhealth = level.var_27F0[param_00].maxhealth;
			var_12.var_E1 = 0;
			var_13 = self.origin + var_03 * -100 + (0,0,40);
			var_12.var_92FD = spawn("script_origin",var_13);
			var_12.var_92FD.var_336 = "test";
			thread func_92FE(var_12.var_92FD);
			if(level.teambased)
			{
				var_12 method_835E(self.team);
			}
	
			var_12 method_830F(level.var_27F0[param_00].var_F267);
			var_12 method_8336(self);
			var_12 method_82FB(180);
			var_12 method_8330(180);
			var_12 method_82B6(50);
			var_12 thread func_27D4();
			var_12 method_835A(1,"buddy_turret");
			var_12 method_82C8(0.8);
			var_14 = var_0E.origin + anglestoforward(var_0E.angles) * -10 + anglestoright(var_0E.angles) * -10 + (0,0,10);
			var_12.var_A63A = spawn("script_model",var_14);
			var_12.var_A63A setscriptmoverkillcam("explosive");
			var_12.var_A63A linkto(var_0E);
			var_0E.var_129B9 = var_12;
			var_12.parent = var_0E;
			var_0E thread func_27D5();
			var_0E.var_129B9 thread func_27D6();
			break;

		case "ball_drone_ability_pet":
			var_0F = 90;
			var_10 = 90;
			break;

		default:
			break;
	}

	var_0E method_830A(var_0F,var_10);
	var_0E.var_1157A = var_09;
	var_0E.var_254D = 10000;
	var_0E.var_254C = 150;
	var_0E.var_2550 = missile_createattractorent(var_0E,var_0E.var_254D,var_0E.var_254C);
	var_0E.var_8BE5 = 0;
	var_0E.var_11196 = 0;
	var_0E.var_93AF = 0;
	var_0E thread func_13A10();
	var_0E thread func_27E3();
	var_0E thread func_27EB();
	var_0E thread func_27E6();
	var_0E thread func_27E5();
	var_0E thread func_27E9();
	var_0E thread func_27E1();
	var_15 = spawnstruct();
	var_15.var_13139 = 1;
	var_15.var_4E53 = ::func_27E0;
	var_0E thread scripts\mp\_movers::func_892F(var_15);
	if(isdefined(level.var_27F0[var_0E.var_27F1].var_110EA))
	{
		var_0E.var_222 scripts\mp\_matchdata::func_AFC9(level.var_27F0[var_0E.var_27F1].var_110EA,var_0E.var_1157A);
	}

	var_0E thread balldrone_destroyongameend();
	return var_0E;
}

//Function Number: 5
func_27E0(param_00)
{
	if(!isdefined(param_00.var_AA33.var_52CF) || param_00.var_AA33.var_52CF)
	{
		self notify("death");
	}
}

//Function Number: 6
func_92FE(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	var_01 = anglestoforward(self.angles);
	for(;;)
	{
		if(scripts\mp\_utility::func_9F19(self) && !scripts\mp\_utility::func_9FC6() && anglestoforward(self.angles) != var_01)
		{
			var_01 = anglestoforward(self.angles);
			var_02 = self.origin + var_01 * -100 + (0,0,40);
			param_00 moveto(var_02,0.5);
		}

		wait(0.5);
	}
}

//Function Number: 7
func_27D9()
{
	self endon("death");
	var_00 = level.var_27F0[self.var_27F1];
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(isdefined(var_02))
			{
				if(level.teambased)
				{
					if(var_02.team != self.team)
					{
						self [[ var_00.var_D483 ]]("enemy",var_02);
					}

					continue;
				}

				if(var_02 != self.var_222)
				{
					self [[ var_00.var_D483 ]]("enemy",var_02);
				}
			}
		}

		wait(1);
	}
}

//Function Number: 8
func_27DB()
{
	self endon("death");
	var_00 = level.var_27F0[self.var_27F1];
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02))
		{
			if(level.teambased)
			{
				if(var_02.team == self.team)
				{
					self [[ var_00.var_D483 ]]("friendly",var_02);
				}

				continue;
			}

			if(var_02 == self.var_222)
			{
				self [[ var_00.var_D483 ]]("friendly",var_02);
			}
		}
	}

	thread func_139D6();
	thread func_13AAD();
}

//Function Number: 9
func_27E1()
{
	var_00 = level.var_27F0[self.var_27F1];
	self [[ var_00.var_D483 ]]();
}

//Function Number: 10
func_273C(param_00,param_01)
{
	self setscriptablepartstate("lights","idle",0);
	self setscriptablepartstate("dust","active",0);
}

//Function Number: 11
func_151B(param_00,param_01)
{
	self setscriptablepartstate("lights","idle",0);
}

//Function Number: 12
func_DBD4(param_00,param_01)
{
	self setscriptablepartstate("lights","idle",0);
}

//Function Number: 13
func_139D6()
{
	self endon("death");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 waittill("spawned_player");
		var_01 = level.var_27F0[self.var_27F1];
		if(isdefined(var_00))
		{
			if(level.teambased)
			{
				if(var_00.team == self.team)
				{
					self [[ var_01.var_D483 ]]("friendly",var_00);
				}
				else
				{
					self [[ var_01.var_D483 ]]("enemy",var_00);
				}

				continue;
			}

			if(var_00 == self.var_222)
			{
				self [[ var_01.var_D483 ]]("friendly",var_00);
				continue;
			}

			self [[ var_01.var_D483 ]]("enemy",var_00);
		}
	}
}

//Function Number: 14
func_13AAD()
{
	self endon("death");
	for(;;)
	{
		level waittill("joined_team",var_00);
		var_00 waittill("spawned_player");
		var_01 = level.var_27F0[self.var_27F1];
		if(isdefined(var_00))
		{
			if(level.teambased)
			{
				if(var_00.team == self.team)
				{
					self [[ var_01.var_D483 ]]("friendly",var_00);
				}
				else
				{
					self [[ var_01.var_D483 ]]("enemy",var_00);
				}

				continue;
			}

			if(var_00 == self.var_222)
			{
				self [[ var_01.var_D483 ]]("friendly",var_00);
				continue;
			}

			self [[ var_01.var_D483 ]]("enemy",var_00);
		}
	}
}

//Function Number: 15
func_10D6E(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	switch(param_00.var_27F1)
	{
		case "alien_ball_drone_4":
		case "alien_ball_drone_3":
		case "alien_ball_drone_2":
		case "alien_ball_drone_1":
		case "alien_ball_drone":
		case "ball_drone_eng_lethal":
		case "ball_drone_backup":
			if(isdefined(param_00.var_129B9) && isdefined(param_00.var_129B9.var_92FD))
			{
				param_00 method_8305(param_00.var_129B9.var_92FD);
			}
			else
			{
				param_00 method_8305(self);
			}
			break;

		default:
			param_00 method_8305(self);
			break;
	}

	var_01 = balldrone_gettargetoffset(param_00,self);
	param_00 method_85C6(self,var_01,16,10);
	param_00 method_83E5(param_00.var_2B3,10,10);
	if(param_00.var_27F1 == "ball_drone_backup")
	{
		if(scripts\mp\killstreaks\_utility::func_A69F(param_00.var_110E8,"passive_seeker"))
		{
			param_00 thread balldrone_patrollevel();
			param_00 thread balldrone_watchfornearbytargets();
			return;
		}

		param_00 thread func_27DA();
		param_00 thread func_27E7();
		param_00 thread func_27EA();
		param_00 thread func_27E8();
		param_00 thread balldrone_watchmodeswitch();
	}
}

//Function Number: 16
func_27DA()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self endon("target_assist");
	self endon("player_defend");
	self endon("switch_modes");
	if(!isdefined(self.var_222))
	{
		thread func_27DE();
		return;
	}

	self.var_222 endon("disconnect");
	self endon("owner_gone");
	if(self.var_27F1 != "ball_drone_eng_lethal")
	{
		self method_83E5(self.var_7247,20,20);
	}
	else
	{
		self method_83E5(self.var_7247,25,50);
	}

	for(;;)
	{
		var_00 = self.var_222 getstance();
		if(!isdefined(self.var_A8F2) || var_00 != self.var_A8F2 || scripts\mp\_utility::func_9FB3(self.stoppedatlocation))
		{
			if(scripts\mp\_utility::func_9FB3(self.stoppedatlocation))
			{
				self.stoppedatlocation = undefined;
			}

			self.var_A8F2 = var_00;
			var_01 = balldrone_gettargetoffset(self,self.var_222);
			self method_85C6(self.var_222,var_01,16,10);
		}

		wait(0.5);
	}
}

//Function Number: 17
func_27DC(param_00)
{
	var_01 = param_00.var_10B83;
	var_02 = self.var_222 getstance();
	switch(var_02)
	{
		case "stand":
			var_01 = param_00.var_10B83;
			break;

		case "crouch":
			var_01 = param_00.var_4AB0;
			break;

		case "prone":
			var_01 = param_00.var_DA90;
			break;
	}

	return var_01;
}

//Function Number: 18
balldrone_watchfornearbytargets()
{
	self endon("death");
	self endon("leaving");
	self.var_222 endon("disconnect");
	self.var_2525 = undefined;
	for(;;)
	{
		self.var_129B9 waittill("turret_on_target");
		self notify("chase_nearby_target");
		var_00 = self.var_129B9 method_8166(1);
		balldrone_guardlocation();
		var_01 = balldrone_gettargetoffset(self,var_00);
		self method_85C6(var_00,var_01,16,10);
		self.var_2525 = 1;
		thread func_13B79(var_00,self.origin,1);
		self waittill("disengage_target");
		self.var_2525 = undefined;
		thread balldrone_patrollevel();
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 19
getvalidenemylist()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(!self.var_222 scripts\mp\_utility::func_9DD6(var_02))
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9F19(var_02))
		{
			continue;
		}

		if(var_02 method_8181("specialty_blindeye"))
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	return var_00;
}

//Function Number: 20
vulturecanseeenemy(param_00)
{
	var_01 = 0;
	var_02 = scripts\common\trace::func_48BC(0,1,0,1,1,0);
	var_03 = [param_00 gettagorigin("j_head"),param_00 gettagorigin("j_mainroot"),param_00 gettagorigin("tag_origin")];
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if(!scripts\common\trace::func_DCF1(self.origin,var_03[var_04],self,var_02))
		{
			continue;
		}

		var_01 = 1;
		break;
	}

	return var_01;
}

//Function Number: 21
balldrone_patrollevel()
{
	self endon("death");
	self endon("leaving");
	self endon("chase_nearby_target");
	self.var_222 endon("disconnect");
	balldrone_guardlocation();
	self method_83E5(15,5,5);
	self method_8316(30);
	self.var_129B9 method_807E();
	self method_8076();
	var_00 = self;
	var_01 = (0,0,50);
	for(;;)
	{
		var_02 = findnewpatrolpoint(level.balldronepathnodes);
		self method_82D9(var_02);
		self waittill("near_goal");
	}
}

//Function Number: 22
findnewpatrolpoint(param_00)
{
	var_01 = undefined;
	var_02 = 0;
	var_03 = sortbydistance(param_00,self.origin);
	var_03 = scripts\common\utility::func_22BD(var_03);
	var_04 = [];
	foreach(var_0A, var_06 in var_03)
	{
		if(isdefined(self.var_4BF7) && var_06 == self.var_4BF7)
		{
			continue;
		}

		if(scripts\mp\_utility::func_9FB3(var_06.var_1305B) && var_0A == var_03.size - 1)
		{
			foreach(var_08 in var_03)
			{
				var_08.var_1305B = undefined;
			}

			var_02 = 1;
		}
		else if(scripts\mp\_utility::func_9FB3(var_06.var_1305B))
		{
			continue;
		}

		var_04[var_04.size] = var_06;
		if(var_04.size == 200)
		{
			break;
		}
	}

	var_0B = randomintrange(0,var_04.size);
	var_0C = var_04[var_0B];
	if(!isdefined(self.initialvalidnode))
	{
		self.initialvalidnode = var_0C;
	}

	if(scripts\mp\_utility::func_9FB3(var_02))
	{
		self.var_4BF7 = self.initialvalidnode;
		var_02 = 0;
	}
	else
	{
		self.var_4BF7 = var_0C;
	}

	self.var_4BF7.var_1305B = 1;
	return self.var_4BF7.origin + (0,0,80);
}

//Function Number: 23
func_27E7()
{
	self endon("death");
	self endon("leaving");
	self endon("switch_modes");
	self.var_222 endon("disconnect");
	for(;;)
	{
		self.var_222 waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D);
		var_09 = scripts\mp\_utility::func_13CA1(var_09,var_0D);
		if(scripts\mp\_utility::func_9FB3(self.var_2525))
		{
			continue;
		}

		if(!func_A00F(var_01))
		{
			continue;
		}

		if(scripts\mp\_utility::func_9FB3(self.var_11196))
		{
			continue;
		}

		if(!isplayer(var_01))
		{
			continue;
		}

		if(!self.var_129B9 func_3874(var_01))
		{
			continue;
		}

		self notify("player_defend");
		self.var_A8F2 = undefined;
		var_0E = balldrone_gettargetoffset(self,var_01);
		self method_85C6(var_01,var_0E,16,10);
		self.var_2525 = 1;
		thread func_13B79(var_01,undefined,1);
		break;
	}
}

//Function Number: 24
func_27EA()
{
	self endon("death");
	self endon("leaving");
	self endon("switch_modes");
	self.var_222 endon("disconnect");
	for(;;)
	{
		self.var_222 waittill("victim_damaged",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(scripts\mp\_utility::func_9FB3(self.var_2525))
		{
			continue;
		}

		if(!func_A00F(var_00))
		{
			continue;
		}

		if(scripts\mp\_utility::func_9FB3(self.var_11196))
		{
			continue;
		}

		if(!isplayer(var_00))
		{
			continue;
		}

		if(!self.var_129B9 func_3874(var_00))
		{
			continue;
		}

		self notify("target_assist");
		self.var_A8F2 = undefined;
		var_0A = balldrone_gettargetoffset(self,var_00);
		self method_85C6(var_00,var_0A,16,10);
		self.var_2525 = 1;
		thread func_13B79(var_00,undefined,1);
		break;
	}
}

//Function Number: 25
func_A00F(param_00,param_01,param_02)
{
	var_03 = 0;
	var_04 = self.var_222.origin;
	if(isdefined(param_01))
	{
		var_04 = param_01;
	}

	var_05 = 1000000;
	if(isdefined(param_02))
	{
		var_05 = param_02;
	}

	if(distance2dsquared(var_04,param_00.origin) < var_05)
	{
		var_03 = 1;
	}

	return var_03;
}

//Function Number: 26
func_13B79(param_00,param_01,param_02)
{
	self endon("death");
	self endon("leaving");
	self endon("switch_modes");
	self endon("player_defend");
	self endon("target_assist");
	self.var_222 endon("disconnect");
	for(;;)
	{
		if(isdefined(param_00) && self.var_129B9 func_3874(param_00))
		{
			if(scripts\mp\_utility::func_9FB3(param_02) && !func_A00F(param_00,param_01))
			{
				break;
			}
			else
			{
				scripts\common\utility::func_136F7();
			}

			continue;
		}

		break;
	}

	self notify("disengage_target");
}

//Function Number: 27
func_27E8()
{
	self endon("death");
	self endon("leaving");
	self endon("switch_modes");
	self.var_222 endon("disconnect");
	self waittill("disengage_target");
	self.var_2525 = undefined;
	thread func_27DA();
	thread func_27E7();
	thread func_27EA();
	thread func_27E8();
}

//Function Number: 28
balldrone_guardlocation()
{
	self.stoppedatlocation = 1;
	self method_82D9(self.origin);
}

//Function Number: 29
balldrone_seekclosesttarget()
{
	self endon("drone_shot_down");
	level endon("game_ended");
	thread balldrone_watchkamikazeinterrupt();
	self method_83E5(self.var_7247 + 25,20,20);
	var_00 = getvalidenemylist();
	var_01 = undefined;
	if(var_00.size > 0)
	{
		var_01 = sortbydistance(var_00,self.origin);
	}

	if(isdefined(var_01) && var_01.size > 0)
	{
		var_02 = balldrone_gettargetoffset(self,var_01[0]);
		self method_85C6(var_01[0],var_02,16,10);
		thread func_13B79(var_01[0]);
		self waittill("disengage_target");
		balldrone_guardlocation();
	}
}

//Function Number: 30
balldrone_watchkamikazeinterrupt()
{
	level endon("game_ended");
	self.var_222 endon("disconnect");
	var_00 = 100;
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E);
		var_0A = scripts\mp\_utility::func_13CA1(var_0A,var_0E);
		if(isdefined(var_02))
		{
			if(lib_0DF8::func_9DDF(var_02))
			{
				continue;
			}

			if(var_02.team == self.team && var_02 != self.var_222)
			{
				continue;
			}

			var_02 scripts\mp\_damagefeedback::func_12E84("");
		}

		var_00 = var_00 - var_01;
		if(var_00 <= 0)
		{
			self notify("drone_shot_down");
		}
	}
}

//Function Number: 31
balldrone_watchradarpulse()
{
	self endon("death");
	self endon("leaving");
	self endon("switch_modes");
	self.var_222 endon("disconnect");
	for(;;)
	{
		function_0222(self.origin,self.var_222);
		self.var_222 playsound("oracle_radar_pulse_npc");
		wait(3);
	}
}

//Function Number: 32
func_27DF()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.var_222 endon("death");
	self.var_222 endon("disconnect");
	self endon("owner_gone");
	self notify("ballDrone_moveToPlayer");
	self endon("ballDrone_moveToPlayer");
	var_00 = balldrone_gettargetoffset(self,self.var_222);
	self method_85C6(self.var_222,var_00,16,10);
	self.var_9A95 = 1;
	thread func_27E4();
}

//Function Number: 33
balldrone_watchmodeswitch()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.var_222 endon("disconnect");
	self endon("owner_gone");
	self.var_130AC scripts\mp\killstreaks\_utility::func_F774(self.var_222,self.var_4C08,360,360,30000,30000,3);
	for(;;)
	{
		self.var_130AC waittill("trigger",var_00);
		if(var_00 != self.var_222)
		{
			continue;
		}

		if(self.var_222 scripts\mp\_utility::func_9FC6())
		{
			continue;
		}

		if(isdefined(self.var_222.var_55E4) && self.var_222.var_55E4 > 0)
		{
			continue;
		}

		if(scripts\mp\_utility::func_9FAE(self.var_222))
		{
			continue;
		}

		var_01 = 0;
		while(self.var_222 usebuttonpressed())
		{
			var_01 = var_01 + 0.05;
			if(var_01 > 0.1)
			{
				self notify("switch_modes");
				self.var_222 playlocalsound("mp_killstreak_warden_switch_mode");
				self.var_BC = func_8026(self.var_BC,self.var_110E8);
				self notify(self.var_BC);
				if(self.var_BC == "ASSAULT")
				{
					var_02 = &"KILLSTREAKS_HINTS_VULTURE_SUPPORT";
					if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_guard"))
					{
						var_02 = &"KILLSTREAKS_HINTS_VULTURE_GUARD";
					}

					self method_8076();
					self.var_93AF = 0;
					self.var_129B9 notify("turretstatechange");
					thread func_27DA();
					thread func_27E7();
					thread func_27EA();
					thread func_27E8();
				}
				else
				{
					var_02 = &"KILLSTREAKS_HINTS_VULTURE_ASSAULT";
					if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_guard"))
					{
						self method_8076();
						self.var_2525 = undefined;
						balldrone_guardlocation();
					}
					else
					{
						self method_8076();
						self.var_2525 = undefined;
						self.var_93AF = 1;
						self.var_129B9 notify("turretstatechange");
						self.var_129B9 method_81D8();
						thread func_27DA();
						thread balldrone_watchradarpulse();
					}
				}

				self.var_130AC makeunusable();
				scripts\mp\_hostmigration::func_13708(1);
				self.var_4C08 = var_02;
				self.var_130AC scripts\mp\killstreaks\_utility::func_F774(self.var_222,self.var_4C08,360,360,30000,30000,3);
				break;
			}

			wait(0.05);
		}

		wait(0.05);
	}
}

//Function Number: 34
func_8026(param_00,param_01)
{
	if(param_00 == "ASSAULT")
	{
		param_00 = "SUPPORT";
		if(scripts\mp\killstreaks\_utility::func_A69F(param_01,"passive_guard"))
		{
			param_00 = "GUARD";
		}
	}
	else
	{
		param_00 = "ASSAULT";
	}

	return param_00;
}

//Function Number: 35
func_27E4()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.var_222 endon("death");
	self.var_222 endon("disconnect");
	self endon("owner_gone");
	self notify("ballDrone_watchForGoal");
	self endon("ballDrone_watchForGoal");
	var_00 = scripts\common\utility::func_13734("goal","near_goal","hit_goal");
	self.var_9A95 = 0;
	self.var_93AF = 0;
	self notify("hit_goal");
}

//Function Number: 36
func_DBD6()
{
	level endon("game_ended");
	self endon("death");
	self endon("drone_toggle");
	for(;;)
	{
		if(isdefined(self.var_11196) && self.var_11196)
		{
			wait(0.5);
			continue;
		}

		if(isdefined(self.var_93AF) && self.var_93AF)
		{
			wait(0.5);
			continue;
		}

		if(isdefined(self.var_DBBF))
		{
			self.var_DBBF moveto(self.origin,0.5);
		}

		wait(0.5);
	}
}

//Function Number: 37
func_B0C8()
{
	level endon("game_ended");
	self endon("drone_toggle");
	self endon("gone");
	self endon("death");
	var_00 = getentarray("low_entry","targetname");
	while(var_00.size > 0)
	{
		foreach(var_02 in var_00)
		{
			while(self istouching(var_02) || self.var_222 istouching(var_02))
			{
				if(isdefined(var_02.var_EE79))
				{
					self.var_B0C9 = float(var_02.var_EE79);
					continue;
				}

				self.var_B0C9 = 0.5;
				wait(0.1);
			}

			self.var_B0C9 = undefined;
		}

		wait(0.1);
	}
}

//Function Number: 38
func_27E3()
{
	level endon("game_ended");
	self endon("gone");
	self waittill("death");
	thread func_27ED();
}

//Function Number: 39
func_27EB()
{
	level endon("game_ended");
	self endon("death");
	self.var_222 endon("disconnect");
	self endon("owner_gone");
	var_00 = level.var_27F0[self.var_27F1];
	var_01 = var_00.var_11901;
	if(!isdefined(var_01))
	{
		return;
	}

	scripts\mp\_hostmigration::func_13708(var_01);
	if(isdefined(self.var_222) && isdefined(var_00.var_13553))
	{
		self.var_222 scripts\mp\_utility::func_D4B6(var_00.var_13553,undefined,undefined,self.var_222.origin);
	}

	thread func_27DE();
}

//Function Number: 40
func_27E6()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.var_222 waittill("killstreak_disowned");
	self notify("owner_gone");
	thread func_27DE();
}

//Function Number: 41
func_27E5()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	for(;;)
	{
		self.var_222 waittill("death");
		var_00 = level.var_27F0[self.var_27F1];
		if(isdefined(var_00.var_54CE) || scripts\mp\_utility::func_7ECE() && self.var_222.pers["deaths"] == scripts\mp\_utility::func_7ECE())
		{
			thread func_27DE();
		}
	}
}

//Function Number: 42
func_27E9()
{
	self endon("death");
	self endon("leaving");
	self.var_222 endon("disconnect");
	self endon("owner_gone");
	level scripts\common\utility::waittill_any_3("round_end_finished","game_ended");
	thread func_27DE();
}

//Function Number: 43
func_27DE()
{
	self endon("death");
	self notify("leaving");
	func_27EE();
}

//Function Number: 44
func_CA50()
{
	var_00 = "icon_minimap_vulture_enemy";
	self.var_6569 = func_49F8(var_00,1,1);
	foreach(var_02 in level.players)
	{
		if(!isplayer(var_02))
		{
			continue;
		}

		if(var_02 scripts\mp\_utility::_hasperk("specialty_engineer") && var_02.team != self.team)
		{
			if(self.var_6569 != -1)
			{
				scripts\mp\objidpoolmanager::minimap_objective_playermask_showto(self.var_6569,var_02 getentitynumber());
			}
		}
	}
}

//Function Number: 45
func_49F8(param_00,param_01,param_02)
{
	var_03 = scripts\mp\objidpoolmanager::requestminimapid(10);
	if(var_03 == -1)
	{
		return -1;
	}

	scripts\mp\objidpoolmanager::minimap_objective_add(var_03,"invisible",(0,0,0));
	if(!isdefined(self getlinkedparent()) && !scripts\mp\_utility::func_9FB3(param_01))
	{
		scripts\mp\objidpoolmanager::minimap_objective_position(var_03,self.origin);
	}
	else if(scripts\mp\_utility::func_9FB3(param_01) && scripts\mp\_utility::func_9FB3(param_02))
	{
		scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_03,self);
	}
	else
	{
		scripts\mp\objidpoolmanager::minimap_objective_onentity(var_03,self);
	}

	scripts\mp\objidpoolmanager::minimap_objective_state(var_03,"active");
	scripts\mp\objidpoolmanager::minimap_objective_icon(var_03,param_00);
	scripts\mp\objidpoolmanager::minimap_objective_playermask_hidefromall(var_03);
	return var_03;
}

//Function Number: 46
func_27DD()
{
	scripts\mp\_damage::func_B9C6(self.maxhealth,"ball_drone",::func_898F,::func_B938,1);
}

//Function Number: 47
func_27D5()
{
	self endon("death");
	self endon("stop_monitor_damage");
	level endon("game_ended");
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D);
		var_09 = scripts\mp\_utility::func_13CA1(var_09,var_0D);
		if(lib_0DF8::func_9DDF(var_01))
		{
			continue;
		}

		scripts\mp\_damage::func_B9C7(var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,"ball_drone",::func_898F,::func_B938,1);
	}
}

//Function Number: 48
func_27D6()
{
	self endon("death");
	self.parent endon("stop_monitor_damage");
	level endon("game_ended");
	self method_81F7();
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D);
		var_09 = scripts\mp\_utility::func_13CA1(var_09,var_0D);
		if(lib_0DF8::func_9DDF(var_01))
		{
			continue;
		}

		if(isdefined(self.parent))
		{
			self.parent scripts\mp\_damage::func_B9C7(var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,"ball_drone",::func_898F,::func_B938,1);
		}
	}
}

//Function Number: 49
func_B938(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_03;
	var_05 = scripts\mp\killstreaks\_utility::func_7FBD(param_00,param_01,param_02,var_05,self.maxhealth,1,1,2);
	return var_05;
}

//Function Number: 50
func_898F(param_00,param_01,param_02,param_03)
{
	if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_self_destruct"))
	{
		self notify("stop_monitor_damage");
		var_04 = 2.5;
		self.var_93AF = 1;
		self notify("switch_modes");
		balldrone_guardlocation();
		thread balldrone_seekclosesttarget();
		var_05 = self.var_222 scripts\mp\_utility::func_1302("dummy_spike_mp",self.origin,self.origin,var_04);
		if(!isdefined(var_05.var_13C2E))
		{
			var_05.var_13C2E = "dummy_spike_mp";
		}

		var_05 linkto(self);
		self setscriptablepartstate("shortout","active",0);
		self playsound("vulture_destruct_initiate");
		thread watchselfdestructfx();
		scripts\common\utility::waittill_any_timeout_1(var_04,"drone_shot_down");
		self playsound("vulture_destruct_warning");
		self setscriptablepartstate("shortout","neutral",0);
		playfx(scripts\common\utility::getfx("kamikaze_drone_explode"),self.origin);
		playsoundatpos(self.origin,"vulture_destruct");
		scripts\mp\_shellshock::func_22FF(1,0.7,800);
		if(isdefined(self.var_222))
		{
			self radiusdamage(self.origin,256,200,100,self.var_222,"MOD_EXPLOSIVE","ball_drone_gun_mp");
		}
	}

	var_06 = level.var_27F0[self.var_27F1];
	var_07 = "callout_destroyed_ball_drone";
	var_08 = scripts\mp\_killstreak_loot::getrarityforlootitem(self.var_110E8.var_1318B);
	if(var_08 != "")
	{
		var_07 = var_07 + "_" + var_08;
	}

	scripts\mp\_damage::func_C548(var_06.var_110EA,param_00,param_01,param_02,param_03,var_06.var_EC44,var_06.var_13523,var_07);
	if(self.var_27F1 == "ball_drone_backup")
	{
		param_00 scripts\mp\_missions::func_D992("ch_vulturekiller");
	}

	if(isdefined(param_01) && param_01 == "concussion_grenade_mp")
	{
		if(scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self.var_222,param_00)))
		{
			param_00 scripts\mp\_missions::func_D991("ch_tactical_emp_eqp");
		}
	}
}

//Function Number: 51
watchselfdestructfx()
{
	self endon("death");
	wait(0.4);
	self playsoundonmovingent("vulture_destruct_build_up");
}

//Function Number: 52
func_13A10()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01,var_02,var_03,var_04);
		scripts\mp\killstreaks\_utility::dodamagetokillstreak(100,var_00,var_00,self.team,var_02,var_04,var_03);
		if(!scripts\mp\_utility::func_9FB3(self.var_11196))
		{
			thread func_27E2(var_01);
		}
	}
}

//Function Number: 53
func_27E2(param_00)
{
	self notify("ballDrone_stunned");
	self endon("ballDrone_stunned");
	self endon("death");
	self.var_222 endon("disconnect");
	level endon("game_ended");
	if(scripts\mp\_utility::func_9FB3(self.var_2525))
	{
		self notify("disengage_target");
	}

	self.var_11196 = 1;
	if(isdefined(level.var_27F0[self.var_27F1].var_7638))
	{
		playfxontag(level.var_27F0[self.var_27F1].var_7638,self,"tag_origin");
	}

	if(self.var_27F1 == "ball_drone_radar")
	{
		if(isdefined(self.var_DBBF))
		{
			self.var_DBBF delete();
		}
	}

	if(isdefined(self.var_129B9))
	{
		self.var_129B9 notify("turretstatechange");
	}

	playfxontag(scripts\common\utility::getfx("emp_stun"),self,"tag_origin");
	scripts\mp\_hostmigration::func_13708(param_00);
	stopfxontag(scripts\common\utility::getfx("emp_stun"),self,"tag_origin");
	self.var_11196 = 0;
	if(self.var_27F1 == "ball_drone_radar")
	{
		var_01 = spawn("script_model",self.origin);
		var_01.team = self.team;
		var_01 method_81F3(self.var_222);
		self.var_DBBF = var_01;
	}

	if(isdefined(self.var_129B9))
	{
		self.var_129B9 notify("turretstatechange");
	}
}

//Function Number: 54
func_27ED()
{
	if(!isdefined(self))
	{
		return;
	}

	func_27EE();
}

//Function Number: 55
func_27EE()
{
	if(isdefined(level.var_27F0[self.var_27F1].var_7630))
	{
		playfx(level.var_27F0[self.var_27F1].var_7630,self.origin);
	}

	if(isdefined(level.var_27F0[self.var_27F1].var_1045F))
	{
		self playsound(level.var_27F0[self.var_27F1].var_1045F);
	}

	self notify("explode");
	func_E0D2();
	scripts\mp\_utility::func_D915("killstreak ended - ball_drone_backup",self.var_222);
}

//Function Number: 56
func_E0D2()
{
	scripts\mp\_utility::func_4FC1();
	if(isdefined(self.var_DBBF))
	{
		self.var_DBBF delete();
	}

	if(isdefined(self.var_130AC))
	{
		self.var_130AC delete();
	}

	if(isdefined(self.var_129B9))
	{
		self.var_129B9 method_835A(0);
		if(isdefined(self.var_129B9.var_92FD))
		{
			self.var_129B9.var_92FD delete();
		}

		if(isdefined(self.var_129B9.var_A63A))
		{
			self.var_129B9.var_A63A delete();
		}

		self.var_129B9 delete();
	}

	if(isdefined(self.var_6569))
	{
		scripts\mp\objidpoolmanager::returnminimapid(self.var_6569);
	}

	if(isdefined(self.var_222) && isdefined(self.var_222.var_27D3))
	{
		self.var_222.var_27D3 = undefined;
	}

	self.var_222 notify("eng_drone_update",-1);
	self delete();
}

//Function Number: 57
func_68C0()
{
	if(level.var_27EF.size >= scripts\mp\_utility::func_B4D2())
	{
		return 1;
	}

	return 0;
}

//Function Number: 58
func_27D4()
{
	self.var_131A0 endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("turretstatechange");
		if(self method_81A0() && isdefined(self.var_131A0.var_11196) && !self.var_131A0.var_11196 && isdefined(self.var_131A0.var_93AF) && !self.var_131A0.var_93AF)
		{
			self method_81D9();
			func_58ED(level.var_27F0[self.var_131A0.var_27F1].var_AF30);
			thread func_27D7();
			continue;
		}

		self method_81D8();
		thread func_27D8();
	}
}

//Function Number: 59
func_27D7()
{
	self.var_131A0 endon("death");
	self endon("stop_shooting");
	level endon("game_ended");
	var_00 = self.var_131A0;
	var_01 = function_0240(level.var_27F0[var_00.var_27F1].var_39B);
	var_02 = level.var_27F0[var_00.var_27F1].var_32C1;
	var_03 = level.var_27F0[var_00.var_27F1].var_C9D3;
	for(;;)
	{
		var_04 = var_02;
		for(var_05 = 0;var_05 < var_04;var_05++)
		{
			if(isdefined(var_00.var_93AF) && var_00.var_93AF)
			{
				break;
			}

			var_06 = self method_8166(0);
			if(isdefined(var_06) && func_3874(var_06))
			{
				var_00 method_8305(var_06);
				level thread scripts\mp\_battlechatter_mp::func_EB87(var_06,"plr_killstreak_target");
				self method_837E();
			}

			wait(var_01);
		}

		wait(var_03);
	}
}

//Function Number: 60
func_6D21()
{
	for(;;)
	{
		var_00 = self method_8166(0);
		if(isdefined(var_00) && func_3874(var_00))
		{
			scripts\mp\_utility::func_1309("alienvulture_mp",self gettagorigin("tag_flash"),var_00.origin,self.var_222);
		}

		var_01 = function_0240("alienvulture_mp");
		if(isdefined(level.var_2787) && isdefined(self.var_222))
		{
			var_01 = self [[ level.var_2787 ]](var_01,self.var_222);
		}

		wait(function_0240("alienvulture_mp"));
	}
}

//Function Number: 61
func_58ED(param_00)
{
	while(param_00 > 0)
	{
		self playsound(level.var_27F0[self.var_131A0.var_27F1].var_10472);
		wait(0.5);
		param_00 = param_00 - 0.5;
	}

	self playsound(level.var_27F0[self.var_131A0.var_27F1].var_10465);
}

//Function Number: 62
func_27D8()
{
	self notify("stop_shooting");
	if(isdefined(self.var_92FD))
	{
		self.var_131A0 method_8305(self.var_92FD);
	}
}

//Function Number: 63
func_3874(param_00)
{
	var_01 = 1;
	if(isplayer(param_00))
	{
		if(!scripts\mp\_utility::func_9F19(param_00) || param_00.sessionstate != "playing")
		{
			return 0;
		}

		if(param_00 scripts\mp\_utility::_hasperk("specialty_blindeye"))
		{
			return 0;
		}
	}

	if(level.teambased && isdefined(param_00.team) && param_00.team == self.team)
	{
		return 0;
	}

	if(isdefined(param_00.team) && param_00.team == "spectator")
	{
		return 0;
	}

	if(isplayer(param_00) && param_00 == self.var_222)
	{
		return 0;
	}

	if(isplayer(param_00) && isdefined(param_00.var_10916) && gettime() - param_00.var_10916 / 1000 <= 4)
	{
		return 0;
	}

	if(distancesquared(param_00.origin,self.origin) > level.var_27F0[self.var_131A0.var_27F1].var_1349E)
	{
		return 0;
	}

	if(isplayer(param_00) && scripts\mp\_utility::func_C7A0(self gettagorigin("tag_flash"),param_00 geteye()))
	{
		return 0;
	}

	if(!isplayer(param_00) && scripts\mp\_utility::func_C7A0(self gettagorigin("tag_flash"),param_00.origin))
	{
		return 0;
	}

	return var_01;
}

//Function Number: 64
balldrone_destroyongameend()
{
	self endon("death");
	level scripts\common\utility::waittill_any_3("bro_shot_start","game_ended");
	func_27ED();
}

//Function Number: 65
balldrone_gettargetoffset(param_00,param_01)
{
	var_02 = level.var_27F0[param_00.var_27F1];
	var_03 = var_02.var_2732;
	var_04 = var_02.var_101BA;
	var_05 = param_00 func_27DC(var_02);
	if(isdefined(param_00.var_B0C9))
	{
		var_05 = var_05 * param_00.var_B0C9;
	}

	var_06 = (var_04,var_03,var_05);
	return var_06;
}