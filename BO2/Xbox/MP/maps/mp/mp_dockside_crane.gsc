/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_dockside_crane.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 28
 * Decompile Time: 386 ms
 * Timestamp: 10/27/2023 3:05:21 AM
*******************************************************************/

#include common_scripts/utility;
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
	precachemodel("p6_dockside_container_lrg_white");
	crane_dvar_init();
	level.crate_models = [];
	level.crate_models[0] = "p6_dockside_container_lrg_red";
	level.crate_models[1] = "p6_dockside_container_lrg_blue";
	level.crate_models[2] = "p6_dockside_container_lrg_white";
	level.crate_models[3] = "p6_dockside_container_lrg_orange";
	claw = getent("claw_base","targetname");
	claw.z_upper = claw.origin[2];
	claw thread sound_wires_move();
	arms_y = getentarray("claw_arm_y","targetname");
	arms_z = getentarray("claw_arm_z","targetname");
	claw.arms = arraycombine(arms_y,arms_z,1,0);
	foreach(arm_z in arms_z)
	{
		arm_y = getclosest(arm_z.origin,arms_y);
		arm_z.parent = arm_y;
	}

	foreach(arm_y in arms_y)
	{
		arm_y.parent = claw;
	}

	claw claw_link_arms("claw_arm_y");
	claw claw_link_arms("claw_arm_z");
	crates = getentarray("crate","targetname");
	array_thread(crates,::sound_pit_move);
	crate_data = [];
	for(i = 0;i < crates.size;i++)
	{
		crates[i] disconnectpaths();
		data = spawnstruct();
		data.origin = crates[i].origin;
		data.angles = crates[i].angles;
		crate_data[i] = data;
	}

	rail = getent("crane_rail","targetname");
	rail thread sound_ring_move();
	rail.roller = getent("crane_roller","targetname");
	rail.roller.wheel = getent("crane_wheel","targetname");
	claw.wires = getentarray("crane_wire","targetname");
	claw.z_wire_max = rail.roller.wheel.origin[2] - 50;
	foreach(wire in claw.wires)
	{
		wire linkto(claw);
		if(wire.origin[2] > claw.z_wire_max)
		{
			wire ghost();
		}
	}

	placements = getentarray("crate_placement","targetname");
	foreach(placement in placements)
	{
		placement.angles = 90 + VectorScale((0,1,0));
		crates[crates.size] = spawn("script_model",placement.origin);
	}

	triggers = getentarray("crate_kill_trigger","targetname");
	foreach(crate in crates)
	{
		crate.kill_trigger = getclosest(crate.origin,triggers);
		crate.kill_trigger.origin = 5 - VectorScale((0,0,1));
		crate.kill_trigger enablelinkto();
		crate.kill_trigger linkto(crate);
		if(crate.model != "")
		{
			crate.kill_trigger.active = 1;
		}
		else
		{
			crate.kill_trigger.active = 0;
		}
	}

	trigger = getclosest(claw.origin,triggers);
	trigger enablelinkto();
	trigger linkto(claw);
	trigger.active = 1;
	placements = array_randomize(placements);
	level thread crane_think(claw,rail,crates,crate_data,placements);
}

//Function Number: 2
crane_dvar_init()
{
	set_dvar_float_if_unset("scr_crane_claw_move_time","5");
	set_dvar_float_if_unset("scr_crane_crate_lower_time","5");
	set_dvar_float_if_unset("scr_crane_crate_raise_time","5");
	set_dvar_float_if_unset("scr_crane_arm_y_move_time","3");
	set_dvar_float_if_unset("scr_crane_arm_z_move_time","3");
	set_dvar_float_if_unset("scr_crane_claw_drop_speed","25");
	set_dvar_float_if_unset("scr_crane_claw_drop_time_min","5");
}

//Function Number: 3
wire_render()
{
	self endon("movedone");
	for(;;)
	{
		wait(0.05);
		foreach(wire in self.wires)
		{
			if(wire.origin[2] > self.z_wire_max)
			{
				wire ghost();
			}
			else
			{
				wire show();
			}
		}
	}
}

//Function Number: 4
crane_think(claw,rail,crates,crate_data,placements)
{
	wait(1);
	claw arms_open();
	for(;;)
	{
		for(i = 0;i < crates.size - placements.size;i++)
		{
			crate = getclosest(crate_data[i].origin,crates);
			rail crane_move(claw,crate_data[i],-318);
			level notify("wires_move");
			claw claw_crate_grab(crate,318);
			lower = 1;
			target = i + 1 % crates.size - placements.size;
			target_crate = getclosest(crate_data[target].origin,crates);
			if(cointoss())
			{
				for(placement_index = 0;placement_index < placements.size;placement_index++)
				{
					placement = placements[placement_index];
					if(!(IsDefined(placement.crate)))
					{
						lower = 0;
						break;
					}
				}
			}

			if(!(lower))
			{
				z_dist = crate.origin[2] - placement.origin[2] - 33;
				rail crane_move(claw,placement,z_dist * -1);
				level notify("wires_move");
				placement.crate = crate;
			}
			else
			{
				rail crane_move(claw,crate_data[target],-181);
				level notify("wires_move");
			}

			claw claw_crate_move(crate);
			if(lower)
			{
				crate crate_lower(target_crate,crate_data[target]);
			}

			crate = target_crate;
			target = i + 2 % crates.size - placements.size;
			target_crate = getclosest(crate_data[target].origin,crates);
			if(!(lower))
			{
				crate = crates[3 + placement_index];
				crate.origin = 137 - VectorScale((0,0,1));
				crate.angles = target_crate.angles;
				wait(0.25);
				claw waittill(target_crate.origin,"movedone");
			}

			crate crate_raise(target_crate,crate_data[target]);
			rail crane_move(claw,crate_data[target],-181);
			level notify("wires_move");
			claw claw_crate_grab(target_crate,181);
			crate = target_crate;
			target = i + 3 % crates.size - placements.size;
			rail crane_move(claw,crate_data[target],-318);
			level notify("wires_move");
			claw claw_crate_drop(crate,crate_data[target]);
		}
	}
}

//Function Number: 5
crane_move(claw,desired,z_dist)
{
	self.roller linkto(self);
	self.roller.wheel linkto(self.roller);
	claw linkto(self.roller.wheel);
	goal = (desired.origin[0],desired.origin[1],self.origin[2]);
	dir = vectornormalize(goal - self.origin);
	angles = VectorToAngles(dir);
	angles = (self.angles[0],angles[1] + 90,self.angles[2]);
	yawdiff = absangleclamp360(self.angles[1] - angles[1]);
	time = yawdiff / 25;
	self rotateto(angles,time,time * 0.35,time * 0.45);
	self thread physics_move();
	level notify("wires_stop");
	level notify("ring_move");
	self waittill("rotatedone");
	self.roller unlink();
	goal = (desired.origin[0],desired.origin[1],self.roller.origin[2]);
	diff = distance2d(goal,self.roller.origin);
	speed = GetDvarFloat(#"C39D2ABF");
	time = diff / speed;
	if(time < GetDvarFloat(#"F60036C0"))
	{
		time = GetDvarFloat(#"F60036C0");
	}

	self.roller moveto(goal,time,time * 0.25,time * 0.25);
	self.roller thread physics_move();
	goal = (desired.origin[0],desired.origin[1],self.roller.wheel.origin[2]);
	self.roller.wheel unlink();
	self.roller.wheel moveto(goal,time,time * 0.25,time * 0.25);
	self.roller.wheel rotateto(90 + VectorScale((0,1,0)),desired.angles,time,time * 0.25);
	claw.z_initial = claw.origin[2];
	claw unlink();
	claw rotateto(desired.angles,time,time * 0.25,time * 0.25);
	claw.goal = (goal[0],goal[1],claw.origin[2] + z_dist);
	claw.time = time;
	claw moveto(claw.goal,time,time * 0.25,time * 0.25);
	level notify("ring_stop",time * 0.25);
}

//Function Number: 6
physics_move()
{
	self endon("rotatedone");
	self endon("movedone");
	for(;;)
	{
		wait(0.05);
		crates = getentarray("care_package","script_noteworthy");
		foreach(crate in crates)
		{
			if(crate istouching(self))
			{
				crate physicslaunch(crate.origin,(0,0,0));
			}
		}
	}
}

//Function Number: 7
claw_crate_grab(crate,z_dist)
{
	self thread wire_render();
	self waittill("movedone");
	level notify("wires_stop");
	self playsound("amb_crane_arms_b");
	self claw_z_arms(-33);
	self playsound("amb_crane_arms");
	self arms_close(crate);
	crate movez(33,GetDvarFloat(#"92CC26F1"));
	self claw_z_arms(33);
	crate linkto(self);
	self movez(z_dist,GetDvarFloat(#"33ED9F5F"));
	self thread wire_render();
	level notify("wires_move");
	self waittill("movedone");
	self playsound("amb_crane_arms");
}

//Function Number: 8
sound_wires_move()
{
	while(1)
	{
		level waittill("wires_move");
		self playsound("amb_crane_wire_start");
		self playloopsound("amb_crane_wire_lp");
		level waittill("wires_stop");
		self playsound("amb_crane_wire_end");
		wait(0.1);
		self stoploopsound(0.2);
	}
}

//Function Number: 9
sound_ring_move()
{
	while(1)
	{
		level waittill("ring_move");
		self playsound("amb_crane_ring_start");
		self playloopsound("amb_crane_ring_lp");
		level waittill("ring_stop");
		self playsound("amb_crane_ring_end");
		wait(0.1);
		self stoploopsound(0.2);
	}
}

//Function Number: 10
sound_pit_move()
{
	while(1)
	{
		level waittill("pit_move");
		self playsound("amb_crane_pit_start");
		self playloopsound("amb_crane_pit_lp");
		level waittill("pit_stop");
		self playsound("amb_crane_pit_end");
		self stoploopsound(0.2);
		wait(0.2);
	}
}

//Function Number: 11
claw_crate_move(crate,claw)
{
	self thread wire_render();
	self waittill("movedone");
	crate unlink();
	self playsound("amb_crane_arms_b");
	level notify("wires_stop");
	crate movez(-33,GetDvarFloat(#"92CC26F1"));
	self claw_z_arms(-33);
	self playsound("amb_crane_arms_b");
	playfxontag(level._effect["crane_dust"],crate,"tag_origin");
	crate playsound("amb_crate_drop");
	self arms_open();
	level notify("wires_move");
	self claw_z_arms(33);
	z_dist = self.z_initial - self.origin[2];
	self movez(z_dist,GetDvarFloat(#"33ED9F5F"));
	self thread wire_render();
}

//Function Number: 12
claw_crate_drop(target,data)
{
	target thread crate_drop_think(self);
	self thread wire_render();
	self waittill("claw_movedone");
	target unlink();
	level notify("wires_stop");
	self playsound("amb_crane_arms_b");
	target movez(-33,GetDvarFloat(#"92CC26F1"));
	self claw_z_arms(-33);
	playfxontag(level._effect["crane_dust"],target,"tag_origin");
	self playsound("amb_crate_drop");
	target notify("claw_done");
	self playsound("amb_crane_arms");
	self arms_open();
	level notify("wires_move");
	target.origin = data.origin;
	self claw_z_arms(33);
	self playsound("amb_crane_arms");
	self movez(318,GetDvarFloat(#"33ED9F5F"));
	self thread wire_render();
	self waittill("movedone");
}

//Function Number: 13
crate_lower(lower,data)
{
	z_dist = Abs(self.origin[2] - lower.origin[2]);
	self movez(z_dist * -1,GetDvarFloat(#"CFA0F999"));
	lower movez(z_dist * -1,GetDvarFloat(#"CFA0F999"));
	level notify("pit_move");
	lower waittill("movedone");
	level notify("pit_stop");
	lower ghost();
	self.origin = data.origin;
	wait(0.25);
}

//Function Number: 14
crate_raise(upper,data)
{
	self crate_set_random_model(upper);
	self.kill_trigger.active = 1;
	self.origin = (data.origin[0],data.origin[1],self.origin[2]);
	self.angles = data.angles;
	wait(0.2);
	self show();
	z_dist = Abs(upper.origin[2] - self.origin[2]);
	self movez(z_dist,GetDvarFloat(#"B4D4D064"));
	upper movez(z_dist,GetDvarFloat(#"B4D4D064"));
	level notify("wires_stop");
	level notify("pit_move");
	upper thread raise_think();
}

//Function Number: 15
raise_think()
{
	self waittill("movedone");
	level notify("pit_stop");
}

//Function Number: 16
crate_set_random_model(other)
{
	models = array_randomize(level.crate_models);
	foreach(model in models)
	{
		if(model == other.model)
		{
		}
		else
		{
			self setmodel(model);
			return;
		}
	}
}

//Function Number: 17
arms_open()
{
	self claw_move_arms(-15);
	self playsound("amb_crane_arms");
}

//Function Number: 18
arms_close(crate)
{
	self claw_move_arms(15,crate);
	self playsound("amb_crane_arms");
}

//Function Number: 19
claw_link_arms(name)
{
	foreach(arm in self.arms)
	{
		if(arm.targetname == name)
		{
			arm linkto(arm.parent);
		}
	}
}

//Function Number: 20
claw_unlink_arms(name)
{
	foreach(arm in self.arms)
	{
		if(arm.targetname == name)
		{
			arm unlink();
		}
	}
}

//Function Number: 21
claw_move_arms(dist,crate)
{
	claw_unlink_arms("claw_arm_y");
	arms = [];
	foreach(arm in self.arms)
	{
		forward = AnglesToForward(arm.angles);
		arm.goal = dist + VectorScale(forward);
		if(arm.targetname == "claw_arm_y")
		{
			arms[arms.size] = arm;
			arm moveto(arm.goal,GetDvarFloat(#"D6F71B0"));
		}
	}

	if(dist > 0)
	{
		wait(GetDvarFloat(#"D6F71B0") / 2);
		foreach(arm in self.arms)
		{
			if(arm.targetname == "claw_arm_y")
			{
				arm moveto(arm.goal,0.1);
				self playsound("amb_crane_arms_b");
			}
		}

		wait(0.05);
		playfxontag(level._effect["crane_spark"],crate,"tag_origin");
		self playsound("amb_arms_latch");
	}

/#
	assert(arms.size == 4);
#/
	waittill_multiple_ents(arms[0],"movedone",arms[1],"movedone",arms[2],"movedone",arms[3],"movedone");
	foreach(arm in self.arms)
	{
		arm.origin = arm.goal;
	}

	self claw_link_arms("claw_arm_y");
}

//Function Number: 22
claw_z_arms(z)
{
	claw_unlink_arms("claw_arm_z");
	arms = [];
	foreach(arm in self.arms)
	{
		if(arm.targetname == "claw_arm_z")
		{
			arms[arms.size] = arm;
			arm movez(z,GetDvarFloat(#"92CC26F1"));
		}
	}

/#
	assert(arms.size == 4);
#/
	waittill_multiple_ents(arms[0],"movedone",arms[1],"movedone",arms[2],"movedone",arms[3],"movedone");
	self claw_link_arms("claw_arm_z");
}

//Function Number: 23
crate_drop_think(claw)
{
	self endon("claw_done");
	self.disablefinalkillcam = 1;
	claw thread claw_drop_think();
	corpse_delay = 0;
	for(;;)
	{
		wait(0.2);
		entities = getdamageableentarray(self.origin,200);
		foreach(entity in entities)
		{
			if(!(entity istouching(self.kill_trigger)))
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
								if(!IsDefined(entity.damagedtodeath) || !entity.damagedtodeath)
								{
									entity domaxdamage(self.origin + (0,0,1),self,self,0,"MOD_CRUSH");
								}
							}
							else
							{
								entity dodamage(entity.health * 2,self.origin + (0,0,1),self,self,0,"MOD_CRUSH");
								if(isplayer(entity))
								{
									claw thread claw_drop_pause();
									corpse_delay = GetTime() + 3000;
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

			continue;
		}

		if(level.gametype == "sd" && !level.multibomb)
		{
			if(level.sdbomb.visuals[0] istouching(self.kill_trigger))
			{
				level.sdbomb maps/mp/gametypes/_gameobjects::returnhome();
			}
		}
	}
}

//Function Number: 24
claw_drop_think()
{
	self endon("claw_pause");
	self waittill("movedone");
	self notify("claw_movedone");
}

//Function Number: 25
claw_drop_pause()
{
	self notify("claw_pause");
	self endon("claw_pause");
	z_diff = Abs(self.goal[2] - self.origin[2]);
	frac = z_diff / 318;
	time = self.time * frac;
	if(time <= 0)
	{
		return;
	}

	self moveto(self.origin,0.01);
	wait(3);
	self thread claw_drop_think();
	self moveto(self.goal,time);
}

//Function Number: 26
destroy_supply_crates()
{
	crates = getentarray("care_package","script_noteworthy");
	foreach(crate in crates)
	{
		if(distancesquared(crate.origin,self.origin) < 40000)
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

//Function Number: 27
destroy_corpses()
{
	corpses = getcorpsearray();
	for(i = 0;i < corpses.size;i++)
	{
		if(distancesquared(corpses[i].origin,self.origin) < 40000)
		{
			corpses[i] delete();
		}
	}
}

//Function Number: 28
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