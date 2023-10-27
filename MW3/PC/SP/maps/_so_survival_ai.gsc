/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_so_survival_ai.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 145
 * Decompile Time: 2560 ms
 * Timestamp: 10/27/2023 2:21:15 AM
*******************************************************************/

//Function Number: 1
ai_preload()
{
	ai_preload_weapons();
	precacheheadicon("headicon_delta_so");
	precacheheadicon("headicon_gign_so");
	precachemodel("weapon_c4");
	level._effect["martyrdom_c4_explosion"] = loadfx("explosions/grenadeExp_metal");
	level._effect["martyrdom_dlight_red"] = loadfx("misc/dlight_red");
	level._effect["martyrdom_red_blink"] = loadfx("misc/power_tower_light_red_blink");
	precachemodel("weapon_claymore");
	level._effect["claymore_laser"] = loadfx("misc/claymore_laser");
	level._effect["claymore_explosion"] = loadfx("explosions/grenadeExp_metal");
	level._effect["claymore_disabled"] = loadfx("explosions/sentry_gun_explosion");
	precachemodel("gas_canisters_backpack");
	precachemodel("ims_scorpion_explosive1");
	precacheshellshock("radiation_low");
	precacheshellshock("radiation_med");
	precacheshellshock("radiation_high");
	level._effect["chemical_tank_explosion"] = loadfx("smoke/so_chemical_explode_smoke");
	level._effect["chemical_tank_smoke"] = loadfx("smoke/so_chemical_stream_smoke");
	level._effect["chemical_mine_spew"] = loadfx("smoke/so_chemical_mine_spew");
	level._effect["money"] = loadfx("props/cash_player_drop");
	maps\_chopperboss::chopper_boss_load_fx();
	animscripts/dog/dog_init::func_3AF2();
}

//Function Number: 2
ai_preload_weapons()
{
	var_00 = 100;
	var_01 = 120;
	for(var_02 = var_00;var_02 <= var_01;var_02++)
	{
		var_03 = get_ai_weapons(get_ai_ref_by_index(var_02));
		foreach(var_05 in var_03)
		{
			precacheitem(var_05);
		}
	}
}

//Function Number: 3
ai_init()
{
	setsaveddvar("ai_dropAkimboChance",0);
	if(!isdefined(level.wave_table))
	{
		level.wave_table = "sp/survival_waves.csv";
	}

	level.survival_ai = [];
	level.survival_boss = [];
	level.survival_ai = ai_type_populate();
	level.survival_repeat_wave = [];
	level.survival_waves_repeated = 0;
	level.survival_wave = [];
	level.survival_wave = func_3D49();
	createthreatbiasgroup("sentry");
	createthreatbiasgroup("allies");
	createthreatbiasgroup("axis");
	createthreatbiasgroup("boss");
	createthreatbiasgroup("dogs");
	setignoremegroup("sentry","dogs");
	setthreatbias("sentry","boss",50);
	setthreatbias("sentry","axis",50);
	setthreatbias("boss","allies",2000);
	setthreatbias("dogs","allies",1000);
	setthreatbias("axis","allies",0);
	foreach(var_01 in level.players)
	{
		var_01.onlygoodnearestnodes = 1;
		var_01 thread update_player_closest_node_think();
	}

	level.var_3B89 = ::setup_attributes;
	level.squad_leader_behavior_func = ::default_ai;
	level.special_ai_behavior_func = ::default_ai;
	level.squad_drop_weapon_rate = 1;
	maps\_utility::add_global_spawn_function("axis",::no_grenade_bag_drop);
	maps\_utility::add_global_spawn_function("axis",::weapon_drop_ammo_adjustment);
	maps\_utility::add_global_spawn_function("axis",::update_enemy_remaining);
	maps\_utility::add_global_spawn_function("axis",::ai_on_long_death);
	maps\_utility::add_global_spawn_function("axis",::kill_sentry_on_contact);
	register_xp();
	thread survival_ai_regular();
	thread survival_ai_martyrdom();
	thread survival_ai_claymore_and_chemical();
	thread survival_boss_juggernaut();
	thread survival_drop_chopper_init();
	thread survival_boss_chopper();
	thread dog_relocate_init();
	maps\_utility::battlechatter_on("allies");
	maps\_utility::battlechatter_on("axis");
}

//Function Number: 4
kill_sentry_on_contact()
{
	self endon("death");
	if(!isai(self))
	{
		return;
	}

	wait 0.5;
	if(isdefined(self.ridingvehicle))
	{
		self waittill("jumpedout");
	}

	if(!isdefined(level.placed_sentry))
	{
		return;
	}

	foreach(var_01 in level.placed_sentry)
	{
		if(!isdefined(var_01) || !isalive(var_01))
		{
			continue;
		}

		if(distance2d(var_01.origin,self.origin) < 40 && distancesquared(var_01.origin,self.origin) < 4096)
		{
			var_01 kill();
		}
	}
}

//Function Number: 5
func_3D49()
{
	var_00 = 0;
	var_01 = 40;
	var_02 = [];
	for(var_03 = var_00;var_03 <= var_01;var_03++)
	{
		var_04 = get_wave_number_by_index(var_03);
		if(!isdefined(var_04) || var_04 == 0)
		{
			continue;
		}

		var_05 = spawnstruct();
		var_05.idx = var_03;
		var_05.num = var_04;
		var_05.survival_ai_class_overrides = get_squad_type(var_04);
		var_05.var_3D4C = get_squad_array(var_04);
		var_05.var_3D4D = get_special_ai(var_04);
		var_05.var_3D4E = get_special_ai_quantity(var_04);
		var_05.var_3D4F = get_wave_boss_delay(var_04);
		var_05.bossai = get_bosses_ai(var_04);
		var_05.bossnonai = get_bosses_nonai(var_04);
		var_05.dogtype = get_dog_type(var_04);
		var_05.dogquantity = get_dog_quantity(var_04);
		var_05.repeating = is_repeating(var_04);
		var_06 = get_armory_unlocked(var_04);
		if(isdefined(var_06) && var_06.size)
		{
			if(!isdefined(level.armory_unlock))
			{
				level.armory_unlock = [];
			}

			foreach(var_08 in var_06)
			{
				level.armory_unlock[var_08] = var_04;
			}
		}

		var_02[var_04] = var_05;
		if(var_05.repeating)
		{
			level.survival_repeat_wave[level.survival_repeat_wave.size] = var_05;
		}
	}

	return var_02;
}

//Function Number: 6
ai_type_add_override_class(param_00,param_01)
{
	if(!isdefined(level.var_3D57))
	{
		level.var_3D57 = [];
	}

	level.var_3D57[param_00] = param_01;
}

//Function Number: 7
ai_type_add_override_weapons(param_00,param_01)
{
	if(!isdefined(level.var_3D59))
	{
		level.var_3D59 = [];
	}

	foreach(var_03 in param_01)
	{
		precacheitem(var_03);
	}

	level.var_3D59[param_00] = param_01;
}

//Function Number: 8
ai_type_populate()
{
	var_00 = 100;
	var_01 = 120;
	var_02 = [];
	for(var_03 = var_00;var_03 <= var_01;var_03++)
	{
		var_04 = get_ai_ref_by_index(var_03);
		if(!isdefined(var_04) || var_04 == "")
		{
			continue;
		}

		var_05 = spawnstruct();
		var_05.idx = var_03;
		var_05.ref = var_04;
		var_05.name = get_ai_name(var_04);
		var_05.var_189B = get_ai_desc(var_04);
		var_05.classname = get_ai_classname(var_04);
		var_05.weapon = get_ai_weapons(var_04);
		var_05.altweapon = get_ai_alt_weapons(var_04);
		var_05.health = get_ai_health(var_04);
		var_05.speed = get_ai_speed(var_04);
		var_05.accuracy = get_ai_accuracy(var_04);
		var_05.xp = get_ai_xp(var_04);
		if(is_ai_boss(var_04))
		{
			level.survival_boss[var_04] = var_05;
		}

		var_02[var_04] = var_05;
	}

	return var_02;
}

//Function Number: 9
givexp_kill(param_00,param_01)
{
	var_02 = "kill";
	if(isdefined(param_00.ally_ref))
	{
		var_02 = "survival_ai_" + param_00.ally_ref.ref;
	}

	var_03 = undefined;
	if(isdefined(param_01))
	{
		var_04 = maps\_rank::getscoreinfovalue(var_02);
		if(isdefined(var_04))
		{
			var_03 = var_04 * param_01;
		}
	}

	maps\_utility::givexp(var_02,var_03);
}

//Function Number: 10
register_xp()
{
	foreach(var_01 in level.survival_ai)
	{
		maps\_rank::registerscoreinfo("survival_ai_" + var_01.ref,get_ai_xp(var_01.ref));
	}
}

//Function Number: 11
update_player_closest_node_think()
{
	self endon("death");
	level endon("special_op_terminated");
	var_00 = 128;
	var_01 = 1;
	var_02 = 512;
	for(;;)
	{
		var_03 = getclosestnodeinsight(self.origin);
		if(isdefined(var_03))
		{
			if(var_03.type != "Begin" && var_03.type != "End" && var_03.type != "Turret")
			{
				self.node_closest = var_03;
			}
		}

		wait 0.25;
	}
}

//Function Number: 12
update_enemy_remaining()
{
	level endon("special_op_terminated");
	waittillframeend;
	level.enemy_remaining = get_survival_enemies_living().size;
	level notify("axis_spawned");
	self waittill("death");
	waittillframeend;
	var_00 = get_survival_enemies_living();
	level.enemy_remaining = var_00.size;
	level notify("axis_died");
	if(common_scripts\utility::flag("aggressive_mode") && var_00.size == 1 && isai(var_00[0]) && var_00[0].type != "dog")
	{
		var_00[0] thread prevent_long_death();
	}
}

//Function Number: 13
get_survival_enemies_living()
{
	var_00 = getaiarray("axis");
	if(isdefined(level.bosses) && level.bosses.size)
	{
		var_00 = maps\_utility::array_merge(var_00,level.bosses);
	}

	var_00 = maps\_utility::array_merge(var_00,dog_get_living());
	return var_00;
}

//Function Number: 14
prevent_long_death()
{
	level endon("special_op_terminated");
	self endon("death");
	if(!isdefined(self.a.doinglongdeath))
	{
		maps\_utility::disable_long_death();
		return;
	}

	for(;;)
	{
		var_00 = 1;
		foreach(var_02 in level.players)
		{
			var_03 = distance2d(var_02.origin,self.origin) < 540;
			if(var_03)
			{
				var_00 = 0;
				break;
			}

			if(self cansee(var_02))
			{
				var_00 = 0;
				break;
			}

			wait 0.05;
		}

		if(var_00)
		{
			var_05 = get_last_attacker();
			if(isdefined(var_05))
			{
				self kill(self.origin,var_05);
			}
			else
			{
				self kill(self.origin);
			}

			return;
		}

		wait 0.1;
	}
}

//Function Number: 15
get_last_attacker()
{
	var_00 = undefined;
	if(isdefined(self.attacker_list) && self.attacker_list.size)
	{
		var_00 = self.attacker_list[self.attacker_list.size - 1];
	}

	return var_00;
}

//Function Number: 16
weapon_drop_ammo_adjustment()
{
	if(!isai(self) || isdefined(self.type) && self.type == "dog")
	{
		return;
	}

	if(!isdefined(level.armory) || !isdefined(level.armory["weapon"]))
	{
		return;
	}

	level endon("special_op_terminated");
	self waittill("weapon_dropped",var_00);
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = getsubstr(var_00.classname,7);
	wait 0.05;
	var_02 = level.armory["weapon"][var_01];
	if(!isdefined(var_00) || !isdefined(var_02))
	{
		return;
	}

	var_03 = var_02.dropclip;
	var_04 = var_02.dropstock;
	var_00 itemweaponsetammo(var_03,var_04);
	var_05 = weaponaltweaponname(var_01);
	if(var_05 != "none")
	{
		var_06 = int(max(1,weaponclipsize(var_05)));
		var_07 = int(max(1,weaponmaxammo(var_05)));
		var_00 itemweaponsetammo(var_06,var_07,var_06,1);
	}
}

//Function Number: 17
no_grenade_bag_drop()
{
	level.nextgrenadedrop = 100000;
}

//Function Number: 18
money_fx_on_death()
{
	level endon("special_op_terminated");
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	playfx(level._effect["money"],self.origin + (0,0,32));
}

//Function Number: 19
ai_on_long_death()
{
	if(!isai(self) || isdefined(self.type) && self.type == "dog")
	{
		return;
	}

	self endon("death");
	level endon("special_op_terminated");
	self waittill("long_death");
	self waittill("flashbang",var_00,var_01,var_02,var_03);
	if(isdefined(var_03) && isdefined(var_03.team) && var_03.team == "allies")
	{
		self kill(self.origin,var_03);
	}
}

//Function Number: 20
get_ai_type_ref()
{
	if(isdefined(self.ally_ref))
	{
		return self.ally_ref.ref;
	}

	if(isdefined(level.leaders))
	{
		foreach(var_01 in level.leaders)
		{
			if(var_01 == self)
			{
				return get_squad_type(level.current_wave);
			}
		}
	}

	if(isdefined(self.leader) && isai(self.leader))
	{
		return get_squad_type(level.current_wave);
	}

	return undefined;
}

//Function Number: 21
get_special_ai_array(param_00)
{
	var_01 = [];
	if(isdefined(level.special_ai) && level.special_ai.size)
	{
		foreach(var_03 in level.special_ai)
		{
			if(isalive(var_03) && isdefined(var_03.ally_ref) && var_03.ally_ref.ref == param_00)
			{
				var_01[var_01.size] = var_03;
			}
		}
	}

	return var_01;
}

//Function Number: 22
default_ai()
{
	self notify("ai_behavior_change");
	self.aggressivemode = 1;
	self.aggressing = undefined;
	var_00 = self [[ level.var_3B89 ]]();
	if(var_00 == "martyrdom")
	{
		thread behavior_special_ai_martyrdom();
		return;
	}

	if(var_00 == "claymore")
	{
		thread behavior_special_ai_claymore();
		return;
	}

	if(var_00 == "chemical")
	{
		thread behavior_special_ai_chemical();
		return;
	}

	if(var_00 == "easy" || var_00 == "regular" || var_00 == "hardened" || var_00 == "veteran" || var_00 == "elite")
	{
		thread default_squad_leader();
	}
}

//Function Number: 23
aggressive_ai()
{
	self notify("ai_behavior_change");
	self.aggressivemode = 1;
	self.aggressing = 1;
	var_00 = self [[ level.var_3B89 ]]();
	if(var_00 == "martyrdom")
	{
		thread behavior_special_ai_martyrdom();
		return;
	}

	if(var_00 == "claymore")
	{
		thread behavior_special_ai_claymore();
		return;
	}

	if(var_00 == "chemical")
	{
		thread behavior_special_ai_chemical();
		return;
	}

	if(var_00 == "easy" || var_00 == "regular" || var_00 == "hardened" || var_00 == "veteran" || var_00 == "elite")
	{
		thread aggressive_squad_leader();
	}
}

//Function Number: 24
setup_attributes()
{
	if(isdefined(self.attributes_set) && isdefined(self.ally_ref))
	{
		return self.ally_ref.ref;
	}

	var_00 = get_ai_type_ref();
	if(!isdefined(self.ally_ref))
	{
		var_01 = get_ai_struct(var_00);
		self.ally_ref = var_01;
	}

	var_02 = isdefined(self.code_classname) && self.code_classname == "script_vehicle";
	var_03 = get_ai_health(var_00);
	if(isdefined(var_03) && !var_02)
	{
		self.health = var_03;
	}

	var_04 = get_ai_speed(var_00);
	if(isdefined(var_04))
	{
		if(var_02)
		{
			self vehicle_setspeed(60 * var_04,20 * var_04);
		}
		else
		{
			self.moveplaybackrate = var_04;
		}
	}

	var_05 = get_ai_accuracy(var_00);
	if(isdefined(var_05))
	{
		maps\_utility::set_baseaccuracy(var_05);
	}

	var_06 = get_ai_alt_weapons(var_00);
	foreach(var_08 in var_06)
	{
		if(var_08 == "fraggrenade")
		{
			self.grenadeammo = 2;
			self.grenadeweapon = "fraggrenade";
		}

		if(var_08 == "flash_grenade")
		{
			self.grenadeammo = 2;
			self.grenadeweapon = "flash_grenade";
		}
	}

	if(isdefined(self.dropweapon) && self.dropweapon && isdefined(level.squad_drop_weapon_rate))
	{
		var_0A = randomfloat(1);
		if(var_0A > level.squad_drop_weapon_rate)
		{
			self.dropweapon = 0;
		}
	}

	self.advance_regardless_of_numbers = 1;
	self.reacquire_without_facing = 1;
	self.minexposedgrenadedist = 256;
	self.attributes_set = 1;
	return var_00;
}

//Function Number: 25
survival_boss_behavior()
{
	self endon("death");
	var_00 = "Boss does not have AI_Type struct, should have been passed when spawning by AI_Type.";
	var_01 = self [[ level.var_3B89 ]]();
	if(!isdefined(var_01))
	{
		return;
	}

	if(var_01 == "jug_regular")
	{
		global_jug_behavior();
		thread boss_jug_regular();
		return;
	}

	if(var_01 == "jug_headshot")
	{
		global_jug_behavior();
		thread boss_jug_headshot();
		return;
	}

	if(var_01 == "jug_explosive")
	{
		global_jug_behavior();
		thread boss_jug_explosive();
		return;
	}

	if(var_01 == "jug_riotshield")
	{
		global_jug_behavior();
		thread boss_jug_riotshield();
	}
}

//Function Number: 26
survival_ai_regular()
{
}

//Function Number: 27
default_squad_leader()
{
	self.goalradius = 900;
	self.aggressing = undefined;
	self setengagementmindist(300,200);
	self setengagementmaxdist(512,768);
	thread manage_ai_relative_to_player(4,self.goalradius,"ai_behavior_change demotion");
}

//Function Number: 28
aggressive_squad_leader()
{
	self.goalradius = 384;
	self.aggressing = 1;
	maps\_utility::enable_heat_behavior(1);
	maps\_utility::disable_surprise();
	self setengagementmindist(88,64);
	self setengagementmaxdist(512,768);
	thread manage_ai_relative_to_player(4,self.goalradius,"ai_behavior_change demotion");
}

//Function Number: 29
behavior_special_ai_martyrdom()
{
	self endon("death");
	self endon("ai_behavior_change");
	if(!isdefined(self.special_ability))
	{
		thread martyrdom_ability();
	}

	var_00 = 0;
	var_01 = 0;
	if(isdefined(self.aggressing) && self.aggressing)
	{
		var_00 = 88;
		var_01 = 64;
		self.goalradius = 384;
		maps\_utility::enable_heat_behavior(1);
		maps\_utility::disable_surprise();
	}
	else
	{
		var_00 = 200;
		var_01 = 100;
		self.goalradius = 900;
	}

	self setengagementmindist(var_00,var_01);
	self setengagementmaxdist(512,768);
	thread manage_ai_relative_to_player(4,self.goalradius,"ai_behavior_change");
}

//Function Number: 30
survival_ai_martyrdom()
{
}

//Function Number: 31
martyrdom_ability()
{
	self.special_ability = 1;
	self.forcelongdeath = 1;
	thread attach_c4("j_spine4",(0,6,0),(0,0,-90));
	thread attach_c4("tag_stowed_back",(0,1,5),(80,90,0));
	thread detonate_c4_when_dead(3,0.4);
}

//Function Number: 32
attach_c4(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = (0,0,0);
	}

	if(!isdefined(param_02))
	{
		param_02 = (0,0,0);
	}

	var_03 = spawn("script_model",self gettagorigin(param_00) + param_01);
	var_03 setmodel("weapon_c4");
	var_03 linkto(self,param_00,param_01,param_02);
	if(!isdefined(self.c4_attachments))
	{
		self.c4_attachments = [];
	}

	self.c4_attachments[self.c4_attachments.size] = var_03;
}

//Function Number: 33
detonate_c4_when_dead(param_00,param_01)
{
	common_scripts\utility::waittill_any("long_death","death","force_c4_detonate");
	self notify("c4_detonated");
	if(!isdefined(self) || !isdefined(self.c4_attachments) || self.c4_attachments.size == 0)
	{
		return;
	}

	var_02 = get_last_attacker();
	if(isdefined(self.dog_neck_snapped))
	{
		param_00 = 5;
	}

	for(var_03 = 0;var_03 < self.c4_attachments.size;var_03++)
	{
		playfxontag(common_scripts\utility::getfx("martyrdom_dlight_red"),self.c4_attachments[var_03],"tag_fx");
		playfxontag(common_scripts\utility::getfx("martyrdom_red_blink"),self.c4_attachments[var_03],"tag_fx");
	}

	var_04 = self.c4_attachments;
	self.c4_attachments = undefined;
	badplace_cylinder("",param_00,var_04[0].origin,144,144,"axis","allies");
	var_05 = max(param_00 - 1.5,0);
	if(var_05 > 0)
	{
		param_00 = param_00 - var_05;
		wait var_05;
	}

	var_04[0] playsound("semtex_warning");
	var_06 = 0;
	if(param_00 > 0.25)
	{
		param_00 = param_00 - 0.25;
		var_06 = 1;
	}

	wait param_00;
	for(var_03 = 0;var_03 < var_04.size;var_03++)
	{
		if(!isdefined(var_04[var_03]))
		{
			continue;
		}

		stopfxontag(common_scripts\utility::getfx("martyrdom_red_blink"),var_04[var_03],"tag_fx");
	}

	if(var_06)
	{
		wait 0.25;
	}

	var_04 = sortbydistance(var_04,var_04[0].origin + (0,0,-120));
	for(var_03 = 0;var_03 < var_04.size;var_03++)
	{
		if(!isdefined(var_04[var_03]))
		{
			continue;
		}

		playfx(level._effect["martyrdom_c4_explosion"],var_04[var_03].origin);
		var_04[var_03] playsound("detpack_explo_main","sound_done");
		physicsexplosioncylinder(var_04[var_03].origin,256,1,2);
		earthquake(0.4,0.8,var_04[var_03].origin,600);
		stopfxontag(common_scripts\utility::getfx("martyrdom_dlight_red"),var_04[var_03],"tag_fx");
		if(!isdefined(var_02))
		{
			var_02 = undefined;
		}

		var_04[var_03] radiusdamage(var_04[var_03].origin,192,100,50,var_02,"MOD_EXPLOSIVE");
		var_04[var_03] thread maps\_so_survival_code::ent_linked_delete();
		wait param_01;
	}
}

//Function Number: 34
behavior_special_ai_claymore()
{
	if(isdefined(self.planting))
	{
		return;
	}

	self endon("death");
	self endon("ai_behavior_change");
	var_00 = 0;
	var_01 = 0;
	if(isdefined(self.aggressing) && self.aggressing)
	{
		var_00 = 88;
		var_01 = 64;
		self.goalradius = 384;
		maps\_utility::enable_heat_behavior(1);
		maps\_utility::disable_surprise();
	}
	else
	{
		var_00 = 300;
		var_01 = 200;
		self.goalradius = 900;
	}

	self setengagementmindist(var_00,var_01);
	self setengagementmaxdist(512,768);
	thread manage_ai_relative_to_player(4,self.goalradius,"ai_behavior_change");
}

//Function Number: 35
survival_ai_claymore_and_chemical()
{
	mine_locs_populate();
	thread mine_locs_manage_weights();
	var_00 = ["claymore","chemical"];
	thread mine_locs_manage_planting(var_00);
}

//Function Number: 36
mine_locs_populate()
{
	level.so_mine_locs = [];
	level.so_mine_locs = get_all_mine_locs();
	foreach(var_01 in level.so_mine_locs)
	{
		var_01.weight = 0;
	}
}

//Function Number: 37
mine_locs_attempt_plant(param_00)
{
	if(isdefined(level.so_mines) && level.so_mines.size >= 6)
	{
		return 0;
	}

	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_01 = common_scripts\utility::array_combine(var_01,get_special_ai_array(var_03));
	}

	var_01 = mine_ai_remove_busy(var_01);
	if(!var_01.size)
	{
		return 0;
	}

	var_05 = mine_locs_get_valid(384,2);
	var_05 = mine_locs_sorted_by_weight(var_05);
	foreach(var_07 in var_05)
	{
		foreach(var_09 in var_01)
		{
			var_0A = distance2d(var_07.origin,var_09.origin);
			if(var_0A > 768 || var_07.origin[2] < var_09.origin[2] - 120 || var_07.origin[2] > var_09.origin[2] + 120)
			{
				continue;
			}

			var_0B = maps\_utility::getclosest(var_07.origin,level.players);
			var_0C = distance2d(var_07.origin,var_0B.origin);
			if(var_0A < var_0C)
			{
				var_09 thread behavior_special_ai_mine_place(var_07);
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 38
mine_ai_remove_busy(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isdefined(var_03.planting))
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 39
mine_locs_sorted_by_weight(param_00)
{
	for(var_01 = 0;var_01 < param_00.size - 1;var_01++)
	{
		var_02 = 0;
		for(var_03 = var_01 + 1;var_03 < param_00.size;var_03++)
		{
			if(param_00[var_03].weight < param_00[var_01].weight)
			{
				var_04 = param_00[var_03];
				param_00[var_03] = param_00[var_01];
				param_00[var_01] = var_04;
			}
		}
	}

	return param_00;
}

//Function Number: 40
mine_locs_get_valid(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in level.so_mine_locs)
	{
		if(var_04 mine_loc_valid_plant(param_00,param_01))
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 41
mine_loc_valid_plant(param_00,param_01)
{
	if(isdefined(self.occupied) || self.weight < param_01)
	{
		return 0;
	}

	foreach(var_03 in level.players)
	{
		if(distance2d(self.origin,var_03.origin) < param_00)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 42
mine_locs_manage_weights()
{
	level endon("special_op_terminated");
	for(;;)
	{
		foreach(var_01 in level.so_mine_locs)
		{
			var_02 = 0;
			foreach(var_04 in level.players)
			{
				if(distance2d(var_01.origin,var_04.origin) <= 512)
				{
					var_01 mine_loc_adjust_weight(1);
					var_02 = 1;
				}
			}

			if(!var_02)
			{
				var_01 mine_loc_adjust_weight(0);
			}
		}

		wait 0.5;
	}
}

//Function Number: 43
mine_loc_adjust_weight(param_00)
{
	if(param_00)
	{
		self.weight = min(20,self.weight + 0.5);
		return;
	}

	self.weight = max(0,self.weight - 0.025);
}

//Function Number: 44
mine_locs_manage_planting(param_00)
{
	level endon("special_op_terminated");
	for(;;)
	{
		if(mine_locs_attempt_plant(param_00))
		{
			wait 8;
			continue;
		}

		wait 2;
	}
}

//Function Number: 45
behavior_special_ai_mine_place(param_00)
{
	self endon("death");
	self.planting = 1;
	self notify("ai_behavior_change");
	param_00.occupied = 1;
	thread mine_ai_planting_death(param_00);
	var_01 = self.goalradius;
	self.goalradius = 48;
	self.ignoreall = 1;
	self.ignoreme = 1;
	self setgoalpos(param_00.origin);
	var_02 = common_scripts\utility::waittill_any_timeout(13,"goal","bad_path");
	if(var_02 != "goal")
	{
		param_00.occupied = undefined;
		if(var_02 == "bad_path")
		{
			level.so_mine_locs = maps\_utility::array_remove_nokeys(level.so_mine_locs,param_00);
		}
	}
	else
	{
		self allowedstances("crouch");
		wait 1;
		var_03 = undefined;
		var_04 = get_ai_type_ref();
		if(var_04 == "claymore")
		{
			var_03 = claymore_create(param_00.origin,param_00.angles);
			var_03 playsound("so_claymore_plant");
			var_03 thread claymore_on_trigger();
			var_03 thread claymore_on_damage();
			var_03 thread claymore_on_emp();
			level notify("ai_claymore_planted");
		}
		else if(var_04 == "chemical")
		{
			var_03 = chembomb_create(param_00.origin,param_00.angles);
			var_03 playsound("so_claymore_plant");
			var_03 thread chembomb_on_trigger();
			var_03 thread chembomb_on_damage();
			level notify("ai_chembomb_planted");
		}
		else
		{
		}

		if(isdefined(var_03))
		{
			if(!isdefined(level.so_mines))
			{
				level.so_mines = [];
			}

			level.so_mines[level.so_mines.size] = var_03;
			var_03 thread mine_on_death(param_00);
			wait 0.25;
			param_00.weight = param_00.weight * 0.5;
		}
	}

	self allowedstances("prone","crouch","stand");
	self.goalradius = var_01;
	self.ignoreall = 0;
	self.ignoreme = 0;
	self.planting = undefined;
	self notify("planting_done");
	var_04 = get_ai_type_ref();
	if(var_04 == "claymore")
	{
		thread behavior_special_ai_claymore();
		return;
	}

	if(var_04 == "chemical")
	{
		thread behavior_special_ai_chemical();
	}
}

//Function Number: 46
mine_ai_planting_death(param_00)
{
	self endon("planting_done");
	level endon("special_op_terminated");
	self waittill("death");
	param_00.occupied = undefined;
}

//Function Number: 47
claymore_create(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",param_00);
	var_03 setmodel("weapon_claymore");
	if(!isdefined(param_02) || param_02)
	{
		var_03.origin = maps\_utility::drop_to_ground(param_00,12,-120);
	}

	var_03.angles = (0,param_01[1],0);
	playfxontag(common_scripts\utility::getfx("claymore_laser"),var_03,"tag_fx");
	if(isdefined(self) && isalive(self))
	{
		var_03.owner = self;
	}

	return var_03;
}

//Function Number: 48
claymore_on_trigger()
{
	self endon("death");
	level endon("special_op_terminated");
	var_00 = 6;
	var_01 = spawn("trigger_radius",self.origin + (0,0,-192),var_00,192,384);
	thread mine_delete_on_death(var_01);
	for(;;)
	{
		var_01 waittill("trigger",var_02);
		if(isdefined(self.owner) && var_02 == self.owner)
		{
			continue;
		}

		if(isdefined(self.disabled))
		{
			self waittill("enabled");
			continue;
		}

		if(var_02 claymore_on_trigger_laser_check(self))
		{
			self notify("triggered");
			claymore_detonate(0.75);
			return;
		}
	}
}

//Function Number: 49
claymore_on_trigger_laser_check(param_00)
{
	if(isdefined(param_00.disabled))
	{
		return 0;
	}

	var_01 = self.origin + (0,0,32);
	var_02 = var_01 - param_00.origin;
	var_03 = anglestoforward(param_00.angles);
	var_04 = vectordot(var_02,var_03);
	if(var_04 < 20)
	{
		return 0;
	}

	var_02 = vectornormalize(var_02);
	var_05 = vectordot(var_02,var_03);
	if(!isdefined(level.so_claymore_trig_dot))
	{
		level.so_claymore_trig_dot = cos(70);
	}

	return var_05 > level.so_claymore_trig_dot;
}

//Function Number: 50
claymore_detonate(param_00)
{
	if(isdefined(self.so_claymore_activated))
	{
		return;
	}

	self.so_claymore_activated = 1;
	level endon("special_op_terminated");
	self playsound("claymore_activated_SP");
	if(isdefined(param_00) && param_00 > 0)
	{
		wait param_00;
	}

	self playsound("detpack_explo_main","sound_done");
	playfx(level._effect["claymore_explosion"],self.origin);
	physicsexplosioncylinder(self.origin,256,1,2);
	earthquake(0.4,0.8,self.origin,600);
	stopfxontag(common_scripts\utility::getfx("claymore_laser"),self,"tag_fx");
	radiusdamage(self.origin,192,100,50,undefined,"MOD_EXPLOSIVE");
	level.so_mine_last_detonate_time = gettime();
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 51
mine_delete_on_death(param_00)
{
	level endon("special_op_terminated");
	self waittill("death");
	level.so_mines = maps\_utility::array_remove_nokeys(level.so_mines,self);
	wait 0.05;
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 52
claymore_on_damage()
{
	self endon("death");
	self endon("triggered");
	level endon("special_op_terminated");
	self.health = 100;
	self setcandamage(1);
	self.maxhealth = 100000;
	self.health = self.maxhealth;
	self waittill("damage",var_00,var_01);
	var_02 = 0.05;
	if(mine_so_detonated_recently())
	{
		var_02 = 0.1 + randomfloat(0.4);
	}

	claymore_detonate(var_02);
}

//Function Number: 53
mine_so_detonated_recently()
{
	return isdefined(level.so_mine_last_detonate_time) && gettime() - level.so_mine_last_detonate_time < 400;
}

//Function Number: 54
claymore_on_emp()
{
	self endon("death");
	self endon("triggered");
	level endon("special_op_terminated");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		playfxontag(common_scripts\utility::getfx("claymore_disabled"),self,"tag_origin");
		self.disabled = 1;
		self notify("disabled");
		wait var_01;
		self.disabled = undefined;
		self notify("enabled");
	}
}

//Function Number: 55
mine_on_death(param_00)
{
	level endon("special_op_terminated");
	self waittill("death");
	param_00.occupied = undefined;
}

//Function Number: 56
behavior_special_ai_chemical()
{
	if(isdefined(self.planting))
	{
		return;
	}

	self endon("death");
	self endon("ai_behavior_change");
	if(!isdefined(self.special_ability))
	{
		thread chemical_ability();
	}

	var_00 = 0;
	var_01 = 0;
	if(isdefined(self.aggressing) && self.aggressing)
	{
		var_00 = 88;
		var_01 = 64;
		self.goalradius = 384;
		maps\_utility::enable_heat_behavior(1);
		maps\_utility::disable_surprise();
	}
	else
	{
		var_00 = 120;
		var_01 = 60;
		self.goalradius = 512;
	}

	self setengagementmindist(var_00,var_01);
	self setengagementmaxdist(512,768);
	thread manage_ai_relative_to_player(4,self.goalradius,"ai_behavior_change");
}

//Function Number: 57
chemical_ability()
{
	self.special_ability = 1;
	self.ignoresuppression = 1;
	self.no_pistol_switch = 1;
	self.norunngun = 1;
	self.disableexits = 1;
	self.disablearrivals = 1;
	self.disablebulletwhizbyreaction = 1;
	self.combatmode = "no_cover";
	self.neversprintforvariation = 1;
	maps\_utility::disable_long_death();
	maps\_utility::disable_surprise();
	var_00 = chemical_ability_attach_tank("tag_shield_back",(0,0,0),(0,90,0));
	thread chemical_ability_tank_spew(var_00);
	thread chemical_ability_on_tank_damage(var_00);
	thread chemical_ability_on_death(var_00);
}

//Function Number: 58
chemical_ability_attach_tank(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",self gettagorigin(param_00) + param_01);
	var_03 setmodel("gas_canisters_backpack");
	var_03.health = 99999;
	var_03 setcandamage(1);
	var_03 linkto(self,param_00,param_01,param_02);
	return var_03;
}

//Function Number: 59
chemical_ability_tank_spew(param_00)
{
	self endon("death");
	param_00 endon("death");
	for(;;)
	{
		playfxontag(common_scripts\utility::getfx("chemical_tank_smoke"),self,"tag_shield_back");
		wait 0.05;
	}
}

//Function Number: 60
chemical_ability_on_tank_damage(param_00)
{
	self endon("death");
	self endon("tank_detonated");
	level endon("special_op_terminated");
	for(;;)
	{
		param_00 waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(isplayer(var_02) || var_05 == "MOD_EXPLOSIVE" || var_05 == "MOD_GRENADE" || var_05 == "MOD_GRENADE_SPLASH")
		{
			thread maps\_so_survival_code::so_survival_kill_ai(var_02,var_05,var_0A);
			return;
		}
	}
}

//Function Number: 61
chemical_ability_on_death(param_00)
{
	self endon("tank_detonated");
	level endon("special_op_terminated");
	self waittill("death",var_01);
	if(!isdefined(self))
	{
		if(isdefined(param_00))
		{
			wait 0.05;
			param_00 delete();
		}

		return;
	}

	thread chemical_ability_detonate(param_00,var_01);
}

//Function Number: 62
chemical_ability_detonate(param_00,param_01)
{
	if(!isdefined(param_00) || isdefined(param_00.detonated))
	{
		return;
	}

	param_00.detonated = 1;
	if(!isdefined(self))
	{
		return;
	}

	self notify("tank_detonated");
	var_02 = self.origin;
	param_00 playsound("detpack_explo_main","sound_done");
	physicsexplosioncylinder(var_02,256,1,0.5);
	earthquake(0.2,0.4,var_02,600);
	param_01 = common_scripts\utility::ter_op(isdefined(param_01),param_01,undefined);
	playfx(common_scripts\utility::getfx("chemical_tank_explosion"),var_02);
	thread chemical_ability_gas_cloud(var_02,6,2);
	param_00 unlink();
	wait 0.05;
	param_00 delete();
}

//Function Number: 63
chemical_ability_gas_cloud(param_00,param_01,param_02)
{
	level endon("special_op_terminated");
	var_03 = 7;
	var_04 = spawn("trigger_radius",param_00 + (0,0,-96),var_03,96,192);
	badplace_cylinder("",param_02,param_00,96,96,"axis","allies");
	var_04 endon("smoke_done");
	var_04 thread wait_for_delete();
	var_04 thread maps\_utility::do_in_order(::maps\_utility::_wait,param_01,::maps\_utility::send_notify,"smoke_done");
	for(;;)
	{
		var_04 waittill("trigger",var_05);
		if(!isdefined(var_05) || !isalive(var_05))
		{
			continue;
		}

		if(isplayer(var_05))
		{
			if(maps\_utility::is_player_down(var_05) || maps\_utility::is_player_down_and_out(var_05))
			{
				continue;
			}

			if(isdefined(var_05.gassed))
			{
				continue;
			}

			var_06 = "";
			var_07 = gettime();
			if(!isdefined(var_05.gassed_before) || isdefined(var_05.gas_time) && var_07 - var_05.gas_time > 1500)
			{
				var_06 = "radiation_low";
			}
			else if(var_05.gas_shock == "radiation_low")
			{
				var_06 = "radiation_med";
			}
			else
			{
				var_06 = "radiation_high";
			}

			var_05.gassed_before = 1;
			var_05.gas_shock = var_06;
			var_05.gas_time = var_07;
			var_05 shellshock(var_06,1.5);
			var_05.gassed = 1;
			var_05 thread chemical_ability_remove_gas_flag(1);
		}

		if(isai(var_05))
		{
		}
	}
}

//Function Number: 64
wait_for_delete()
{
	level endon("special_op_terminated");
	self waittill("smoke_done");
	self delete();
}

//Function Number: 65
chemical_ability_remove_gas_flag(param_00)
{
	self endon("death");
	wait param_00;
	self.gassed = undefined;
}

//Function Number: 66
chembomb_create(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",param_00);
	var_03 setmodel("ims_scorpion_explosive1");
	if(!isdefined(param_02) || param_02)
	{
		var_03.origin = maps\_utility::drop_to_ground(param_00,12,-120) + (0,0,5);
	}

	var_03.angles = (0,param_01[1],0);
	var_03.tag_origin = var_03 common_scripts\utility::spawn_tag_origin();
	var_03.tag_origin linkto(var_03,"tag_explosive1",(0,0,6),(-90,0,0));
	playfxontag(common_scripts\utility::getfx("chemical_mine_spew"),var_03.tag_origin,"tag_origin");
	if(isdefined(self) && isalive(self))
	{
		var_03.owner = self;
	}

	return var_03;
}

//Function Number: 67
chembomb_on_trigger()
{
	self endon("death");
	level endon("special_op_terminated");
	var_00 = 6;
	var_01 = spawn("trigger_radius",self.origin + (0,0,-96),var_00,96,192);
	thread mine_delete_on_death(var_01);
	for(;;)
	{
		var_01 waittill("trigger",var_02);
		if(isdefined(self.owner) && var_02 == self.owner)
		{
			continue;
		}

		if(isdefined(self.disabled))
		{
			self waittill("enabled");
			continue;
		}

		self notify("triggered");
		chembomb_detonate(0.5);
	}
}

//Function Number: 68
chembomb_on_damage()
{
	self endon("death");
	self endon("triggered");
	level endon("special_op_terminated");
	self.health = 100;
	self setcandamage(1);
	self.maxhealth = 100000;
	self.health = self.maxhealth;
	self waittill("damage",var_00,var_01);
	var_02 = 0.05;
	if(mine_so_detonated_recently())
	{
		var_02 = 0.1 + randomfloat(0.4);
	}

	chembomb_detonate(var_02);
}

//Function Number: 69
chembomb_detonate(param_00)
{
	if(isdefined(self.chembomb_activated))
	{
		return;
	}

	self.chembomb_activated = 1;
	level endon("special_op_terminated");
	self playsound("claymore_activated_SP");
	if(isdefined(param_00) && param_00 > 0)
	{
		wait param_00;
	}

	level.so_mine_last_detonate_time = gettime();
	self playsound("detpack_explo_main","sound_done");
	physicsexplosioncylinder(self.origin,256,1,0.5);
	earthquake(0.2,0.4,self.origin,600);
	playfx(common_scripts\utility::getfx("chemical_tank_explosion"),self.origin);
	stopfxontag(common_scripts\utility::getfx("chemical_mine_spew"),self.tag_origin,"tag_origin");
	thread chemical_ability_gas_cloud(self.origin,6,1);
	self.tag_origin delete();
	wait 0.05;
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 70
dog_relocate_init()
{
	level.dog_reloc_trig_array = getentarray("dog_relocate","targetname");
	if(!isdefined(level.dog_reloc_trig_array) || level.dog_reloc_trig_array.size == 0)
	{
		return;
	}

	foreach(var_01 in level.dog_reloc_trig_array)
	{
		var_02 = common_scripts\utility::getstruct(var_01.target,"targetname");
		var_01.reloc_origin = var_02.origin;
		var_01 thread dog_reloc_monitor();
	}
}

//Function Number: 71
dog_reloc_monitor()
{
	level endon("special_op_terminated");
	for(;;)
	{
		self waittill("trigger",var_00);
		while(var_00 istouching(self))
		{
			var_00.dog_reloc = self.reloc_origin;
			wait 0.05;
		}

		var_00.dog_reloc = undefined;
	}
}

//Function Number: 72
spawn_dogs(param_00,param_01)
{
	level endon("special_op_terminated");
	level endon("wave_ended");
	if(!isdefined(param_00) || param_00 == "" || !isdefined(param_01) || !param_01)
	{
		return;
	}

	level.dogs = [];
	var_02 = [];
	foreach(var_04 in level.players)
	{
		var_02[var_02.size] = var_04;
	}

	var_06 = getentarray("dog_spawner","targetname")[0];
	level.dogs_attach_c4 = isdefined(param_00) && param_00 == "dog_splode";
	var_06 maps\_utility::add_spawn_function(::dog_setup);
	var_06 maps\_utility::add_spawn_function(::dog_seek_player);
	var_06 maps\_utility::add_spawn_function(::dog_register_death);
	for(var_07 = 0;var_07 < param_01;var_07++)
	{
		var_08 = maps\_so_survival_code::get_furthest_from_these(level.wave_spawn_locs,var_02,4);
		var_06.count = 1;
		var_06.origin = var_08.origin;
		var_06.angles = var_08.angles;
		var_09 = int(40 + randomint(10) / param_01);
		level.survival_dog_spawning = 1;
		var_0A = var_06 maps\_utility::spawn_ai(1);
		var_0A.ally_ref = get_ai_struct(param_00);
		var_0A setthreatbiasgroup("dogs");
		var_0A [[ level.var_3B89 ]]();
		var_0A.canclimbladders = 0;
		level.dogs[level.dogs.size] = var_0A;
		level.survival_dog_spawning = undefined;
		if(!common_scripts\utility::flag("aggressive_mode"))
		{
			common_scripts\utility::waittill_any_timeout(var_09,"aggressive_mode");
		}

		wait 0.05;
	}
}

//Function Number: 73
dog_setup()
{
	self.badplaceawareness = 0;
	self.grenadeawareness = 0;
	if(isdefined(level.dogs_attach_c4) && level.dogs_attach_c4)
	{
		thread attach_c4("j_hip_base_ri",(6,6,-3),(0,0,0));
		thread attach_c4("j_hip_base_le",(-6,-6,3),(0,0,0));
		thread detonate_c4_when_dead(3,0.4);
		thread dog_detonate_c4_near_sentry();
	}
}

//Function Number: 74
dog_detonate_c4_near_sentry()
{
	level endon("special_op_terminated");
	self endon("death");
	self endon("c4_detonated");
	var_00 = self.origin;
	var_01 = self.origin;
	var_02 = gettime();
	for(;;)
	{
		wait 0.2;
		var_01 = self.origin;
		var_03 = gettime();
		if(distancesquared(var_01,var_00) > squared(10) || animscripts/dog/dog_combat::func_3B2A())
		{
			var_00 = var_01;
			var_02 = var_03;
		}

		if(!isdefined(level.placed_sentry) || !level.placed_sentry.size)
		{
			continue;
		}

		if(var_03 - var_02 < 2000)
		{
			continue;
		}

		var_04 = 0;
		foreach(var_06 in level.placed_sentry)
		{
			if(isdefined(var_06.carrier))
			{
				continue;
			}

			if(distancesquared(var_01,var_06.origin) < squared(40))
			{
				var_04 = 1;
				break;
			}
		}

		if(var_04)
		{
			break;
		}
		else
		{
			var_00 = var_01;
			var_02 = var_03;
		}
	}

	self notify("stop_dog_seek_player");
	self.ignoreall = 1;
	self setgoalpos(self.origin);
	self notify("force_c4_detonate");
}

//Function Number: 75
dog_register_death()
{
	self waittill("death");
	level.dogs = dog_get_living();
}

//Function Number: 76
dog_seek_player()
{
	level endon("special_op_terminated");
	level endon("wave_ended");
	self endon("death");
	self endon("stop_dog_seek_player");
	self.moveplaybackrate = 0.75;
	self.goalheight = 80;
	self.goalradius = 300;
	var_00 = 1;
	for(;;)
	{
		var_01 = maps\_utility::get_closest_player_healthy(self.origin);
		if(!isdefined(var_01))
		{
			var_01 = maps\_utility::get_closest_player(self.origin);
		}

		if(isdefined(var_01))
		{
			var_02 = self cansee(var_01);
			var_03 = distancesquared(self.origin,var_01.origin);
			if(isdefined(var_01.dog_reloc))
			{
				self setgoalpos(var_01.dog_reloc);
			}
			else if((!var_02 || var_03 > 1048576) && isdefined(var_01.node_closest))
			{
				self setgoalpos(var_01.node_closest.origin);
				self.goalradius = 24;
			}
			else
			{
				self setgoalpos(var_01.origin);
				self.goalradius = 384;
			}
		}

		wait var_00;
	}
}

//Function Number: 77
dog_get_count()
{
	var_00 = dog_get_living().size;
	if(isdefined(level.survival_dog_spawning))
	{
		var_00++;
	}

	return var_00;
}

//Function Number: 78
dog_get_living()
{
	if(!isdefined(level.dogs))
	{
		level.dogs = [];
		return level.dogs;
	}

	var_00 = [];
	foreach(var_02 in level.dogs)
	{
		if(isdefined(var_02) && isalive(var_02))
		{
			var_00[var_00.size] = var_02;
		}
	}

	return var_00;
}

//Function Number: 79
survival_boss_juggernaut()
{
}

//Function Number: 80
is_juggernaut_used(param_00)
{
	foreach(var_02 in param_00)
	{
		if(issubstr(var_02,"jug_"))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 81
spawn_juggernaut(param_00,param_01)
{
	level endon("special_op_terminated");
	var_02 = drop_jug_by_chopper(param_00,param_01);
	if(!isdefined(var_02))
	{
		return;
	}

	var_02.ally_ref = get_ai_struct(param_00);
	var_02.kill_assist_xp = int(get_ai_xp(param_00) * 0.2);
	var_02 maps\_so_survival_loot::loot_roll(0);
	level.bosses[level.bosses.size] = var_02;
	var_02 waittill("jumpedout");
	level notify("juggernaut_jumpedout");
	var_02 thread survival_boss_behavior();
	var_02 thread maps\_so_survival_code::clear_from_boss_array_when_dead();
}

//Function Number: 82
drop_jug_by_chopper(param_00,param_01)
{
	var_02 = maps\_so_survival_code::get_spawners_by_targetname(param_00)[0];
	var_02 maps\_utility::add_spawn_function(::money_fx_on_death);
	var_03 = maps\_so_survival_code::chopper_spawn_from_targetname_and_drive("jug_drop_chopper",param_01.origin,param_01);
	var_03 thread maps\_chopperboss::chopper_path_release("reached_dynamic_path_end death deathspin");
	var_03 maps\_vehicle::godon();
	var_03.script_vehicle_selfremove = 1;
	var_03 vehicle_setspeed(60 + randomint(15),30,30);
	var_03 thread maps\_so_survival_code::chopper_drop_smoke_at_unloading();
	var_03 maps\_so_survival_code::chopper_spawn_pilot_from_targetname("jug_drop_chopper_pilot");
	var_04 = var_03 maps\_so_survival_code::chopper_spawn_passenger(var_02);
	var_04 maps\_utility::deletable_magic_bullet_shield();
	var_04 thread maps\_utility::do_in_order(::common_scripts\utility::waittill_any,"jumpedout",::maps\_utility::stop_magic_bullet_shield);
	var_04 setthreatbiasgroup("boss");
	return var_04;
}

//Function Number: 83
progressive_damaged()
{
	self endon("death");
	self endon("new_jug_behavior");
	for(;;)
	{
		if(self.health <= 250)
		{
			self.walkdist = 500;
			self.walkdistfacingmotion = 500;
		}
		else
		{
			self.walkdist = 1000;
			self.walkdistfacingmotion = 1000;
		}

		wait 0.05;
	}
}

//Function Number: 84
damage_factor()
{
	self endon("death");
	self endon("new_jug_behavior");
	self.bullet_resistance = 0;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(self.magic_bullet_shield))
		{
			continue;
		}

		var_0A = 0;
		var_0B = 0;
		if(isdefined(var_01) && isai(var_01) && self.team != var_01.team)
		{
			var_0A = dmg_factor_calc(var_00,self.dmg_factor["ai_damage"]);
		}
		else if(var_04 == "MOD_MELEE")
		{
			if(isdefined(var_01) && isplayer(var_01) && isdefined(var_09) && issubstr(var_09,"riotshield_so"))
			{
				var_0A = dmg_factor_calc(var_00,self.dmg_factor["melee_riotshield"]);
			}
			else
			{
				var_0A = dmg_factor_calc(var_00,self.dmg_factor["melee"]);
			}
		}
		else if(var_04 == "MOD_EXPLOSIVE" || var_04 == "MOD_GRENADE" || var_04 == "MOD_GRENADE_SPLASH" || var_04 == "MOD_PROJECTILE" || var_04 == "MOD_PROJECTILE_SPLASH")
		{
			var_0A = dmg_factor_calc(var_00,self.dmg_factor["explosive"]);
		}
		else if(maps\_so_survival_code::was_headshot())
		{
			var_0A = dmg_factor_calc(var_00,self.dmg_factor["headshot"]);
			var_0B = 1;
		}
		else
		{
			var_0A = dmg_factor_calc(var_00,self.dmg_factor["bodyshot"]);
		}

		var_0A = int(var_0A);
		if(var_0A < 0 && abs(var_0A) >= self.health)
		{
			if(var_0B)
			{
				self.died_of_headshot = 1;
			}

			thread maps\_so_survival_code::so_survival_kill_ai(var_01,var_04,var_09);
		}
		else
		{
			self.health = self.health + var_0A;
		}

		self notify("dmg_factored");
	}
}

//Function Number: 85
dmg_factor_calc(param_00,param_01)
{
	var_02 = 0;
	if(isdefined(param_01) && param_01)
	{
		var_02 = int(param_00 * 1 - param_01);
	}

	return var_02;
}

//Function Number: 86
global_jug_behavior()
{
	self.dmg_factor["headshot"] = 1;
	self.dmg_factor["bodyshot"] = 1;
	self.dmg_factor["melee"] = 1;
	self.dmg_factor["melee_riotshield"] = 1;
	self.dmg_factor["explosive"] = 1;
	self.dmg_factor["ai_damage"] = 1;
	self.dropweapon = 0;
	self.minpaindamage = 350;
	maps\_utility::set_battlechatter(0);
	self.aggressing = 1;
	self.dontmelee = undefined;
	self.meleealwayswin = 1;
	thread damage_factor();
	thread progressive_damaged();
}

//Function Number: 87
boss_jug_helmet_pop(param_00,param_01)
{
	self endon("death");
	var_02 = self.health;
	if(isdefined(self.ally_ref))
	{
		var_02 = get_ai_health(self.ally_ref.ref);
	}

	for(;;)
	{
		if(self.health / var_02 <= param_00)
		{
			animscripts/death::func_D17();
			var_03 = self.dmg_factor.size;
			self.dmg_factor = maps\_utility::array_combine_keys(self.dmg_factor,param_01);
			return;
		}

		self waittill("dmg_factored");
	}
}

//Function Number: 88
boss_jug_regular()
{
	self.dmg_factor["headshot"] = 0.75;
	self.dmg_factor["bodyshot"] = 0.33;
	self.dmg_factor["melee"] = 0.25;
	self.dmg_factor["melee_riotshield"] = 0.25;
	self.dmg_factor["explosive"] = 0.33;
	self.dmg_factor["ai_damage"] = 0.33;
	self setengagementmindist(100,60);
	self setengagementmaxdist(512,768);
	self.goalradius = 128;
	self.goalheight = 81;
	thread manage_ai_relative_to_player(2,self.goalradius,"new_jug_behavior","stop_hunting");
}

//Function Number: 89
boss_jug_headshot()
{
	self.dmg_factor["headshot"] = 1;
	self.dmg_factor["bodyshot"] = 0.33;
	self.dmg_factor["melee"] = 0.25;
	self.dmg_factor["melee_riotshield"] = 0.25;
	self.dmg_factor["explosive"] = 1;
	self.dmg_factor["ai_damage"] = 0.25;
	self setengagementmindist(100,60);
	self setengagementmaxdist(512,768);
	self.goalradius = 128;
	self.goalheight = 81;
	thread manage_ai_relative_to_player(2,self.goalradius,"new_jug_behavior","stop_hunting");
}

//Function Number: 90
boss_jug_explosive()
{
	self.dmg_factor["headshot"] = 0.33;
	self.dmg_factor["bodyshot"] = 0.25;
	self.dmg_factor["melee"] = 0.25;
	self.dmg_factor["melee_riotshield"] = 0.25;
	self.dmg_factor["explosive"] = 0.33;
	self.dmg_factor["ai_damage"] = 0.25;
	self setengagementmindist(100,60);
	self setengagementmaxdist(512,768);
	self.goalradius = 128;
	self.goalheight = 81;
	thread manage_ai_relative_to_player(2,self.goalradius,"new_jug_behavior","stop_hunting");
}

//Function Number: 91
boss_jug_riotshield()
{
	self endon("death");
	self endon("riotshield_damaged");
	self.dmg_factor["headshot"] = 0.75;
	self.dmg_factor["bodyshot"] = 0.75;
	self.dmg_factor["melee"] = 0.33;
	self.dmg_factor["melee_riotshield"] = 0.33;
	self.dmg_factor["explosive"] = 1;
	self.dmg_factor["ai_damage"] = 0.25;
	if(getdvarint("survival_chaos") != 1)
	{
		self.dropriotshield = 1;
	}

	subclass_juggernaut_riotshield();
	if(getdvarint("survival_chaos") != 1)
	{
		thread juggernaut_abandon_shield();
	}

	if(1)
	{
		self.shieldbulletblocklimit = 9999;
	}

	self setengagementmindist(100,60);
	self setengagementmaxdist(512,768);
	self.goalradius = 128;
	self.goalheight = 81;
	self.usechokepoints = 0;
	thread manage_ai_relative_to_player(2,self.goalradius,"new_jug_behavior","stop_hunting");
	thread juggernaut_manage_min_pain_damage();
}

//Function Number: 92
juggernaut_manage_min_pain_damage()
{
	self endon("death");
	for(;;)
	{
		if(self.health <= 250)
		{
			self.minpaindamage = 250;
		}
		else
		{
			self.minpaindamage = 350;
		}

		wait 0.05;
	}
}

//Function Number: 93
subclass_juggernaut_riotshield()
{
	self.juggernaut = 1;
	self.doorflashchance = 0.05;
	self.aggressivemode = 1;
	self.ignoresuppression = 1;
	self.no_pistol_switch = 1;
	self.norunngun = 1;
	self.disablearrivals = 1;
	self.disablebulletwhizbyreaction = 1;
	self.combatmode = "no_cover";
	self.neversprintforvariation = 1;
	self.a.disablelongdeath = 1;
	self.pathenemyfightdist = 128;
	self.pathenemylookahead = 128;
	maps\_utility::disable_turnanims();
	maps\_utility::disable_surprise();
	self.meleealwayswin = 1;
	if(!self isbadguy())
	{
		return;
	}

	level notify("juggernaut_spawned");
	thread subclass_juggernaut_death();
}

//Function Number: 94
juggernaut_abandon_shield()
{
	self endon("death");
	thread juggernaut_abandon_shield_low_health(0.5);
	self waittill("riotshield_damaged");
	wait 0.05;
	ai_drop_riotshield();
	if(!isalive(self))
	{
		return;
	}

	animscripts/riotshield/riotshield::func_3AD4();
	thread maps\_juggernaut::subclass_juggernaut();
	self notify("new_jug_behavior");
	global_jug_behavior();
	thread boss_jug_regular();
}

//Function Number: 95
juggernaut_abandon_shield_low_health(param_00)
{
	self endon("death");
	self endon("riotshield_damaged");
	var_01 = self.health;
	if(isdefined(self.ally_ref))
	{
		var_01 = get_ai_health(self.ally_ref.ref);
	}

	for(;;)
	{
		self waittill("damage");
		if(self.health / var_01 <= param_00)
		{
			self notify("riotshield_damaged");
			return;
		}
	}
}

//Function Number: 96
subclass_juggernaut_death()
{
	self endon("new_jug_behavior");
	self waittill("death",var_00);
	if(getdvarint("survival_chaos") != 1)
	{
		ai_drop_riotshield();
	}

	level notify("juggernaut_died");
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(var_00))
	{
		return;
	}

	if(!isplayer(var_00))
	{
	}
}

//Function Number: 97
survival_boss_chopper()
{
	level.chopper_boss_min_dist2d = 128;
	maps\_chopperboss::chopper_boss_locs_populate("script_noteworthy","so_chopper_boss_path_struct");
}

//Function Number: 98
survival_drop_chopper_init()
{
	var_00 = common_scripts\utility::getstructarray("drop_path_start","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02;
		while(isdefined(var_03))
		{
			if(isdefined(var_03.script_unload))
			{
				var_03.ground_pos = maps\_utility::groundpos(var_03.origin);
				break;
			}

			if(isdefined(var_03.target))
			{
				var_03 = common_scripts\utility::getstruct(var_03.target,"targetname");
				continue;
			}

			break;
		}
	}
}

//Function Number: 99
spawn_chopper_boss(param_00,param_01)
{
	level endon("special_op_terminated");
	var_02 = maps\_so_survival_code::chopper_spawn_from_targetname(param_00,param_01.origin);
	var_02 maps\_so_survival_code::chopper_spawn_pilot_from_targetname("jug_drop_chopper_pilot");
	var_02 thread maps\_remotemissile_utility::setup_remote_missile_target();
	var_02.ally_ref = get_ai_struct(param_00);
	var_02 [[ level.var_3B89 ]]();
	if(isdefined(level.xp_enable) && level.xp_enable)
	{
		var_02 thread maps\_rank::ai_xp_init();
	}

	var_02.kill_assist_xp = int(get_ai_xp(param_00) * 0.2);
	level.bosses[level.bosses.size] = var_02;
	var_02 thread maps\_chopperboss::chopper_boss_behavior_little_bird(param_01);
	var_02 thread maps\_chopperboss::chopper_path_release("death deathspin");
	var_02 thread maps\_so_survival_code::clear_from_boss_array_when_dead();
	var_02 setthreatbiasgroup("boss");
	setthreatbias("sentry","boss",1500);
	foreach(var_04 in var_02.mgturret)
	{
		var_04 setbottomarc(90);
	}

	return var_02;
}

//Function Number: 100
spawn_ally_team(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	var_05 = maps\_so_survival_code::get_spawners_by_targetname(param_00)[0];
	if(!isdefined(var_05))
	{
		return var_04;
	}

	var_06 = maps\_so_survival_code::chopper_spawn_from_targetname_and_drive("ally_drop_chopper",param_02.origin,param_02);
	var_06 thread maps\_chopperboss::chopper_path_release("reached_dynamic_path_end death deathspin");
	var_06 maps\_vehicle::godon();
	var_06 vehicle_setspeed(60 + randomint(15),30,30);
	var_06.script_vehicle_selfremove = 1;
	var_06 endon("death");
	var_06 maps\_so_survival_code::chopper_spawn_pilot_from_targetname("friendly_support_delta");
	for(var_07 = 0;var_07 < param_01;var_07++)
	{
		var_08 = var_06 maps\_so_survival_code::chopper_spawn_passenger(var_05,var_07 + 2);
		var_08 maps\_utility::set_battlechatter(0);
		var_08 maps\_utility::deletable_magic_bullet_shield();
		var_08 thread ally_remove_bullet_shield(20,"jumpedout");
		var_08 setthreatbiasgroup("allies");
		var_08.ignoreme = 1;
		var_08.ally_ref = get_ai_struct(param_00);
		var_08 [[ level.var_3B89 ]]();
		var_08 thread setup_ai_weapon();
		var_08.owner = param_03;
		var_04[var_04.size] = var_08;
		var_08.var_6C1 = "allies";
		if(param_00 == "friendly_support_delta")
		{
			var_08.headicon = "headicon_delta_so";
		}

		if(param_00 == "friendly_support_riotshield")
		{
			var_08.headicon = "headicon_gign_so";
		}

		var_08.drawoncompass = 0;
		wait 0.05;
	}

	var_06 thread ally_team_setup(var_04);
	return var_04;
}

//Function Number: 101
_geteye()
{
	if(isdefined(self) && isalive(self))
	{
		return self geteye();
	}

	return undefined;
}

//Function Number: 102
ally_team_setup(param_00)
{
	self endon("death");
	self waittill("unloaded");
	common_scripts\utility::array_thread(param_00,::ally_setup);
}

//Function Number: 103
ally_setup()
{
	if(!isdefined(self) || !isalive(self))
	{
		return;
	}

	self setengagementmindist(300,200);
	self setengagementmaxdist(512,768);
	self.goalradius = 512;
	if(isdefined(self.ally_ref) && issubstr(self.ally_ref.ref,"riotshield"))
	{
		self.goalradius = 448;
		self setengagementmindist(200,100);
		self setengagementmaxdist(512,768);
		thread drop_riotshield_think();
		thread ally_manage_min_pain_damage(300);
	}
	else
	{
		thread ally_manage_min_pain_damage(150);
	}

	self.ignoreme = 0;
	self.fixednode = 0;
	self.dropweapon = 0;
	self.dropriotshield = 1;
	self.drawoncompass = 1;
	maps\_utility::set_battlechatter(1);
	self pushplayer(0);
	self.bullet_resistance = 30;
	thread ally_on_death();
	thread manage_ai_relative_to_player(4,self.goalradius);
}

//Function Number: 104
ally_manage_min_pain_damage(param_00)
{
	self endon("death");
	for(;;)
	{
		self.minpaindamage = param_00;
		wait 0.05;
	}
}

//Function Number: 105
drop_riotshield_think()
{
	self endon("death");
	common_scripts\utility::waittill_any_return("riotshield_damaged","dog_attacks_ai");
	wait 0.05;
	ai_drop_riotshield();
	if(!isalive(self))
	{
		return;
	}

	animscripts/riotshield/riotshield::func_3AD4();
}

//Function Number: 106
ally_remove_bullet_shield(param_00,param_01)
{
	self endon("death");
	if(isdefined(param_01))
	{
		self waittill(param_01);
	}

	wait param_00;
	maps\_utility::stop_magic_bullet_shield();
}

//Function Number: 107
ally_on_death()
{
	self waittill("death");
	if(isdefined(self.owner) && isalive(self.owner))
	{
		self.owner notify("ally_died");
	}

	ai_drop_riotshield();
}

//Function Number: 108
setup_ai_weapon()
{
	waittillframeend;
	if(isdefined(self.team) && self.team == "axis")
	{
		maps\_so_survival_loot::loot_roll();
	}

	if(isdefined(level.coop_incap_weapon))
	{
		self.sidearm = level.coop_incap_weapon;
		maps\_utility::place_weapon_on(self.sidearm,"none");
	}

	var_00 = get_ai_weapons(self.ally_ref.ref)[0];
	if(!isdefined(var_00) || var_00 == self.weapon)
	{
		return;
	}

	maps\_utility::forceuseweapon(var_00,"primary");
}

//Function Number: 109
get_all_mine_locs()
{
	var_00 = common_scripts\utility::getstructarray("so_claymore_loc","targetname");
	return var_00;
}

//Function Number: 110
ai_drop_riotshield()
{
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.weaponinfo["iw5_riotshield_so"]))
	{
		var_00 = self.weaponinfo["iw5_riotshield_so"].position;
		if(isdefined(self.dropriotshield) && self.dropriotshield && var_00 != "none")
		{
			thread animscripts/shared::func_23C9("iw5_riotshield_so",var_00);
		}

		animscripts/shared::func_23BE("iw5_riotshield_so");
		self.weaponinfo["iw5_riotshield_so"].position = "none";
		self.a.weaponpos[var_00] = "none";
	}
}

//Function Number: 111
manage_ai_relative_to_player(param_00,param_01,param_02,param_03)
{
	level endon("special_op_terminated");
	self endon("death");
	self.goalradius = common_scripts\utility::ter_op(isdefined(param_01),param_01,self.goalradius);
	self.goalheight = 80;
	if(isdefined(param_02))
	{
		var_04 = strtok(param_02," ");
		foreach(var_06 in var_04)
		{
			self endon(var_06);
		}
	}

	if(isdefined(param_03))
	{
		var_08 = strtok(param_03," ");
		foreach(var_0A in var_08)
		{
			self notify(var_0A);
		}
	}

	survival_disable_sprint();
	var_0C = 1;
	var_0D = undefined;
	for(;;)
	{
		var_0E = maps\_utility::get_closest_player_healthy(self.origin);
		if(!isdefined(var_0E))
		{
			var_0E = maps\_utility::get_closest_player(self.origin);
		}

		if(!isdefined(var_0E))
		{
			wait param_00;
			continue;
		}

		if(self.team == "allies")
		{
			if(distancesquared(self.origin,var_0E.origin) > self.goalradius * self.goalradius)
			{
				self setgoalentity(var_0E);
				wait 2;
				continue;
			}
		}
		else if(distancesquared(self.origin,var_0E.origin) < self.goalradius * self.goalradius)
		{
			self getenemyinfo(var_0E);
		}

		if(!isdefined(var_0D) || var_0D != var_0E)
		{
			var_0D = var_0E;
			self setgoalentity(var_0E);
			self notify("target_reset");
			thread bad_path_listener(var_0E);
		}

		if(var_0C)
		{
			var_0C = 0;
			if(self.team == "axis")
			{
				self getenemyinfo(var_0E);
			}
		}

		survival_disable_sprint();
		if(self.team == "allies")
		{
			self setgoalpos(self.origin);
			if(isdefined(self.subclass) && self.subclass == "riotshield")
			{
				wait randomfloatrange(0.2,2);
				var_0F = self.goalradius;
				self.goalradius = 1;
				wait 0.1;
				self.goalradius = var_0F;
			}
		}

		wait param_00;
	}
}

//Function Number: 112
bad_path_listener(param_00)
{
	self endon("target_reset");
	self endon("death");
	for(;;)
	{
		self waittill("bad_path");
		if(isdefined(param_00.node_closest))
		{
			self setgoalpos(param_00.node_closest.origin);
			var_01 = param_00.origin;
			while(distancesquared(var_01,param_00.origin) < 144)
			{
				wait 0.5;
			}

			self setgoalentity(param_00);
		}
	}
}

//Function Number: 113
manage_ai_poll_player_state(param_00)
{
	self endon("death");
	self endon("manage_ai_stop_polling_player_state");
	for(;;)
	{
		wait 0.1;
		if(!isdefined(param_00) || !isalive(param_00) || maps\_utility::is_player_down(param_00))
		{
			self notify("manage_ai_player_invalid");
			return;
		}
		else if(distancesquared(self.origin,param_00.origin) <= self.goalradius * self.goalradius)
		{
			self notify("manage_ai_player_found");
			return;
		}
	}
}

//Function Number: 114
manage_ai_go_to_player_node(param_00)
{
	if(isdefined(param_00.node_closest))
	{
		self setgoalpos(param_00.node_closest.origin);
	}
}

//Function Number: 115
survival_enable_sprint()
{
	if(isdefined(self.subclass) && self.subclass == "riotshield")
	{
		if(isdefined(self.juggernaut))
		{
			maps\_riotshield::riotshield_fastwalk_on();
			return;
		}

		maps\_riotshield::riotshield_sprint_on();
		return;
	}

	if(isdefined(self.juggernaut))
	{
		maps\_utility::enable_sprint();
		return;
	}

	self.combatmode = "no_cover";
}

//Function Number: 116
survival_disable_sprint()
{
	if(isdefined(self.subclass) && self.subclass == "riotshield")
	{
		if(isdefined(self.juggernaut))
		{
			maps\_riotshield::riotshield_fastwalk_off();
			return;
		}

		maps\_riotshield::riotshield_sprint_off();
		return;
	}

	if(isdefined(self.juggernaut))
	{
		maps\_utility::disable_sprint();
		return;
	}

	self.combatmode = "cover";
}

//Function Number: 117
ai_exist(param_00)
{
	return isdefined(level.survival_ai) && isdefined(level.survival_ai[param_00]);
}

//Function Number: 118
get_ai_index(param_00)
{
	if(ai_exist(param_00))
	{
		return level.survival_ai[param_00].idx;
	}

	return int(tablelookup("sp/survival_waves.csv",1,param_00,0));
}

//Function Number: 119
get_ai_ref_by_index(param_00)
{
	return tablelookup("sp/survival_waves.csv",0,param_00,1);
}

//Function Number: 120
get_ai_struct(param_00)
{
	var_01 = "Trying to get survival AI_type struct before stringtable is ready, or type doesnt exist.";
	return level.survival_ai[param_00];
}

//Function Number: 121
get_ai_classname(param_00)
{
	if(isdefined(level.var_3D57) && isdefined(level.var_3D57[param_00]))
	{
		return level.var_3D57[param_00];
	}

	if(ai_exist(param_00))
	{
		return level.survival_ai[param_00].classname;
	}

	return tablelookup("sp/survival_waves.csv",1,param_00,4);
}

//Function Number: 122
get_ai_weapons(param_00)
{
	if(isdefined(level.var_3D59) && isdefined(level.var_3D59[param_00]))
	{
		return level.var_3D59[param_00];
	}

	if(ai_exist(param_00))
	{
		return level.survival_ai[param_00].weapon;
	}

	var_01 = tablelookup("sp/survival_waves.csv",1,param_00,5);
	return strtok(var_01," ");
}

//Function Number: 123
get_ai_alt_weapons(param_00)
{
	if(ai_exist(param_00))
	{
		return level.survival_ai[param_00].altweapon;
	}

	var_01 = tablelookup("sp/survival_waves.csv",1,param_00,6);
	return strtok(var_01," ");
}

//Function Number: 124
get_ai_name(param_00)
{
	if(ai_exist(param_00))
	{
		return level.survival_ai[param_00].name;
	}

	return tablelookup("sp/survival_waves.csv",1,param_00,2);
}

//Function Number: 125
get_ai_desc(param_00)
{
	if(ai_exist(param_00))
	{
		return level.survival_ai[param_00].var_189B;
	}

	return tablelookup("sp/survival_waves.csv",1,param_00,3);
}

//Function Number: 126
get_ai_health(param_00)
{
	if(isdefined(level.survival_waves_repeated))
	{
		var_01 = 1 + level.survival_waves_repeated * 0.1;
	}
	else
	{
		var_01 = 1;
	}

	if(ai_exist(param_00))
	{
		return int(level.survival_ai[param_00].health * var_01);
	}

	var_02 = tablelookup("sp/survival_waves.csv",1,param_00,7);
	if(var_02 == "")
	{
		return undefined;
	}

	return int(int(var_02) * var_01);
}

//Function Number: 127
get_ai_speed(param_00)
{
	if(isdefined(level.survival_waves_repeated))
	{
		var_01 = 1 + level.survival_waves_repeated * 0.05;
	}
	else
	{
		var_01 = 1;
	}

	if(ai_exist(param_00))
	{
		return min(level.survival_ai[param_00].speed * var_01,1.5);
	}

	var_02 = tablelookup("sp/survival_waves.csv",1,param_00,8);
	if(var_02 == "")
	{
		return undefined;
	}

	return min(float(var_02) * var_01,1.5);
}

//Function Number: 128
get_ai_accuracy(param_00)
{
	if(isdefined(level.survival_waves_repeated))
	{
		var_01 = 1 + level.survival_waves_repeated * 0.2;
	}
	else
	{
		var_01 = 1;
	}

	if(ai_exist(param_00))
	{
		if(isdefined(level.survival_ai[param_00].accuracy))
		{
			return level.survival_ai[param_00].accuracy * var_01;
		}
		else
		{
			return level.survival_ai[param_00].accuracy;
		}
	}

	var_02 = tablelookup("sp/survival_waves.csv",1,param_00,11);
	if(var_02 == "")
	{
		return undefined;
	}

	return float(var_02) * var_01;
}

//Function Number: 129
get_ai_xp(param_00)
{
	if(ai_exist(param_00))
	{
		return level.survival_ai[param_00].xp;
	}

	var_01 = tablelookup("sp/survival_waves.csv",1,param_00,9);
	if(var_01 == "")
	{
		return undefined;
	}

	return int(var_01);
}

//Function Number: 130
is_ai_boss(param_00)
{
	if(ai_exist(param_00) && isdefined(level.survival_boss))
	{
		return isdefined(level.survival_boss[param_00]);
	}

	var_01 = tablelookup("sp/survival_waves.csv",1,param_00,10);
	if(!isdefined(var_01) || var_01 == "")
	{
		return 0;
	}

	return 1;
}

//Function Number: 131
wave_exist(param_00)
{
	return isdefined(level.survival_wave) && isdefined(level.survival_wave[param_00]);
}

//Function Number: 132
get_wave_boss_delay(param_00)
{
	if(wave_exist(param_00))
	{
		return level.survival_wave[param_00].var_3D4F;
	}

	return int(tablelookup(level.wave_table,2,param_00,1));
}

//Function Number: 133
get_wave_index(param_00)
{
	if(wave_exist(param_00))
	{
		return level.survival_wave[param_00].idx;
	}

	return int(tablelookup(level.wave_table,2,param_00,0));
}

//Function Number: 134
get_wave_number_by_index(param_00)
{
	return int(tablelookup(level.wave_table,0,param_00,2));
}

//Function Number: 135
get_squad_type(param_00)
{
	if(wave_exist(param_00))
	{
		return level.survival_wave[param_00].survival_ai_class_overrides;
	}

	return tablelookup(level.wave_table,2,param_00,3);
}

//Function Number: 136
get_squad_array(param_00)
{
	if(wave_exist(param_00))
	{
		return level.survival_wave[param_00].var_3D4C;
	}

	var_01 = [];
	var_02 = int(tablelookup(level.wave_table,2,param_00,4));
	if(var_02 <= 3)
	{
		var_01[0] = var_02;
	}
	else
	{
		var_03 = var_02 % 3;
		var_04 = int(var_02 / 3);
		for(var_05 = 0;var_05 < var_04;var_05++)
		{
			var_01[var_05] = 3;
		}

		if(var_03 == 1)
		{
			if(level.merge_squad_member_max == 4)
			{
				var_01[var_01.size - 1] = var_01[var_01.size - 1] + var_03;
			}
			else
			{
				var_06 = 1;
				var_01[var_01.size - 1] = var_01[var_01.size - 1] - var_06;
				var_01[var_01.size] = var_03 + var_06;
			}
		}
		else if(var_03 == 2)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 137
get_special_ai(param_00)
{
	if(wave_exist(param_00))
	{
		return level.survival_wave[param_00].var_3D4D;
	}

	var_01 = tablelookup(level.wave_table,2,param_00,5);
	if(isdefined(var_01) && var_01 != "")
	{
		return strtok(var_01," ");
	}

	return undefined;
}

//Function Number: 138
get_special_ai_quantity(param_00)
{
	if(wave_exist(param_00))
	{
		return level.survival_wave[param_00].var_3D4E;
	}

	var_01 = tablelookup(level.wave_table,2,param_00,6);
	var_02 = [];
	if(isdefined(var_01) && var_01 != "")
	{
		var_01 = strtok(var_01," ");
		for(var_03 = 0;var_03 < var_01.size;var_03++)
		{
			var_02[var_03] = int(var_01[var_03]);
		}

		return var_02;
	}

	return undefined;
}

//Function Number: 139
get_special_ai_type_quantity(param_00,param_01)
{
	var_02 = get_special_ai(param_00);
	var_03 = get_special_ai_quantity(param_00);
	if(isdefined(var_02) && isdefined(var_03) && var_02.size && var_03.size)
	{
		foreach(var_06, var_05 in var_02)
		{
			if(param_01 == var_05)
			{
				return var_03[var_06];
			}
		}
	}

	return 0;
}

//Function Number: 140
get_bosses_ai(param_00)
{
	if(wave_exist(param_00))
	{
		return level.survival_wave[param_00].bossai;
	}

	var_01 = tablelookup(level.wave_table,2,param_00,7);
	if(isdefined(var_01) && var_01 != "")
	{
		return strtok(var_01," ");
	}

	return undefined;
}

//Function Number: 141
get_bosses_nonai(param_00)
{
	if(wave_exist(param_00))
	{
		return level.survival_wave[param_00].bossnonai;
	}

	var_01 = tablelookup(level.wave_table,2,param_00,8);
	if(isdefined(var_01) && var_01 != "")
	{
		return strtok(var_01," ");
	}

	return undefined;
}

//Function Number: 142
is_repeating(param_00)
{
	if(wave_exist(param_00))
	{
		return level.survival_wave[param_00].repeating;
	}

	return int(tablelookup(level.wave_table,2,param_00,9));
}

//Function Number: 143
get_armory_unlocked(param_00)
{
	var_01 = tablelookup(level.wave_table,2,param_00,10);
	var_01 = strtok(var_01," ");
	return var_01;
}

//Function Number: 144
get_dog_type(param_00)
{
	if(wave_exist(param_00))
	{
		return level.survival_wave[param_00].dogtype;
	}

	var_01 = get_special_ai(param_00);
	if(!isdefined(var_01) || !var_01.size)
	{
		return "";
	}

	foreach(var_03 in var_01)
	{
		if(issubstr(var_03,"dog"))
		{
			return var_03;
		}
	}

	return "";
}

//Function Number: 145
get_dog_quantity(param_00)
{
	if(wave_exist(param_00))
	{
		return level.survival_wave[param_00].dogquantity;
	}

	var_01 = get_dog_type(param_00);
	if(!isdefined(var_01))
	{
		return 0;
	}

	return get_special_ai_type_quantity(param_00,var_01);
}