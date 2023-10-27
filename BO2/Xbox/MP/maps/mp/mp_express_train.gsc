/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_express_train.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 15
 * Decompile Time: 276 ms
 * Timestamp: 10/27/2023 3:05:27 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_events;
#include maps/mp/_tacticalinsertion;
#include maps/mp/_utility;
#include maps/mp/gametypes/_gameobjects;
#include maps/mp/gametypes/_weaponobjects;
#include maps/mp/gametypes/ctf;
#include maps/mp/killstreaks/_rcbomb;
#include maps/mp/killstreaks/_supplydrop;

//Function Number: 1
init()
{
	precachevehicle("express_train_engine_mp");
	precachemodel("p6_bullet_train_car_phys");
	precachemodel("p6_bullet_train_engine_rev");
	precacheshader("compass_train_carriage");
	precachestring(&"traincar");
	precachestring(&"trainengine");
	gates = getentarray("train_gate_rail","targetname");
	brushes = getentarray("train_gate_rail_brush","targetname");
	triggers = getentarray("train_gate_kill_trigger","targetname");
	traintriggers = getentarray("train_kill_trigger","targetname");
	foreach(brush in brushes)
	{
		brush disconnectpaths();
	}

	waittime = 0.05;
	foreach(gate in gates)
	{
		gate.waittime = waittime;
		waittime = waittime + 0.05;
		gate.og_origin = gate.origin;
		brush = getclosest(gate.origin,brushes);
		brush linkto(gate);
		gate.kill_trigger = getclosest(gate.origin,triggers);
		if(IsDefined(gate.kill_trigger))
		{
			gate.kill_trigger enablelinkto();
			gate.kill_trigger linkto(gate);
		}
	}

	start = getvehiclenode("train_start","targetname");
	endgates = getentarray("train_gate_rail_end","targetname");
	entrygate = getclosest(start.origin,endgates);
	for(i = 0;i < endgates.size;i++)
	{
		if(endgates[i] == entrygate)
		{
		}
		else
		{
			exitgate = endgates[i];
			break;
		}
	}

	cars = [];
	cars[0] = spawnvehicle("p6_bullet_train_engine_phys","train","express_train_engine_mp",start.origin,(0,0,0));
	cars[0] ghost();
	cars[0] setcheapflag(1);
	cars[0].ismagicbullet = 1;
	killcam = spawn("script_model",25 + VectorScale((0,0,1)));
	killcam.angles = 10 + VectorScale((0,-1,0));
	killcam linkto(cars[0]);
	foreach(traintrigger in traintriggers)
	{
		cars[0].trainkilltrigger = traintrigger;
		traintrigger.origin = start.origin;
		traintrigger enablelinkto();
		traintrigger linkto(cars[0]);
	}

	for(i = 1;i < 20;i++)
	{
		cars[i] = spawn("script_model",start.origin);
		cars[i] setmodel("p6_bullet_train_car_phys");
		cars[i] ghost();
		cars[i] setcheapflag(1);
	}

	cars[20] = spawn("script_model",start.origin);
	cars[20] setmodel("p6_bullet_train_engine_rev");
	cars[20] ghost();
	cars[20] setcheapflag(1);
	waittillframeend;
	if(level.timelimit)
	{
		seconds = level.timelimit * 60;
		add_timed_event(int(seconds * 0.25),"train_start");
		add_timed_event(int(seconds * 0.75),"train_start");
	}
	else if(level.scorelimit)
	{
		add_score_event(int(level.scorelimit * 0.25),"train_start");
		add_score_event(int(level.scorelimit * 0.75),"train_start");
	}

	level thread train_think(gates,entrygate,exitgate,cars,start,killcam);
}

//Function Number: 2
showaftertime(time)
{
	wait(time);
	self show();
}

//Function Number: 3
train_think(gates,entrygate,exitgate,cars,start,killcam)
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("train_start");
		entrygate gate_move(-172);
		traintiming = getdvarfloatdefault("scr_express_trainTiming",4);
		exitgate thread waitthenmove(traintiming,-172);
		array_func(gates,::gate_move,-172);
		foreach(gate in gates)
		{
			gate playloopsound("amb_train_incomming_beep");
			gate playsound("amb_gate_move");
		}

		gatedownwait = getdvarintdefault("scr_express_gateDownWait",2);
		wait(gatedownwait);
		foreach(gate in gates)
		{
			gate stoploopsound(2);
		}

		wait(2);
		cars[0] attachpath(start);
		cars[0].killcament = undefined;
		if(IsDefined(cars[0].trainkilltrigger))
		{
			cars[0] thread train_move_think(cars[0].trainkilltrigger);
		}

		cars[0] startpath();
		cars[0] showaftertime(0.2);
		cars[0] thread record_positions();
		cars[0] thread watch_end();
		cars[0] playloopsound("amb_train_lp");
		cars[0] setclientfield("train_moving",1);
		cars[0] thread watch_player_touch();
		killcam.starttime = GetTime();
		cars[0].killcament = killcam;
		next = "_b";
		for(i = 1;i < cars.size;i++)
		{
			if(i == 1)
			{
				wait(0.4);
			}
			else
			{
				wait(0.35);
			}

			if(i >= 3 && i % 3 == 0)
			{
				cars[i] playloopsound("amb_train_lp" + next);
				switch(next)
				{
					case "€GSC\r\n":
						next = "_c";
						break;
	
					case "€GSC\r\n":
						next = "_d";
						break;
	
					case "€GSC\r\n":
						next = "";
						break;
	
					default:
						next = "_b";
						break;
				}
			}

			cars[i] thread watch_player_touch();
			if(i == cars.size - 1)
			{
				cars[i] thread car_move();
			}
			else
			{
				cars[i] thread car_move();
			}
		}

		traintiming = getdvarfloatdefault("scr_express_trainTiming2",2);
		entrygate thread waitthenmove(traintiming);
		gateupwait = getdvarfloatdefault("scr_express_gateUpWait",6.5);
		wait(gateupwait);
		exitgate gate_move();
		array_func(gates,::gate_move);
		foreach(gate in gates)
		{
			gate playsound("amb_gate_move");
		}

		wait(6);
	}
}

//Function Number: 4
waitthenmove(time,distance)
{
	wait(time);
	self gate_move(distance);
}

//Function Number: 5
record_positions()
{
	self endon("reached_end_node");
	if(IsDefined(level.train_positions))
	{
		return;
	}

	level.train_positions = [];
	level.train_angles = [];
	for(;;)
	{
		level.train_positions[level.train_positions.size] = self.origin;
		level.train_angles[level.train_angles.size] = self.angles;
		wait(0.05);
	}
}

//Function Number: 6
watch_player_touch()
{
	self endon("end_of_track");
	self endon("delete");
	self endon("death");
	self.disablefinalkillcam = 1;
	for(;;)
	{
		self waittill("touch",entity);
		if(isplayer(entity))
		{
			entity dodamage(entity.health * 2,self.origin + (0,0,1),self,self,0,"MOD_CRUSH");
		}
	}
}

//Function Number: 7
watch_end()
{
	self waittill("reached_end_node");
	self ghost();
	self setclientfield("train_moving",0);
	self stoploopsound(0.2);
	self playsound("amb_train_end");
}

//Function Number: 8
car_move()
{
	self setclientfield("train_moving",1);
	for(i = 0;i < level.train_positions.size;i++)
	{
		self.origin = level.train_positions[i];
		self.angles = level.train_angles[i];
		wait(0.05);
		if(i == 4)
		{
			self show();
		}
	}

	self notify("end_of_track");
	self ghost();
	self setclientfield("train_moving",0);
	self stoploopsound(0.2);
	self playsound("amb_train_end");
}

//Function Number: 9
gate_rotate(yaw)
{
	self rotateyaw(yaw,5);
}

//Function Number: 10
gate_move(z_dist)
{
	if(IsDefined(self.kill_trigger))
	{
		self thread gate_move_think(IsDefined(z_dist));
	}

	if(!(IsDefined(z_dist)))
	{
		self moveto(self.og_origin,5);
	}
	else
	{
		self.og_origin = self.origin;
		self movez(z_dist,5);
	}
}

//Function Number: 11
train_move_think(kill_trigger)
{
	self endon("movedone");
	self endon("reached_end_node");
	for(;;)
	{
		wait(0.05);
		pixbeginevent("train_move_think");
		entities = getdamageableentarray(self.origin,200);
		foreach(entity in entities)
		{
			if(IsDefined(entity.targetname) && entity.targetname == "train")
			{
			}
			else if(isplayer(entity))
			{
			}
			else if(!(entity istouching(kill_trigger)))
			{
			}
			else if(IsDefined(entity.model) && entity.model == "t6_wpn_tac_insert_world")
			{
				entity maps/mp/_tacticalinsertion::destroy_tactical_insertion();
			}
			else if(!(isalive(entity)))
			{
			}
			else if(IsDefined(entity.targetname))
			{
				if(entity.targetname == "talon")
				{
					entity notify("death");
				}
				else if(entity.targetname == "rcbomb")
				{
					entity maps/mp/killstreaks/_rcbomb::rcbomb_force_explode();
				}
				else if(entity.targetname == "riotshield_mp")
				{
					entity dodamage(1,self.origin + (0,0,1),self,self,0,"MOD_CRUSH");
				}
				else if(IsDefined(entity.helitype) && entity.helitype == "qrdrone")
				{
					watcher = entity.owner maps/mp/gametypes/_weaponobjects::getweaponobjectwatcher("qrdrone");
					watcher thread maps/mp/gametypes/_weaponobjects::waitanddetonate(entity,0,undefined);
				}
				else if(entity.classname == "grenade")
				{
					if(!(IsDefined(entity.name)))
					{
					}
					else if(!(IsDefined(entity.owner)))
					{
					}
					else if(entity.name == "proximity_grenade_mp")
					{
						watcher = entity.owner getwatcherforweapon(entity.name);
						watcher thread maps/mp/gametypes/_weaponobjects::waitanddetonate(entity,0,undefined,"script_mover_mp");
					}
					else if(!(isweaponequipment(entity.name)))
					{
					}
					else
					{
						watcher = entity.owner getwatcherforweapon(entity.name);
						if(!(IsDefined(watcher)))
						{
						}
						else
						{
							watcher thread maps/mp/gametypes/_weaponobjects::waitanddetonate(entity,0,undefined,"script_mover_mp");
							if(entity.classname == "auto_turret")
							{
								if(IsDefined(entity.carried) && entity.carried == 1)
								{
								}
								else
								{
									if(!IsDefined(entity.damagedtodeath) || !entity.damagedtodeath)
									{
										entity domaxdamage(self.origin + (0,0,1),self,self,0,"MOD_CRUSH");
									}

									entity dodamage(entity.health * 2,self.origin + (0,0,1),self,self,0,"MOD_CRUSH");
								}
							}
						}
					}
				}
			}
		}

		self destroy_supply_crates();
		if(level.gametype == "ctf")
		{
			foreach(flag in level.flags)
			{
				if(flag.curorigin != flag.trigger.baseorigin && flag.visuals[0] istouching(kill_trigger))
				{
					flag maps/mp/gametypes/ctf::returnflag();
				}
			}
		}
		else if(level.gametype == "sd" && !level.multibomb)
		{
			if(level.sdbomb.visuals[0] istouching(kill_trigger))
			{
				level.sdbomb maps/mp/gametypes/_gameobjects::returnhome();
			}
		}

		pixendevent();
	}
}

//Function Number: 12
gate_move_think(ignoreplayers)
{
	self endon("movedone");
	self.disablefinalkillcam = 1;
	corpse_delay = 0;
	if(IsDefined(self.waittime))
	{
		wait(self.waittime);
	}

	for(;;)
	{
		wait(0.4);
		pixbeginevent("gate_move_think");
		entities = getdamageableentarray(self.origin,100);
		foreach(entity in entities)
		{
			if(ignoreplayers == 1 && isplayer(entity))
			{
			}
			else if(!(entity istouching(self.kill_trigger)))
			{
			}
			else if(IsDefined(entity.model) && entity.model == "t6_wpn_tac_insert_world")
			{
				entity maps/mp/_tacticalinsertion::destroy_tactical_insertion();
			}
			else if(!(isalive(entity)))
			{
			}
			else if(IsDefined(entity.targetname))
			{
				if(entity.targetname == "talon")
				{
					entity notify("death");
				}
				else if(entity.targetname == "rcbomb")
				{
					entity maps/mp/killstreaks/_rcbomb::rcbomb_force_explode();
				}
				else if(entity.targetname == "riotshield_mp")
				{
					entity dodamage(1,self.origin + (0,0,1),self,self,0,"MOD_CRUSH");
				}
				else if(IsDefined(entity.helitype) && entity.helitype == "qrdrone")
				{
					watcher = entity.owner maps/mp/gametypes/_weaponobjects::getweaponobjectwatcher("qrdrone");
					watcher thread maps/mp/gametypes/_weaponobjects::waitanddetonate(entity,0,undefined);
				}
				else if(entity.classname == "grenade")
				{
					if(!(IsDefined(entity.name)))
					{
					}
					else if(!(IsDefined(entity.owner)))
					{
					}
					else if(entity.name == "proximity_grenade_mp")
					{
						watcher = entity.owner getwatcherforweapon(entity.name);
						watcher thread maps/mp/gametypes/_weaponobjects::waitanddetonate(entity,0,undefined,"script_mover_mp");
					}
					else if(!(isweaponequipment(entity.name)))
					{
					}
					else
					{
						watcher = entity.owner getwatcherforweapon(entity.name);
						if(!(IsDefined(watcher)))
						{
						}
						else
						{
							watcher thread maps/mp/gametypes/_weaponobjects::waitanddetonate(entity,0,undefined,"script_mover_mp");
							if(entity.classname == "auto_turret")
							{
								if(IsDefined(entity.carried) && entity.carried == 1)
								{
								}
								else
								{
									if(!IsDefined(entity.damagedtodeath) || !entity.damagedtodeath)
									{
										entity domaxdamage(self.origin + (0,0,1),self,self,0,"MOD_CRUSH");
									}

									entity dodamage(entity.health * 2,self.origin + (0,0,1),self,self,0,"MOD_CRUSH");
								}
							}
						}
					}
				}
			}
		}

		self destroy_supply_crates();
		if(GetTime() > corpse_delay)
		{
			self destroy_corpses();
		}

		if(level.gametype == "ctf")
		{
			foreach(flag in level.flags)
			{
				if(flag.visuals[0] istouching(self.kill_trigger))
				{
					flag maps/mp/gametypes/ctf::returnflag();
				}
			}
		}
		else if(level.gametype == "sd" && !level.multibomb)
		{
			if(level.sdbomb.visuals[0] istouching(self.kill_trigger))
			{
				level.sdbomb maps/mp/gametypes/_gameobjects::returnhome();
			}
		}

		pixendevent();
	}
}

//Function Number: 13
getwatcherforweapon(weapname)
{
	if(!(IsDefined(self)))
	{
		return undefined;
	}

	if(!(isplayer(self)))
	{
		return undefined;
	}

	for(i = 0;i < self.weaponobjectwatcherarray.size;i++)
	{
		if(self.weaponobjectwatcherarray[i].weapon != weapname)
		{
		}
		else
		{
			return self.weaponobjectwatcherarray[i];
		}
	}

	return undefined;
}

//Function Number: 14
destroy_supply_crates()
{
	crates = getentarray("care_package","script_noteworthy");
	foreach(crate in crates)
	{
		if(distancesquared(crate.origin,self.origin) < 10000)
		{
			if(crate istouching(self))
			{
				playfx(level._supply_drop_explosion_fx,crate.origin);
				playsoundatposition("wpn_grenade_explode",crate.origin);
				wait(0.1);
				crate maps/mp/killstreaks/_supplydrop::cratedelete();
			}
		}
	}
}

//Function Number: 15
destroy_corpses()
{
	corpses = getcorpsearray();
	for(i = 0;i < corpses.size;i++)
	{
		if(distancesquared(corpses[i].origin,self.origin) < 10000)
		{
			corpses[i] delete();
		}
	}
}