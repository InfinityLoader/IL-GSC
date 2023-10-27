/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hub_streaks.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 47
 * Decompile Time: 785 ms
 * Timestamp: 10/27/2023 3:23:17 AM
*******************************************************************/

//Function Number: 1
func_85BE()
{
	var_00 = getentarray("misc_turret","classname");
	var_01 = getentarray("aa_barrel_clip","targetname");
	level.var_813 = [];
	foreach(var_03 in var_00)
	{
		if(issubstr(var_03.var_106,"flak38"))
		{
			var_03 method_8153(-15);
			if(var_03.var_116 == (452.6,611.9,12.7))
			{
				var_03 method_8151(136);
				var_03 method_8150(118);
			}

			if(var_03.var_116 == (905.5,2614,24.9))
			{
				var_03 method_8151(119);
				var_03 method_8150(145);
				var_03 method_8153(-21);
			}

			if(var_03.var_116 == (-766.5,2652,-160.5))
			{
				var_03 method_8151(102);
				var_03 method_8150(177);
				var_03 method_8153(-19);
			}

			var_03 setdefaultdroppitchyaw(-35);
			var_03 thread func_5FC3();
			var_03 makeunusable();
			level.var_813 = common_scripts\utility::func_F6F(level.var_813,var_03);
			var_04 = function_01AC(var_01,var_03.var_116);
			var_03.var_15C9 = [];
			var_03.var_15C9[0] = var_04[0];
			var_03.var_15C9[1] = var_04[1];
			var_03.var_15C9[2] = var_04[2];
		}
	}

	level.var_611["gj_plane_smoke"] = loadfx("vfx/test/gj_plane_smoke_trail");
	level.var_611["plane_death"] = loadfx("vfx/map/mp_hub/hub_flak_enemy_plane_death_rnr");
	level.var_611["wing_explosion"] = loadfx("vfx/test/gj_plane_trail");
	level.var_611["fire_small"] = loadfx("vfx/fire/fire_lp_s");
	level.var_611["care_package_allies_destroy"] = loadfx("vfx/props/care_package_explode_allies");
	level.var_611["care_package_axis_beacon"] = loadfx("vfx/lights/ger_carepackage_beacon");
	level.var_611["care_package_allies_beacon"] = loadfx("vfx/lights/usa_carepackage_beacon");
	level.var_611["care_package_landed"] = loadfx("vfx/smoke/care_package_landed");
	level.var_611["care_package_hit"] = loadfx("vfx/explosion/bouncing_betty_explosion");
	level.var_611["gj_m45_quad_muzzleflash"] = loadfx("vfx/muzzleflash/ger_aa_flak38_wv_mp");
	level.var_611["hub_plane_tracer"] = loadfx("vfx/map/mp_hub/hub_flak_enemy_plane_tracer_rnr");
	level.var_320F = loadfx("vfx/unique/vfx_marker_dom_white");
	level.var_3CDF = 0;
	level.var_7043 = [];
	level.var_702F = getent("plane_care_package_start","targetname");
	level.var_702E = getent("plane_care_package_end","targetname");
	level.var_5FEB = (0,0,0);
	level.var_80B4 = [];
	level.var_80B5 = [];
	level.var_80B5["carepackage"] = 0;
	lib_0529::func_8A0E();
	setdvarifuninitialized("hub_flak_event_force_start",0);
	if(!level.var_4F50 && function_02A3())
	{
		thread func_63BD();
	}

	thread func_6396();
	thread func_63BC();
}

//Function Number: 2
func_63BD()
{
	level endon("game_ended");
	for(;;)
	{
		while(getdvarint("spv_hub_planes_kswitch",1) == 1 || getdvarint("1258",0))
		{
			wait(1);
		}

		var_00 = getdvarint("spv_hub_plane_event_freq",14400);
		var_01 = getdvarint("spv_hub_plane_event_range_time",3600);
		var_00 = randomintrange(var_00 - var_01,var_00 + var_01);
		wait(var_00);
		if(getdvarint("spv_hub_planes_kswitch",1) == 0)
		{
			func_4ADF();
		}
	}
}

//Function Number: 3
func_6396()
{
	level endon("game_ended");
	for(;;)
	{
		setdvar("hub_flak_event_force_start",0);
		while(getdvarint("hub_flak_event_force_start",0) == 0)
		{
			wait(1);
		}

		func_4ADF();
	}
}

//Function Number: 4
func_63BC()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("plane_event_start");
		wait(100);
		level notify("plane_event_end");
	}
}

//Function Number: 5
func_5FC3()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("turretownerchange");
		var_00 = self method_80E2();
		if(isdefined(var_00) && isplayer(var_00))
		{
			var_00 thread enteraaturret(self);
			var_00 maps\mp\gametypes\_hub_unk1::func_7D1D(3);
			var_00 maps\mp\gametypes\_hub_unk1::func_7D1E(2);
			var_00 enableslowaim(0.4,0.3,0.4,0.3);
			thread func_1FB3(var_00);
		}
	}
}

//Function Number: 6
handlenormalexit(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 waittill("turretownerchange");
	self notify("exit_aa_turret");
	foreach(var_02 in level.var_7043)
	{
		var_02 func_2F96(self);
	}

	self method_80F6();
	self method_85C7();
	self.var_5722 = 0;
	maps\mp\gametypes\_hub_unk1::func_870B(0);
	self setclientomnvar("ui_hub_in_flakgun",0);
	if(isdefined(param_00.var_15C9[0]))
	{
		param_00.var_15C9[0] solid();
	}

	if(isdefined(param_00.var_15C9[1]))
	{
		param_00.var_15C9[1] solid();
	}

	if(isdefined(param_00.var_15C9[2]))
	{
		param_00.var_15C9[2] solid();
	}

	maps\mp\gametypes\_hub_unk1::func_7E4E(3);
	maps\mp\gametypes\_hub_unk1::func_7E4F(2);
}

//Function Number: 7
handleleaveactivity(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("exit_aa_turret");
	for(;;)
	{
		self waittill("luinotifyserver",var_01,var_02);
		if(var_01 == "hub_leave_activity")
		{
			self method_85E9();
			return;
		}
	}
}

//Function Number: 8
enteraaturret(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	self method_85C8();
	self method_812B(1);
	self.var_5722 = 1;
	maps\mp\gametypes\_hub_unk1::func_870B(1);
	self setclientomnvar("ui_hub_in_flakgun",1);
	if(isdefined(param_00.var_15C9[0]))
	{
		param_00.var_15C9[0] notsolid();
	}

	if(isdefined(param_00.var_15C9[1]))
	{
		param_00.var_15C9[1] notsolid();
	}

	if(isdefined(param_00.var_15C9[2]))
	{
		param_00.var_15C9[2] notsolid();
	}

	thread handleleaveactivity(param_00);
	thread handlenormalexit(param_00);
}

//Function Number: 9
func_1FB3(param_00)
{
	self endon("death");
	level endon("game_ended");
	self endon("turretownerchange");
	for(;;)
	{
		self waittill("turret_fire",var_01);
		level notify("flak_projectile_fired",var_01[0],param_00);
		thread func_681D(param_00);
	}
}

//Function Number: 10
func_681D(param_00)
{
	var_01 = self.var_116 + (0,0,100);
	if(isdefined(param_00))
	{
	}

	var_02 = [];
	foreach(var_04 in level.var_744A)
	{
		if(!isdefined(param_00) || var_04 != param_00)
		{
			var_02[var_02.size] = var_04;
		}
	}

	if(isdefined(var_02) && var_02.size > 0)
	{
		lib_0380::func_2889("mp_hub_allies_npc_flak_tail",var_02,var_01);
	}
}

//Function Number: 11
func_4ADF()
{
	level endon("game_ended");
	if(level.var_3CDF)
	{
		return;
	}

	level.var_3CDF = 1;
	thread func_0B7A();
	level notify("plane_event_start");
	level.var_2DCA = 0;
	level.totalplanesdestroyed = 0;
	level.var_2758 = 0;
	level.var_2DC7 = 0;
	foreach(var_01 in level.var_744A)
	{
		if(var_01.var_572A)
		{
			continue;
		}
	}

	setomnvar("ui_flak_gun_event",1);
	setomnvar("ui_fge_timeRemaining",100);
	setomnvar("ui_fge_carepackages_secured",level.var_2758);
	setomnvar("ui_fge_carepackages_remaining",level.var_1FFD.size);
	setomnvar("ui_fge_planes_remaining",level.var_7043.size);
	thread func_4D4C();
	wait(10);
	thread eventtimekeeper();
	for(;;)
	{
		thread func_92F2();
		var_03 = level common_scripts\utility::func_A715("plane_event_end","spawnNextWave");
		if(var_03 == "plane_event_end")
		{
			break;
		}
	}

	if(level.var_2DCA > 0)
	{
		level.var_2DC7 = 1;
	}

	level.var_2DCA = -1;
	while(level.var_1FFD.size > 0 || level.var_A984)
	{
		wait(1);
	}

	setomnvar("ui_fge_planes_shot_down",level.totalplanesdestroyed);
	setomnvar("ui_fge_carepackages_remaining",level.var_1FFD.size);
	foreach(var_05 in level.var_7043)
	{
		if(isdefined(var_05))
		{
			var_05 thread func_5F15();
		}
	}

	if(level.var_2758 > 0)
	{
		foreach(var_01 in level.var_744A)
		{
			var_01 lib_0468::func_A21(level.var_2758);
			var_01 iclientprintln(&"MP_RECEIVED_ARMORY_CREDITS",level.var_2758 * 10);
		}
	}
	else if(level.var_2DC7)
	{
		foreach(var_01 in level.var_744A)
		{
			var_01 lib_0468::func_A21(0);
		}
	}

	setomnvar("ui_fge_carepackages_secured",level.var_2758);
	setomnvar("ui_flak_gun_event",0);
	setomnvar("ui_fge_timeRemaining",0);
	level.var_3CDF = 0;
}

//Function Number: 12
func_0B7A()
{
	level endon("game_ended");
	var_00 = (398,-374,500);
	lib_0380::func_2889("mp_hub_allies_air_raid_horn",undefined,var_00);
	wait(3);
	lib_0380::func_2889("mp_hub_allies_air_raid_horn_lp",undefined,var_00);
	wait(20);
	lib_0380::func_2889("mp_hub_allies_air_raid_horn_lp",undefined,var_00);
	wait(20);
	lib_0380::func_2889("mp_hub_allies_air_raid_horn_lp",undefined,var_00);
	wait(20);
	lib_0380::func_2889("mp_hub_allies_air_raid_horn_lp",undefined,var_00);
	wait(20);
	lib_0380::func_2889("mp_hub_allies_air_raid_horn_lp",undefined,var_00);
	wait(15);
	lib_0380::func_2889("mp_hub_allies_air_raid_horn_end",undefined,var_00);
}

//Function Number: 13
eventtimekeeper()
{
	level endon("game_ended");
	for(var_00 = 90;var_00 > 0;var_00 = var_00 - 1)
	{
		setomnvar("ui_fge_timeRemaining",var_00);
		wait(1);
	}
}

//Function Number: 14
func_92F2()
{
	level endon("game_ended");
	wait(3);
	if(level.var_2DCA == -1)
	{
		return;
	}

	level.var_2DCA = 0;
	level.var_94DE = 1;
	level.var_A984 = 1;
	func_9032();
	wait(5);
	thread func_9061();
	thread managefighterplanetracers();
	while(level.var_1FFD.size < 1 || level.var_7043.size < 1)
	{
		wait(1);
	}

	level.var_A984 = 0;
}

//Function Number: 15
func_4D4C()
{
	level endon("game_ended");
	foreach(var_01 in level.var_813)
	{
		var_01 thread func_4ACA();
		var_01 makeusable();
	}

	level waittill("plane_event_end");
	while(level.var_A984)
	{
		wait(1);
	}

	while(level.var_7043.size > 0)
	{
		wait(1);
	}

	foreach(var_01 in level.var_813)
	{
		var_01 makeunusable();
		var_04 = var_01 method_80E2();
		if(isdefined(var_04))
		{
			var_04 method_80E0(var_01);
		}
	}
}

//Function Number: 16
destroycrateaftertime(param_00)
{
	level endon("game_ended");
	self endon("crate_start_countdown");
	wait(param_00);
	if(isdefined(self))
	{
		lib_0529::func_2D30(1,1,1);
	}
}

//Function Number: 17
func_4ACA()
{
	level endon("game_ended");
	level endon("plane_event_end");
	for(;;)
	{
		var_00 = self method_80E2();
		if(isdefined(var_00) && isplayer(var_00))
		{
			foreach(var_02 in level.var_7043)
			{
				var_02 func_365E(var_00);
			}
		}

		self waittill("turretownerchange");
	}
}

//Function Number: 18
func_365E(param_00)
{
	if(!isdefined(param_00))
	{
		foreach(var_02 in level.var_813)
		{
			param_00 = var_02 method_80E2();
			if(isdefined(param_00) && isplayer(param_00))
			{
				self hudoutlineenableforclient(param_00,1,0);
			}
		}

		return;
	}

	self hudoutlineenableforclient(param_00,1,0);
}

//Function Number: 19
func_2F96(param_00)
{
	if(!isdefined(param_00))
	{
		foreach(param_00 in level.var_744A)
		{
			self hudoutlinedisableforclient(param_00);
		}

		return;
	}

	self hudoutlinedisableforclient(param_00);
}

//Function Number: 20
func_9032()
{
	var_00 = spawn("script_model",level.var_702F.var_116);
	var_00.var_1D = (0,300,0);
	var_01 = "usa_bomber_commando_vista";
	var_02 = "usa_bomber_commando_vista_fade";
	var_00 setmodel(var_02);
	var_00 thread func_39C6(var_01,1);
	var_00 scriptmodelplayanim("ks_emergency_airdrop_usa");
	thread func_3EB7(var_00);
	var_00.var_1A7 = "allies";
	var_00 thread func_649F(var_02);
	var_00 hudoutlineenableforclients(level.var_744A,2,0);
}

//Function Number: 21
func_3EB7(param_00)
{
	wait(2.5);
	lib_0380::func_288B("mp_hub_friendly_plane_flyby",undefined,param_00);
}

//Function Number: 22
func_649F(param_00)
{
	level endon("game_ended");
	var_01 = 10;
	self moveto(level.var_702E.var_116 + (0,0,1500),var_01);
	wait(6.75);
	self moveto(level.var_702E.var_116 + (0,0,1500),var_01);
	func_7032();
	self moveto(level.var_702E.var_116 + (0,0,1500),2);
	wait(1);
	func_39CB(param_00,1);
	wait(1);
	self delete();
}

//Function Number: 23
func_7032()
{
	for(var_00 = 0;var_00 < 10;var_00++)
	{
		thread func_4AAD(var_00);
		wait(randomfloatrange(0.2,0.4));
	}

	setomnvar("ui_fge_carepackages_remaining",level.var_1FFD.size);
}

//Function Number: 24
notifyplayers(param_00,param_01)
{
	foreach(var_03 in level.var_744A)
	{
		if(var_03.var_572A)
		{
			continue;
		}

		var_03 luinotifyeventextraplayer(param_01,1,param_00);
	}
}

//Function Number: 25
func_4ACD(param_00)
{
	self endon("captured");
	self endon("death");
	common_scripts\utility::func_A74B("crate_start_countdown",120);
	if(isdefined(self.var_321B))
	{
		if(!isdefined(self.var_321B.var_7450))
		{
			self.var_321B.var_7450 = 0;
		}

		notifyplayers(self,&"init_supply_drop_countdown");
		wait(1);
		for(var_01 = 9;var_01 > 0;var_01--)
		{
			for(var_02 = 0;self.var_321B.var_7450 > 0;var_02 = 1)
			{
				if(!var_02)
				{
					notifyplayers(self,&"set_supply_drop_countdown");
				}

				wait(0.25);
			}

			if(var_02)
			{
				notifyplayers(self,&"set_supply_drop_countdown");
			}

			wait(1);
		}

		while(self.var_321B.var_7450 > 0)
		{
			wait(0.25);
		}
	}
}

//Function Number: 26
func_4AB3(param_00)
{
	level endon("game_ended");
	self endon("death");
	func_4ACD(param_00);
	if(isdefined(self) && isdefined(self.var_6E4A))
	{
		self.var_6E4A delete();
	}

	if(isdefined(self) && isdefined(self.flag_wait))
	{
		self.flag_wait delete();
	}

	notifyplayers(self,&"delete_supply_drop_countdown");
	common_scripts\utility::func_F93(level.var_1FFD,self);
	setomnvar("ui_fge_carepackages_remaining",level.var_1FFD.size - 1);
	lib_0529::func_2D30(1,1);
}

//Function Number: 27
func_4AAD(param_00)
{
	level endon("game_ended");
	var_01 = spawn("script_model",self.var_116 + (randomintrange(-3,3),randomfloatrange(-3,3),-20));
	var_01.var_1D = (0,0,0);
	var_01.var_28D5 = 0;
	var_01.var_A22B = 0;
	var_01.var_1A7 = "any";
	var_01.var_2748 = 99;
	var_01.visualteam = "allies";
	var_01.var_944E = "ammo";
	var_01.var_1A5 = "care_package";
	var_01 setmodel("usa_carepackage_crate");
	playfxontag(common_scripts\utility::func_44F5("care_package_allies_beacon"),var_01,"TAG_FX");
	var_02 = spawn("script_model",var_01 gettagorigin("tag_origin") + (0,0,-10));
	var_02.var_1D = (0,180,0);
	var_02 setmodel("usa_carepackage_parachute_anim");
	var_02.var_3A1C = randomintrange(5,15);
	level.var_94DE = level.var_94DE + var_02.var_3A1C;
	var_02.var_1A7 = "allies";
	var_02.visualteam = "allies";
	var_03 = spawn("script_model",var_02.var_116);
	var_03.var_1D = var_02.var_1D;
	var_03 setmodel("ger_carepackage_parachute");
	var_03 setcandamage(1);
	var_03 method_805C();
	var_03 method_8449(var_02);
	var_01.var_1D = var_02 gettagangles("TAG_CRATE");
	var_01.var_116 = var_02 gettagorigin("TAG_CRATE");
	var_01 method_8449(var_02,"TAG_CRATE");
	var_01.var_6E4A = var_02;
	var_01.flag_wait = var_03;
	var_01 thread func_4AB3(param_00);
	var_02 thread func_64B8();
	var_02 scriptmodelplayanim("carepackage_parachute_deploy");
	wait(1.75);
	var_02.var_2D6A = 1;
	if(isdefined(var_01.var_6E4A))
	{
		var_02 scriptmodelplayanim("carepackage_parachute_loop");
	}

	var_02 thread lib_0529::func_63BB(var_01,var_02);
	var_03 thread lib_0529::func_63BA(var_02,var_01);
	var_01 thread lib_0529::func_2745();
	var_01 thread lib_0529::func_2752(var_01.var_944E);
	var_01 thread lib_0529::func_74BA();
	var_01 thread destroycrateaftertime(60);
}

//Function Number: 28
func_64B8()
{
	self endon("death");
	self endon("detach");
	thread func_1FF9();
	for(;;)
	{
		if(!isdefined(self.var_2D6A) || !self.var_2D6A)
		{
			self moveto(self.var_116 - (0,0,35),0.05);
		}
		else
		{
			self moveto(self.var_116 - (0,0,self.var_3A1C),0.05);
		}

		wait 0.05;
	}
}

//Function Number: 29
func_1FF9()
{
	var_00 = self;
	var_01 = 0.5;
	var_02 = 0.5;
	var_03 = lib_0380::func_288B("mp_hub_crpkg_parachute_lp",undefined,var_00,var_01);
	var_00 waittill("detach");
	lib_0380::func_2893(var_03,var_02);
	lib_0380::func_2889("mp_hub_crpkg_parachute_release",undefined,var_00.var_116);
}

//Function Number: 30
func_9061()
{
	var_00 = 600;
	var_01 = function_01DC("plane_start_node","targetname");
	var_02 = randomint(var_01.size);
	var_03 = 0;
	while(var_03 < 12)
	{
		var_04 = var_01[var_02];
		var_05 = function_01DC(var_04.var_81EF,"script_linkname");
		var_05 = common_scripts\utility::func_F92(var_05);
		func_9060(var_04);
		var_03++;
		wait(0.6);
		if(var_05.size > 0)
		{
			func_9060(var_05[0]);
			var_03++;
		}

		if(var_05.size > 1)
		{
			func_9060(var_05[1]);
			var_03++;
		}

		wait(5);
		var_06 = randomint(var_01.size);
		if(var_06 == var_02)
		{
			var_06++;
			if(var_06 >= var_01.size)
			{
				var_06 = 0;
			}
		}

		var_02 = var_06;
	}
}

//Function Number: 31
objnum(param_00)
{
	if(!isdefined(level.var_68A7))
	{
		level.var_68A7 = [];
	}

	if(!isdefined(level.var_68A7[param_00]))
	{
		level.var_68A7[param_00] = level.var_68A7.size + 1;
	}

	return level.var_68A7[param_00];
}

//Function Number: 32
func_9060(param_00)
{
	var_01 = maps\mp\_utility::func_8FE4(param_00.var_165,"ger_bomber_stuka_vista","ger_bomber_stuka_hub",1);
	lib_0380::func_6846("mp_hub_allies_flak_event_plane_lp",undefined,var_01);
	var_01 thread maps\mp\gametypes\_damage::func_8676(1500,undefined,::func_7040);
	var_01.var_BC = var_01.var_FB;
	var_01.var_1193 = [];
	var_01.var_29B5 = ::func_703F;
	var_01.firing = 0;
	var_01 func_365E();
	var_01 thread func_3BD4();
	level.var_7043 = common_scripts\utility::func_F6F(level.var_7043,var_01);
	setomnvar("ui_fge_planes_remaining",level.var_7043.size);
	var_01 thread func_4AC1();
}

//Function Number: 33
func_4AC1()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	for(;;)
	{
		level waittill("flak_projectile_fired",var_00,var_01);
		thread func_3CE3(var_00,var_01);
	}
}

//Function Number: 34
func_3CE3(param_00,param_01)
{
	self endon("death");
	self endon("crashing");
	param_01 endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	var_02 = 422500;
	for(;;)
	{
		var_03 = self.var_116;
		var_04 = distancesquared(param_00.var_116,var_03);
		if(var_04 < var_02)
		{
			self dodamage(500,var_03,param_01,param_00,"MOD_PROJECTILE",param_00.var_A9E0);
			param_00 method_81D6();
		}

		wait 0.05;
	}
}

//Function Number: 35
managefighterplanetracers()
{
	level endon("game_ended");
	level endon("plane_event_end");
	for(;;)
	{
		var_00 = isdefined(level.var_1FFD) && level.var_1FFD.size > 0;
		foreach(var_02 in level.var_7043)
		{
			if(var_02.firing && !var_00)
			{
				var_03 = common_scripts\utility::func_44F5("hub_plane_tracer");
				stopfxontag(var_03,var_02,"tag_muzzle_fx_1");
				stopfxontag(var_03,var_02,"tag_muzzle_fx_2");
				var_02.firing = 0;
			}

			if(!var_02.firing && var_00)
			{
				var_03 = common_scripts\utility::func_44F5("hub_plane_tracer");
				wait 0.05;
				playfxontag(var_03,var_02,"tag_muzzle_fx_1");
				wait 0.05;
				playfxontag(var_03,var_02,"tag_muzzle_fx_2");
				var_02.firing = 1;
			}
		}

		wait(1);
	}
}

//Function Number: 36
func_3BD4()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("stop_shooting");
	for(;;)
	{
		while(!isdefined(level.var_1FFD) || level.var_1FFD.size == 0)
		{
			wait(1);
		}

		var_00 = randomint(level.var_94DE);
		for(var_01 = 0;var_01 < level.var_1FFD.size;var_01++)
		{
			if(!isdefined(level.var_1FFD[var_01]) || !isdefined(level.var_1FFD[var_01].var_6E4A))
			{
				continue;
			}

			if(var_00 < level.var_1FFD[var_01].var_6E4A.var_3A1C)
			{
				self.var_9823 = level.var_1FFD[var_01];
				break;
			}

			var_00 = var_00 - level.var_1FFD[var_01].var_6E4A.var_3A1C;
		}

		for(var_01 = 0;var_01 < 4;var_01++)
		{
			if(isdefined(self.var_9823) && !isdefined(self.var_9823.var_5AFA))
			{
				lib_0380::func_6842("mp_hub_plane_shot",undefined,self.var_116);
			}

			wait(0.5);
		}

		if(isdefined(self.var_9823) && !isdefined(self.var_9823.var_5AFA))
		{
			var_02 = self.var_116;
			lib_0380::func_2889("mp_hub_care_package_hit",undefined,var_02);
			self.var_9823.var_2748 = self.var_9823.var_2748 - 11;
			playfxontag(level.var_611["care_package_hit"],self.var_9823,"tag_origin");
			if(self.var_9823.var_2748 <= 11)
			{
				playfxontag(level.var_611["fire_small"],self.var_9823,"tag_origin");
			}

			if(self.var_9823.var_2748 <= 0 && isdefined(self.var_9823.flag_wait))
			{
				lib_0380::func_2889("mp_hub_care_package_exp",undefined,var_02);
				self.var_9823.flag_wait dodamage(1,self.var_116);
				setomnvar("ui_fge_carepackages_remaining",level.var_1FFD.size);
			}
		}
	}
}

//Function Number: 37
func_64B9()
{
	level endon("game_ended");
	self endon("crashing");
	self endon("death");
	self scriptmodelplayanim("mp_hub_airplane");
	for(;;)
	{
		if(self.var_A995 % 2 == 0)
		{
			self moveto(level.var_705E[self.var_A995].var_116 + self.var_6A15,7);
			wait(7);
		}
		else
		{
			self moveto(level.var_705E[self.var_A995].var_116 + self.var_6A15,14);
			wait(14);
		}

		self.var_1D = level.var_705E[self.var_A995].var_1D;
		self.var_A995++;
		if(self.var_A995 == 4)
		{
			self.var_A995 = 0;
		}
	}
}

//Function Number: 38
func_9BC4(param_00)
{
	level endon("game_ended");
	self endon("crashing");
	if(!isdefined(self.var_669B))
	{
		self.var_669B = self.var_116;
	}

	while(isdefined(self))
	{
		self.var_6A67 = self.var_669B;
		self.var_669B = self.var_116;
		if(isdefined(level.var_1FFD) && level.var_1FFD.size > 0)
		{
			var_01 = self.var_9823;
			if(!isdefined(var_01))
			{
				wait(1);
				continue;
			}

			if(isdefined(self.var_5A45))
			{
				break;
			}

			var_02 = distance2dsquared(var_01.var_116,self.var_116);
			if(var_02 < 30000000)
			{
				if(isdefined(var_01.flag_wait))
				{
					var_01.flag_wait dodamage(1,var_01.var_116,self);
				}

				playfx(level.var_5959,var_01.var_116);
				var_01.var_2DC4 = 1;
				self.var_5A45 = 1;
				setomnvar("ui_fge_carepackages_remaining",level.var_1FFD.size);
				if(isdefined(self.var_4F7D))
				{
					self.var_4F7D destroy();
				}

				self moveto(self.var_2952.var_116,5);
				wait(5);
				func_2F96();
				func_2D47();
			}
		}

		wait 0.05;
	}
}

//Function Number: 39
func_9BCE()
{
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		if(self.var_116[2] < 600)
		{
			func_2D47();
			playfx(level.var_5959,self.var_116);
		}

		wait(0.5);
	}
}

//Function Number: 40
func_2D47()
{
	if(!isdefined(self))
	{
		return;
	}

	level.var_7043 = common_scripts\utility::func_F93(level.var_7043,self);
	if(level.var_2DCA != -1)
	{
		level.var_2DCA++;
		level.totalplanesdestroyed++;
		setomnvar("ui_fge_planes_remaining",level.var_7043.size);
	}

	if(level.var_2DCA >= 12)
	{
		level notify("spawnNextWave");
	}

	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 41
func_2D48(param_00)
{
	level endon("game_ended");
	self endon("death");
	wait(param_00);
	if(isdefined(self))
	{
		func_2D47();
	}
}

//Function Number: 42
func_7040(param_00,param_01,param_02,param_03)
{
	self.var_1180 = param_00;
	func_5F15();
}

//Function Number: 43
func_7030(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00.maxhealth) && !isplayer(param_00))
	{
		param_00 = param_00 method_80E2();
	}

	param_00 maps\mp\gametypes\_damagefeedback::func_A102("standard_nosound");
	return param_03;
}

//Function Number: 44
func_703F(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(param_01.maxhealth) && !isplayer(param_01))
	{
		param_01 = param_01 method_80E2();
	}

	if(isdefined(self.var_6E74))
	{
		var_0C = self.var_6E74;
	}
	else
	{
		var_0C = self;
	}

	var_0C.var_1193 = maps\mp\_utility::func_2341(var_0C.var_1193);
	if(!common_scripts\utility::func_F79(var_0C.var_1193,param_01))
	{
		var_0C.var_1193[param_01.var_48CA] = param_01;
	}

	playfx(level.var_5959,self.var_116);
	if(param_05 != "turretweapon_ger_btry_flak38_mp" && param_05 != "bazooka_mp" && param_05 != "panzerschreck_mp")
	{
		param_02 = 1;
	}

	var_0C.var_BC = var_0C.var_BC - param_02;
	if(var_0C.var_BC <= 0)
	{
		param_01 maps\mp\gametypes\_damagefeedback::func_A102("killshot_nosound");
		var_0C func_5F15();
		foreach(var_0E in var_0C.var_1193)
		{
			var_0E thread maps\mp\gametypes\_missions::func_7750("ch_hq_aagun");
		}

		return;
	}

	param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard_nosound");
}

//Function Number: 45
func_5F15()
{
	level endon("game_ended");
	self endon("death");
	if(isdefined(self.var_56BB))
	{
		return;
	}

	var_00 = common_scripts\utility::func_44F5("hub_plane_tracer");
	stopfxontag(var_00,self,"tag_muzzle_fx_1");
	stopfxontag(var_00,self,"tag_muzzle_fx_2");
	if(isdefined(self.var_4F7D))
	{
		self.var_4F7D destroy();
	}

	foreach(var_02 in level.var_744A)
	{
		func_2F96(var_02);
	}

	self notify("crashing");
	self.var_56BB = 1;
	var_04 = anglestoforward(self.var_1D);
	playfx(common_scripts\utility::func_44F5("plane_death"),self.var_116,var_04);
	var_05 = self.var_116;
	lib_0380::func_2889("mp_hub_plane_destruct_explode",undefined,var_05);
	func_2D47();
}

//Function Number: 46
func_39C6(param_00,param_01)
{
	self endon("death");
	self setmaterialscriptparam(0,1,param_01);
	wait(param_01);
	self setmodel(param_00);
}

//Function Number: 47
func_39CB(param_00,param_01)
{
	self setmodel(param_00);
	self setmaterialscriptparam(1,0,param_01);
}