/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_vanguard.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 48
 * Decompile Time: 818 ms
 * Timestamp: 10/27/2023 1:33:26 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	func_71FB();
	func_71FC();
	level.remote_uav = [];
	level.killstreakfuncs["vanguard"] = ::tryusevanguard;
	level.vanguard_lastdialogtime = 0;
	level.vanguardfiremisslefunc = ::func_8823;
	level.lasedstrikeglow = loadfx("fx/misc/laser_glow");
}

//Function Number: 2
func_71FB()
{
	level.vanguard_fx["hit"] = loadfx("fx/impacts/large_metal_painted_hit");
	level.vanguard_fx["smoke"] = loadfx("fx/smoke/remote_heli_damage_smoke_runner");
	level.vanguard_fx["explode"] = loadfx("vfx/gameplay/explosions/vehicle/vang/vfx_exp_vanguard");
	level.vanguard_fx["target_marker_circle"] = loadfx("vfx/gameplay/mp/core/vfx_marker_gryphon_orange");
}

//Function Number: 3
func_71FC()
{
	level.vanguardrangetriggers = getentarray("remote_heli_range","targetname");
	level.vanguardmaxheightent = getent("airstrikeheight","targetname");
	if(isdefined(level.vanguardmaxheightent))
	{
		level.vanguardmaxheight = level.vanguardmaxheightent.origin[2];
		level.vanguradmaxdistancesq = 163840000;
	}

	level.is_mp_descent = 0;
	if(maps\mp\_utility::getmapname() == "mp_descent" || maps\mp\_utility::getmapname() == "mp_descent_new")
	{
		level.vanguardmaxheight = level.vanguardrangetriggers[0].origin[2] + 360;
		level.is_mp_descent = 1;
	}
}

//Function Number: 4
tryusevanguard(param_00,param_01)
{
	return func_87DF(param_00,param_01);
}

//Function Number: 5
func_87DF(param_00,param_01)
{
	if(maps\mp\_utility::func_4995() || self isusingturret())
	{
		return 0;
	}

	if(isdefined(self.underwater) && self.underwater)
	{
		return 0;
	}

	if(func_3043(self.team) || level.littlebirds.size >= 4)
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}
	else if(maps\mp\_utility::func_21E7() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}
	else if(isdefined(self.drones_disabled))
	{
		self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE");
		return 0;
	}

	maps\mp\_utility::func_4487();
	var_02 = func_3CE2(param_00,param_01);
	if(!isdefined(var_02))
	{
		maps\mp\_utility::decrementfauxvehiclecount();
		return 0;
	}

	if(!maps\mp\_utility::func_47BB())
	{
		maps\mp\_matchdata::func_4F1D(param_01,self.origin);
	}

	return func_7AFF(var_02,param_01,param_00);
}

//Function Number: 6
func_3043(param_00)
{
	if(level.teambased)
	{
		return isdefined(level.remote_uav[param_00]);
	}

	return isdefined(level.remote_uav[param_00]) || isdefined(level.remote_uav[level.otherteam[param_00]]);
}

//Function Number: 7
findvalidvanguardspawnpoint(param_00,param_01)
{
	var_02 = anglestoforward(self.angles);
	var_03 = anglestoright(self.angles);
	var_04 = self geteye();
	var_05 = var_04 + (0,0,param_01);
	var_06 = var_05 + param_00 * var_02;
	if(checkvanguardspawnpoint(var_04,var_06))
	{
		return var_06;
	}

	var_06 = var_05 - param_00 * var_02;
	if(checkvanguardspawnpoint(var_04,var_06))
	{
		return var_06;
	}

	var_06 = var_06 + param_00 * var_03;
	if(checkvanguardspawnpoint(var_04,var_06))
	{
		return var_06;
	}

	var_06 = var_05 - param_00 * var_03;
	if(checkvanguardspawnpoint(var_04,var_06))
	{
		return var_06;
	}

	var_06 = var_05;
	if(checkvanguardspawnpoint(var_04,var_06))
	{
		return var_06;
	}

	common_scripts\utility::func_8AFE();
	var_06 = var_05 + 0.707 * param_00 * var_02 + var_03;
	if(checkvanguardspawnpoint(var_04,var_06))
	{
		return var_06;
	}

	var_06 = var_05 + 0.707 * param_00 * var_02 - var_03;
	if(checkvanguardspawnpoint(var_04,var_06))
	{
		return var_06;
	}

	var_06 = var_05 + 0.707 * param_00 * var_03 - var_02;
	if(checkvanguardspawnpoint(var_04,var_06))
	{
		return var_06;
	}

	var_06 = var_05 + 0.707 * param_00 * -1 * var_02 - var_03;
	if(checkvanguardspawnpoint(var_04,var_06))
	{
		return var_06;
	}

	return undefined;
}

//Function Number: 8
checkvanguardspawnpoint(param_00,param_01)
{
	var_02 = 0;
	if(stopcinematicforall(param_01,20,40.01,undefined,1,1))
	{
		var_02 = bullettracepassed(param_00,param_01,0,undefined);
	}

	return var_02;
}

//Function Number: 9
func_3CE2(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_spawnscoring::finddronepathnode(self,90,20,192);
	if(!isdefined(var_03))
	{
		var_03 = maps\mp\gametypes\_spawnscoring::finddronepathnode(self,0,20,192);
		if(!isdefined(var_03))
		{
			var_03 = findvalidvanguardspawnpoint(80,35);
			if(!isdefined(var_03))
			{
				var_03 = findvalidvanguardspawnpoint(80,0);
			}
		}
	}

	if(isdefined(var_03))
	{
		var_04 = self.angles;
		var_05 = func_212E(param_00,self,param_01,var_03,var_04,param_02);
		if(!isdefined(var_05))
		{
			self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		}

		return var_05;
	}

	self iprintlnbold(&"KILLSTREAKS_VANGUARD_NO_SPAWN_POINT");
	return undefined;
}

//Function Number: 10
func_7AFF(param_00,param_01,param_02)
{
	maps\mp\_utility::func_720F(param_01);
	maps\mp\_utility::func_350E(1);
	self.restoreangles = self.angles;
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::func_70E6(0);
	}

	thread func_8CFB(param_00);
	var_03 = maps\mp\killstreaks\_killstreaks::func_4649("vanguard");
	if(var_03 != "success")
	{
		param_00 notify("death");
		return 0;
	}
	else if(!isdefined(param_00))
	{
		return 0;
	}

	maps\mp\_utility::func_350E(0);
	param_00.playerlinked = 1;
	self cameralinkto(param_00,"tag_origin");
	self remotecontrolvehicle(param_00);
	param_00.ammocount = 100;
	self.remote_uav_ridelifeid = param_02;
	self.remoteuav = param_00;
	thread maps\mp\_utility::func_7FA0("used_vanguard",self);
	return 1;
}

//Function Number: 11
func_8832(param_00)
{
	if(!isdefined(param_00.lasttouchedplatform.destroydroneoncollision) || param_00.lasttouchedplatform.destroydroneoncollision || !isdefined(self.spawngraceperiod) || gettime() > self.spawngraceperiod)
	{
		thread handledeathdamage(undefined,undefined,undefined,undefined);
	}

	wait(1);
	thread maps\mp\_movers::func_3F24(param_00);
}

//Function Number: 12
func_212E(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnhelicopter(param_01,param_03,param_04,"remote_uav_mp","vehicle_drone_vanguard");
	if(!isdefined(var_06))
	{
		return undefined;
	}

	var_06 maps\mp\killstreaks\_helicopter::addtolittlebirdlist();
	var_06 thread maps\mp\killstreaks\_helicopter::func_6590();
	var_06 makevehiclesolidcapsule(20,-5,10);
	var_06.attackarrow = spawn("script_model",(0,0,0));
	var_06.attackarrow setmodel("tag_origin");
	var_06.attackarrow.angles = (-90,0,0);
	var_06.attackarrow.offset = 4;
	var_07 = spawnturret("misc_turret",var_06.origin,"ball_drone_gun_mp",0);
	var_07 linkto(var_06,"tag_turret_attach",(0,0,0),(0,0,0));
	var_07 setmodel("vehicle_drone_vanguard_gun");
	var_07 maketurretinoperable();
	var_06.turret = var_07;
	var_07 makeunusable();
	var_06.lifeid = param_00;
	var_06.team = param_01.team;
	var_06.pers["team"] = param_01.team;
	var_06.owner = param_01;
	var_06 common_scripts\utility::func_5009(param_01.team);
	if(issentient(var_06))
	{
		var_06 setthreatbiasgroup("DogsDontAttack");
	}

	var_06.health = 999999;
	var_06.maxhealth = 750;
	var_06.damagetaken = 0;
	var_06.smoking = 0;
	var_06.inheliproximity = 0;
	var_06.helitype = "remote_uav";
	var_07.owner = param_01;
	var_07 setentityowner(var_06);
	var_07 thread maps\mp\gametypes\_weapons::doblinkinglight("tag_fx1");
	var_07.parent = var_06;
	var_07.health = 999999;
	var_07.maxhealth = 250;
	var_07.damagetaken = 0;
	level thread func_882E(var_06);
	level thread func_8831(var_06,param_05);
	level thread func_882C(var_06);
	level thread func_8830(var_06);
	var_06 thread func_8840();
	var_06 thread func_8841();
	var_06 thread func_8827();
	var_06.turret thread func_883E();
	var_06 thread func_8CDF();
	var_08 = spawn("script_model",var_06.origin);
	var_08 setscriptmoverkillcam("explosive");
	var_08 linkto(var_06,"tag_player",(-10,0,20),(0,0,0));
	var_06.killcament = var_08;
	var_06.spawngraceperiod = gettime() + 2000;
	var_09 = addstruct();
	var_09.validateaccuratetouching = 1;
	var_09.deathoverridecallback = ::func_8832;
	var_06 thread maps\mp\_movers::func_3F25(var_09);
	level.remote_uav[var_06.team] = var_06;
	return var_06;
}

//Function Number: 13
watchhostmigrationfinishedinit(param_00)
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	level endon("game_ended");
	param_00 endon("death");
	for(;;)
	{
		level waittill("host_migration_end");
		func_9280();
		param_00 thread func_8837();
	}
}

//Function Number: 14
func_8CFB(param_00)
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	level endon("game_ended");
	param_00 endon("death");
	self waittill("intro_cleared");
	func_9280();
	param_00 enableaimassist();
	thread func_883D(param_00);
	thread func_882D(param_00);
	thread func_882F(param_00);
	thread func_883F(param_00);
	param_00 thread func_8837();
	if(!level.hardcoremode)
	{
		param_00 thread func_8838();
	}

	thread watchhostmigrationfinishedinit(param_00);
	maps\mp\_utility::func_350E(0);
}

//Function Number: 15
func_9280()
{
	self thermalvisionfofoverlayon();
	self thermalvisionon();
	self setclientomnvar("ui_vanguard",1);
}

//Function Number: 16
func_882F(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("death");
	param_00 endon("end_remote");
	param_00 thread maps\mp\killstreaks\_killstreaks::allowridekillstreakplayerexit();
	param_00 waittill("killstreakExit");
	if(isdefined(param_00.owner))
	{
		param_00.owner maps\mp\_utility::func_4D35("gryphon_gone");
	}

	param_00 notify("death");
}

//Function Number: 17
func_883F(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("death");
	param_00 endon("end_remote");
	while(!isdefined(param_00.attackarrow))
	{
		wait(0.05);
	}

	param_00 setotherent(param_00.attackarrow);
	param_00 setturrettargetent(param_00.attackarrow);
}

//Function Number: 18
func_883D(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("death");
	param_00 endon("end_remote");
	for(;;)
	{
		if(param_00 maps\mp\_utility::func_818D("gryphon"))
		{
			param_00 notify("damage",1019,self,self.angles,self.origin,"MOD_EXPLOSIVE",undefined,undefined,undefined,undefined,"c4_mp");
		}

		self.lockedlocation = param_00.attackarrow.origin;
		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 19
func_8837()
{
	playfxontagforclients(level.vanguard_fx["target_marker_circle"],self.attackarrow,"tag_origin",self.owner);
	thread vanguard_showreticletoenemies();
}

//Function Number: 20
func_8838()
{
	self endon("death");
	self endon("end_remote");
	for(;;)
	{
		level waittill("joined_team",var_00);
		stopfxontag(level.vanguard_fx["target_marker_circle"],self.attackarrow,"tag_origin");
		common_scripts\utility::func_8AFE();
		func_8837();
	}
}

//Function Number: 21
vanguard_showreticletoenemies()
{
	self endon("death");
	self endon("end_remote");
	if(!level.hardcoremode)
	{
		foreach(var_01 in level.players)
		{
			if(self.owner maps\mp\_utility::isenemy(var_01))
			{
				common_scripts\utility::func_8AFE();
				playfxontagforclients(level.vanguard_fx["target_marker_circle"],self.attackarrow,"tag_origin",var_01);
			}
		}
	}
}

//Function Number: 22
func_883B(param_00)
{
	var_01 = func_3C24(param_00.owner,param_00);
	if(isdefined(var_01))
	{
		param_00.attackarrow.origin = var_01[0] + (0,0,4);
		return var_01[0];
	}

	return undefined;
}

//Function Number: 23
func_3C24(param_00,param_01)
{
	var_02 = param_01.turret gettagorigin("tag_flash");
	var_03 = param_00 getangles();
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
func_882D(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("end_remote");
	self notifyonplayercommand("vanguard_fire","+attack");
	self notifyonplayercommand("vanguard_fire","+attack_akimbo_accessible");
	param_00.firereadytime = gettime();
	for(;;)
	{
		self waittill("vanguard_fire");
		maps\mp\gametypes\_hostmigration::func_8BBA();
		if(isdefined(level.hostmigrationtimer))
		{
			continue;
		}

		if(isdefined(self.lockedlocation) && gettime() >= param_00.firereadytime)
		{
			self thread [[ level.vanguardfiremisslefunc ]](param_00,self.lockedlocation);
		}
	}
}

//Function Number: 25
func_883A(param_00,param_01,param_02)
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
		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 26
func_4F89(param_00,param_01)
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
func_8823(param_00,param_01)
{
	level endon("game_ended");
	if(param_00.ammocount <= 0)
	{
	}

	var_02 = param_00.turret gettagorigin("tag_fire");
	var_02 = var_02 + (0,0,-25);
	if(distancesquared(var_02,param_01) < 10000)
	{
		param_00 playsoundtoplayer("weap_vanguard_fire_deny",self);
	}

	param_00.ammocount--;
	self playlocalsound("weap_gryphon_fire_plr");
	maps\mp\_utility::func_6044("weap_gryphon_fire_npc",param_00.origin);
	thread func_883A(param_00,"shotgun_fire",1);
	earthquake(0.3,0.25,param_00.origin,60);
	var_03 = magicbullet("remote_tank_projectile_mp",var_02,param_01,self);
	var_03.vehicle_fired_from = param_00;
	var_04 = 1500;
	param_00.firereadytime = gettime() + var_04;
	thread updateweaponui(param_00,var_04 * 0.001);
	var_03 maps\mp\gametypes\_hostmigration::func_8B7D("death",4);
	earthquake(0.3,0.75,param_01,128);
	if(isdefined(param_00))
	{
		earthquake(0.25,0.75,param_00.origin,60);
		thread func_883A(param_00,"damage_heavy",3);
		if(param_00.ammocount == 0)
		{
			wait(0.75);
			param_00 notify("death");
		}
	}
}

//Function Number: 28
updateweaponui(param_00,param_01)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("death");
	param_00 endon("end_remote");
	self setclientomnvar("ui_vanguard_ammo",-1);
	wait(param_01);
	self setclientomnvar("ui_vanguard_ammo",param_00.ammocount);
}

//Function Number: 29
func_3C0A(param_00,param_01)
{
	var_02 = (3000,3000,3000);
	var_03 = vectornormalize(param_00.origin - param_01 + (0,0,-400));
	var_04 = rotatevector(var_03,(0,25,0));
	var_05 = param_01 + var_04 * var_02;
	if(func_49AA(var_05,param_01))
	{
		return var_05;
	}

	var_04 = rotatevector(var_03,(0,-25,0));
	var_05 = param_01 + var_04 * var_02;
	if(func_49AA(var_05,param_01))
	{
		return var_05;
	}

	var_05 = param_01 + var_03 * var_02;
	if(func_49AA(var_05,param_01))
	{
		return var_05;
	}

	return param_01 + (0,0,3000);
}

//Function Number: 30
func_49AA(param_00,param_01)
{
	var_02 = bullettrace(param_00,param_01,0);
	if(var_02["fraction"] > 0.99)
	{
		return 1;
	}

	return 0;
}

//Function Number: 31
func_8840()
{
	self endon("death");
	var_00 = self.origin;
	self.rangecountdownactive = 0;
	for(;;)
	{
		if(!isdefined(self))
		{
		}

		if(!isdefined(self.owner))
		{
		}

		if(!func_8828())
		{
			while(!func_8828())
			{
				if(!isdefined(self))
				{
				}

				if(!isdefined(self.owner))
				{
				}

				if(!self.rangecountdownactive)
				{
					self.rangecountdownactive = 1;
					thread func_8835();
				}

				if(isdefined(self.heliinproximity))
				{
					var_01 = distance(self.origin,self.heliinproximity.origin);
				}
				else if(isdefined(level.disablevanguardsinair))
				{
					var_01 = 467.5;
				}
				else
				{
					var_01 = distance(self.origin,var_00);
				}

				var_02 = func_91F5(var_01);
				self.owner setclientomnvar("ui_vanguard",var_02);
				wait(0.1);
			}

			self notify("in_range");
			self.rangecountdownactive = 0;
			self.owner setclientomnvar("ui_vanguard",1);
		}

		var_03 = castint(angleclamp360(self.angles[1]));
		self.owner setclientomnvar("ui_vanguard_heading",var_03);
		var_04 = self.origin[2] * 0.0254;
		var_04 = castint(clamp(var_04,-250,250));
		self.owner setclientomnvar("ui_vanguard_altitude",var_04);
		var_05 = distance2d(self.origin,self.attackarrow.origin) * 0.0254;
		var_05 = castint(clamp(var_05,0,256));
		self.owner setclientomnvar("ui_vanguard_range",var_05);
		var_00 = self.origin;
		wait(0.1);
	}
}

//Function Number: 32
func_91F5(param_00)
{
	param_00 = clamp(param_00,50,550);
	return 2 + castint(8 * param_00 - 50 / 500);
}

//Function Number: 33
func_8828()
{
	if(isdefined(self.inheliproximity) && self.inheliproximity)
	{
		return 0;
	}

	if(isdefined(level.disablevanguardsinair))
	{
		return 0;
	}

	if(isdefined(level.vanguardrangetriggers[0]))
	{
		foreach(var_01 in level.vanguardrangetriggers)
		{
			if(self istouching(var_01))
			{
				return 0;
			}
		}

		if(level.is_mp_descent)
		{
			return self.origin[2] < level.vanguardmaxheight;
		}
		else
		{
			return 1;
		}
	}
	else if(function_0210(self.origin,level.mapcenter) < level.vanguradmaxdistancesq && self.origin[2] < level.vanguardmaxheight)
	{
		return 1;
	}

	return 0;
}

//Function Number: 34
func_8835()
{
	self endon("death");
	self endon("in_range");
	if(isdefined(self.heliinproximity))
	{
		var_00 = 3;
	}
	else
	{
		var_00 = 6;
	}

	maps\mp\gametypes\_hostmigration::func_8B0D(var_00);
	self notify("death","range_death");
}

//Function Number: 35
func_882E(param_00)
{
	param_00 endon("death");
	param_00.owner common_scripts\utility::func_8B2A("killstreak_disowned");
	param_00 notify("death");
}

//Function Number: 36
func_8831(param_00,param_01)
{
	param_00 endon("death");
	var_02 = 60;
	if(!maps\mp\_utility::func_47BB())
	{
	}
	else
	{
		var_02 = param_01;
	}

	maps\mp\gametypes\_hostmigration::func_8B0D(var_02);
	if(isdefined(param_00.owner))
	{
		param_00.owner maps\mp\_utility::func_4D35("gryphon_gone");
	}

	param_00 notify("death");
}

//Function Number: 37
func_882C(param_00)
{
	level endon("game_ended");
	level endon("objective_cam");
	var_01 = param_00.turret;
	param_00 waittill("death");
	param_00 maps\mp\gametypes\_weapons::func_7C5B();
	stopfxontag(level.vanguard_fx["target_marker_circle"],param_00.attackarrow,"tag_origin");
	playfx(level.vanguard_fx["explode"],param_00.origin);
	param_00 playsound("ball_drone_explode");
	var_01 delete();
	if(isdefined(param_00.targeteffect))
	{
		param_00.targeteffect delete();
	}

	func_8822(param_00.owner,param_00);
}

//Function Number: 38
func_8830(param_00)
{
	param_00 endon("death");
	level common_scripts\utility::func_8B2A("objective_cam","game_ended");
	playfx(level.vanguard_fx["explode"],param_00.origin);
	param_00 playsound("ball_drone_explode");
	func_8822(param_00.owner,param_00);
}

//Function Number: 39
func_8822(param_00,param_01)
{
	param_01 notify("end_remote");
	param_01.playerlinked = 0;
	param_01 setotherent(undefined);
	func_8836(param_00,param_01);
	stopfxontag(level.vanguard_fx["smoke"],param_01,"tag_origin");
	level.remote_uav[param_01.team] = undefined;
	maps\mp\_utility::decrementfauxvehiclecount();
	if(isdefined(param_01.killcament))
	{
		param_01.killcament delete();
	}

	param_01.attackarrow delete();
	param_01 delete();
}

//Function Number: 40
func_6664()
{
	self visionsetnakedforplayer("",1);
	maps\mp\_utility::set_visionset_for_watching_players("",1);
}

//Function Number: 41
func_8836(param_00,param_01)
{
	if(!isdefined(param_00))
	{
	}

	param_00 maps\mp\_utility::func_1D59();
	param_00 func_6664();
	param_00 setclientomnvar("ui_vanguard",0);
	if(getdvarint("camera_thirdPerson"))
	{
		param_00 maps\mp\_utility::func_70E6(1);
	}

	param_00 cameraunlink(param_01);
	param_00 remotecontrolvehicleoff(param_01);
	param_00 thermalvisionoff();
	param_00 thermalvisionfofoverlayoff();
	param_00 setangles(param_00.restoreangles);
	param_00.remoteuav = undefined;
	if(param_00.team == "spectator")
	{
	}

	level thread func_8824(param_00);
}

//Function Number: 42
func_8824(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("death");
	level endon("game_ended");
	param_00 maps\mp\_utility::func_350E(1);
	wait(0.5);
	param_00 maps\mp\_utility::func_350E(0);
}

//Function Number: 43
func_8841()
{
	level endon("game_ended");
	self endon("death");
	self endon("end_remote");
	for(;;)
	{
		var_00 = 0;
		foreach(var_02 in level.helis)
		{
			if(distance(var_02.origin,self.origin) < 300)
			{
				var_00 = 1;
				self.heliinproximity = var_02;
			}
		}

		foreach(var_05 in level.littlebirds)
		{
			if(var_05 != self && !isdefined(var_05.helitype) || var_05.helitype != "remote_uav" && distance(var_05.origin,self.origin) < 300)
			{
				var_00 = 1;
				self.heliinproximity = var_05;
			}
		}

		if(!self.inheliproximity && var_00)
		{
			self.inheliproximity = 1;
		}
		else if(self.inheliproximity && !var_00)
		{
			self.inheliproximity = 0;
			self.heliinproximity = undefined;
		}

		wait(0.05);
	}
}

//Function Number: 44
func_8827()
{
	self endon("death");
	level endon("game_ended");
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		maps\mp\gametypes\_damage::func_537C(var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,"remote_uav",::handledeathdamage,::modifydamage,1);
	}
}

//Function Number: 45
func_883E()
{
	self endon("death");
	level endon("game_ended");
	self maketurretsolid();
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(self.parent))
		{
			self.parent maps\mp\gametypes\_damage::func_537C(var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,"remote_uav",::handledeathdamage,::modifydamage,1);
		}
	}
}

//Function Number: 46
modifydamage(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	var_04 = maps\mp\gametypes\_damage::handleempdamage(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::func_3F8A(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handlegrenadedamage(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handleapdamage(param_01,param_02,var_04,param_00);
	if(param_02 == "MOD_MELEE")
	{
		var_04 = self.maxhealth * 0.34;
	}

	playfxontagforclients(level.vanguard_fx["hit"],self,"tag_origin",self.owner);
	if(self.smoking == 0 && self.damagetaken >= self.maxhealth / 2)
	{
		self.smoking = 1;
		playfxontag(level.vanguard_fx["smoke"],self,"tag_origin");
	}

	return var_04;
}

//Function Number: 47
handledeathdamage(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.owner))
	{
		self.owner maps\mp\_utility::func_4D35("gryphon_destroyed");
	}

	maps\mp\gametypes\_damage::onkillstreakkilled(param_00,param_01,param_02,param_03,"destroyed_vanguard",undefined,"callout_destroyed_vanguard");
	if(isdefined(param_00))
	{
		param_00 maps\mp\gametypes\_missions::func_61CE("ch_gryphondown");
		maps\mp\gametypes\_missions::checkaachallenges(param_00,self,param_01);
	}
}

//Function Number: 48
func_8CDF()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		stopfxontag(level.vanguard_fx["target_marker_circle"],self.attackarrow,"tag_origin");
		common_scripts\utility::func_8AFE();
		thread vanguard_showreticletoenemies();
		playfxontag(common_scripts\utility::func_3AB9("emp_stun"),self,"tag_origin");
		wait(var_01);
		stopfxontag(level.vanguard_fx["target_marker_circle"],self.attackarrow,"tag_origin");
		common_scripts\utility::func_8AFE();
		thread func_8837();
	}
}