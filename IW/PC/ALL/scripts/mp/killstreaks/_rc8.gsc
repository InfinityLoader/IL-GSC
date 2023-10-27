/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_rc8.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 59
 * Decompile Time: 3161 ms
 * Timestamp: 10/27/2023 12:29:25 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["rc8_malfunction"] = loadfx("vfx/iw7/core/mp/killstreaks/vfx_rc8_glitch_out.vfx");
	level._effect["rc8_explode"] = loadfx("vfx/iw7/core/mp/killstreaks/vfx_rc8_dest_exp.vfx");
	scripts\mp\killstreaks\_killstreaks::func_DEFB("remote_c8",::func_128F7);
	var_00 = ["passive_increased_speed","passive_decreased_duration","passive_energy_machgun","passive_boosters","passive_speed_duration"];
	scripts\mp\_killstreak_loot::func_DF07("remote_c8",var_00);
}

//Function Number: 2
func_F8F4()
{
	level.agent_funcs["remote_c8"] = level.agent_funcs["player"];
	level.agent_funcs["remote_c8"]["think"] = ::func_DCF4;
	level.agent_funcs["remote_c8"]["on_killed"] = ::func_DCF3;
	level.agent_funcs["remote_c8"]["on_damaged"] = ::func_DCF2;
	level.agent_funcs["remote_c8"]["gametype_update"] = ::func_BFF0;
}

//Function Number: 3
func_DCF4()
{
	self endon("death");
	self endon("disconnect");
	self endon("owner_disconnect");
	level endon("game_ended");
	self method_845A("rc8_mp");
	self botsetflag("disable_wall_traversals",1);
	self botsetflag("ads_shield",1);
	self botsetstance("stand");
	self setmovespeedscale(0.8);
	thread func_DCF9();
	thread func_DCF7();
	thread func_DCFA();
	thread func_DCFB();
	thread rc8_watchvoice();
	thread rc8_watchhostmigration();
	thread rc8_watchupdateuav();
	thread rc8_manageboostfx();
	thread rc8_watchupdatecranked();
}

//Function Number: 4
func_DCF5(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isrc8falldamage(param_04))
	{
		return;
	}

	self notify("rc8_damage",param_01,param_00);
}

//Function Number: 5
func_DCFB()
{
	self endon("death");
	self endon("disconnect");
	self.var_222 endon("destroyed_rc8");
	level endon("game_ended");
	var_00 = scripts\common\trace::func_48BC(0,1,1,1,1,1,1);
	self waittill("rc8_launched");
	var_01 = 1;
	var_02 = undefined;
	for(;;)
	{
		if(!self isonground())
		{
			if(scripts\mp\_utility::func_9FB3(self.booston))
			{
				while(scripts\mp\_utility::func_9FB3(self.booston))
				{
					scripts\common\utility::func_136F7();
				}
			}

			var_03 = self.origin[2];
			if(scripts\mp\_utility::func_9FB3(var_01))
			{
				var_01 = undefined;
				var_02 = "heavy_damage";
				thread startmidairdamage(var_02);
			}

			while(!self isonground())
			{
				if(scripts\mp\_utility::func_9FB3(self.booston))
				{
					while(scripts\mp\_utility::func_9FB3(self.booston))
					{
						scripts\common\utility::func_136F7();
					}

					var_03 = self.origin[2];
					continue;
				}

				scripts\common\utility::func_136F7();
			}

			self notify("on_ground");
			var_04 = self.origin[2];
			if(var_03 - var_04 < 60)
			{
				continue;
			}

			if(isdefined(self.midairdamage))
			{
				self.var_FC99 = 1;
				self.midairdamage setscriptablepartstate("fall","damage",0);
				thread func_511F(0.05);
				wait(0.2);
				self.midairdamage setscriptablepartstate("fall","neutral",0);
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 6
startmidairdamage(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("on_ground");
	self.var_222 endon("destroyed_rc8");
	level endon("game_ended");
	for(;;)
	{
		self.midairdamage setscriptablepartstate("air_damage",param_00,0);
		scripts\common\utility::func_136F7();
		self.midairdamage setscriptablepartstate("air_damage","neutral",0);
	}
}

//Function Number: 7
rc8_watchvoice()
{
	self endon("death");
	self endon("disconnect");
	self.var_222 endon("destroyed_rc8");
	level endon("game_ended");
	var_00 = undefined;
	var_01 = undefined;
	for(;;)
	{
		self waittill("try_play_voice",var_02,var_03);
		if(isdefined(var_00) && var_00 == var_03)
		{
			continue;
		}

		if(isdefined(var_01) && gettime() < var_01 + var_02 + 5000)
		{
			continue;
		}

		var_00 = var_03;
		var_01 = gettime();
		wait(var_02);
		if(isdefined(self.var_222.var_4BE1) && self.var_222.var_4BE1 == "MANUAL")
		{
			self playsoundtoteam(var_03,"allies",self.var_222);
			self playsoundtoteam(var_03,"axis",self.var_222);
			continue;
		}

		self playsoundtoteam(var_03,"allies");
		self playsoundtoteam(var_03,"axis");
	}
}

//Function Number: 8
rc8_watchhostmigration()
{
	self endon("death");
	self endon("disconnect");
	self.var_222 endon("destroyed_rc8");
	level endon("game_ended");
	for(;;)
	{
		level waittill("host_migration_begin");
		rc8_disable_movement(1);
		rc8_disable_attack(1);
		rc8_disable_rotation(1);
		level waittill("host_migration_end");
		rc8_disable_movement(0);
		rc8_disable_attack(0);
		rc8_disable_rotation(0);
	}
}

//Function Number: 9
rc8_watchupdateuav()
{
	self endon("death");
	self endon("disconnect");
	self.var_222 endon("destroyed_rc8");
	level endon("game_ended");
	for(;;)
	{
		level waittill("uav_update");
		rc8_setuavstrength();
	}
}

//Function Number: 10
rc8_setuavstrength()
{
	if(level.teambased)
	{
		rc8_updateteamuavstatus(self.team);
		return;
	}

	rc8_updateplayersuavstatus();
}

//Function Number: 11
rc8_updateteamuavstatus(param_00,param_01)
{
	var_02 = getuavstrengthmin();
	var_03 = getuavstrengthmax();
	var_04 = getuavstrengthlevelshowenemydirectional();
	var_05 = getuavstrengthlevelneutral();
	var_06 = getuavstrengthlevelshowenemyfastsweep();
	if(isdefined(param_01))
	{
		var_07 = param_01;
	}
	else
	{
		var_07 = scripts\mp\killstreaks\_uav::func_12B5(param_01);
	}

	if(param_00 == "axis")
	{
		var_08 = level.axisactiveuavs;
	}
	else
	{
		var_08 = level.alliesactiveuavs;
	}

	if(scripts\mp\_utility::_hasperk("specialty_empimmune") && var_07 <= var_05)
	{
		var_07 = int(clamp(var_08 + var_05,var_05,var_03));
	}

	if(var_07 <= var_02)
	{
		var_07 = var_02;
	}
	else if(var_07 >= var_03)
	{
		var_07 = var_03;
	}

	self method_85A6(var_07);
	if(var_07 >= var_05)
	{
		self method_85A5(0);
	}
	else
	{
		self method_85A5(1);
	}

	if(var_07 <= var_05)
	{
		self method_85A4(0);
		self.var_255 = 0;
		if(isdefined(self.var_254) && self.var_254 == "constant_radar")
		{
			self.var_254 = "normal_radar";
		}

		self setclientomnvar("ui_show_hardcore_minimap",0);
		return;
	}

	scripts\mp\killstreaks\_uav::setradarmode(var_07,var_06,var_04);
	self.var_255 = var_07 >= var_04;
	self method_85A4(1);
	self setclientomnvar("ui_show_hardcore_minimap",1);
}

//Function Number: 12
rc8_updateplayersuavstatus(param_00)
{
	var_01 = getuavstrengthmin();
	var_02 = getuavstrengthmax();
	var_03 = getuavstrengthlevelshowenemydirectional();
	var_04 = getuavstrengthlevelshowenemyfastsweep();
	var_05 = level.var_1679[self.var_222.var_86BD + "_radarStrength"];
	foreach(var_07 in level.players)
	{
		if(var_07 == self.var_222)
		{
			continue;
		}

		var_08 = level.var_164F[var_07.var_86BD];
		if(var_08 > 0 && !self.var_222 scripts\mp\_utility::_hasperk("specialty_empimmune"))
		{
			var_05 = var_01;
			break;
		}
	}

	if(var_05 <= var_01)
	{
		var_05 = var_01;
	}
	else if(var_05 >= var_02)
	{
		var_05 = var_02;
	}

	self method_85A6(var_05);
	if(var_05 >= getuavstrengthlevelneutral())
	{
		self method_85A5(0);
	}
	else
	{
		self method_85A5(1);
	}

	if(var_05 <= getuavstrengthlevelneutral())
	{
		self method_85A4(0);
		self.var_255 = 0;
		if(isdefined(self.var_254) && self.var_254 == "constant_radar")
		{
			self.var_254 = "normal_radar";
		}

		self setclientomnvar("ui_show_hardcore_minimap",0);
		return;
	}

	scripts\mp\killstreaks\_uav::setradarmode(var_05,var_04,var_03);
	self.var_255 = var_05 >= var_03;
	self method_85A4(1);
	self setclientomnvar("ui_show_hardcore_minimap",1);
}

//Function Number: 13
rc8_watchupdatecranked()
{
	self endon("death");
	self endon("disconnect");
	self.var_222 endon("destroyed_rc8");
	level endon("game_ended");
	if(isdefined(self.var_222.var_47ED) && isdefined(self.var_222.var_47EE))
	{
		self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",self.var_222.var_47EE);
	}

	for(;;)
	{
		self.var_222 scripts\common\utility::waittill_any_3("watchBombTimer","stop_cranked");
		if(!isdefined(self.var_222.var_47EE))
		{
			self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",0);
			continue;
		}

		self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",self.var_222.var_47EE);
	}
}

//Function Number: 14
func_DCFA()
{
	self endon("death");
	self endon("disconnect");
	self.var_222 endon("destroyed_rc8");
	level endon("game_ended");
	var_00 = self.health;
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	self.var_7197 = ::func_DCF5;
	for(;;)
	{
		self waittill("rc8_damage",var_03,var_04);
		var_05 = gettime();
		if(var_05 - var_01 > 1000)
		{
			var_02 = 0;
		}

		var_01 = gettime();
		var_02 = var_02 + var_03;
		var_06 = var_04.origin - self.origin;
		var_06 = (var_06[0],var_06[1],0);
		var_06 = vectornormalize(var_06);
		var_07 = anglestoforward(self.angles);
		var_08 = vectordot(var_06,var_07);
		if(var_08 < 0)
		{
			continue;
		}

		if(var_02 > 50)
		{
			self botpressbutton("ads",randomfloatrange(2,4));
			var_02 = 0;
		}
	}
}

//Function Number: 15
func_DCF7()
{
	self endon("death");
	self endon("disconnect");
	self.var_222 endon("destroyed_rc8");
	level endon("game_ended");
	while(!isdefined(self.mainweapon))
	{
		wait(0.25);
	}

	var_00 = self getweaponammoclip(self.mainweapon);
	for(;;)
	{
		self waittill("weapon_fired",var_01);
		if(isdefined(self.var_10C) && isplayer(self.var_10C))
		{
			level thread scripts\mp\_battlechatter_mp::func_EB87(self.var_10C,"plr_killstreak_target");
		}

		if(scripts\mp\_utility::func_9FB3(self.var_19))
		{
			thread playvoice(1,"vox_c8_engaging");
		}

		if(isdefined(var_01) && var_01 == "iw7_chargeshot_c8_mp" || var_01 == "iw7_minigun_c8_mp")
		{
			self setweaponammoclip(var_01,var_00);
		}
	}
}

//Function Number: 16
func_DCF8(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(isdefined(param_00) && isalive(param_00))
	{
		if(isdefined(self.var_10C))
		{
			param_00 = self.var_10C;
		}

		if(self botcanseeentity(param_00))
		{
			self botclearscriptgoal();
			return;
		}

		var_01 = getclosestpointonnavmesh(param_00.origin,self);
		if(param_00 scripts\mp\_utility::isinarbitraryup())
		{
			var_02 = scripts\common\trace::func_48CC(1);
			if(scripts\common\trace::func_DCF1(self geteye(),param_00 geteye(),undefined,var_02))
			{
				var_03 = vectornormalize(param_00.origin - self geteye());
				var_04 = (0,0,1);
				if(vectordot(var_04,var_03) < 0.92)
				{
					self botlookatpoint(param_00.origin,0.5,"script_forced");
				}
				else
				{
					break;
				}
			}

			var_05 = (param_00.origin[0],param_00.origin[1],param_00.origin[2] - 100);
			var_05 = getgroundposition(var_05,15,2000);
			var_01 = getclosestpointonnavmesh(var_05,self);
		}

		self botsetscriptgoal(var_01,0,"hunt");
		wait(0.5);
	}

	self botclearscriptgoal();
}

//Function Number: 17
func_DCF6()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(var_02.ignoreme || isdefined(var_02.var_222) && var_02.var_222.ignoreme)
		{
			continue;
		}

		if(!isalive(var_02))
		{
			continue;
		}

		if(isdefined(var_02.team) && self.team == var_02.team)
		{
			continue;
		}

		if(var_02 method_8181("specialty_blindeye"))
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	var_04 = undefined;
	if(var_00.size > 0)
	{
		var_04 = sortbydistance(var_00,self.origin);
	}

	if(isdefined(var_04) && var_04.size > 0)
	{
		return var_04[0];
	}

	return undefined;
}

//Function Number: 18
func_DCF9()
{
	self endon("death");
	self endon("disconnect");
	self.var_222 endon("destroyed_rc8");
	level endon("game_ended");
	for(;;)
	{
		if(scripts\mp\_utility::func_9FB3(self.var_19))
		{
			thread playvoice(1,"vox_c8_seeking");
		}

		if(isdefined(self.var_10C) && isalive(self.var_10C) && isplayer(self.var_10C) && !self.var_10C method_8181("specialty_blindeye"))
		{
			if(!self botcanseeentity(self.var_10C))
			{
				func_DCF8(self.var_10C);
			}
		}
		else
		{
			var_00 = func_DCF6();
			if(isdefined(var_00))
			{
				func_DCF8(var_00);
			}
		}

		scripts\mp\_hostmigration::func_13708(0.5);
	}
}

//Function Number: 19
func_DCF3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
}

//Function Number: 20
func_DCF2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = isdefined(param_01) && isdefined(self.var_222) && self.var_222 == param_01;
	if(isdefined(level.var_13CA6))
	{
		param_05 = [[ level.var_13CA6 ]](param_05,param_00);
	}

	if(isrc8falldamage(param_00))
	{
		return;
	}

	var_0D = 0;
	if(self.var_222.var_FC96)
	{
		var_0D = self.var_222.var_FC96;
	}

	if(!scripts\mp\_utility::func_9FB3(self.var_19))
	{
		param_02 = param_02 / 2;
	}

	scripts\mp\_damage::func_374D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
	var_0E = self.var_222.var_FC96 - var_0D;
	if(var_0E > 0)
	{
		self.var_222 thread scripts\mp\_missions::func_D991("ch_rc8_shield",var_0E);
	}

	scripts\mp\_damage::func_AF96(self,param_02,param_01,param_07,param_06,param_04,param_0A,undefined,param_0B,param_03,param_05);
	scripts\mp\_damage::func_C546("remote_c8",param_01,param_05,param_02);
	scripts\mp\killstreaks\_killstreaks::func_A6A0(param_01,param_05,self,param_04);
}

//Function Number: 21
rc8_manageboostfx()
{
	self endon("death");
	self endon("disconnect");
	self endon("owner_disconnect");
	self.var_222 endon("disconnect");
	level endon("game_ended");
	self notify("scriptableBoostFxManager");
	self endon("scriptableBoostFxManager");
	self waittill("rc8_launched");
	self setscriptablepartstate("rc8_jump","neutral",0);
	for(;;)
	{
		self waittill("doubleJumpBoostBegin");
		self.booston = 1;
		self setscriptablepartstate("rc8_jump","active",0);
		self waittill("doubleJumpBoostEnd");
		self.booston = undefined;
		self setscriptablepartstate("rc8_jump","neutral",0);
	}
}

//Function Number: 22
isrc8falldamage(param_00)
{
	return isdefined(param_00) && isdefined(param_00.model) && param_00.model == "ks_remote_c8_mp";
}

//Function Number: 23
func_BFF0()
{
	return 0;
}

//Function Number: 24
func_128F7(param_00)
{
	var_01 = checkrc8available(1);
	if(!var_01)
	{
		if(isdefined(param_00.var_394) && param_00.var_394 != "none")
		{
			self notify("killstreak_finished_with_weapon_" + param_00.var_394);
		}

		return 0;
	}

	var_02 = scripts\mp\killstreaks\_target_marker::func_819B(param_00,::checkrc8availablevalidationfunc);
	if(!isdefined(var_02.var_AEC4))
	{
		scripts\mp\_utility::func_4FC1();
		return 0;
	}

	scripts\mp\_matchdata::func_AFC9(param_00.var_110EA,self.origin);
	thread func_10D8D(param_00,var_02);
	var_03 = "used_remote_c8";
	var_04 = scripts\mp\_killstreak_loot::getrarityforlootitem(param_00.var_1318B);
	if(var_04 != "")
	{
		var_03 = var_03 + "_" + var_04;
	}

	level thread scripts\mp\_utility::func_115DE(var_03,self);
	return 1;
}

//Function Number: 25
checkrc8available(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(lib_0D65::func_8008("remote_c8") >= 2)
	{
		if(param_00)
		{
			scripts\mp\_hud_message::func_10122("KILLSTREAKS_RC8_MAX");
		}

		return 0;
	}

	if(lib_0D65::func_8011(self,"remote_c8") >= 1)
	{
		if(param_00)
		{
			scripts\mp\_hud_message::func_10122("KILLSTREAKS_RC8_MAX");
		}

		return 0;
	}

	if(level.teambased && lib_0D65::func_8012(self.team,"remote_c8") >= 1)
	{
		if(param_00)
		{
			scripts\mp\_hud_message::func_10122("KILLSTREAKS_RC8_MAX");
		}

		return 0;
	}

	return 1;
}

//Function Number: 26
checkrc8availablevalidationfunc()
{
	return checkrc8available(1);
}

//Function Number: 27
func_3772(param_00)
{
	scripts\mp\_utility::func_93FA();
	if(scripts\mp\_utility::func_4BD7(level.var_6BAA) >= scripts\mp\_utility::func_B4D2())
	{
		return;
	}

	var_01 = func_6CC3();
	if(!var_01)
	{
		return;
	}

	var_02 = scripts\mp\killstreaks\_airdrop::func_7EC0(var_01);
}

//Function Number: 28
func_6CC3(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = getnodesinradiussorted(self.origin,param_00,param_01,param_00,"path");
	foreach(var_06 in var_04)
	{
	}

	var_08 = scripts\common\trace::func_48BC(0,1,0,0,0,0,0);
	foreach(var_06 in var_04)
	{
		var_0A = scripts\common\trace::func_DCED(var_06.origin,var_06.origin + (0,0,param_02),level.var_3CB5,var_08);
		if(var_0A["hittype"] == "hittype_none")
		{
			var_03 = var_06.origin;
			break;
		}
	}

	return var_03;
}

//Function Number: 29
func_10D8D(param_00,param_01)
{
	self endon("destroyed_rc8");
	self endon("disconnect");
	var_02 = param_01.var_AEC4 + (0,0,10000);
	var_03 = param_01.var_AEC4;
	var_04 = rotatepointaroundvector(anglestoright(param_01.angles),anglestoforward(param_01.angles),90);
	var_05 = vectortoangles(var_04);
	var_06 = spawn("script_model",var_03 + (0,0,3));
	var_06 setmodel("ks_remote_c8_mp");
	var_06 method_831F(self);
	var_06 method_82DD(self);
	var_06 dontinterpolate();
	var_06 setscriptablepartstate("laser_target","start");
	thread func_FBF0(var_06.origin);
	var_07 = "mp_robot_c8";
	var_08 = scripts\mp\_killstreak_loot::getrarityforlootitem(param_00.var_1318B);
	if(var_08 != "")
	{
		var_07 = var_07 + "_" + var_08;
	}

	var_09 = scripts\mp\agents\_agents::func_16F2("remote_c8",self.team,"rc8Agent",var_02,(self.angles[0],0,0),self,0,0,"veteran",undefined,1,1,1,1);
	var_09 reset_rc8_functionality();
	var_09 setmodel(var_07);
	var_09 method_8369("vm_robot_c8_base_mp");
	var_09 setscriptablepartstate("CompassIcon","hideIcon");
	var_09 method_8184();
	var_09.midairdamage = spawn("script_model",var_09.origin);
	var_09.midairdamage setmodel("ks_remote_c8_mp");
	var_09.midairdamage method_831F(self);
	var_09.midairdamage method_82DD(self);
	var_09.midairdamage dontinterpolate();
	var_09.midairdamage linkto(var_09,"tag_origin");
	var_09.midairdamage.var_13C2E = "iw7_c8landing_mp";
	var_09.midairdamage.var_110E8 = param_00;
	var_09.midairdamage.var_A63A = spawn("script_model",var_09.origin);
	var_09.midairdamage.var_A63A setmodel("tag_origin");
	var_09.midairdamage.var_A63A linkto(var_09,"tag_origin",(-10,0,250),(0,0,0));
	thread func_13AE2(var_09);
	thread func_13998(var_09,param_01,var_06);
	thread watchgameover(var_09);
	scripts\mp\_hostmigration::func_13708(3.5);
	var_0A = spawn("script_model",var_02);
	var_0A setmodel("veh_mil_lnd_ca_droppod_c8_mp");
	var_0A moveto(var_03,2.65,0,0);
	var_0A setscriptablepartstate("pod","fall",0);
	thread func_13A0B(var_0A);
	var_0A thread watchreachpoddestination(var_03);
	var_09 linkto(var_0A,"tag_origin");
	var_09.var_A6BB = param_00.var_110EA;
	var_09.var_165A = param_00.var_110EA;
	var_09.var_110EA = param_00.var_110EA;
	var_09.var_110E8 = param_00;
	var_09.var_222 = self;
	var_09.var_5F6F = undefined;
	var_09.var_FC99 = 1;
	var_09 method_831F(self);
	var_09 method_82DD(self);
	var_09 thread scripts\mp\killstreaks\_agent_killstreak::func_6CE2();
	var_0B = 2800;
	var_09 scripts\mp\agents\_agent_common::func_F28C(var_0B);
	var_09.var_ED75 = 60;
	var_09.mainweapon = "iw7_chargeshot_c8_mp";
	if(scripts\mp\killstreaks\_utility::func_A69F(var_09.var_110E8,"passive_energy_machgun"))
	{
		var_09.mainweapon = "iw7_minigun_c8_mp";
	}

	var_09 scripts\mp\_utility::func_12C6(var_09.mainweapon);
	var_09 scripts\mp\_utility::func_12C6("iw7_c8landing_mp");
	var_09 scripts\mp\_utility::func_12C6("iw7_c8shutdown_mp");
	var_09 scripts\mp\_utility::func_12C6("iw7_c8destruct_mp");
	var_09 scripts\mp\_utility::func_12C6("iw7_c8offhandshield_mp",0);
	var_09 method_844C("iw7_c8offhandshield_mp");
	var_09 method_8451(var_09.mainweapon);
	var_09 scripts\common\utility::func_1C6E(0);
	var_09 scripts\mp\_utility::func_8387("specialty_viewkickoverride");
	var_09 scripts\mp\_utility::func_8387("specialty_block_health_regen");
	var_09 method_8422(0);
	var_09 method_8424(0);
	var_09 allowslide(0);
	var_09 allowcrouch(0);
	var_09 allowprone(0);
	var_09 method_8472(0);
	var_09 method_8012(0);
	var_09 allowjump(0);
	var_09 botsetflag("disable_traversals",1);
	var_09 botsetflag("disable_crouch",1);
	var_09 botsetflag("disable_prone",1);
	var_09 botsetflag("affected_by_blindeye",1);
	var_09 botsetflag("disable_corner_combat",1);
	var_09 method_82C6("c8servo");
	if(scripts\mp\killstreaks\_utility::func_A69F(var_09.var_110E8,"passive_boosters"))
	{
		var_09 method_845A("rc8_jump_mp");
		var_09 allowjump(1);
		var_09 method_8422(1);
		var_09 method_85C5(1);
		var_09 botsetflag("disable_traversals",0);
		var_09 botsetflag("disable_wall_traversals",1);
	}

	var_09 setscriptablepartstate("CompassIcon","remote_c8");
	var_09 scripts\mp\_utility::func_F751();
	var_09 scripts\mp\killstreaks\_utility::func_FAE4("destroyed_rc8","rc8_mp");
	var_09 scripts\mp\_utility::func_8387("specialty_blindeye");
	var_09 scripts\mp\_damage::func_E247();
	var_09 notify("rc8_launched");
	var_0A waittill("explode",var_0C);
	if(isdefined(var_06))
	{
		var_06 setscriptablepartstate("laser_target","neutral");
		var_06 setscriptablepartstate("pod","explode");
	}

	if(isdefined(var_0A))
	{
		var_0A delete();
	}

	if(isdefined(param_01.var_1349C))
	{
		param_01.var_1349C delete();
	}

	var_09.origin = var_0C;
	var_09 method_8383();
	var_09.midairdamage.var_A63A unlink();
	var_09.midairdamage.var_A63A linkto(var_09,"j_helmet");
	thread updatekillcampos(5,var_09,var_09.midairdamage.var_A63A);
	var_09 attachshieldmodel("weapon_c8_shield_top_mp","j_wristshield");
	var_09 attachshieldmodel("weapon_c8_shield_bottom_mp","j_wristbtmshield");
	var_09.var_130AC = spawn("script_model",var_09 gettagorigin("tag_eye"));
	var_09.var_130AC linkto(var_09,"tag_eye");
	if(isdefined(var_09.var_8C98))
	{
		var_09.var_8C98 = undefined;
	}

	self.var_DCFC = var_09;
	self.var_4BE1 = "AI";
	func_F697(self.var_4BE1,1);
	var_09 scripts\mp\killstreaks\_utility::func_1843(var_09.var_A6BB,"Killstreak_Ground",self,1);
	if(scripts\mp\killstreaks\_utility::func_A69F(var_09.var_110E8,"passive_speed_duration"))
	{
		var_09.var_ED75 = int(var_09.var_ED75 / 1.2);
	}

	thread func_13AD7(var_09.var_130AC);
	thread func_13B7E(var_09.var_ED75);
	thread func_13A10(var_09);
	thread func_13996();
	thread func_13ACD(var_09);
	thread func_13B0C(var_09);
	if(scripts\mp\killstreaks\_utility::func_A69F(var_09.var_110E8,"passive_speed_duration"))
	{
		var_09 setmovespeedscale(1);
	}
}

//Function Number: 30
watchreachpoddestination(param_00)
{
	self endon("death");
	level endon("game_ended");
	while(distancesquared(self.origin,param_00) > 0)
	{
		scripts\common\utility::func_136F7();
	}

	self notify("explode",param_00);
}

//Function Number: 31
updatekillcampos(param_00,param_01,param_02)
{
	self endon("destroyed_rc8");
	wait(param_00);
	param_02 unlink();
	param_02 linkto(param_01,"tag_origin",(0,0,150),(0,0,0));
}

//Function Number: 32
watchgameover(param_00)
{
	self endon("destroyed_rc8");
	level waittill("game_ended");
	self notify("destroyed_rc8",1);
}

//Function Number: 33
func_FBF0(param_00)
{
	self endon("destroyed_rc8");
	playsoundatpos(param_00,"rc8_laser_on");
	scripts\mp\_hostmigration::func_13708(0.5);
	var_01 = spawn("script_origin",param_00);
	var_01 playloopsound("rc8_laser_lp");
	var_01 thread func_FB68(self,1.5,"rc8_pod_incoming");
	var_01 thread func_FB69(self,"destroyed_rc8");
	scripts\mp\_hostmigration::func_13708(5.3);
	playsoundatpos(param_00,"rc8_land");
	scripts\mp\_hostmigration::func_13708(0.5);
	playsoundatpos(param_00,"rc8_intro_pod_break");
	scripts\mp\_hostmigration::func_13708(0.2);
	var_01 delete();
}

//Function Number: 34
func_FB68(param_00,param_01,param_02)
{
	param_00 endon("destroyed_rc8");
	scripts\mp\_hostmigration::func_13708(param_01);
	if(isdefined(self))
	{
		self playsound(param_02);
	}
}

//Function Number: 35
func_FB69(param_00,param_01)
{
	level endon("game_ended");
	param_00 waittill(param_01);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 36
func_13A0B(param_00)
{
	param_00 endon("death");
	level endon("game_ended");
	self waittill("destroyed_rc8",var_01);
	if(scripts\mp\_utility::func_9FB3(var_01))
	{
		scripts\mp\_shellshock::func_22FF(1,0.7,800);
		if(isdefined(param_00))
		{
			param_00 delete();
		}
	}
}

//Function Number: 37
func_F697(param_00,param_01)
{
	thread func_560D(param_00,param_01);
	thread func_627B(param_01);
}

//Function Number: 38
func_560D(param_00,param_01)
{
	self endon("disconnect");
	self endon("destroyed_rc8");
	level endon("game_ended");
	self.var_DCFC.var_130AC makeunusable();
	self.var_4BE1 = param_00;
	if(!scripts\mp\_utility::func_9FB3(param_01) && param_00 == "AI")
	{
		self notify("stop_manual_rc8");
		scripts\common\utility::func_136F7();
		self.var_DCFC thermalvisionfofoverlayoff();
		self.var_DCFC method_85A2("");
		self.var_DCFC setclientomnvar("ui_rc8_controls",0);
		self.var_DCFC setclientomnvar("ui_killstreak_missile_warn",0);
		self.var_DCFC setclientomnvar("ui_remote_c8_countdown",0);
		self.var_DCFC setclientomnvar("ui_remote_c8_health",0);
		self setclientomnvar("ui_out_of_bounds_countdown",0);
	}
	else if(param_00 == "MANUAL")
	{
		thread func_10D87();
	}

	self.var_DCFC rc8_disable_movement(1);
	self.var_DCFC rc8_disable_rotation(1);
	self.var_DCFC rc8_disable_attack(1);
	if(scripts\mp\_utility::func_9FB3(param_01))
	{
		self.var_DCFC scripts\mp\_utility::_switchtoweapon("iw7_c8landing_mp");
	}
	else
	{
		self.var_DCFC scripts\mp\_utility::_switchtoweapon("iw7_c8shutdown_mp");
	}

	self.var_DCFC.var_19 = undefined;
	if(scripts\mp\_utility::func_9FB3(param_01))
	{
		scripts\mp\_hostmigration::func_13708(0.5);
		self.var_DCFC.var_FC99 = undefined;
	}
	else
	{
		scripts\mp\_hostmigration::func_13708(1.2);
	}

	self notify("finished_disable");
}

//Function Number: 39
func_10D87()
{
	self endon("disconnect");
	level endon("game_ended");
	var_00 = scripts\mp\killstreaks\_proxyagent::func_45D0(self.var_DCFC,self.var_DCFC.var_110E8,"stop_manual_rc8",self.var_DCFC.var_ED75,1,"rc8_mp");
	if(!var_00)
	{
		if(!isalive(self.var_DCFC) || scripts\mp\_utility::func_9FB3(self.var_DCFC.var_5F6F))
		{
			return;
		}

		self.var_4BE1 = "AI";
		return;
	}

	self.var_DCFC thermalvisionfofoverlayon();
	self.var_DCFC method_85A2("rc8_mp");
	self.var_DCFC setclientomnvar("ui_rc8_controls",1);
	self.var_DCFC setclientomnvar("ui_remote_c8_countdown",gettime() + int(self.var_DCFC.var_ED75 * 1000));
	self.var_DCFC setclientomnvar("ui_remote_c8_health",self.var_DCFC.health / self.var_DCFC.maxhealth);
}

//Function Number: 40
func_627B(param_00)
{
	self endon("disconnect");
	self endon("destroyed_rc8");
	level endon("game_ended");
	self waittill("finished_disable");
	waitforswitchtoweapon(self.var_DCFC,self.var_DCFC.mainweapon);
	var_01 = self.var_4BE1;
	if(var_01 == "AI")
	{
		scripts\mp\_utility::func_C638("remote_c8_ai");
	}
	else
	{
		scripts\common\utility::func_136F7();
		self.var_DCFC scripts\mp\_utility::func_7385(1);
		scripts\mp\_utility::func_C638("remote_c8_user");
	}

	if(scripts\mp\_utility::func_9FB3(param_00))
	{
		scripts\mp\_hostmigration::func_13708(1.6);
	}
	else
	{
		scripts\mp\_hostmigration::func_13708(1.2);
	}

	if(!isalive(self.var_DCFC) || scripts\mp\_utility::func_9FB3(self.var_DCFC.var_5F6F))
	{
		return;
	}

	if(var_01 == "MANUAL")
	{
		self.var_DCFC scripts\mp\_utility::func_7385(0);
		self.var_DCFC rc8_setuavstrength();
	}

	self.var_DCFC method_8597(1);
	self.var_DCFC rc8_disable_movement(0);
	self.var_DCFC rc8_disable_rotation(0);
	self.var_DCFC rc8_disable_attack(0);
	self.var_DCFC.var_130AC scripts\mp\killstreaks\_utility::func_F774(self,&"KILLSTREAKS_HINTS_RC8_CONTROL",360,360,30000,30000,1);
	self.var_DCFC.var_19 = 1;
	self notify("switched_mode");
}

//Function Number: 41
waitforswitchtoweapon(param_00,param_01)
{
	self endon("disconnect");
	self endon("destroyed_rc8");
	level endon("game_ended");
	var_02 = 0;
	while(!var_02)
	{
		param_00 scripts\mp\_utility::_switchtoweapon(param_01);
		var_03 = 0.5;
		while(var_03 > 0)
		{
			if(param_00 scripts\mp\_utility::func_9DA5(param_01))
			{
				var_02 = 1;
				break;
			}

			var_03 = var_03 - 0.05;
			scripts\common\utility::func_136F7();
		}
	}
}

//Function Number: 42
func_8026(param_00)
{
	var_01 = undefined;
	if(param_00 == "AI")
	{
		var_01 = "MANUAL";
	}
	else
	{
		var_01 = "AI";
	}

	return var_01;
}

//Function Number: 43
func_13AD7(param_00)
{
	self endon("disconnect");
	self endon("destroyed_rc8");
	var_01 = self;
	for(;;)
	{
		if(isdefined(self.var_4BE1) && self.var_4BE1 == "AI")
		{
			param_00 waittill("trigger",var_02);
			if(var_02 != self)
			{
				continue;
			}

			if(scripts\mp\_utility::func_9FC6())
			{
				continue;
			}

			if(isdefined(self.var_55E4) && self.var_55E4 > 0)
			{
				continue;
			}

			if(scripts\mp\_utility::func_9FAE(self))
			{
				continue;
			}

			var_01 = self;
		}
		else
		{
			var_01 = self.var_DCFC;
		}

		var_03 = self.var_4BE1;
		var_04 = 0;
		var_05 = 0.1;
		if(self.var_4BE1 == "MANUAL")
		{
			var_05 = 0.3;
		}

		while(var_01 usebuttonpressed())
		{
			var_04 = var_04 + 0.05;
			if(var_04 > var_05)
			{
				var_06 = func_8026(var_03);
				func_F697(var_06,0);
				self waittill("switched_mode");
				break;
			}

			wait(0.05);
		}

		wait(0.05);
	}
}

//Function Number: 44
func_13AE2(param_00)
{
	self endon("destroyed_rc8");
	level endon("game_ended");
	scripts\common\utility::waittill_any_3("joined_team","disconnect","joined_spectators");
	self notify("destroyed_rc8",1);
}

//Function Number: 45
func_13B7E(param_00)
{
	self endon("disconnect");
	self endon("host_migration_lifetime_update");
	self endon("destroyed_rc8");
	level endon("game_ended");
	thread scripts\mp\killstreaks\_utility::watchhostmigrationlifetime("destroyed_rc8",param_00,::func_13B7E);
	while(param_00 > 0)
	{
		wait(0.05);
		param_00 = param_00 - 0.05;
		self.var_DCFC.var_ED75 = self.var_DCFC.var_ED75 - 0.05;
		if(self.var_DCFC.var_ED75 < 0)
		{
			self.var_DCFC.var_ED75 = 0;
		}
	}

	var_01 = ["remote_c8_end","remote_c8_timeout"];
	var_02 = randomint(var_01.size);
	var_03 = var_01[var_02];
	scripts\mp\_utility::func_D4B6(var_03,undefined,undefined,self.origin);
	self notify("destroyed_rc8",0);
}

//Function Number: 46
func_13A10(param_00)
{
	level endon("game_ended");
	self endon("destroyed_rc8");
	for(;;)
	{
		param_00 waittill("emp_damage",var_01,var_02,var_03,var_04,var_05);
		param_00 scripts\mp\killstreaks\_utility::dodamagetokillstreak(100,var_01,var_01,self.team,var_03,var_05,var_04);
	}
}

//Function Number: 47
func_13999(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		var_01 = param_00 getcurrentweapon();
		iprintlnbold("Current Weapon: " + var_01);
		wait(1);
	}
}

//Function Number: 48
func_13996()
{
	self endon("destroyed_rc8");
	for(;;)
	{
		self waittill("player_killstreak_agent_death",var_00,var_01,var_02,var_03,var_04,var_05,var_06);
		if(!isdefined(self.var_DCFC))
		{
			break;
		}

		if(var_00 != self.var_DCFC)
		{
			continue;
		}

		if(scripts\mp\_utility::func_9FB3(self.var_DCFC.var_5F6F))
		{
			continue;
		}

		if(isdefined(var_06) && var_06 == "concussion_grenade_mp")
		{
			if(scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self.var_222,var_02)))
			{
				var_02 scripts\mp\_missions::func_D991("ch_tactical_emp_eqp");
			}
		}

		if(isplayer(var_02) && var_02 != self)
		{
			var_07 = "callout_destroyed_remote_c8";
			var_08 = scripts\mp\_killstreak_loot::getrarityforlootitem(self.var_DCFC.var_110E8.var_1318B);
			if(var_08 != "")
			{
				var_07 = var_07 + "_" + var_08;
			}

			self.var_DCFC scripts\mp\_damage::func_C548("remote_c8",var_02,var_06,var_05,var_03,"destroyed_remote_c8","remote_c8_destroy",var_07);
		}

		if(scripts\mp\_utility::func_9FB3(level.var_C1C3))
		{
			self notify("destroyed_rc8",1);
			continue;
		}

		self notify("destroyed_rc8",0);
	}
}

//Function Number: 49
func_13998(param_00,param_01,param_02)
{
	self waittill("destroyed_rc8",var_03);
	param_00 thread func_D51B(var_03,param_01,param_02);
}

//Function Number: 50
func_D51B(param_00,param_01,param_02)
{
	if(isdefined(self.var_AE62))
	{
		self.var_AE62 = undefined;
	}

	if(isdefined(param_01.var_1349C))
	{
		param_01.var_1349C delete();
	}

	if(isdefined(param_02))
	{
		param_02 delete();
	}

	if(isdefined(self.midairdamage))
	{
		if(isdefined(self.midairdamage.var_A63A))
		{
			self.midairdamage.var_A63A delete();
		}

		self.midairdamage delete();
	}

	if(isdefined(self.var_130AC))
	{
		self.var_130AC makeunusable();
		self.var_130AC delete();
	}

	if(isdefined(self.mainweapon))
	{
		self.mainweapon = undefined;
	}

	self setclientomnvar("ui_rc8_controls",0);
	self setclientomnvar("ui_killstreak_missile_warn",0);
	self setclientomnvar("ui_remote_c8_countdown",0);
	self setclientomnvar("ui_remote_c8_health",0);
	self method_85A2("");
	self thermalvisionfofoverlayoff();
	rc8_disable_movement(1);
	rc8_disable_rotation(1);
	rc8_disable_attack(1);
	self botsetflag("ads_shield",0);
	if(scripts\mp\_utility::func_9FB3(param_00))
	{
		if(isdefined(self.var_222))
		{
			if(isdefined(self.var_222.var_4BE1) && self.var_222.var_4BE1 == "MANUAL")
			{
				self.var_222 notify("stop_manual_rc8");
			}
		}
	}
	else
	{
		self.var_5F6F = 1;
		var_03 = 3;
		if(isdefined(self.var_222))
		{
			if(isdefined(self.var_222.var_4BE1) && self.var_222.var_4BE1 == "MANUAL")
			{
				self.var_222 notify("stop_manual_rc8");
				scripts\common\utility::func_136F7();
			}

			self.var_222.var_4BE1 = undefined;
			var_04 = self.var_222 scripts\mp\_utility::func_1302("dummy_spike_mp",self.origin,self.origin,var_03);
			if(!isdefined(var_04.var_13C2E))
			{
				var_04.var_13C2E = "dummy_spike_mp";
			}

			var_04 linkto(self);
		}

		playfxontag(scripts\common\utility::getfx("rc8_malfunction"),self,"j_mainroot");
		scripts\mp\_utility::_switchtoweapon("iw7_c8destruct_mp");
		thread func_FBF1(var_03);
		scripts\mp\_hostmigration::func_13708(var_03);
	}

	playfx(scripts\common\utility::getfx("rc8_explode"),self.origin);
	playsoundatpos(self.origin,"c8_destruct");
	playsoundatpos(self.origin,"frag_grenade_explode");
	scripts\mp\_shellshock::func_22FF(1,0.7,800);
	scripts\mp\_utility::func_41BA();
	self hide();
	self.var_AE62 = undefined;
	self.nocorpse = 1;
	if(!scripts\mp\_utility::func_9FB3(param_00))
	{
		if(isdefined(self.var_222))
		{
			self radiusdamage(self.origin,256,200,100,self.var_222,"MOD_EXPLOSIVE",self.mainweapon);
		}

		self suicide();
	}

	reset_rc8_functionality();
	lib_0D65::func_4DDB();
	scripts\mp\_utility::func_D915("killstreak ended - remote_c8",self.var_222);
}

//Function Number: 51
func_FBF1(param_00)
{
	self playsound("c8_destruct_initiate");
	scripts\common\utility::delaycall(0.4,::playsound,"c8_destruct_build_up");
	scripts\mp\_hostmigration::func_13708(param_00 - 0.5);
	self playsound("c8_destruct_warning");
}

//Function Number: 52
func_13ACD(param_00)
{
	self endon("disconnect");
	self endon("destroyed_rc8");
	var_01 = 100;
	for(;;)
	{
		param_00 waittill("victim_damaged",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
		if(var_03 == param_00 && var_02 != param_00 && var_06 == "MOD_MELEE")
		{
			if(isplayer(var_02))
			{
				var_0C = anglestoforward(param_00 getplayerangles());
				var_0D = param_00.origin;
				var_0E = param_00 gettagorigin("c8_shield_le") + (0,0,20) + var_0C * 200;
				var_0F = vectornormalize(var_0E - var_0D);
				var_01 = var_02.health + 1;
				var_02 method_84DC(var_0F,700);
				var_02 playsound("rc8_melee_hit");
				wait(0.05);
			}
			else
			{
				var_01 = 100;
			}

			var_02 dodamage(var_01,var_02.origin,self,param_00,"MOD_EXPLOSIVE",var_07);
			scripts\mp\_shellshock::func_1245(0.1,0.08,var_08,100);
		}
	}
}

//Function Number: 53
func_13B0C(param_00)
{
	self endon("disconnect");
	self endon("destroyed_rc8");
	level endon("game_ended");
	for(;;)
	{
		self waittill("spawned_player");
		if(isdefined(param_00))
		{
			param_00 method_831F(self);
		}
	}
}

//Function Number: 54
func_511F(param_00)
{
	self endon("death");
	self endon("disconnect");
	self.var_222 endon("destroyed_rc8");
	level endon("game_ended");
	wait(param_00);
	self.var_FC99 = undefined;
}

//Function Number: 55
playvoice(param_00,param_01)
{
	self notify("try_play_voice",param_00,param_01);
}

//Function Number: 56
rc8_disable_movement(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.disabledmovement))
		{
			self.disabledmovement = 0;
		}

		self.disabledmovement++;
		self botsetflag("disable_movement",1);
		return;
	}

	if(!isdefined(self.disabledmovement))
	{
		self.disabledmovement = 0;
	}
	else
	{
		self.disabledmovement--;
	}

	if(!self.disabledmovement)
	{
		self botsetflag("disable_movement",0);
	}
}

//Function Number: 57
rc8_disable_attack(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.var_55B1))
		{
			self.var_55B1 = 0;
		}

		self.var_55B1++;
		self botsetflag("disable_attack",1);
		return;
	}

	if(!isdefined(self.var_55B1))
	{
		self.var_55B1 = 0;
	}
	else
	{
		self.var_55B1--;
	}

	if(!self.var_55B1)
	{
		self botsetflag("disable_attack",0);
	}
}

//Function Number: 58
rc8_disable_rotation(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.disablerotation))
		{
			self.disablerotation = 0;
		}

		self.disablerotation++;
		self botsetflag("disable_rotation",1);
		return;
	}

	if(!isdefined(self.disablerotation))
	{
		self.disablerotation = 0;
	}
	else
	{
		self.disablerotation--;
	}

	if(!self.disablerotation)
	{
		self botsetflag("disable_rotation",0);
	}
}

//Function Number: 59
reset_rc8_functionality()
{
	self.disabledmovement = undefined;
	self.var_55B1 = undefined;
	self.disablerotation = undefined;
}