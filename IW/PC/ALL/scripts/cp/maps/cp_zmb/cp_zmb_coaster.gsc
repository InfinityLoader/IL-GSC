/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_zmb\cp_zmb_coaster.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 45
 * Decompile Time: 2380 ms
 * Timestamp: 10/27/2023 12:08:02 AM
*******************************************************************/

//Function Number: 1
func_957B()
{
	scripts\common\utility::flag_init("coaster_active");
	var_00 = scripts\common\utility::getstructarray("coaster","script_noteworthy");
	level.var_42FC = [];
	foreach(var_02 in var_00)
	{
		var_02 thread func_42F9();
	}

	wait(5);
	var_04 = scripts\common\utility::getstruct("ice_frost","targetname");
	var_05 = getent(var_04.target,"targetname");
	var_05 thread func_7380();
}

//Function Number: 2
func_42F9()
{
	level.var_E681 = [];
	level.var_42F7 = getvehiclenode("coaster_start_node","targetname");
	level.var_42F3 = getvehiclenode("coaster_transition_node","targetname");
	level.var_E681[0] = spawnvehicle("park_roller_coaster_cart","coaster","cp_roller_coaster",level.var_42F7.origin,level.var_42F7.angles);
	level.var_E681[1] = spawnvehicle("park_roller_coaster_cart","coaster","cp_roller_coaster",level.var_42F3.origin,level.var_42F3.angles);
	var_00 = getentarray("coaster_dmg_trig","targetname");
	level.var_E681[0].var_5761 = scripts\common\utility::getclosest(level.var_E681[0].origin,var_00);
	level.var_E681[0].var_5761 enablelinkto();
	level.var_E681[0].var_5761 linkto(level.var_E681[0]);
	level.var_E681[1].var_5761 = scripts\common\utility::getclosest(level.var_E681[1].origin,var_00);
	level.var_E681[1].var_5761 enablelinkto();
	level.var_E681[1].var_5761 linkto(level.var_E681[1]);
	level thread func_42EA(level.var_E681[1].var_5761);
	level thread func_42EA(level.var_E681[0].var_5761);
	level.var_E681[0] attachpath(level.var_42F7);
	level.var_E681[1] attachpath(level.var_42F3);
	var_01 = scripts\common\utility::istrue(self.var_E1B9) && isdefined(self.var_D71C);
	level thread func_42ED();
	self.var_76F2 = getentarray(self.target,"targetname");
	level thread func_42F8(self);
	for(;;)
	{
		var_02 = "power_on";
		if(var_01)
		{
			var_02 = level scripts\common\utility::waittill_any_return_no_endon_death_3("power_on",self.var_D71C + " power_on","power_off");
		}

		if(var_02 != "power_off")
		{
			setomnvar("zm_coaster1_ent",level.var_E681[0]);
			setomnvar("zm_coaster2_ent",level.var_E681[1]);
			scripts\cp\_interaction::remove_from_current_interaction_list(self);
			self.var_D776 = 1;
			func_C602();
			scripts\cp\_interaction::add_to_current_interaction_list(self);
			setomnvar("zombie_coasterInfo",0);
			var_03 = ["announcer_polarpeaks_description","announcer_polarpeaks_start"];
			level thread scripts\cp\_music_and_dialog::func_1752(var_03,(-224,-2160,720),120,120,2250000,100);
		}
		else
		{
			setomnvar("zombie_coasterInfo",-1);
			self.var_D776 = 0;
			func_426E();
		}

		if(!var_01)
		{
			break;
		}
	}
}

//Function Number: 3
func_1297B()
{
	var_00 = getentarray("coaster_ice_monster","targetname");
	foreach(var_02 in var_00)
	{
		if(var_02.script_noteworthy == "idle")
		{
			var_02 setscriptablepartstate("main",scripts\common\utility::random(["idle1","idle2"]));
			continue;
		}

		if(var_02.script_noteworthy == "stoke")
		{
			var_02 setscriptablepartstate("main","stoke");
			continue;
		}

		if(var_02.script_noteworthy == "scare")
		{
			var_02 setscriptablepartstate("main","scare1");
			continue;
		}

		if(var_02.script_noteworthy == "sit")
		{
			var_02 setscriptablepartstate("main","sit");
		}
	}

	foreach(var_06, var_05 in level.players)
	{
		setomnvar("zm_coaster_hiscore_p" + var_06 + 1,0);
		var_05.var_42EE = 0;
		setomnvar("zm_coaster_pic_p" + int(var_05 getentitynumber() + 1),var_05.var_CFC4);
	}
}

//Function Number: 4
func_C602()
{
	foreach(var_01 in self.var_76F2)
	{
		var_01 rotateto(var_01.var_ECF3,1);
	}
}

//Function Number: 5
func_426E()
{
	foreach(var_01 in self.var_76F2)
	{
		var_01 rotateto((0,270,0),1);
	}
}

//Function Number: 6
func_42F8(param_00)
{
	level.var_11922 = 0;
	while(!param_00.var_D776)
	{
		wait(0.05);
	}

	for(;;)
	{
		var_01 = level scripts\common\utility::func_13734("coaster_started","regular_wave_starting","event_wave_starting");
		if(var_01 == "coaster_started")
		{
			level.var_11922++;
			if(level.var_11922 >= 2 || level.players.size == 1)
			{
				param_00.out_of_order = 1;
				param_00 func_426E();
				setomnvar("zombie_coasterInfo",-1);
			}

			continue;
		}

		level.var_11922 = 0;
		if(scripts\common\utility::istrue(param_00.out_of_order))
		{
			param_00.out_of_order = 0;
			param_00 func_C602();
			foreach(var_03 in level.players)
			{
				if(isdefined(var_03.var_A8D3) && var_03.var_A8D3 == param_00)
				{
					var_03 thread scripts\cp\_interaction::func_DE6E();
				}
			}
		}

		var_05 = getomnvar("zombie_coasterInfo");
		if(var_05 <= 0)
		{
			setomnvar("zombie_coasterInfo",0);
		}
	}
}

//Function Number: 7
func_42ED()
{
	for(;;)
	{
		level waittill("coaster_started",var_00);
		var_00.var_E4FF = 1;
		wait(5);
		var_01 = undefined;
		foreach(var_03 in level.var_E681)
		{
			if(var_03 == var_00)
			{
				continue;
			}
			else
			{
				var_01 = var_03;
			}
		}

		if(isdefined(var_01.var_E4FF))
		{
			var_01 waittill("ride_finished");
		}

		wait(1);
		var_01 attachpath(level.var_42F3);
		var_01 startpath();
	}
}

//Function Number: 8
func_10BF1(param_00,param_01)
{
	var_02 = 8;
	if(isdefined(param_01.var_AD27))
	{
		var_02 = 4 * param_01.var_AD27;
	}

	level notify("coaster_started",param_01);
	scripts\cp\zombies\zombies_spawning::func_93EB(var_02);
	param_01 attachpath(level.var_42F7);
	param_01 startpath();
	if(isdefined(param_01.var_AD27))
	{
		param_01 thread func_42F6();
	}

	param_01 waittill("reached_end_node");
	if(isdefined(param_01.var_AD27))
	{
		param_01 func_12BB0(param_01);
	}

	param_01 notify("ride_finished");
	param_01.var_E4FF = undefined;
	if(isdefined(param_01.var_AD27))
	{
		var_02 = 4 * param_01.var_AD27;
	}

	scripts\cp\zombies\zombies_spawning::func_4FB8(var_02);
}

//Function Number: 9
func_12FBD(param_00,param_01)
{
	if(!param_01 scripts\cp\_utility::isteleportenabled())
	{
		param_01 scripts\cp\_interaction::func_DE6E();
		return;
	}

	if(scripts\common\utility::istrue(param_01.coaster_ridden_this_round))
	{
		param_01 scripts\cp\_interaction::func_9A3C(param_00,&"CP_ZMB_INTERACTIONS_ALREADY_RIDDEN");
		wait(0.1);
		return;
	}

	if(param_01 secondaryoffhandbuttonpressed() || param_01 fragbuttonpressed())
	{
		param_01 scripts\cp\_interaction::func_DE6E();
		return;
	}

	if(scripts\common\utility::istrue(param_01.var_9FCB))
	{
		param_01 notify("coaster_ride_beginning");
		wait(0.5);
	}

	param_01 scripts\cp\_damage::func_12EA8("standard_cp");
	param_01 scripts\cp\powers\coop_powers::func_D728();
	param_01 scripts\cp\_utility::allow_player_teleport(0);
	param_01.coaster_ridden_this_round = 1;
	level.var_13BD4 = level.wave_num;
	var_02 = scripts\common\utility::getclosest(param_00.origin,level.var_E681);
	if(!isdefined(var_02.var_AD27))
	{
		var_02.var_AD27 = 0;
	}

	var_02.var_AD27++;
	if(var_02.var_AD27 >= 2)
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	}

	scripts\cp\zombies\zombie_analytics::func_AF8C("coaster",param_01);
	if(!isdefined(param_00.var_E4F7))
	{
		param_00.var_E4F7 = 1;
		level thread func_E4EA(param_00,var_02);
	}

	param_01 thread func_42F5();
	param_01 thread scripts\cp\_vo::try_to_play_vo("coaster_ride","zmb_comment_vo");
	level thread func_AD0B(param_01,var_02);
}

//Function Number: 10
func_42F5()
{
	self endon("ride_over");
	self endon("disconnect");
	self endon("last_stand");
	scripts\common\utility::delaycall(3.76,::playlocalsound,"scn_rollercoaster_plr_lr_01",self);
	var_00 = getvehiclenode(level.var_42F7.target,"targetname");
	for(;;)
	{
		var_00 waittill("trigger");
		if(isdefined(var_00.name))
		{
			switch(var_00.name)
			{
				case "coaster_sound_2":
					self playlocalsound("scn_rollercoaster_plr_lr_02",self);
					break;
	
				case "coaster_sound_3":
					self playlocalsound("scn_rollercoaster_plr_lr_03",self);
					break;
	
				default:
					break;
			}
		}

		if(!isdefined(var_00.target))
		{
			break;
		}

		var_00 = getvehiclenode(var_00.target,"targetname");
	}
}

//Function Number: 11
func_E4EA(param_00,param_01)
{
	wait(5);
	level thread func_11AB9(param_01);
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	level thread func_42E8(param_00,param_01);
	param_01 thread func_42F4();
}

//Function Number: 12
func_11AB9(param_00)
{
	param_00.var_6009 = 0;
	param_00 endon("ride_finished");
	for(;;)
	{
		wait(1);
		param_00.var_6009++;
	}
}

//Function Number: 13
func_42E8(param_00,param_01)
{
	level thread func_10BF1(param_00,param_01);
	param_00 func_426E();
	var_02 = undefined;
	foreach(var_04 in level.var_E681)
	{
		if(var_04 == param_01)
		{
			continue;
		}
		else
		{
			var_02 = var_04;
		}
	}

	if(isdefined(var_02.var_E4FF))
	{
		for(var_06 = 25 + 86 - var_02.var_6009;var_06 > 0;var_06--)
		{
			if(!scripts\common\utility::istrue(param_00.out_of_order))
			{
				setomnvar("zombie_coasterInfo",var_06);
			}
			else
			{
				setomnvar("zombie_coasterInfo",-1);
			}

			wait(1);
		}
	}
	else
	{
		for(var_07 = 25;var_07 >= 0;var_07--)
		{
			if(!scripts\common\utility::istrue(param_00.out_of_order))
			{
				setomnvar("zombie_coasterInfo",var_07);
			}
			else
			{
				setomnvar("zombie_coasterInfo",-1);
			}

			wait(1);
		}
	}

	param_00.var_E4F7 = undefined;
	if(!scripts\common\utility::istrue(param_00.out_of_order))
	{
		param_00 func_C602();
		setomnvar("zombie_coasterInfo",0);
	}

	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
}

//Function Number: 14
func_AD0B(param_00,param_01)
{
	var_02 = "tag_guy0" + param_01.var_AD27;
	param_00 setplayerangles((0,0,0));
	param_00 playerlinktodelta(param_01,var_02,0,60,60,60,15,0);
	param_00 allowstand(0);
	param_00 allowprone(0);
	param_00 method_8012(0);
	param_00 setclientomnvar("zombie_arcade_game_time",1);
	param_00.var_AD2C = 1;
	param_00.disable_consumables = 1;
	param_00 scripts\cp\_utility::func_1C5D(0);
	param_00.var_AD1C = param_01;
	param_00.var_F084 = param_01.var_AD27;
	param_00 scripts\cp\_utility::func_1C5C(1);
	param_00.var_D7AB = param_00 scripts\cp\zombies\arcade_game_utility::func_EB76(param_00);
	param_00 giveweapon("iw7_zm1coaster_zm");
	param_00 switchtoweapon("iw7_zm1coaster_zm");
	param_00 scripts\common\utility::func_1C76(0);
	param_00 scripts\common\utility::func_1C6E(0);
	param_00 thread func_42F1(param_00);
	param_00 thread func_42EF(param_00);
	if(param_01 == level.var_E681[0])
	{
		setomnvar("zm_coaster_score_p" + param_00.var_F084 + "_c1",0);
	}
	else
	{
		setomnvar("zm_coaster_score_p" + param_00.var_F084 + "_c2",0);
	}

	scripts\common\utility::func_136F7();
	param_00 setclientomnvar("zombie_coaster_ticket_earned",-1);
	scripts\common\utility::func_136F7();
	param_00.var_11580 = 0;
	param_00.var_1189F = 0;
	wait(5);
	param_00 scripts\cp\_utility::setlowermessage("coaster",&"CP_ZMB_INTERACTIONS_COASTER_HINT",4);
}

//Function Number: 15
coaster_laststand_vos(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("game_ended");
	param_00 thread scripts\cp\_vo::try_to_play_vo("laststand_coaster","zmb_comment_vo");
}

//Function Number: 16
func_42F1(param_00)
{
	param_00 endon("ride_over");
	param_00 endon("disconnect");
	param_00 waittill("last_stand");
	param_00 stoplocalsound("scn_rollercoaster_plr_lr_01");
	param_00 stoplocalsound("scn_rollercoaster_plr_lsrs_01");
	param_00 stoplocalsound("scn_rollercoaster_plr_lr_02");
	param_00 stoplocalsound("scn_rollercoaster_plr_lsrs_02");
	param_00 stoplocalsound("scn_rollercoaster_plr_lr_03");
	param_00 stoplocalsound("scn_rollercoaster_plr_lsrs_03");
	level thread coaster_laststand_vos(param_00);
	param_00 unlink();
	scripts\cp\zombies\zombies_spawning::func_4FB8(4);
	var_01 = "coaster_exit" + param_00 getentitynumber();
	var_02 = scripts\common\utility::getstruct(var_01,"targetname");
	param_00 setorigin(var_02.origin);
	param_00 setplayerangles(var_02.angles);
	param_00 allowstand(1);
	param_00 allowprone(1);
	param_00 method_8012(1);
	param_00.var_AD2C = undefined;
	param_00.disable_consumables = undefined;
	if(!param_00 scripts\cp\_utility::func_213E())
	{
		param_00 scripts\cp\_utility::func_1C5D(1);
	}

	param_00.var_AD1C.var_AD27--;
	if(param_00.var_AD1C.var_AD27 <= 0)
	{
		param_00.var_AD1C.var_AD27 = undefined;
	}

	param_00.var_AD1C = undefined;
	param_00 scripts\cp\powers\coop_powers::func_D72E();
	param_00 scripts\common\utility::func_1C76(1);
	if(!param_00 scripts\common\utility::func_9FBE())
	{
		param_00 scripts\common\utility::func_1C6E(1);
	}

	param_00 setclientomnvar("zombie_coaster_ticket_earned",-1);
	param_00 setclientomnvar("zombie_arcade_game_time",-1);
	if(param_00 scripts\cp\_utility::func_9E3A())
	{
		param_00 scripts\cp\_utility::func_1C5C(0);
	}

	if(!param_00 scripts\cp\_utility::isteleportenabled())
	{
		param_00 scripts\cp\_utility::allow_player_teleport(1);
	}

	param_00 thread func_100FA();
	param_00 notify("ride_over");
}

//Function Number: 17
func_42EF(param_00)
{
	param_00 endon("last_stand");
	param_00 endon("ride_over");
	for(;;)
	{
		param_00 waittill("weapon_fired");
		param_00 givemaxammo("iw7_zm1coaster_zm");
		param_00 setweaponammoclip("iw7_zm1coaster_zm",weaponclipsize("iw7_zm1coaster_zm"));
	}
}

//Function Number: 18
func_12BB0(param_00)
{
	foreach(var_02 in level.players)
	{
		if(!isdefined(var_02.var_AD2C))
		{
			continue;
		}

		if(!isdefined(var_02.var_AD1C) || var_02.var_AD1C != param_00)
		{
			continue;
		}

		var_03 = "coaster_exit" + var_02 getentitynumber();
		var_04 = scripts\common\utility::getstruct(var_03,"targetname");
		var_02 setorigin(var_04.origin);
		var_02 setplayerangles(var_04.angles);
		var_02 unlink();
		var_02 allowstand(1);
		var_02 allowprone(1);
		var_02 method_8012(1);
		var_02.var_AD2C = undefined;
		var_02.disable_consumables = undefined;
		if(!var_02 scripts\cp\_utility::func_213E())
		{
			var_02 scripts\cp\_utility::func_1C5D(1);
		}

		var_02.var_AD1C = undefined;
		var_02 setstance("stand");
		var_02 scripts\cp\powers\coop_powers::func_D72E();
		var_02 scripts\common\utility::func_1C76(1);
		if(!var_02 scripts\common\utility::func_9FBE())
		{
			var_02 scripts\common\utility::func_1C6E(1);
		}

		var_02 takeweapon("iw7_zm1coaster_zm");
		var_02 scripts\cp\zombies\arcade_game_utility::func_82F5(var_02);
		var_02 setclientomnvar("zombie_coaster_ticket_earned",-1);
		var_02 setclientomnvar("zombie_arcade_game_time",-1);
		if(var_02 scripts\cp\_utility::func_9E3A())
		{
			var_02 scripts\cp\_utility::func_1C5C(0);
		}

		if(!var_02 scripts\cp\_utility::isteleportenabled())
		{
			var_02 scripts\cp\_utility::allow_player_teleport(1);
		}

		var_02 notify("ride_over");
	}

	param_00.var_AD27 = undefined;
}

//Function Number: 19
func_42F6()
{
	self endon("ride_finished");
	level endon("game_ended");
	self.var_9AB0 = 0.1;
	self.var_9AAF = 0.12;
	wait(15);
	for(;;)
	{
		var_00 = self.origin;
		earthquake(randomfloatrange(self.var_9AB0,self.var_9AAF),2,var_00,200);
		wait(randomfloatrange(0.25,0.75));
	}
}

//Function Number: 20
func_42F4()
{
	var_00 = getvehiclenode(level.var_42F7.target,"targetname");
	for(;;)
	{
		var_00 waittill("trigger");
		if(isdefined(var_00.script_noteworthy))
		{
			switch(var_00.script_noteworthy)
			{
				case "open_door":
					level thread func_C5E2(var_00);
					break;
	
				case "close_door":
					level thread func_4256(var_00);
					break;
	
				case "score_tally":
					level thread func_100F3(self);
					break;
	
				case "activate_targets":
					level notify("activate_" + var_00.script_label);
					break;
	
				case "spawn_coaster_group3":
				case "spawn_coaster_group2":
				case "spawn_coaster_group1":
				case "spawn_coaster_group0":
					level thread func_1068B(var_00.script_noteworthy,::func_42FB,self);
					break;
	
				case "delete_laser":
					break;
	
				default:
					level thread func_107EB(var_00.script_noteworthy,self);
					break;
			}
		}

		if(!isdefined(var_00.target))
		{
			break;
		}

		var_00 = getvehiclenode(var_00.target,"targetname");
	}
}

//Function Number: 21
func_1068B(param_00,param_01,param_02)
{
	if(!isdefined(param_02.var_AD27) || param_02.var_AD27 == 0)
	{
		return;
	}

	var_03 = scripts\common\utility::getstructarray(param_00,"targetname");
	var_04 = 0;
	if(param_02.var_AD27 == 1)
	{
		var_04 = 1;
	}

	foreach(var_0A, var_06 in var_03)
	{
		var_06.var_9B95 = 1;
		for(;;)
		{
			var_07 = var_06 scripts\cp\zombies\zombies_spawning::func_1081B("generic_zombie",1);
			if(isdefined(var_07))
			{
				break;
			}

			wait(0.05);
		}

		var_07.entered_playspace = 1;
		var_07.nocorpse = 1;
		var_07.health = 100;
		var_07.var_9CDD = 1;
		var_07.var_FF78 = 0;
		var_07.var_9CA2 = 1;
		var_07.is_coaster_zombie = 1;
		var_07 setscriptablepartstate("eyes","eye_glow_off");
		var_07 detachall();
		var_08 = ["park_clown_zombie","park_clown_zombie_blue","park_clown_zombie_green","park_clown_zombie_orange","park_clown_zombie_yellow"];
		var_09 = scripts\common\utility::random(var_08);
		var_07 setmodel(var_09);
		var_07 thread [[ param_01 ]](param_02);
		var_07 thread func_50E9(15);
		if(var_04 && var_03.size > 2 && var_0A >= scripts\cp\_utility::func_E76A(var_03.size * 0.65))
		{
			return;
		}
	}
}

//Function Number: 22
func_50E9(param_00)
{
	self endon("death");
	wait(param_00);
	self dodamage(150,self.origin);
}

//Function Number: 23
func_42FB(param_00)
{
	self endon("death");
	thread func_699B(param_00);
	self.var_1F5 = "walk";
	self.var_BCE4 = 1;
	self.var_126E8 = 1;
	self.var_772A = 1;
	for(;;)
	{
		self method_82ED(param_00);
		wait(0.1);
	}
}

//Function Number: 24
func_699B(param_00)
{
	self endon("death");
	var_01 = 0;
	var_02 = 21904;
	while(!var_01)
	{
		foreach(var_04 in level.players)
		{
			if(distancesquared(self.origin,var_04.origin) <= var_02)
			{
				var_01 = 1;
			}
		}

		if(var_01)
		{
			break;
		}

		wait(0.05);
	}

	foreach(var_04 in level.players)
	{
		if(!isdefined(var_04.var_AD1C) || var_04.var_AD1C != param_00)
		{
			continue;
		}

		if(var_04 scripts\cp\_utility::has_zombie_perk("perk_machine_tough"))
		{
			var_04 dodamage(90,var_04.origin,self,self,"MOD_EXPLOSIVE");
			continue;
		}

		var_04 dodamage(45,var_04.origin,self,self,"MOD_EXPLOSIVE");
	}

	self dodamage(150,self.origin);
}

//Function Number: 25
func_C5E2(param_00)
{
	switch(param_00.var_EE79)
	{
		case "coaster_door_1":
			level thread func_C5E7(param_00);
			break;

		case "coaster_door_2":
			level thread func_C5E7(param_00);
			break;

		case "coaster_door_3":
			level thread func_C5E7(param_00);
			level thread func_42E9(param_00);
			break;

		case "coaster_door_4":
			level thread func_C5E7(param_00);
			level thread func_C5E1();
			level thread func_9286();
			break;
	}
}

//Function Number: 26
func_9286()
{
	var_00 = scripts\common\utility::getstruct("ice_frost","targetname");
	var_01 = spawnfx(level._effect["coaster_ice_frost"],var_00.origin,anglestoforward(var_00.angles),anglestoup(var_00.angles));
	wait(0.1);
	triggerfx(var_01);
	wait(5);
	var_01 delete();
}

//Function Number: 27
func_7380()
{
	var_00 = scripts\common\utility::getstruct("ice_frost","targetname");
	var_01 = spawnfx(level._effect["coaster_ice_frost"],var_00.origin,anglestoforward(var_00.angles),anglestoup(var_00.angles));
	wait(1);
	triggerfx(var_01);
	for(;;)
	{
		self waittill("trigger",var_02);
		if(!scripts\cp\_utility::func_FF18(var_02) && isdefined(var_02.var_EF89))
		{
			continue;
		}
		else
		{
			var_02 thread func_3E72();
		}
	}
}

//Function Number: 28
func_3E72()
{
	self endon("disconnect");
	self.var_EF89 = function_01E1(level._effect["coaster_full_screen"],self geteye(),self);
	wait(0.1);
	triggerfx(self.var_EF89);
	scripts\common\utility::waittill_any_timeout_1(5,"last_stand");
	self.var_EF89 delete();
	self.var_EF89 = undefined;
}

//Function Number: 29
func_4256(param_00)
{
	switch(param_00.var_EE79)
	{
		case "coaster_door_1":
			level thread func_425B(param_00);
			break;

		case "coaster_door_2":
			level thread func_425B(param_00);
			break;

		case "coaster_door_3":
			level thread func_425B(param_00);
			break;

		case "coaster_door_4":
			level thread func_425B(param_00);
			break;
	}
}

//Function Number: 30
func_C5E7(param_00)
{
	var_01 = getentarray(param_00.var_EE79,"targetname");
	foreach(var_03 in var_01)
	{
		if(var_03.model == "zmb_triton_ice_door_r_01")
		{
			var_03 rotateyaw(-80,1);
			continue;
		}

		var_03 rotateyaw(80,1);
	}
}

//Function Number: 31
func_425B(param_00)
{
	var_01 = getentarray(param_00.var_EE79,"targetname");
	foreach(var_03 in var_01)
	{
		if(var_03.model == "zmb_triton_ice_door_r_01")
		{
			var_03 rotateyaw(80,1);
			continue;
		}

		var_03 rotateyaw(-80,1);
	}
}

//Function Number: 32
func_42E9(param_00)
{
	var_01 = getentarray(param_00.var_EE79,"targetname");
	earthquake(0.34,5,var_01[0].origin,500);
	var_02 = scripts\common\utility::getstruct("coaster_rocks","targetname");
	playfx(level._effect["coaster_rocks"],var_02.origin);
	for(;;)
	{
		wait(1.65);
		if(!isdefined(var_02.target))
		{
			return;
		}

		var_02 = scripts\common\utility::getstruct(var_02.target,"targetname");
		earthquake(0.34,3,var_02.origin + (0,0,-200),700);
		playfx(level._effect["coaster_rocks"],var_02.origin);
	}
}

//Function Number: 33
func_C5E1(param_00)
{
	wait(2.5);
	var_01 = getent("coaster_door_4a","targetname");
	var_02 = getent("coaster_door_4b","targetname");
	var_01 rotateyaw(110,0.5);
	wait(3.75);
	var_02 rotateyaw(-110,0.5);
	wait(5);
	var_01 rotateyaw(-110,0.5);
	wait(1);
	var_02 rotateyaw(110,0.5);
}

//Function Number: 34
func_107EB(param_00,param_01)
{
	var_02 = scripts\common\utility::getstructarray(param_00,"targetname");
	var_03 = [];
	foreach(var_06, var_05 in var_02)
	{
		var_03[var_06] = spawn("script_model",var_05.origin);
		var_03[var_06].angles = var_05.angles;
		var_03[var_06].struct = var_05;
		var_03[var_06] setmodel(var_05.var_EE79);
		wait(0.1);
	}

	level waittill("activate_" + param_00);
	foreach(var_08 in var_03)
	{
		var_08 thread func_11553();
		wait(0.15);
	}

	if(param_00 == "targets_group6")
	{
		level thread func_10757(var_03,param_01);
	}

	level thread func_869E(var_03);
}

//Function Number: 35
func_10757(param_00,param_01)
{
	var_02 = scripts\common\utility::getstructarray("coaster_laser_fx_spot","targetname");
	var_03 = getentarray("coaster_laser_trigger","targetname");
	foreach(var_05 in var_02)
	{
		var_06 = spawnfx(level._effect["coaster_laser"],var_05.origin,anglestoforward(var_05.angles),anglestoup(var_05.angles));
		scripts\common\utility::func_136F7();
		triggerfx(var_06);
		var_05.var_7542 = var_06;
		var_05.trigger = scripts\common\utility::getclosest(var_05.origin,var_03);
		level thread func_A86E(var_05);
		level thread func_A867(var_05,param_01);
	}

	level thread func_A86D(var_02,param_00);
}

//Function Number: 36
func_A86E(param_00)
{
	param_00.trigger endon("target_shot");
	wait(15);
	param_00.var_7542 delete();
	param_00.trigger notify("target_shot");
}

//Function Number: 37
func_A86D(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		if(isdefined(var_03.struct.script_noteworthy) && isdefined(var_03.struct.script_noteworthy == "laser_target"))
		{
			var_03 thread func_13958(param_00);
		}
	}
}

//Function Number: 38
func_A867(param_00,param_01)
{
	param_00.trigger endon("target_shot");
	for(;;)
	{
		param_00.trigger waittill("trigger",var_02);
		if(isplayer(var_02))
		{
			break;
		}
	}

	foreach(var_04 in level.players)
	{
		if(!isdefined(var_04.var_AD1C) || var_04.var_AD1C != param_01)
		{
			continue;
		}

		if(var_04 scripts\cp\_utility::has_zombie_perk("perk_machine_tough"))
		{
			var_04 dodamage(90,var_04.origin,param_00.trigger,param_00.trigger,"MOD_EXPLOSIVE");
		}
		else
		{
			var_04 dodamage(50,var_04.origin,param_00.trigger,param_00.trigger,"MOD_EXPLOSIVE");
		}

		var_04 shellshock("default",1.25);
	}

	earthquake(0.3,1,param_00.origin,500);
	param_00.var_7542 delete();
	param_00.trigger notify("target_shot");
}

//Function Number: 39
func_13958(param_00)
{
	var_01 = scripts\common\utility::getclosest(self.origin,param_00);
	var_01.trigger endon("target_shot");
	for(;;)
	{
		self waittill("damage",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
		if(!isdefined(var_03) || !isdefined(var_0B) || !isdefined(var_03.var_AD2C))
		{
			continue;
		}

		playfx(level._effect["coaster_laser_exp"],self.origin);
		var_01.var_7542 delete();
		var_01.trigger notify("target_shot");
	}
}

//Function Number: 40
func_11553()
{
	self endon("death");
	if(isdefined(self.struct.script_delay))
	{
		wait(self.struct.script_delay);
	}

	self playsound("rollercoaster_sign_up");
	self.var_C378 = self.angles;
	var_00 = scripts\common\utility::getstruct(self.struct.target,"targetname");
	self rotateto(var_00.angles,0.25);
	self.health = 999999;
	self setcandamage(1);
	var_01 = 5;
	for(;;)
	{
		self waittill("damage",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
		if(!isdefined(var_03) || !isdefined(var_0B) || !isdefined(var_03.var_AD2C))
		{
			continue;
		}

		self.health = 999999;
		if(var_0B == "iw7_zm1coaster_zm")
		{
			var_03 setclientomnvar("damage_feedback_kill",1);
			var_03 setclientomnvar("damage_feedback_notify",gettime());
			var_03.var_11580++;
			var_03.var_1189F = var_03.var_11580 * var_01;
			scripts\common\utility::func_136F7();
			var_03 thread scripts\cp\_vo::try_to_play_vo("coaster_ride_shot","zmb_comment_vo","low",10,0,0,1,10);
			var_0C = var_03.var_AD1C;
			if(var_0C == level.var_E681[0])
			{
				setomnvar("zm_coaster_score_p" + var_03.var_F084 + "_c1",var_03.var_11580);
			}
			else
			{
				setomnvar("zm_coaster_score_p" + var_03.var_F084 + "_c2",var_03.var_11580);
			}

			if(!isdefined(var_03.var_42EE))
			{
				var_03.var_42EE = 0;
			}

			if(var_03.var_11580 > var_03.var_42EE)
			{
				setomnvar("zm_coaster_hiscore_p" + int(var_03 getentitynumber() + 1),var_03.var_11580);
				var_03.var_42EE = var_03.var_11580;
			}

			var_03 notify("coaster_target_hit_notify");
			self playsound("rollercoaster_target_pings");
			self rotateto(self.var_C378,0.25);
			return;
		}
	}
}

//Function Number: 41
func_869E(param_00)
{
	wait(20);
	foreach(var_02 in param_00)
	{
		var_02 delete();
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 42
func_100F3(param_00)
{
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02.var_AD1C) && var_02.var_AD1C == param_00)
		{
			var_02 thread scripts\cp\_vo::try_to_play_vo("coaster_ride_sucess","zmb_comment_vo","low",10,0,0,0,50);
			var_02 thread func_100FA();
			var_02 thread func_42EB();
		}
	}
}

//Function Number: 43
func_100FA()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < self.var_11580;var_01++)
	{
		self playlocalsound("zmb_wheel_spin_tick");
		self setclientomnvar("zombie_coaster_ticket_earned",var_01 + 1 * 10);
		var_00++;
		wait(0.1);
	}

	self playlocalsound("zmb_ui_earn_tickets");
	wait(0.25);
	if(var_00 > 0 && !scripts\common\utility::istrue(self.inlaststand))
	{
		thread scripts\cp\_vo::try_to_play_vo("arcade_complete","zmb_comment_vo","low",10,0,0,0,45);
		scripts\cp\zombies\zombie_analytics::func_AF6E(1,self,level.var_13BD4,"coaster",0,var_00,self.pers["timesPerWave"].var_11930[level.var_13BD4]["coaster"]);
	}

	scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(self);
	self setclientomnvar("zombie_coaster_ticket_earned",-1);
}

//Function Number: 44
func_42EB()
{
	wait(2);
	self playlocalsound("announcer_polarpeaks_finish");
}

//Function Number: 45
func_42EA(param_00)
{
	level endon("game_ended");
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!scripts\cp\_utility::func_FF18(var_01))
		{
			continue;
		}

		var_01.var_B36E = 1;
		var_01 dodamage(var_01.health + 50,param_00.origin);
	}
}