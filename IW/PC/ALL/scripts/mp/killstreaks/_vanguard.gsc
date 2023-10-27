/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_vanguard.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 48
 * Decompile Time: 2310 ms
 * Timestamp: 10/27/2023 12:30:00 AM
*******************************************************************/

//Function Number: 1
init()
{
	func_FAB1();
	func_FAC4();
	scripts\mp\killstreaks\_killstreaks::func_DEFB("vanguard",::func_1290D);
	level.var_DF74 = [];
	level.var_13167 = 0;
	level.var_1317F = ::func_13160;
	level.var_A864 = loadfx("vfx/misc/laser_glow");
}

//Function Number: 2
func_FAB1()
{
}

//Function Number: 3
func_FAC4()
{
	level.var_13182 = getentarray("remote_heli_range","targetname");
	level.var_13181 = getent("airstrikeheight","targetname");
	if(isdefined(level.var_13181))
	{
		level.var_13180 = level.var_13181.origin[2];
		level.var_13183 = 163840000;
	}

	level.var_9C46 = 0;
	if(scripts\mp\_utility::func_7F8B() == "mp_descent" || scripts\mp\_utility::func_7F8B() == "mp_descent_new")
	{
		level.var_13180 = level.var_13182[0].origin[2] + 360;
		level.var_9C46 = 1;
	}
}

//Function Number: 4
func_1290D(param_00,param_01)
{
	return func_130F5(param_00,param_01);
}

//Function Number: 5
func_130F5(param_00,param_01)
{
	if(scripts\mp\_utility::func_9FC6() || self isusingturret())
	{
		return 0;
	}

	if(isdefined(self.var_12B90) && self.var_12B90)
	{
		return 0;
	}

	if(func_68C5(self.team) || level.var_AD8B.size >= 4)
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}
	else if(scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2() || level.var_6BAA + 1 >= scripts\mp\_utility::func_B4D2())
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}
	else if(isdefined(self.var_5CC4))
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_UNAVAILABLE");
		return 0;
	}

	scripts\mp\_utility::func_93FA();
	var_02 = func_8356(param_00,param_01);
	if(!isdefined(var_02))
	{
		scripts\mp\_utility::func_4FC1();
		return 0;
	}

	scripts\mp\_matchdata::func_AFC9(param_01,self.origin);
	return func_10E0A(var_02,param_01,param_00);
}

//Function Number: 6
func_68C5(param_00)
{
	if(level.teambased)
	{
		return isdefined(level.var_DF74[param_00]);
	}

	return isdefined(level.var_DF74[param_00]) || isdefined(level.var_DF74[level.var_C74B[param_00]]);
}

//Function Number: 7
func_6CCC(param_00,param_01)
{
	var_02 = anglestoforward(self.angles);
	var_03 = anglestoright(self.angles);
	var_04 = self geteye();
	var_05 = var_04 + (0,0,param_01);
	var_06 = var_05 + param_00 * var_02;
	if(func_3E5C(var_04,var_06))
	{
		return var_06;
	}

	var_06 = var_05 - param_00 * var_02;
	if(func_3E5C(var_04,var_06))
	{
		return var_06;
	}

	var_06 = var_06 + param_00 * var_03;
	if(func_3E5C(var_04,var_06))
	{
		return var_06;
	}

	var_06 = var_05 - param_00 * var_03;
	if(func_3E5C(var_04,var_06))
	{
		return var_06;
	}

	var_06 = var_05;
	if(func_3E5C(var_04,var_06))
	{
		return var_06;
	}

	scripts\common\utility::func_136F7();
	var_06 = var_05 + 0.707 * param_00 * var_02 + var_03;
	if(func_3E5C(var_04,var_06))
	{
		return var_06;
	}

	var_06 = var_05 + 0.707 * param_00 * var_02 - var_03;
	if(func_3E5C(var_04,var_06))
	{
		return var_06;
	}

	var_06 = var_05 + 0.707 * param_00 * var_03 - var_02;
	if(func_3E5C(var_04,var_06))
	{
		return var_06;
	}

	var_06 = var_05 + 0.707 * param_00 * -1 * var_02 - var_03;
	if(func_3E5C(var_04,var_06))
	{
		return var_06;
	}

	return undefined;
}

//Function Number: 8
func_3E5C(param_00,param_01)
{
	var_02 = 0;
	if(capsuletracepassed(param_01,20,40.01,undefined,1,1))
	{
		var_02 = bullettracepassed(param_00,param_01,0,undefined);
	}

	return var_02;
}

//Function Number: 9
func_8356(param_00,param_01,param_02)
{
	var_03 = scripts\mp\_spawnscoring::func_6CB5(self,90,20,192);
	if(!isdefined(var_03))
	{
		var_03 = scripts\mp\_spawnscoring::func_6CB5(self,0,20,192);
		if(!isdefined(var_03))
		{
			var_03 = func_6CCC(80,35);
			if(!isdefined(var_03))
			{
				var_03 = func_6CCC(80,0);
			}
		}
	}

	if(isdefined(var_03))
	{
		var_04 = self.angles;
		var_05 = func_4A30(param_00,self,param_01,var_03,var_04,param_02);
		if(!isdefined(var_05))
		{
			scripts\mp\_hud_message::func_10122("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		}

		return var_05;
	}

	scripts\mp\_hud_message::func_10122("KILLSTREAKS_VANGUARD_NO_SPAWN_POINT");
	return undefined;
}

//Function Number: 10
func_10E0A(param_00,param_01,param_02)
{
	scripts\mp\_utility::func_FB09(param_01);
	scripts\mp\_utility::func_7385(1);
	self.var_E2D7 = self.angles;
	if(getdvarint("camera_thirdPerson"))
	{
		scripts\mp\_utility::setthirdpersondof(0);
	}

	thread func_13AA8(param_00);
	var_03 = scripts\mp\killstreaks\_killstreaks::func_98C2("vanguard");
	if(var_03 != "success")
	{
		param_00 notify("death");
		return 0;
	}
	else if(!isdefined(param_00))
	{
		return 0;
	}

	scripts\mp\_utility::func_7385(0);
	param_00.var_D3D3 = 1;
	self cameralinkto(param_00,"tag_origin");
	self method_825C(param_00);
	param_00.var_1E41 = 100;
	self.var_DF75 = param_02;
	self.var_DF8A = param_00;
	thread scripts\mp\_utility::func_115DE("used_vanguard",self);
	return 1;
}

//Function Number: 11
func_1316F(param_00)
{
	if(!isdefined(param_00.var_AA33.var_52CF) || param_00.var_AA33.var_52CF || !isdefined(self.var_108D4) || gettime() > self.var_108D4)
	{
		thread func_898F(undefined,undefined,undefined,undefined);
		return;
	}

	wait(1);
	thread scripts\mp\_movers::func_892E(param_00);
}

//Function Number: 12
func_4A30(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnhelicopter(param_01,param_03,param_04,"remote_uav_mp","veh_mil_air_un_pocketdrone_mp");
	if(!isdefined(var_06))
	{
		return undefined;
	}

	var_06 scripts\mp\killstreaks\_helicopter::func_1852();
	var_06 thread scripts\mp\killstreaks\_helicopter::func_E111();
	var_06 method_81FC(20,-5,10);
	var_06.var_24D1 = spawn("script_model",(0,0,0));
	var_06.var_24D1 setmodel("tag_origin");
	var_06.var_24D1.angles = (-90,0,0);
	var_06.var_24D1.var_C364 = 4;
	var_07 = spawnturret("misc_turret",var_06.origin,"ball_drone_gun_mp",0);
	var_07 linkto(var_06,"tag_turret_attach",(0,0,0),(0,0,0));
	var_07 setmodel("veh_mil_air_un_pocketdrone_gun_mp");
	var_07 method_81F5();
	var_06.var_129B9 = var_07;
	var_07 makeunusable();
	var_06.var_AC68 = param_00;
	var_06.team = param_01.team;
	var_06.pers["team"] = param_01.team;
	var_06.var_222 = param_01;
	var_06 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air",param_01);
	if(issentient(var_06))
	{
		var_06 method_834E("DogsDontAttack");
	}

	var_06.health = 999999;
	var_06.maxhealth = 750;
	var_06.var_E1 = 0;
	var_06.var_1037E = 0;
	var_06.var_94D1 = 0;
	var_06.var_8DD9 = "remote_uav";
	var_07.var_222 = param_01;
	var_07 method_82DD(var_06);
	var_07 thread scripts\mp\_weapons::func_57EB("tag_fx1");
	var_07.parent = var_06;
	var_07.health = 999999;
	var_07.maxhealth = 250;
	var_07.var_E1 = 0;
	level thread func_1316B(var_06);
	level thread func_1316E(var_06,param_05);
	level thread func_13169(var_06);
	level thread func_1316D(var_06);
	var_06 thread func_1317D();
	var_06 thread func_1317E();
	var_06 thread func_13164();
	var_06.var_129B9 thread func_1317B();
	var_06 thread func_13A10();
	var_08 = spawn("script_model",var_06.origin);
	var_08 setscriptmoverkillcam("explosive");
	var_08 linkto(var_06,"tag_player",(-10,0,20),(0,0,0));
	var_06.var_A63A = var_08;
	var_06.var_108D4 = gettime() + 2000;
	var_09 = spawnstruct();
	var_09.var_13139 = 1;
	var_09.var_4E53 = ::func_1316F;
	var_06 thread scripts\mp\_movers::func_892F(var_09);
	level.var_DF74[var_06.team] = var_06;
	return var_06;
}

//Function Number: 13
func_13AA2(param_00)
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	level endon("game_ended");
	param_00 endon("death");
	for(;;)
	{
		level waittill("host_migration_end");
		func_98DE();
		param_00 thread func_13175();
	}
}

//Function Number: 14
func_13AA8(param_00)
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	level endon("game_ended");
	param_00 endon("death");
	self waittill("intro_cleared");
	func_98DE();
	param_00 method_80C7();
	thread func_1317A(param_00);
	thread func_1316A(param_00);
	thread func_1316C(param_00);
	thread func_1317C(param_00);
	param_00 thread func_13175();
	if(!level.var_8B38)
	{
		param_00 thread func_13176();
	}

	thread func_13AA2(param_00);
	scripts\mp\_utility::func_7385(0);
}

//Function Number: 15
func_98DE()
{
	self thermalvisionfofoverlayon();
	self setclientomnvar("ui_vanguard",1);
}

//Function Number: 16
func_1316C(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("death");
	param_00 endon("end_remote");
	param_00 thread scripts\mp\killstreaks\_killstreaks::func_1CA5();
	param_00 waittill("killstreakExit");
	if(isdefined(param_00.var_222))
	{
		param_00.var_222 scripts\mp\_utility::func_AAEC("gryphon_gone");
	}

	param_00 notify("death");
}

//Function Number: 17
func_1317C(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("death");
	param_00 endon("end_remote");
	while(!isdefined(param_00.var_24D1))
	{
		wait(0.05);
	}

	param_00 method_831F(param_00.var_24D1);
	param_00 method_835C(param_00.var_24D1);
}

//Function Number: 18
func_1317A(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("death");
	param_00 endon("end_remote");
	for(;;)
	{
		if(param_00 scripts\mp\_utility::touchingbadtrigger("gryphon"))
		{
			param_00 notify("damage",1019,self,self.angles,self.origin,"MOD_EXPLOSIVE",undefined,undefined,undefined,undefined,"c4_mp");
		}

		self.var_AEF8 = param_00.var_24D1.origin;
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 19
func_13175()
{
	playfxontagforclients(level.var_13162["target_marker_circle"],self.var_24D1,"tag_origin",self.var_222);
	thread func_13179();
}

//Function Number: 20
func_13176()
{
	self endon("death");
	self endon("end_remote");
	for(;;)
	{
		level waittill("joined_team",var_00);
		stopfxontag(level.var_13162["target_marker_circle"],self.var_24D1,"tag_origin");
		scripts\common\utility::func_136F7();
		func_13175();
	}
}

//Function Number: 21
func_13179()
{
	self endon("death");
	self endon("end_remote");
	if(!level.var_8B38)
	{
		foreach(var_01 in level.players)
		{
			if(self.var_222 scripts\mp\_utility::func_9DD6(var_01))
			{
				scripts\common\utility::func_136F7();
				playfxontagforclients(level.var_13162["target_marker_circle"],self.var_24D1,"tag_origin",var_01);
			}
		}
	}
}

//Function Number: 22
func_13178(param_00)
{
	var_01 = func_819C(param_00.var_222,param_00);
	if(isdefined(var_01))
	{
		param_00.var_24D1.origin = var_01[0] + (0,0,4);
		return var_01[0];
	}

	return undefined;
}

//Function Number: 23
func_819C(param_00,param_01)
{
	var_02 = param_01.var_129B9 gettagorigin("tag_flash");
	var_03 = param_00 getplayerangles();
	var_04 = anglestoforward(var_03);
	var_05 = var_02 + var_04 * 15000;
	var_06 = bullettrace(var_02,var_05,0,param_01);
	if(var_06["surfacetype"] == "none")
	{
		return undefined;
	}

	if(var_06["surfacetype"] == "default")
	{
		return undefined;
	}

	var_07 = var_06["entity"];
	var_08 = [];
	var_08[0] = var_06["position"];
	var_08[1] = var_06["normal"];
	return var_08;
}

//Function Number: 24
func_1316A(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("end_remote");
	self notifyonplayercommand("vanguard_fire","+attack");
	self notifyonplayercommand("vanguard_fire","+attack_akimbo_accessible");
	param_00.var_6D7F = gettime();
	for(;;)
	{
		self waittill("vanguard_fire");
		scripts\mp\_hostmigration::func_13834();
		if(isdefined(level.var_90A9))
		{
			continue;
		}

		if(isdefined(self.var_AEF8) && gettime() >= param_00.var_6D7F)
		{
			self thread [[ level.var_1317F ]](param_00,self.var_AEF8);
		}
	}
}

//Function Number: 25
func_13177(param_00,param_01,param_02)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("end_remote");
	param_00 notify("end_rumble");
	param_00 endon("end_rumble");
	for(var_03 = 0;var_03 < param_02;var_03++)
	{
		self playrumbleonentity(param_01);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 26
func_B06C(param_00,param_01)
{
	param_01 endon("death");
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		triggerfx(param_00);
		wait(0.25);
	}
}

//Function Number: 27
func_13160(param_00,param_01)
{
	level endon("game_ended");
	if(param_00.var_1E41 <= 0)
	{
		return;
	}

	var_02 = param_00.var_129B9 gettagorigin("tag_fire");
	var_02 = var_02 + (0,0,-25);
	if(distancesquared(var_02,param_01) < 10000)
	{
		param_00 playsoundtoplayer("weap_vanguard_fire_deny",self);
		return;
	}

	param_00.var_1E41--;
	self playlocalsound("weap_gryphon_fire_plr");
	scripts\mp\_utility::func_D52A("weap_gryphon_fire_npc",param_00.origin);
	thread func_13177(param_00,"shotgun_fire",1);
	earthquake(0.3,0.25,param_00.origin,60);
	var_03 = scripts\mp\_utility::func_1309("remote_tank_projectile_mp",var_02,param_01,self);
	var_03.var_131D8 = param_00;
	var_04 = 1500;
	param_00.var_6D7F = gettime() + var_04;
	thread func_12F63(param_00,var_04 * 0.001);
	var_03 scripts\mp\_hostmigration::func_137B8("death",4);
	earthquake(0.3,0.75,param_01,128);
	if(isdefined(param_00))
	{
		earthquake(0.25,0.75,param_00.origin,60);
		thread func_13177(param_00,"damage_heavy",3);
		if(param_00.var_1E41 == 0)
		{
			wait(0.75);
			param_00 notify("death");
		}
	}
}

//Function Number: 28
func_12F63(param_00,param_01)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("death");
	param_00 endon("end_remote");
	self setclientomnvar("ui_vanguard_ammo",-1);
	wait(param_01);
	self setclientomnvar("ui_vanguard_ammo",param_00.var_1E41);
}

//Function Number: 29
func_8166(param_00,param_01)
{
	var_02 = (3000,3000,3000);
	var_03 = vectornormalize(param_00.origin - param_01 + (0,0,-400));
	var_04 = rotatevector(var_03,(0,25,0));
	var_05 = param_01 + var_04 * var_02;
	if(func_9FE6(var_05,param_01))
	{
		return var_05;
	}

	var_04 = rotatevector(var_03,(0,-25,0));
	var_05 = param_01 + var_04 * var_02;
	if(func_9FE6(var_05,param_01))
	{
		return var_05;
	}

	var_05 = param_01 + var_03 * var_02;
	if(func_9FE6(var_05,param_01))
	{
		return var_05;
	}

	return param_01 + (0,0,3000);
}

//Function Number: 30
func_9FE6(param_00,param_01)
{
	var_02 = bullettrace(param_00,param_01,0);
	if(var_02["fraction"] > 0.99)
	{
		return 1;
	}

	return 0;
}

//Function Number: 31
func_1317D()
{
	self endon("death");
	var_00 = self.origin;
	self.var_DCCE = 0;
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		if(!isdefined(self.var_222))
		{
			return;
		}

		if(!func_13165())
		{
			while(!func_13165())
			{
				if(!isdefined(self))
				{
					return;
				}

				if(!isdefined(self.var_222))
				{
					return;
				}

				if(!self.var_DCCE)
				{
					self.var_DCCE = 1;
					thread func_13173();
				}

				if(isdefined(self.var_8DBD))
				{
					var_01 = distance(self.origin,self.var_8DBD.origin);
				}
				else if(isdefined(level.var_5618))
				{
					var_01 = 467.5;
				}
				else
				{
					var_01 = distance(self.origin,var_00);
				}

				var_02 = func_8123(var_01);
				self.var_222 setclientomnvar("ui_vanguard",var_02);
				wait(0.1);
			}

			self notify("in_range");
			self.var_DCCE = 0;
			self.var_222 setclientomnvar("ui_vanguard",1);
		}

		var_03 = int(angleclamp(self.angles[1]));
		self.var_222 setclientomnvar("ui_vanguard_heading",var_03);
		var_04 = self.origin[2] * 0.0254;
		var_04 = int(clamp(var_04,-250,250));
		self.var_222 setclientomnvar("ui_vanguard_altitude",var_04);
		var_05 = distance2d(self.origin,self.var_24D1.origin) * 0.0254;
		var_05 = int(clamp(var_05,0,256));
		self.var_222 setclientomnvar("ui_vanguard_range",var_05);
		var_00 = self.origin;
		wait(0.1);
	}
}

//Function Number: 32
func_8123(param_00)
{
	param_00 = clamp(param_00,50,550);
	return 2 + int(8 * param_00 - 50 / 500);
}

//Function Number: 33
func_13165()
{
	if(!isdefined(level.var_13183) || !isdefined(level.var_13180))
	{
		return 0;
	}

	if(isdefined(self.var_94D1) && self.var_94D1)
	{
		return 0;
	}

	if(isdefined(level.var_5618))
	{
		return 0;
	}

	if(isdefined(level.var_13182[0]))
	{
		foreach(var_01 in level.var_13182)
		{
			if(self istouching(var_01))
			{
				return 0;
			}
		}

		if(level.var_9C46)
		{
			return self.origin[2] < level.var_13180;
		}
		else
		{
			return 1;
		}
	}
	else if(distance2dsquared(self.origin,level.var_B32E) < level.var_13183 && self.origin[2] < level.var_13180)
	{
		return 1;
	}

	return 0;
}

//Function Number: 34
func_13173()
{
	self endon("death");
	self endon("in_range");
	if(isdefined(self.var_8DBD))
	{
		var_00 = 3;
	}
	else
	{
		var_00 = 6;
	}

	scripts\mp\_hostmigration::func_13708(var_00);
	self notify("death","range_death");
}

//Function Number: 35
func_1316B(param_00)
{
	param_00 endon("death");
	param_00.var_222 scripts\common\utility::waittill_any_3("killstreak_disowned");
	param_00 notify("death");
}

//Function Number: 36
func_1316E(param_00,param_01)
{
	param_00 endon("death");
	var_02 = 60;
	scripts\mp\_hostmigration::func_13708(var_02);
	if(isdefined(param_00.var_222))
	{
		param_00.var_222 scripts\mp\_utility::func_AAEC("gryphon_gone");
	}

	param_00 notify("death");
}

//Function Number: 37
func_13169(param_00)
{
	level endon("game_ended");
	level endon("objective_cam");
	var_01 = param_00.var_129B9;
	param_00 waittill("death");
	param_00 scripts\mp\_weapons::func_11061();
	stopfxontag(level.var_13162["target_marker_circle"],param_00.var_24D1,"tag_origin");
	playfx(level.var_13162["explode"],param_00.origin);
	param_00 playsound("ball_drone_explode");
	var_01 delete();
	if(isdefined(param_00.var_1155D))
	{
		param_00.var_1155D delete();
	}

	func_1315F(param_00.var_222,param_00);
}

//Function Number: 38
func_1316D(param_00)
{
	param_00 endon("death");
	level scripts\common\utility::waittill_any_3("objective_cam","game_ended");
	playfx(level.var_13162["explode"],param_00.origin);
	param_00 playsound("ball_drone_explode");
	func_1315F(param_00.var_222,param_00);
}

//Function Number: 39
func_1315F(param_00,param_01)
{
	param_01 notify("end_remote");
	param_01.var_D3D3 = 0;
	param_01 method_831F(undefined);
	func_13174(param_00,param_01);
	stopfxontag(level.var_13162["smoke"],param_01,"tag_origin");
	level.var_DF74[param_01.team] = undefined;
	scripts\mp\_utility::func_4FC1();
	if(isdefined(param_01.var_A63A))
	{
		param_01.var_A63A delete();
	}

	param_01.var_24D1 delete();
	param_01 delete();
}

//Function Number: 40
func_E2E5()
{
	self visionsetnakedforplayer("",1);
	scripts\mp\_utility::func_F607("",1);
}

//Function Number: 41
func_13174(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	param_00 scripts\mp\_utility::func_41E9();
	param_00 func_E2E5();
	param_00 setclientomnvar("ui_vanguard",0);
	if(getdvarint("camera_thirdPerson"))
	{
		param_00 scripts\mp\_utility::setthirdpersondof(1);
	}

	param_00 cameraunlink(param_01);
	param_00 method_825D(param_01);
	param_00 thermalvisionfofoverlayoff();
	param_00 setplayerangles(param_00.var_E2D7);
	param_00.var_DF8A = undefined;
	if(param_00.team == "spectator")
	{
		return;
	}

	level thread func_13161(param_00);
}

//Function Number: 42
func_13161(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("death");
	level endon("game_ended");
	param_00 scripts\mp\_utility::func_7385(1);
	wait(0.5);
	param_00 scripts\mp\_utility::func_7385(0);
}

//Function Number: 43
func_1317E()
{
	level endon("game_ended");
	self endon("death");
	self endon("end_remote");
	for(;;)
	{
		var_00 = 0;
		foreach(var_02 in level.var_8DD3)
		{
			if(distance(var_02.origin,self.origin) < 300)
			{
				var_00 = 1;
				self.var_8DBD = var_02;
			}
		}

		foreach(var_05 in level.var_AD8B)
		{
			if(var_05 != self && !isdefined(var_05.var_8DD9) || var_05.var_8DD9 != "remote_uav" && distance(var_05.origin,self.origin) < 300)
			{
				var_00 = 1;
				self.var_8DBD = var_05;
			}
		}

		if(!self.var_94D1 && var_00)
		{
			self.var_94D1 = 1;
		}
		else if(self.var_94D1 && !var_00)
		{
			self.var_94D1 = 0;
			self.var_8DBD = undefined;
		}

		wait(0.05);
	}
}

//Function Number: 44
func_13164()
{
	self endon("death");
	level endon("game_ended");
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		scripts\mp\_damage::func_B9C7(var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,"remote_uav",::func_898F,::func_B938,1);
	}
}

//Function Number: 45
func_1317B()
{
	self endon("death");
	level endon("game_ended");
	self method_81F7();
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(self.parent))
		{
			self.parent scripts\mp\_damage::func_B9C7(var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,"remote_uav",::func_898F,::func_B938,1);
		}
	}
}

//Function Number: 46
func_B938(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	var_04 = scripts\mp\_damage::func_8999(param_01,param_02,var_04);
	var_04 = scripts\mp\_damage::func_89C6(param_01,param_02,var_04);
	var_04 = scripts\mp\_damage::func_89AC(param_01,param_02,var_04);
	var_04 = scripts\mp\_damage::func_8975(param_01,param_02,var_04);
	if(param_02 == "MOD_MELEE")
	{
		var_04 = self.maxhealth * 0.34;
	}

	playfxontagforclients(level.var_13162["hit"],self,"tag_origin",self.var_222);
	if(self.var_1037E == 0 && self.var_E1 >= self.maxhealth / 2)
	{
		self.var_1037E = 1;
		playfxontag(level.var_13162["smoke"],self,"tag_origin");
	}

	return var_04;
}

//Function Number: 47
func_898F(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_222))
	{
		self.var_222 scripts\mp\_utility::func_AAEC("gryphon_destroyed");
	}

	scripts\mp\_damage::func_C548("vanguard",param_00,param_01,param_02,param_03,"destroyed_vanguard",undefined,"callout_destroyed_vanguard");
	if(isdefined(param_00))
	{
		param_00 scripts\mp\_missions::func_D992("ch_gryphondown");
		scripts\mp\_missions::func_3DE3(param_00,self,param_01);
	}
}

//Function Number: 48
func_13A10()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		stopfxontag(level.var_13162["target_marker_circle"],self.var_24D1,"tag_origin");
		scripts\common\utility::func_136F7();
		thread func_13179();
		playfxontag(scripts\common\utility::getfx("emp_stun"),self,"tag_origin");
		wait(var_01);
		stopfxontag(level.var_13162["target_marker_circle"],self.var_24D1,"tag_origin");
		scripts\common\utility::func_136F7();
		thread func_13175();
	}
}