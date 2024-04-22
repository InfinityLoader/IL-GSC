/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_tridrone.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 416 ms
 * Timestamp: 4/22/2024 2:16:25 AM
*******************************************************************/

//Function Number: 1
watchtridroneusage()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	tridroneammoinit();
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "tri_drone_mp")
		{
			if(!isalive(self))
			{
				var_00 delete();
				return;
			}

			thread tryusetridrone(var_00);
		}
	}
}

//Function Number: 2
init()
{
	precacheshellshock("flashbang_mp");
	precachemodel("projectile_bouncing_betty_grenade_small");
	precachemodel("projectile_bouncing_betty_grenade_small_bombsquad");
	level.tridronesettings = spawnstruct();
	level.tridronesettings.minecountdown = 1;
	level.tridronesettings.blastradius = 132;
	level.tridronesettings.dronebounceheight = 128;
	level.tridronesettings.dronemesh = "projectile_bouncing_betty_grenade_small";
	level.tridronesettings.dronebombsquadmesh = "projectile_bouncing_betty_grenade_small_bombsquad";
	level.tridronesettings.droneexplosionfx = loadfx("vfx/explosion/frag_grenade_default");
	level.tridronesettings.beacon["enemy"] = loadfx("vfx/lights/light_c4_blink");
	level.tridronesettings.beacon["friendly"] = loadfx("vfx/lights/light_mine_blink_friendly");
	level.tridronesettings.dome = loadfx("vfx/unique/orbital_dome_ground_friendly");
}

//Function Number: 3
tridroneammoinit()
{
	if(!isdefined(self.tridroneammo))
	{
		self.tridroneammo = 0;
		thread showammocount();
	}

	self.tridroneammo = 0;
	self.tridroneammo = self.tridroneammo + 3;
	if(!isdefined(self.tridronedeployed))
	{
		self.tridronedeployed = [];
	}
}

//Function Number: 4
tryusetridrone(param_00)
{
	if(self.tridroneammo <= 0)
	{
		tridroneammoinit();
	}

	if(self.tridroneammo > 0)
	{
		thread launchtridrone(param_00);
		self.tridroneammo--;
		if(self.tridroneammo >= 1)
		{
			self giveweapon("tri_drone_mp");
		}
	}

	return 1;
}

//Function Number: 5
launchtridrone(param_00)
{
	var_01 = spawnmine(param_00);
	self.tridronedeployed = common_scripts\utility::array_add(self.tridronedeployed,var_01);
	thread monitorplayerdeath(var_01);
}

//Function Number: 6
activategroupedtridrones(param_00)
{
	self endon("death");
	foreach(var_02 in param_00.tridronedeployed)
	{
		if(isdefined(var_02))
		{
			if(var_02 != self)
			{
				var_02.trigger notify("trigger");
				wait(0.25);
			}
		}
	}
}

//Function Number: 7
removegroupedtridrone()
{
	self.owner.tridronedeployed = common_scripts\utility::array_remove(self.owner.tridronedeployed,self);
}

//Function Number: 8
monitorplayerdeath(param_00)
{
	param_00 endon("death");
	self waittill("death");
	self.tridroneammo = 0;
	if(isdefined(param_00.pickuptrigger))
	{
		param_00.pickuptrigger delete();
	}

	param_00 delete();
}

//Function Number: 9
spawnmine(param_00)
{
	param_00 waittill("missile_stuck");
	var_01 = bullettrace(param_00.origin,param_00.origin - (0,0,4),0,param_00);
	var_02 = bullettrace(param_00.origin,param_00.origin + (0,0,4),0,param_00);
	var_03 = anglestoforward(param_00.angles);
	var_04 = bullettrace(param_00.origin + (0,0,4),param_00.origin + var_03 * 4,0,param_00);
	var_05 = undefined;
	var_06 = 0;
	var_07 = 0;
	if(var_04["surfacetype"] != "none")
	{
		var_05 = var_04;
		var_07 = 1;
	}
	else if(var_02["surfacetype"] != "none")
	{
		var_05 = var_02;
		var_06 = 1;
	}
	else if(var_01["surfacetype"] != "none")
	{
		var_05 = var_01;
	}
	else
	{
		var_05 = var_01;
	}

	var_08 = var_05["position"];
	if(var_08 == var_02["position"])
	{
		var_08 = var_08 + (0,0,-5);
	}

	var_09 = spawn("script_model",var_08);
	var_09.isup = var_06;
	var_09.isforward = var_07;
	var_0A = vectornormalize(var_05["normal"]);
	var_0B = vectortoangles(var_0A);
	var_0B = var_0B + (90,0,0);
	var_09.angles = var_0B;
	var_09 setmodel(level.tridronesettings.dronemesh);
	var_09.owner = self;
	var_09 setotherent(self);
	var_09.killcamoffset = (0,0,55);
	var_09.killcament = spawn("script_model",var_09.origin + var_09.killcamoffset);
	var_09.stunned = 0;
	var_09.weaponname = "tri_drone_mp";
	param_00 delete();
	level.mines[level.mines.size] = var_09;
	var_09 thread createbombsquadmodel(level.tridronesettings.dronebombsquadmesh,"tag_origin",self);
	var_09 thread minebeacon();
	var_09 thread settridroneteamheadicon(self.team);
	var_09 thread minedamagemonitor();
	var_09 thread mineproximitytrigger(self);
	var_09 thread mineselfdestruct();
	var_09 thread deletemineonteamswitch(self);
	var_09 thread handleemp(self,"apm_mine");
	return var_09;
}

//Function Number: 10
showdebugradius()
{
	var_00["dome"] = spawnfx(level.tridronesettings.dome,self gettagorigin("tag_fx"));
	triggerfx(var_00["dome"]);
	self waittill("death");
	var_00["dome"] delete();
}

//Function Number: 11
showammocount()
{
	self endon("disconnect");
	for(;;)
	{
		if("tri_drone_mp" == self getlethalweapon())
		{
			self setclientomnvar("ui_tri_drone_count",self.tridroneammo);
		}

		wait 0.05;
	}
}

//Function Number: 12
createbombsquadmodel(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",(0,0,0));
	var_03 hide();
	wait(0.05);
	var_03 thread maps\mp\gametypes\_weapons::bombsquadvisibilityupdater(param_02);
	var_03 setmodel(param_00);
	var_03 linkto(self,param_01,(0,0,0),(0,0,0));
	var_03 setcontents(0);
	self waittill("death");
	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	var_03 delete();
}

//Function Number: 13
minebeacon()
{
	var_00["friendly"] = spawnfx(level.tridronesettings.beacon["friendly"],self gettagorigin("tag_fx"));
	var_00["enemy"] = spawnfx(level.tridronesettings.beacon["enemy"],self gettagorigin("tag_fx"));
	thread minebeaconteamupdater(var_00);
	self waittill("death");
	var_00["friendly"] delete();
	var_00["enemy"] delete();
}

//Function Number: 14
minebeaconteamupdater(param_00,param_01)
{
	self endon("death");
	var_02 = self.owner.team;
	wait(0.05);
	triggerfx(param_00["friendly"]);
	triggerfx(param_00["enemy"]);
	for(;;)
	{
		param_00["friendly"] hide();
		param_00["enemy"] hide();
		foreach(var_04 in level.players)
		{
			if(level.teambased)
			{
				if(var_04.team == var_02)
				{
					param_00["friendly"] showtoplayer(var_04);
				}
				else
				{
					param_00["enemy"] showtoplayer(var_04);
				}

				continue;
			}

			if(var_04 == self.owner)
			{
				param_00["friendly"] showtoplayer(var_04);
				continue;
			}

			param_00["enemy"] showtoplayer(var_04);
		}

		level common_scripts\utility::waittill_either("joined_team","player_spawned");
	}
}

//Function Number: 15
settridroneteamheadicon(param_00)
{
	self endon("death");
	wait(0.05);
	if(level.teambased)
	{
		if(self.isup == 1 || self.isforward == 1)
		{
			maps\mp\_entityheadicons::setteamheadicon(param_00,(0,0,28),undefined,1);
			return;
		}

		maps\mp\_entityheadicons::setteamheadicon(param_00,(0,0,28));
		return;
	}

	if(isdefined(self.owner))
	{
		if(self.isup == 1)
		{
			maps\mp\_entityheadicons::setplayerheadicon(self.owner,(28,0,28));
			return;
		}

		maps\mp\_entityheadicons::setplayerheadicon(self.owner,(0,0,28));
		return;
	}
}

//Function Number: 16
minedamagemonitor()
{
	self endon("mine_triggered");
	self endon("mine_selfdestruct");
	self endon("death");
	self setcandamage(1);
	self.maxhealth = 100000;
	self.health = self.maxhealth;
	var_00 = undefined;
	for(;;)
	{
		self waittill("damage",var_01,var_00,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!isplayer(var_00))
		{
			continue;
		}

		if(!maps\mp\gametypes\_weapons::friendlyfirecheck(self.owner,var_00))
		{
			continue;
		}

		if(isdefined(var_09))
		{
			var_0A = maps\mp\_utility::strip_suffix(var_09,"_lefthand");
			switch(var_0A)
			{
				case "smoke_grenade_var_mp":
				case "smoke_grenade_mp":
					break;
			}
		}

		break;
	}

	self notify("mine_destroyed");
	removegroupedtridrone();
	if(isdefined(var_04) && issubstr(var_04,"MOD_GRENADE") || issubstr(var_04,"MOD_EXPLOSIVE"))
	{
		self.waschained = 1;
	}

	if(isdefined(var_08) && var_08 & level.idflags_penetration)
	{
		self.wasdamagedfrombulletpenetration = 1;
	}

	self.wasdamaged = 1;
	if(isplayer(var_00))
	{
		var_00 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("bouncing_betty");
	}

	if(level.teambased)
	{
		if(isdefined(var_00) && isdefined(var_00.pers["team"]) && isdefined(self.owner) && isdefined(self.owner.pers["team"]))
		{
			if(var_00.pers["team"] != self.owner.pers["team"])
			{
				var_00 notify("destroyed_explosive");
			}
		}
	}
	else if(isdefined(self.owner) && isdefined(var_00) && var_00 != self.owner)
	{
		var_00 notify("destroyed_explosive");
	}

	thread mineexplode(var_00);
}

//Function Number: 17
mineexplode(param_00)
{
	if(!isdefined(self) || !isdefined(self.owner))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = self.owner;
	}

	self playsound("null");
	var_01 = self gettagorigin("tag_fx");
	playfx(level.tridronesettings.droneexplosionfx,var_01);
	wait(0.05);
	if(!isdefined(self) || !isdefined(self.owner))
	{
		return;
	}

	self hide();
	self radiusdamage(self.origin,192,60,60,param_00,"MOD_EXPLOSIVE","bouncingbetty_mp");
	foreach(var_03 in level.players)
	{
		var_04 = distance(self.origin,var_03.origin);
		if(var_04 < 192)
		{
			var_03 shellshock("flashbang_mp",2.5);
		}
	}

	if(isdefined(self.owner) && isdefined(level.leaderdialogonplayer_func))
	{
		self.owner thread [[ level.leaderdialogonplayer_func ]]("mine_destroyed",undefined,undefined,self.origin);
	}

	wait(0.2);
	if(!isdefined(self) || !isdefined(self.owner))
	{
		return;
	}

	thread apm_mine_deletekillcament();
	self notify("death");
	if(isdefined(self.pickuptrigger))
	{
		self.pickuptrigger delete();
	}

	self hide();
}

//Function Number: 18
apm_mine_deletekillcament()
{
	wait(3);
	self.killcament delete();
	self delete();
	level.mines = common_scripts\utility::array_removeundefined(level.mines);
}

//Function Number: 19
equipmentwatchuse()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("change_owner");
	self.pickuptrigger setcursorhint("HINT_NOICON");
	var_00 = self.pickuptrigger.owner;
	equipmentenableuse(var_00);
	for(;;)
	{
		self.pickuptrigger waittill("trigger",var_00);
		var_00 playlocalsound("scavenger_pack_pickup");
		var_00.tridroneammo++;
		if(var_00.tridroneammo == 1)
		{
			var_00 giveweapon("tri_drone_mp");
		}

		if(isdefined(self.pickuptrigger))
		{
			self.pickuptrigger delete();
		}

		self.killcament delete();
		self delete();
		level.mines = common_scripts\utility::array_removeundefined(level.mines);
	}
}

//Function Number: 20
equipmentenableuse(param_00)
{
	self notify("equipmentWatchUse");
	self endon("spawned_player");
	self endon("disconnect");
	self endon("equipmentWatchUse");
	self endon("change_owner");
	self.pickuptrigger setcursorhint("HINT_NOICON");
	self.pickuptrigger sethintstring(&"MP_PICKUP_TRI_DRONE");
	self.pickuptrigger maps\mp\_utility::setselfusable(param_00);
}

//Function Number: 21
equipmentdisableuse(param_00)
{
	self.trigger sethintstring("");
	self.trigger maps\mp\_utility::setselfunusuable();
}

//Function Number: 22
mineproximitytrigger(param_00)
{
	self endon("mine_destroyed");
	self endon("mine_selfdestruct");
	self endon("death");
	wait(2);
	self.pickuptrigger = spawn("script_origin",self.origin);
	self.pickuptrigger.owner = param_00;
	thread equipmentwatchuse();
	var_01 = spawn("trigger_radius",self.origin + (0,0,-96),0,192,192);
	var_01.owner = self;
	self.trigger = var_01;
	thread minedeletetrigger(var_01);
	var_02 = undefined;
	for(;;)
	{
		var_01 waittill("trigger",var_02);
		if(!isdefined(var_02))
		{
			break;
		}

		if(getdvarint("scr_minesKillOwner") != 1)
		{
			if(isdefined(self.owner))
			{
				if(var_02 == self.owner)
				{
					continue;
				}

				if(isdefined(var_02.owner) && var_02.owner == self.owner)
				{
					continue;
				}
			}

			if(!maps\mp\gametypes\_weapons::friendlyfirecheck(self.owner,var_02,0))
			{
				continue;
			}
		}

		if(lengthsquared(var_02 getentityvelocity()) < 10)
		{
			continue;
		}

		if(var_02 damageconetrace(self.origin,self) > 0)
		{
			break;
		}
	}

	removegroupedtridrone();
	self notify("mine_triggered");
	self playsound("claymore_activated");
	self playsound("mine_betty_spin");
	playfx(level.mine_launch,self.origin);
	var_03 = anglestoup(self.angles);
	var_04 = self.origin + var_03 * 64;
	self moveto(var_04,0.75,0,0.25);
	self.killcament moveto(var_04 + self.killcamoffset,0.75,0,0.25);
	self rotatevelocity((0,750,32),0.7,0,0.65);
	thread playspinnerfx();
	if(isplayer(var_02) && var_02 maps\mp\_utility::_hasperk("specialty_class_engineer"))
	{
		var_02 notify("triggered_mine");
		wait(3);
	}
	else
	{
		wait(1);
	}

	thread mineexplode();
}

//Function Number: 23
playspinnerfx()
{
	self endon("death");
	var_00 = gettime() + 1000;
	while(gettime() < var_00)
	{
		wait(0.05);
		playfxontag(level.mine_spin,self,"tag_fx_spin1");
		playfxontag(level.mine_spin,self,"tag_fx_spin3");
		wait(0.05);
		playfxontag(level.mine_spin,self,"tag_fx_spin2");
		playfxontag(level.mine_spin,self,"tag_fx_spin4");
	}
}

//Function Number: 24
minedeletetrigger(param_00)
{
	common_scripts\utility::waittill_any("mine_triggered","mine_destroyed","death");
	param_00 delete();
}

//Function Number: 25
mineselfdestruct()
{
	self endon("mine_triggered");
	self endon("mine_destroyed");
	self endon("death");
	wait(120);
	self notify("mine_selfdestruct");
	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}

	playfx(level._effect["equipment_explode"],self.origin);
	self delete();
}

//Function Number: 26
deletemineonteamswitch(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	self endon("death");
	param_00 waittill("joined_team");
	self delete();
	self notify("death");
}

//Function Number: 27
handleemp(param_00,param_01)
{
	self endon("death");
	if(param_00 maps\mp\_utility::isemped())
	{
		self notify("death");
		if(param_01 == "apm_mine")
		{
			playfx(level._effect["equipment_explode"],self.origin);
			self delete();
		}

		return;
	}

	for(;;)
	{
		level waittill("emp_update");
		if(!param_00 maps\mp\_utility::isemped())
		{
			continue;
		}

		if(param_01 == "apm_mine")
		{
			playfx(level._effect["equipment_explode"],self.origin);
			self delete();
		}

		self notify("death");
	}
}