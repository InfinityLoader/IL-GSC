/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_helisniper.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 32
 * Decompile Time: 540 ms
 * Timestamp: 10/27/2023 1:32:44 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	maps\mp\killstreaks\_helicopter_guard::func_4D1C();
	maps\mp\killstreaks\_helicopter_guard::func_4D1B();
	level.sniper_explode = loadfx("fx/explosions/sniper_incendiary");
	level.killstreakfuncs["heli_sniper"] = ::func_843B;
	var_00 = addstruct();
	var_00.xppopup = "destroyed_helo_scout";
	var_00.callout = "callout_destroyed_helo_scout";
	var_00.samdamagescale = 0.09;
	var_00.enginevfxtag = "tag_engine_right";
	level.heliconfigs["heli_sniper"] = var_00;
}

//Function Number: 2
func_843B(param_00,param_01)
{
	var_02 = getcloseststartnode(self.origin);
	var_03 = getclosestnode(self.origin);
	var_04 = vectortoangles(var_03.origin - var_02.origin);
	if(isdefined(self.underwater) && self.underwater)
	{
		return 0;
	}

	if(isdefined(self.isjuggernautlevelcustom) && self.isjuggernautlevelcustom == 1)
	{
		return 0;
	}
	else if(!isdefined(level.air_node_mesh) || !isdefined(var_02) || !isdefined(var_03))
	{
		self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE_IN_LEVEL");
		return 0;
	}

	var_05 = 1;
	if(func_3040())
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	if(maps\mp\_utility::func_21E7() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_05 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	if(isdefined(self.iscapturingcrate) && self.iscapturingcrate)
	{
		return 0;
	}

	if(isdefined(self.isreviving) && self.isreviving)
	{
		return 0;
	}

	var_06 = createheli(self,var_02,var_03,var_04,param_01,param_00);
	if(!isdefined(var_06))
	{
		return 0;
	}

	var_07 = helipickup(var_06,param_01);
	if(isdefined(var_07) && var_07 == "fail")
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
func_3040()
{
	return isdefined(level.lbsniper);
}

//Function Number: 4
getcloseststartnode(param_00)
{
	var_01 = undefined;
	var_02 = 999999;
	foreach(var_04 in level.air_start_nodes)
	{
		var_05 = distance(var_04.origin,param_00);
		if(var_05 < var_02)
		{
			var_01 = var_04;
			var_02 = var_05;
		}
	}

	return var_01;
}

//Function Number: 5
createheli(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = getent("airstrikeheight","targetname");
	var_07 = param_02.origin;
	var_08 = anglestoforward(param_03);
	var_09 = param_01.origin;
	var_0A = spawnhelicopter(param_00,var_09,var_08,"attack_littlebird_mp",level.littlebird_model);
	if(!isdefined(var_0A))
	{
	}

	var_0B = maps\mp\_utility::func_3AC9();
	var_0C = var_07 + maps\mp\_utility::gethelipilotmeshoffset() + var_0B;
	var_0D = var_07 + maps\mp\_utility::gethelipilotmeshoffset() - var_0B;
	var_0E = bullettrace(var_0C,var_0D,0,0,0,0,1);
	if(isdefined(var_0E["entity"]) && var_0E["normal"][2] > 0.1)
	{
		var_07 = var_0E["position"] - maps\mp\_utility::gethelipilotmeshoffset() + (0,0,384);
	}

	var_0A maps\mp\killstreaks\_helicopter::addtolittlebirdlist("lbSniper");
	var_0A thread maps\mp\killstreaks\_helicopter::func_6590();
	var_0A thread waitfordeath();
	var_0A.lifeid = param_05;
	var_0A.forward = var_08;
	var_0A.pathstart = var_09;
	var_0A.pathgoal = var_07;
	var_0A.pathend = param_01.origin;
	var_0A.flyheight = var_07[2];
	var_0A.maxheight = var_06.origin;
	var_0A.ongroundpos = param_01.origin;
	var_0A.pickuppos = var_0A.ongroundpos + (0,0,300);
	var_0A.hoverpos = var_0A.ongroundpos + (0,0,600);
	var_0A.forwardyaw = var_08[1];
	var_0A.backwardyaw = var_08[1] + 180;
	if(var_0A.backwardyaw > 360)
	{
		var_0A.backwardyaw = var_0A.backwardyaw - 360;
	}

	var_0A.helitype = "littlebird";
	var_0A.heli_type = "littlebird";
	var_0A.locindex = param_01.orgin;
	var_0A.allowsafeeject = 1;
	var_0A.attractor = missilecreateattractorent(var_0A,level.heli_attract_strength,level.heli_attract_range);
	var_0A.isdestroyed = 0;
	var_0A.maxhealth = level.heli_maxhealth;
	var_0A thread maps\mp\killstreaks\_flares::func_33DA(1);
	var_0A thread maps\mp\killstreaks\_helicopter::func_40A5("heli_sniper",1);
	var_0A thread func_4155(param_04);
	var_0A.owner = param_00;
	var_0A.team = param_00.team;
	var_0A thread leaveonownerdisconnect();
	var_0A.speed = 100;
	var_0A.ammo = 100;
	var_0A.followspeed = 40;
	var_0A setcandamage(1);
	var_0A setmaxpitchroll(45,45);
	var_0A setspeed(var_0A.speed,100,40);
	var_0A setyawspeed(120,60);
	var_0A sethoverparams(10,10,60);
	var_0A neargoalnotifydist(512);
	var_0A.killcount = 0;
	var_0A.streakname = "heli_sniper";
	var_0A.allowboard = 0;
	var_0A.ownerboarded = 0;
	var_0A hidepart("tag_wings");
	return var_0A;
}

//Function Number: 6
func_3A3A(param_00)
{
	self endon("death");
	self endon("crashing");
	self endon("helicopter_removed");
	self endon("heightReturned");
	var_01 = getent("airstrikeheight","targetname");
	if(isdefined(var_01))
	{
		var_02 = var_01.origin[2];
	}
	else if(isdefined(level.airstrikeheightscale))
	{
		var_02 = 850 * level.airstrikeheightscale;
	}
	else
	{
		var_02 = 850;
	}

	var_03 = bullettrace(param_00,param_00 - (0,0,10000),0,self,0,0,0,0);
	var_04 = var_03["position"][2];
	var_05 = 0;
	var_06 = 0;
	for(var_07 = 0;var_07 < 30;var_07++)
	{
		wait(0.05);
		var_08 = var_07 % 8;
		var_09 = var_07 * 7;
		switch(var_08)
		{
			case 0:
				var_05 = var_09;
				var_06 = var_09;
				break;

			case 1:
				var_05 = var_09 * -1;
				var_06 = var_09 * -1;
				break;

			case 2:
				var_05 = var_09 * -1;
				var_06 = var_09;
				break;

			case 3:
				var_05 = var_09;
				var_06 = var_09 * -1;
				break;

			case 4:
				var_05 = 0;
				var_06 = var_09 * -1;
				break;

			case 5:
				var_05 = var_09 * -1;
				var_06 = 0;
				break;

			case 6:
				var_05 = var_09;
				var_06 = 0;
				break;

			case 7:
				var_05 = 0;
				var_06 = var_09;
				break;

			default:
				break;
		}

		var_0A = bullettrace(param_00 + (var_05,var_06,1000),param_00 - (var_05,var_06,10000),0,self,0,0,0,0,0);
		if(isdefined(var_0A["entity"]))
		{
			continue;
		}

		if(var_0A["position"][2] + 145 > var_04)
		{
			var_04 = var_0A["position"][2] + 145;
		}
	}

	return var_04;
}

//Function Number: 7
helipickup(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("crashing");
	param_00 endon("owner_disconnected");
	param_00 endon("killstreakExit");
	var_02 = getcloseststartnode(self.origin);
	level thread maps\mp\_utility::func_7FA0("used_heli_sniper",self,self.team);
	if(isdefined(var_02.angles))
	{
		var_03 = var_02.angles;
	}
	else
	{
		var_03 = (0,0,0);
	}

	common_scripts\utility::_disableusability();
	var_04 = param_00.flyheight;
	if(isdefined(var_02.neighbors[0]))
	{
		var_05 = var_02.neighbors[0];
	}
	else
	{
		var_05 = getclosestnode(self.origin);
	}

	var_06 = anglestoforward(self.angles);
	var_07 = var_05.origin * (1,1,0) + (0,0,1) * var_04 + var_06 * -100;
	param_00.targetpos = var_07;
	param_00.currentnode = var_05;
	var_08 = func_5490(param_00);
	if(isdefined(var_08) && var_08 == "fail")
	{
		param_00 thread helileave();
		return var_08;
	}

	thread func_9373(param_00);
	return var_08;
}

//Function Number: 8
func_9373(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("crashing");
	param_00 endon("owner_disconnected");
	param_00 endon("killstreakExit");
	if(isdefined(self.imslist))
	{
		destroycarriedims();
	}

	param_00 thread func_3CE6();
	param_00 setyawspeed(1,1,1,0.1);
	param_00 notify("picked_up_passenger");
	common_scripts\utility::_enableusability();
	param_00 setspeed(param_00.speed,100,40);
	self.onhelisniper = 1;
	self.helisniper = param_00;
	param_00 endon("owner_death");
	param_00 thread func_624D();
	param_00 thread func_4D4A();
	param_00 setgoalpos(param_00.targetpos,1);
	param_00 thread func_4154();
	param_00 waittill("near_goal");
	param_00 thread func_4160();
	thread func_8CDE(param_00);
	wait(45);
	self notify("heli_sniper_timeout");
	dodropff(param_00);
}

//Function Number: 9
dodropff(param_00)
{
	param_00 notify("dropping");
	param_00 thread func_4171();
	param_00 waittill("at_dropoff");
	param_00 setspeed(60);
	param_00 setyawspeed(180,180,180,0.3);
	wait(1);
	if(!maps\mp\_utility::func_4945(self))
	{
	}

	thread func_70E4();
	self ridevehicle();
	self allowjump(1);
	self setstance("stand");
	self.onhelisniper = 0;
	self.helisniper = undefined;
	param_00.ownerboarded = 0;
	self takeweapon("iw6_gm6helisnipe_mp_gm6scope");
	self enableweaponswitch();
	maps\mp\_utility::func_70B1();
	var_01 = common_scripts\utility::func_3B0A();
	if(!self hasweapon(var_01))
	{
		var_01 = maps\mp\killstreaks\_killstreaks::func_3AAA();
	}

	maps\mp\_utility::func_7E17(var_01);
	wait(1);
	if(isdefined(param_00))
	{
		param_00 thread helileave();
	}
}

//Function Number: 10
func_8CDE(param_00)
{
	self endon("heli_sniper_timeout");
	param_00 thread maps\mp\killstreaks\_killstreaks::allowridekillstreakplayerexit("dropping");
	param_00 waittill("killstreakExit");
	dodropff(param_00);
}

//Function Number: 11
func_5490(param_00)
{
	self endon("disconnect");
	self visionsetnakedforplayer("black_bw",0.5);
	maps\mp\_utility::set_visionset_for_watching_players("black_bw",0.5,1);
	var_01 = common_scripts\utility::func_8B35(0.5,"death");
	maps\mp\gametypes\_hostmigration::func_8BBA();
	if(var_01 == "death")
	{
		thread maps\mp\killstreaks\_killstreaks::clearrideintro(1);
		return "fail";
	}

	self playsoundonmovingent();
	if(var_01 != "disconnect")
	{
		thread maps\mp\killstreaks\_killstreaks::clearrideintro(1,0.75);
		if(self.team == "spectator")
		{
			return "fail";
		}
	}

	param_00 attachplayertochopper();
	if(!isalive(self))
	{
		return "fail";
	}

	level.helisnipereyeson = param_00;
	level notify("update_uplink");
}

//Function Number: 12
destroycarriedims()
{
	foreach(var_01 in self.imslist)
	{
		if(isdefined(var_01.carriedby) && var_01.carriedby == self)
		{
			self forceusehintoff();
			self.iscarrying = undefined;
			self.carrieditem = undefined;
			if(isdefined(var_01.bombsquadmodel))
			{
				var_01.bombsquadmodel delete();
			}

			var_01 delete();
			self enableweapons();
		}
	}
}

//Function Number: 13
func_4154()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self.owner endon("death");
	var_00 = self.origin + anglestoright(self.owner.angles) * 1000;
	self.lookatent = spawn("script_origin",var_00);
	self setlookatent(self.lookatent);
	self setyawspeed(360,120);
	for(;;)
	{
		wait(0.25);
		var_00 = self.origin + anglestoright(self.owner.angles) * 1000;
		self.lookatent.origin = var_00;
	}
}

//Function Number: 14
attachplayertochopper()
{
	self.owner notify("force_cancel_sentry");
	self.owner notify("force_cancel_ims");
	self.owner notify("force_cancel_placement");
	self.owner notify("cancel_carryRemoteUAV");
	self.owner setangles(self gettagangles("TAG_RIDER"));
	self.owner setweaponmodelvariant(self,40,70,10,70,1);
	self.owner setstance("crouch");
	self.owner allowjump(0);
	thread func_6420();
	self.ownerboarded = 1;
	self notify("boarded");
	self.owner.chopper = self;
}

//Function Number: 15
func_4171()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("owner_disconnected");
	self endon("owner_death");
	var_00 = undefined;
	var_01 = undefined;
	var_02 = undefined;
	var_03 = 0;
	foreach(var_05 in level.air_node_mesh)
	{
		if(!isdefined(var_05.script_parameters) || !issubstr(var_05.script_parameters,"pickupNode"))
		{
			continue;
		}

		var_06 = distancesquared(var_05.origin,self.origin);
		if(!isdefined(var_02) || var_06 < var_02)
		{
			var_01 = var_05;
			var_02 = var_06;
			if(var_05.script_parameters == "pickupNodehigh")
			{
				var_03 = 1;
				continue;
			}

			var_03 = 0;
		}
	}

	if(maps\mp\_utility::getmapname() == "mp_chasm")
	{
		if(var_01.origin == (-224,-1056,2376))
		{
			var_01.origin = (-304,-896,2376);
		}
	}

	if(var_03 && !bullettracepassed(self.origin,var_01.origin,0,self))
	{
		self setgoalpos(self.origin + (0,0,2300),1);
		func_8B72("near_goal","goal",5);
		var_08 = var_01.origin;
		var_08 = var_08 + (0,0,1500);
	}
	else if(var_02.origin[2] > self.origin[2])
	{
		var_08 = var_02.origin;
	}
	else
	{
		var_08 = var_02.origin * (1,1,0);
		var_08 = var_08 + (0,0,self.origin[2]);
	}

	self setgoalpos(var_08,1);
	var_09 = func_3A3A(var_08);
	var_0A = var_08 * (1,1,0);
	var_0B = var_0A + (0,0,var_09);
	func_8B72("near_goal","goal",5);
	self.movedlow = 0;
	self setgoalpos(var_0B + (0,0,200),1);
	self.droppingoff = 1;
	func_8B72("near_goal","goal",5);
	self.movedlow = 1;
	self notify("at_dropoff");
}

//Function Number: 16
func_8B72(param_00,param_01,param_02)
{
	level endon("game_ended");
	self endon(param_00);
	self endon(param_01);
	wait(param_02);
}

//Function Number: 17
func_4160()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("dropping");
	self setspeed(60,45,20);
	self neargoalnotifydist(8);
	for(;;)
	{
		var_00 = self.owner getnormalizedmovement();
		if(var_00[0] >= 0.15 || var_00[1] >= 0.15 || var_00[0] <= -0.15 || var_00[1] <= -0.15)
		{
			thread func_5093(var_00);
		}

		wait(0.05);
	}
}

//Function Number: 18
helifreemovementcontrol()
{
	self setspeed(80,60,20);
	self neargoalnotifydist(8);
	for(;;)
	{
		var_00 = self.owner getnormalizedmovement();
		if(var_00[0] >= 0.15 || var_00[1] >= 0.15 || var_00[0] <= -0.15 || var_00[1] <= -0.15)
		{
			thread manualmovefree(var_00);
		}

		wait(0.05);
	}
}

//Function Number: 19
manualmovefree(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("dropping");
	self notify("manualMove");
	self endon("manualMove");
	var_01 = anglestoforward(self.owner.angles) * 350 * param_00[0];
	var_02 = anglestoright(self.owner.angles) * 250 * param_00[1];
	var_03 = var_01 + var_02;
	var_04 = self.origin + var_03;
	var_04 = var_04 * (1,1,0);
	var_04 = var_04 + (0,0,self.maxheight[2]);
	if(function_0210((0,0,0),var_04) > 8000000)
	{
	}

	self setgoalpos(var_04,1);
	self waittill("goal");
}

//Function Number: 20
func_5093(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("dropping");
	self notify("manualMove");
	self endon("manualMove");
	var_01 = anglestoforward(self.owner.angles) * 250 * param_00[0];
	var_02 = anglestoright(self.owner.angles) * 250 * param_00[1];
	var_03 = var_01 + var_02;
	var_04 = 256;
	var_05 = self.origin + var_03;
	var_06 = maps\mp\_utility::func_3AC9();
	var_07 = var_05 + maps\mp\_utility::gethelipilotmeshoffset() + var_06;
	var_08 = var_05 + maps\mp\_utility::gethelipilotmeshoffset() - var_06;
	var_09 = bullettrace(var_07,var_08,0,0,0,0,1);
	if(isdefined(var_09["entity"]) && var_09["normal"][2] > 0.1)
	{
		var_05 = var_09["position"] - maps\mp\_utility::gethelipilotmeshoffset() + (0,0,var_04);
		var_0A = var_05[2] - self.origin[2];
		if(var_0A > 1000)
		{
		}

		self setgoalpos(var_05,1);
		self waittill("goal");
	}
}

//Function Number: 21
helileave()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self notify("end_disconnect_check");
	self notify("end_death_check");
	self notify("leaving");
	if(isdefined(self.ladder))
	{
		self.ladder delete();
	}

	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	if(isdefined(self.turret))
	{
		self.turret delete();
	}

	if(isdefined(self.msg))
	{
		self.msg maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(self.switchmsg))
	{
		self.switchmsg maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(self.movemsg))
	{
		self.movemsg maps\mp\gametypes\_hud_util::destroyelem();
	}

	self clearlookatent();
	level.helisnipereyeson = undefined;
	level notify("update_uplink");
	self setyawspeed(220,220,220,0.3);
	self setspeed(120,60);
	self setgoalpos(self.origin + (0,0,1200),1);
	self waittill("goal");
	var_00 = self.pathend - self.pathgoal * 5000;
	self setgoalpos(var_00,1);
	self setspeed(300,75);
	self.leaving = 1;
	common_scripts\utility::func_8B35(5,"goal");
	if(isdefined(level.lbsniper) && level.lbsniper == self)
	{
		level.lbsniper = undefined;
	}

	self notify("delete");
	self delete();
}

//Function Number: 22
func_4155(param_00)
{
	level endon("game_ended");
	self endon("leaving");
	self waittill("death");
	maps\mp\gametypes\_hostmigration::func_8BBA();
	thread maps\mp\killstreaks\_helicopter::func_4D0A();
	if(isdefined(self.ladder))
	{
		self.ladder delete();
	}

	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	if(isdefined(self.turret))
	{
		self.turret delete();
	}

	if(isdefined(self.msg))
	{
		self.msg maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(self.switchmsg))
	{
		self.switchmsg maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(self.movemsg))
	{
		self.movemsg maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(self.owner) && isalive(self.owner) && self.ownerboarded == 1)
	{
		self.owner ridevehicle();
		var_01 = undefined;
		var_02 = undefined;
		if(isdefined(self.attackers))
		{
			var_03 = 0;
			foreach(var_06, var_05 in self.attackers)
			{
				if(var_05 >= var_03)
				{
					var_03 = var_05;
					var_01 = var_06;
				}
			}
		}

		if(isdefined(var_01))
		{
			foreach(var_08 in level.participants)
			{
				if(var_08 maps\mp\_utility::getuniqueid() == var_01)
				{
					var_02 = var_08;
				}
			}
		}

		var_0A = getdvarint("scr_team_fftype");
		if(isdefined(self.killingattacker) && isdefined(self.killingattacker.isharrier))
		{
			self.killingattacker entityradiusdamage(self.owner.origin,200,2600,2600,self.killingattacker);
		}
		else if(isdefined(var_02) && var_0A != 2)
		{
			radiusdamage(self.owner.origin,200,2600,2600,var_02);
		}
		else if(var_0A == 2 && isdefined(var_02) && maps\mp\_utility::attackerishittingteam(var_02,self.owner))
		{
			radiusdamage(self.owner.origin,200,2600,2600,var_02);
			radiusdamage(self.owner.origin,200,2600,2600);
		}
		else
		{
			radiusdamage(self.owner.origin,200,2600,2600);
		}

		self.owner.onhelisniper = 0;
		self.owner.helisniper = undefined;
	}
}

//Function Number: 23
func_70E4()
{
	if(!maps\mp\_utility::_hasperk("specialty_falldamage"))
	{
		level endon("game_ended");
		self endon("death");
		self endon("disconnect");
		maps\mp\_utility::func_3CFB("specialty_falldamage",0);
		wait(2);
		maps\mp\_utility::_unsetperk("specialty_falldamage");
	}
}

//Function Number: 24
func_6420()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("dropping");
	var_00 = 0;
	for(;;)
	{
		wait(0.05);
		if(!isdefined(self.owner.lightarmorhp) && !self.owner maps\mp\_utility::isjuggernaut())
		{
			self.owner maps\mp\perks\_perkfunctions::func_7063();
			var_00++;
			if(var_00 >= 2)
			{
				break;
			}
		}
	}
}

//Function Number: 25
func_4A9D()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("dropping");
	for(;;)
	{
		if(self.owner getstance() != "crouch")
		{
			self.owner setstance("crouch");
		}

		wait(0.05);
	}
}

//Function Number: 26
func_3CE6()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("dropping");
	self.owner endon("disconnect");
	for(;;)
	{
		if(!isalive(self.owner))
		{
			return "fail";
		}

		if(self.owner getcurrentprimaryweapon() != "iw6_gm6helisnipe_mp_gm6scope")
		{
			self.owner giveweapon("iw6_gm6helisnipe_mp_gm6scope");
			self.owner switchtoweaponimmediate("iw6_gm6helisnipe_mp_gm6scope");
			self.owner disableweaponswitch();
			self.owner maps\mp\_utility::func_70B1(0,100);
			self.owner givemaxammo("iw6_gm6helisnipe_mp_gm6scope");
		}
		else
		{
		}

		wait(0.05);
	}
}

//Function Number: 27
func_6647()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self.owner endon("death");
	self.owner endon("disconnect");
	self.owner endon("dropping");
	for(;;)
	{
		self.owner waittill("weapon_fired");
		self.owner givemaxammo("iw6_gm6helisnipe_mp_gm6scope");
	}
}

//Function Number: 28
func_624D()
{
	level endon("game_ended");
	self.owner endon("disconnect");
	self endon("death");
	self endon("crashing");
	self.owner waittill("death");
	self.owner.onhelisniper = 0;
	self.owner.helisniper = undefined;
	self.ownerboarded = 0;
	if(isdefined(self.origin))
	{
		physicsexplosionsphere(self.origin,200,200,1);
	}
}

//Function Number: 29
leaveonownerdisconnect()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("end_disconnect_check");
	self.owner waittill("disconnect");
	self notify("owner_disconnected");
	thread helileave();
}

//Function Number: 30
func_4D4A()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("end_death_check");
	self.owner waittill("death");
	self notify("owner_death");
	thread helileave();
}

//Function Number: 31
getclosestnode(param_00)
{
	var_01 = undefined;
	var_02 = 999999;
	foreach(var_04 in level.air_node_mesh)
	{
		var_05 = distance(var_04.origin,param_00);
		if(var_05 < var_02)
		{
			var_01 = var_04;
			var_02 = var_05;
		}
	}

	return var_01;
}

//Function Number: 32
waitfordeath()
{
	var_00 = self getentitynumber();
	self waittill("death");
	level.lbsniper = undefined;
	if(isdefined(level.helisnipereyeson))
	{
		level.helisnipereyeson = undefined;
		level notify("update_uplink");
	}
}