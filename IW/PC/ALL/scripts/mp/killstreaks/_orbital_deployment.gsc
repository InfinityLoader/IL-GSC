/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_orbital_deployment.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 39
 * Decompile Time: 2390 ms
 * Timestamp: 10/27/2023 12:29:15 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_E5DE = [];
	level.var_DF7E["explode"] = loadfx("vfx/core/expl/aerial_explosion");
	scripts\mp\killstreaks\_killstreaks::func_DEFB("orbital_deployment",::func_128F2);
	level._effect["odin_clouds"] = loadfx("vfx/core/mp/killstreaks/odin/odin_parallax_clouds");
	level._effect["odin_fisheye"] = loadfx("vfx/code/screen/vfx_scrnfx_odin_fisheye.vfx");
	level._effect["odin_targeting"] = loadfx("vfx/core/mp/killstreaks/odin/vfx_marker_good_target");
	level._effect["odin_targeting_bad"] = loadfx("vfx/core/mp/killstreaks/odin/vfx_marker_bad_target");
	level._effect["phase_out_friendly"] = loadfx("vfx/core/mp/killstreaks/vfx_phase_orbital_deployment_friendly");
	level._effect["phase_out_enemy"] = loadfx("vfx/core/mp/killstreaks/vfx_phase_orbital_deployment_enemy");
	level._effect["drop_pod_atmo"] = loadfx("vfx/core/expl/emp_flash_mp");
	level._effect["drop_pod_fx"] = loadfx("vfx/core/mp/killstreaks/odin/vfx_odin_flash_small");
	level.var_C6D7 = [];
	level.var_C6D7["orbital_deployment"] = spawnstruct();
	level.var_C6D7["orbital_deployment"].var_11901 = 60;
	level.var_C6D7["orbital_deployment"].var_110EA = "orbital_deployment";
	level.var_C6D7["orbital_deployment"].var_13260 = "odin_mp";
	level.var_C6D7["orbital_deployment"].var_B91A = "vehicle_odin_mp";
	level.var_C6D7["orbital_deployment"].var_115EB = "used_orbital_deployment";
	level.var_C6D7["orbital_deployment"].var_13553 = "odin_gone";
	level.var_C6D7["orbital_deployment"].var_1352D = "odin_target_killed";
	level.var_C6D7["orbital_deployment"].var_1352C = "odin_targets_killed";
	level.var_C6D7["orbital_deployment"].var_12B20 = 3;
	level.var_C6D7["orbital_deployment"].var_12B80 = &"KILLSTREAKS_ODIN_UNAVAILABLE";
	level.var_C6D7["orbital_deployment"].var_394["juggernaut"] = spawnstruct();
	level.var_C6D7["orbital_deployment"].var_394["juggernaut"].var_D5E4 = "null";
	level.var_C6D7["orbital_deployment"].var_394["juggernaut"].var_D5DD = "odin_jugg_launch";
	if(!isdefined(level.var_8D7C))
	{
		level.var_8D7C = getent("heli_pilot_mesh","targetname");
		if(!isdefined(level.var_8D7C))
		{
		}
		else
		{
			level.var_8D7C.origin = level.var_8D7C.origin + scripts\mp\_utility::func_7EF9();
		}
	}

	level.var_163A = [];
}

//Function Number: 2
func_128F2(param_00)
{
	self endon("disconnect");
	var_01 = param_00.var_98F2;
	if(isdefined(self.var_12B90) && self.var_12B90)
	{
		return 0;
	}

	var_02 = func_10DD3(param_00.var_110EA);
	if(!isdefined(var_02))
	{
		var_02 = 0;
	}

	return var_02;
}

//Function Number: 3
func_10DD3(param_00,param_01)
{
	level endon("game_ended");
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	self.var_E2D7 = vectortoangles(anglestoforward(self.angles));
	func_C6CB();
	if(param_01 == 1)
	{
		scripts\common\utility::func_1C6E(0);
		scripts\common\utility::func_1C76(0);
		scripts\mp\_utility::func_93FA();
		var_02 = func_49FB();
		if(!isdefined(var_02))
		{
			scripts\common\utility::func_1C76(1);
			scripts\mp\_utility::func_4FC1();
			return 0;
		}

		self method_825C(var_02);
	}
	else
	{
		scripts\common\utility::func_1C6E(0);
		scripts\common\utility::func_1C76(0);
		var_03 = scripts\mp\killstreaks\_mapselect::func_8112(param_00);
		if(!isdefined(var_03))
		{
			func_C6C4();
			scripts\common\utility::func_1C6E(1);
			scripts\common\utility::func_1C76(1);
			return 0;
		}

		func_10DD4(var_03[0].var_AEC4,var_03[0].var_AEC4 + (0,0,10000),param_00);
	}

	return 1;
}

//Function Number: 4
func_49FB()
{
	var_00 = (0,0,0);
	var_01 = self.origin * (1,1,0) + level.var_8D7C.origin - scripts\mp\_utility::func_7EF9() * (0,0,1);
	var_02 = spawnhelicopter(self,var_01,var_00,level.var_C6D7["orbital_deployment"].var_13260,level.var_C6D7["orbital_deployment"].var_B91A);
	if(!isdefined(var_02))
	{
		return;
	}

	var_02.var_2B3 = 40;
	var_02.var_222 = self;
	var_02.team = self.team;
	var_02.var_110EA = "orbital_deployment";
	level.var_163A["orbital_deployment"] = 1;
	self.var_98FF = 1;
	self.var_A641 = 0;
	self.var_C6C3 = var_02;
	var_02 thread func_C6D4();
	var_02 thread func_C6D3();
	var_02 thread func_C6D0();
	var_02 thread func_C6D2();
	return var_02;
}

//Function Number: 5
func_C6D4()
{
	self endon("death");
	level endon("game_ended");
	var_00 = self.var_222;
	var_00 endon("disconnect");
	var_00 endon("juggernaut_dead");
	if(!isai(var_00))
	{
		var_00 notifyonplayercommand("orbital_deployment_action","+attack");
		var_00 notifyonplayercommand("orbital_deployment_action","+attack_akimbo_accessible");
	}

	for(;;)
	{
		var_00 waittill("orbital_deployment_action");
		if(scripts\mp\_utility::func_9FB3(self.var_1156A.var_EA21))
		{
			var_00 setclientomnvar("ui_odin",-1);
			var_00 func_10DD4(self.var_1156A.origin,self.origin,self.var_110EA);
			var_00 method_825D(self);
			func_4074();
			self notify("death");
			break;
		}
		else
		{
			var_00 scripts\mp\_utility::_playlocalsound("odin_negative_action");
		}

		wait(1.1);
	}
}

//Function Number: 6
func_7E6A(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = getnodesinradiussorted(param_00,256,0,128,"Path");
	if(!isdefined(var_01[0]))
	{
		return;
	}

	return var_01[0];
}

//Function Number: 7
func_C6D3()
{
	level endon("game_ended");
	self endon("death");
	self.var_222 endon("disconnect");
	self.var_222 endon("joined_team");
	self.var_222 endon("joined_spectators");
	var_00 = level.var_C6D7["orbital_deployment"];
	scripts\mp\_hostmigration::func_13708(var_00.var_11901);
	thread func_C6C7();
}

//Function Number: 8
func_C6D0()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.var_222 scripts\common\utility::waittill_any_3("disconnect","joined_team","joined_spectators");
	thread func_C6C7();
}

//Function Number: 9
func_C6D2()
{
	self endon("death");
	level endon("game_ended");
	var_00 = self.var_222;
	var_00 endon("disconnect");
	var_01 = var_00 method_816E();
	var_02 = var_01 + anglestoforward(self gettagangles("tag_player")) * 10000;
	var_03 = bullettrace(var_01,var_02,0,self);
	var_04 = spawn("script_model",var_03["position"]);
	var_04.angles = vectortoangles((0,0,1));
	var_04 setmodel("tag_origin");
	self.var_1156A = var_04;
	var_04 endon("death");
	var_05 = bullettrace(var_04.origin + (0,0,50),var_04.origin + (0,0,-100),0,var_04);
	var_04.origin = var_05["position"] + (0,0,50);
	var_04 hide();
	var_04 showtoplayer(var_00);
	var_04 childthread func_B9F2(var_00);
	thread func_10129();
	self method_831F(var_04);
}

//Function Number: 10
func_B9F2(param_00)
{
	param_00 endon("disconnect");
	self endon("death");
	level endon("game_ended");
	wait(1.5);
	var_01 = [];
	for(;;)
	{
		var_02 = func_7E6A(self.origin);
		if(isdefined(var_02))
		{
			self.var_EA21 = 1;
			stopfxontag(level._effect["odin_targeting_bad"],self,"tag_origin");
			wait(0.05);
			playfxontag(level._effect["odin_targeting"],self,"tag_origin");
		}
		else
		{
			self.var_EA21 = 0;
			stopfxontag(level._effect["odin_targeting"],self,"tag_origin");
			wait(0.05);
			playfxontag(level._effect["odin_targeting_bad"],self,"tag_origin");
		}

		var_03 = param_00 scripts\mp\_utility::func_7BC3();
		foreach(var_05 in var_01)
		{
			if(!scripts\common\utility::func_2286(var_03,var_05))
			{
				var_01 = scripts\common\utility::func_22A9(var_01,var_05);
				self hide();
				self showtoplayer(param_00);
			}
		}

		foreach(var_05 in var_03)
		{
			self showtoplayer(var_05);
			if(!scripts\common\utility::func_2286(var_01,var_05))
			{
				var_01 = scripts\common\utility::array_add(var_01,var_05);
				stopfxontag(level._effect["odin_targeting"],self,"tag_origin");
				wait(0.05);
				playfxontag(level._effect["odin_targeting"],self,"tag_origin");
			}
		}

		wait(0.05);
	}
}

//Function Number: 11
func_10129()
{
	self endon("death");
	wait(1);
	var_00 = func_7E6A(self.var_1156A.origin);
	if(isdefined(var_00))
	{
		playfxontag(level._effect["odin_targeting"],self.var_1156A,"tag_origin");
		return;
	}

	playfxontag(level._effect["odin_targeting_bad"],self.var_1156A,"tag_origin");
}

//Function Number: 12
func_C6C7(param_00)
{
	self endon("death");
	self notify("leaving");
	var_01 = level.var_C6D7["orbital_deployment"];
	scripts\mp\_utility::func_AAE7(var_01.var_13553);
	if(isdefined(self.var_222))
	{
		self.var_222 func_C6C5(self,param_00);
	}

	self notify("gone");
	func_4074();
	func_C6CC(3);
	scripts\mp\_utility::func_4FC1();
	level.var_163A["orbital_deployment"] = undefined;
	self delete();
}

//Function Number: 13
func_4074()
{
	if(isdefined(self.var_1156A))
	{
		self.var_1156A delete();
	}

	if(isdefined(self.var_C6CA))
	{
		self.var_C6CA delete();
	}
}

//Function Number: 14
func_C6CC(param_00)
{
	while(isdefined(self.var_9BE2) && param_00 > 0)
	{
		wait(0.05);
		param_00 = param_00 - 0.05;
	}
}

//Function Number: 15
func_C6C5(param_00,param_01)
{
	if(isdefined(param_00))
	{
		self setclientomnvar("ui_odin",-1);
		param_00 notify("end_remote");
		self notify("odin_ride_ended");
		func_C6C4();
		if(getdvarint("camera_thirdPerson"))
		{
			scripts\mp\_utility::setthirdpersondof(1);
		}

		self thermalvisionfofoverlayoff();
		self method_825D(param_00);
		self setplayerangles(self.var_E2D7);
		if(isdefined(param_01) && param_01)
		{
			func_108F5();
			self.var_A641 = 0;
			scripts\common\utility::allow_weapon(1);
			self notify("weapon_change",self getcurrentweapon());
		}

		self stoplocalsound("odin_negative_action");
		self stoplocalsound("odin_positive_action");
		foreach(var_03 in level.var_C6D7["orbital_deployment"].var_394)
		{
			if(isdefined(var_03.var_D5E4))
			{
				self stoplocalsound(var_03.var_D5E4);
			}

			if(isdefined(var_03.var_D5DD))
			{
				self stoplocalsound(var_03.var_D5DD);
			}
		}

		if(isdefined(param_00.var_A4A3))
		{
			param_00.var_A4A3 scripts\mp\bots\_bots_strategy::func_2DC1(self,350);
		}

		self notify("stop_odin");
	}
}

//Function Number: 16
func_108F5()
{
	self.var_98FF = 0;
	var_00 = self [[ level.var_8136 ]]();
	var_01 = var_00.origin;
	var_02 = var_00.angles;
	self.angles = var_02;
	self setorigin(var_01,1);
	foreach(var_04 in level.players)
	{
		if(var_04 != self)
		{
			self showtoplayer(var_04);
		}
	}
}

//Function Number: 17
func_10DD8()
{
	var_00 = undefined;
	if(self.team == "allies")
	{
		var_00 = "axis";
	}
	else if(self.team == "axis")
	{
		var_00 = "allies";
	}
	else
	{
	}

	var_01 = anglestoforward(self.angles);
	var_02 = anglestoup(self.angles);
	foreach(var_04 in level.players)
	{
		if(var_04 != self)
		{
			self method_8429(var_04);
			if(var_04.team == self.team)
			{
				playfx(level._effect["phase_out_friendly"],self.origin,var_01,var_02);
				continue;
			}

			playfx(level._effect["phase_out_enemy"],self.origin,var_01,var_02);
		}
	}
}

//Function Number: 18
func_C6CB()
{
	scripts\mp\_utility::func_FB09("orbital_deployment");
}

//Function Number: 19
func_C6C4()
{
	if(isdefined(self))
	{
		scripts\mp\_utility::func_41E9();
	}
}

//Function Number: 20
func_10DD4(param_00,param_01,param_02)
{
	func_10D70();
	self waittill("blackout_done");
	scripts\mp\_utility::func_7385(1);
	level thread func_B9CB(self);
	level thread func_B9DD(self);
	level thread func_B9FD(self);
	var_03 = scripts\mp\killstreaks\_killstreaks::func_98C2(param_02);
	if(var_03 == "success")
	{
		level thread func_1285(param_00,param_01,self,param_02);
	}
	else
	{
		self notify("end_kill_streak");
		func_C6C4();
		scripts\common\utility::func_1C6E(1);
		scripts\common\utility::func_1C76(1);
	}

	level thread scripts\mp\_utility::func_115DE(level.var_C6D7["orbital_deployment"].var_115EB,self);
}

//Function Number: 21
func_1285(param_00,param_01,param_02,param_03)
{
	param_02.var_98FF = 1;
	var_04 = 0;
	var_05 = param_00;
	var_06 = param_01;
	var_07 = vectornormalize(var_06 - var_05);
	var_06 = var_07 * 14000 + var_05;
	var_08 = scripts\mp\_utility::func_1309("drone_hive_projectile_mp",var_06 - (0,0,5000),var_05,param_02);
	var_08 method_830B(1);
	var_09 = spawn("script_model",var_08.origin);
	var_09 setmodel("jsp_drop_pod_top");
	var_09 linkto(var_08,"tag_origin");
	var_09 method_831F(var_08);
	var_09.team = param_02.team;
	var_09.var_222 = param_02;
	var_09 scripts\mp\killstreaks\_utility::func_1843(param_03,"Killstreak_Air",var_09.var_222,1);
	if(scripts\mp\_utility::func_9F19(param_02))
	{
		param_02 func_10DD8();
	}

	if(isdefined(param_02.var_6BA7) && param_02.var_6BA7)
	{
		param_02.var_6BA6 = param_02 getstance();
		param_02 thread scripts\mp\_playerlogic::func_108F2(0);
		var_04 = 1;
	}

	param_02 setorigin(var_08.origin + (0,0,10),1);
	var_08 thread func_13A22("large_rod");
	var_08.team = param_02.team;
	var_08.type = "remote";
	var_08.var_222 = param_02;
	var_08 thread scripts\mp\killstreaks\_remotemissile::func_898C();
	level.var_DF80 = 1;
	level thread func_B9C8(var_08,1);
	level thread func_B9C1(var_08);
	func_C6D6(param_02,var_08);
	param_02 setclientomnvar("ui_predator_missile",3);
	param_02 setclientomnvar("ui_predator_missiles_left",0);
	playfx(level._effect["drop_pod_atmo"],var_08.origin);
	var_08 thread func_5821();
	var_08 thread func_13AA4(param_02);
	var_08 thread func_13AA3(param_02);
	for(;;)
	{
		var_0A = var_08 scripts\common\utility::func_13734("death","missileTargetSet");
		scripts\mp\_hostmigration::func_13834();
		if(var_0A == "death")
		{
			break;
		}

		if(!isdefined(var_08))
		{
			break;
		}
	}

	if(isdefined(var_08))
	{
		param_00 = var_08.origin;
		if(isdefined(param_02))
		{
			param_02 scripts\mp\_matchdata::func_AFC9(param_03,var_08.origin);
		}
	}

	level thread func_E474(param_02,undefined,param_00,var_09,var_04);
}

//Function Number: 22
func_B9C1(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		param_00.var_222 waittill("missileTargetSet");
		param_00 notify("missileTargetSet");
	}
}

//Function Number: 23
func_C6D6(param_00,param_01)
{
	param_00 scripts\mp\_utility::func_7385(1);
	param_00 cameralinkto(param_01,"tag_origin");
	param_00 controlslinkto(param_01);
	param_00 visionsetmissilecamforplayer("default",0);
	param_00 thread scripts\mp\_utility::func_F607("default",0,undefined,1);
	param_00 visionsetmissilecamforplayer(game["thermal_vision"],1);
	param_00 thread func_50FF();
}

//Function Number: 24
func_50FF()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	scripts\mp\_hostmigration::func_13708(0.25);
	self thermalvisionfofoverlayon();
}

//Function Number: 25
func_13A22(param_00)
{
	self waittill("explode",var_01);
	if(param_00 == "small_rod")
	{
		playrumbleonposition("grenade_rumble",var_01);
		earthquake(0.7,1,var_01,1000);
		return;
	}

	if(param_00 == "large_rod")
	{
		playrumbleonposition("artillery_rumble",var_01);
		earthquake(1,1,var_01,2000);
	}
}

//Function Number: 26
func_13AA4(param_00)
{
	param_00 endon("killstreak_disowned");
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		level waittill("host_migration_begin");
		if(isdefined(self))
		{
			param_00 visionsetmissilecamforplayer(game["thermal_vision"],0);
			param_00 scripts\mp\_utility::func_F607("default",0,undefined,1);
			param_00 thermalvisionfofoverlayon();
			continue;
		}

		param_00 setclientomnvar("ui_predator_missile",2);
	}
}

//Function Number: 27
func_13AA3(param_00)
{
	param_00 endon("killstreak_disowned");
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		level waittill("host_migration_end");
		if(isdefined(self))
		{
			param_00 setclientomnvar("ui_predator_missile",3);
			continue;
		}

		param_00 setclientomnvar("ui_predator_missile",2);
	}
}

//Function Number: 28
func_B9CB(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("end_kill_streak");
	param_00 waittill("killstreak_disowned");
	level thread func_E474(param_00);
}

//Function Number: 29
func_B9DD(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("end_kill_streak");
	level waittill("game_ended");
	level thread func_E474(param_00);
}

//Function Number: 30
func_B9FD(param_00)
{
	param_00 endon("end_kill_streak");
	param_00 endon("disconnect");
	level waittill("objective_cam");
	level thread func_E474(param_00,1);
}

//Function Number: 31
func_B9C8(param_00,param_01)
{
	param_00 waittill("death");
	scripts\mp\_hostmigration::func_13834();
	if(isdefined(param_00.var_114F1))
	{
		param_00.var_114F1 delete();
	}

	if(isdefined(param_00.var_6649))
	{
		level.var_E5DE[param_00.var_6649] = undefined;
	}

	if(param_01)
	{
		level.var_DF80 = undefined;
	}
}

//Function Number: 32
func_E474(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_00))
	{
		if(isdefined(param_03))
		{
			param_03 thread func_51B1();
		}

		return;
	}

	param_00 setclientomnvar("ui_predator_missile",2);
	param_00 notify("end_kill_streak");
	param_00 notify("orbital_deployment_complete");
	param_00 thermalvisionfofoverlayoff();
	param_00 controlsunlink();
	if(!isdefined(param_01))
	{
		scripts\mp\_hostmigration::func_13708(0.95);
	}

	param_00 cameraunlink();
	param_00 setclientomnvar("ui_predator_missile",0);
	if(!param_04)
	{
		param_00 func_C6C4();
		param_00 scripts\common\utility::func_1C76(1);
	}
	else
	{
		param_00 scripts\common\utility::func_1C58(0);
		param_00 scripts\common\utility::func_1C76(0);
		param_00 func_C6C4();
		param_00 scripts\common\utility::func_1C76(1);
	}

	param_00 scripts\mp\_utility::func_7385(0);
	param_00 scripts\common\utility::func_1C6E(1);
	if(isdefined(param_02))
	{
		param_00 func_10D89(param_02,param_03);
	}
}

//Function Number: 33
func_10D89(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	var_02.angles = self.angles;
	var_02.var_222 = self;
	var_02.team = self.team;
	self.var_98FF = 0;
	self setorigin(param_00 + (0,0,15),1);
	foreach(var_04 in level.players)
	{
		if(var_04 != self)
		{
			self showtoplayer(var_04);
		}
	}

	self notify("weapon_change",self getcurrentweapon());
	param_01 thread func_51B1();
}

//Function Number: 34
func_51B1()
{
	wait(0.7);
	playfx(scripts\common\utility::getfx("trophy_spark_fx"),self.origin);
	self delete();
}

//Function Number: 35
func_10D70()
{
	var_00 = newclienthudelem(self);
	var_00.x = 0;
	var_00.y = 0;
	var_00.alignx = "left";
	var_00.aligny = "top";
	var_00.sort = 1;
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.foreground = 1;
	var_00 setshader("black",640,480);
	thread func_50E0(var_00,0,0.05,1);
	var_01 = 0.1;
	childthread func_50DE(var_00,var_01);
}

//Function Number: 36
func_50E0(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	wait(param_01);
	param_00 fadeovertime(param_02);
}

//Function Number: 37
func_50DE(param_00,param_01)
{
	wait(param_01);
	param_00 destroy();
	self notify("blackout_done");
}

//Function Number: 38
func_5821()
{
	wait(0.5);
	playfx(level._effect["drop_pod_fx"],self.origin);
	wait(0.3);
	playfx(level._effect["drop_pod_fx"],self.origin);
	wait(0.3);
	playfx(level._effect["drop_pod_fx"],self.origin);
}

//Function Number: 39
func_D39C(param_00)
{
	var_01 = self.pers["killstreaks"];
	for(var_02 = 0;var_02 <= 3;var_02++)
	{
		var_03 = var_01[var_02];
		if(isdefined(var_03) && var_03.var_110EA == param_00 && var_03.var_269A)
		{
			return 1;
		}
	}

	return 0;
}