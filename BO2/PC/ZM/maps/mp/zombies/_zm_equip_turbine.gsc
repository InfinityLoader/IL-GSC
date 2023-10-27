/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_equip_turbine.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 73 ms
 * Timestamp: 10/27/2023 3:03:05 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/gametypes_zm/_weaponobjects;
#include maps/mp/zombies/_zm_buildables;
#include maps/mp/zombies/_zm_equipment;
#include maps/mp/zombies/_zm_power;
#include maps/mp/zombies/_zm_unitrigger;
#include maps/mp/zombies/_zm_utility;

#using_animtree( "zombie_turbine" );

//Function Number: 1
init(hint,howto)
{
	if(!(IsDefined(hint)))
	{
		hint = &"ZOMBIE_EQUIP_TURBINE_PICKUP_HINT_STRING";
	}

	if(!(IsDefined(howto)))
	{
		howto = &"ZOMBIE_EQUIP_TURBINE_HOWTO";
	}

	if(!(maps/mp/zombies/_zm_equipment::is_equipment_included("equip_turbine_zm")))
	{
		return;
	}

	level.turbine_name = "equip_turbine_zm";
	maps/mp/zombies/_zm_equipment::register_equipment("equip_turbine_zm",hint,howto,"turbine_zm_icon","turbine",undefined,::transferturbine,::dropturbine,::pickupturbine,::placeturbine);
	maps/mp/zombies/_zm_equipment::add_placeable_equipment("equip_turbine_zm","p6_anim_zm_buildable_turbine",::destroy_placed_turbine);
	level thread onplayerconnect();
	maps/mp/gametypes_zm/_weaponobjects::createretrievablehint("equip_turbine",hint);
	level._effect["turbine_on"] = loadfx("maps/zombie/fx_zmb_tranzit_wind_turbine_on");
	level._effect["turbine_med"] = loadfx("maps/zombie/fx_zmb_tranzit_wind_turbine_med");
	level._effect["turbine_low"] = loadfx("maps/zombie/fx_zmb_tranzit_wind_turbine_low");
	level._effect["turbine_aoe"] = loadfx("maps/zombie/fx_zmb_tranzit_wind_turbine_aoe");
	level._turbine_disappear_fx = loadfx("maps/zombie/fx_zmb_tranzit_turbine_explo");
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connecting",player);
		player thread onplayerspawned();
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	self thread setupwatchers();
	for(;;)
	{
		self waittill("spawned_player");
		self thread watchturbineuse();
	}
}

//Function Number: 4
setupwatchers()
{
	self waittill("weapon_watchers_created");
	watcher = maps/mp/gametypes_zm/_weaponobjects::getweaponobjectwatcher("equip_turbine");
	watcher.onspawnretrievetriggers = maps/mp/zombies/_zm_equipment::equipment_onspawnretrievableweaponobject;
}

//Function Number: 5
watchturbineuse()
{
	self notify("watchTurbineUse");
	self endon("watchTurbineUse");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("equipment_placed",weapon,weapname);
		if(weapname == level.turbine_name)
		{
			self cleanupoldturbine();
			self.buildableturbine = weapon;
			self thread startturbinedeploy(weapon);
			level notify("turbine_deployed");
		}
	}
}

//Function Number: 6
cleanupoldturbine(preserve_state)
{
	if(IsDefined(self.localpower))
	{
		maps/mp/zombies/_zm_power::end_local_power(self.localpower);
		self notify("depower_on_disconnect");
		self.localpower = undefined;
		self.turbine_power_is_on = 0;
	}

	self.turbine_is_powering_on = 0;
	if(IsDefined(self.buildableturbine))
	{
		if(IsDefined(self.buildableturbine.stub))
		{
			thread maps/mp/zombies/_zm_unitrigger::unregister_unitrigger(self.buildableturbine.stub);
			self.buildableturbine.stub = undefined;
		}

		self.buildableturbine stoploopsound();
		self.buildableturbine delete();
		if(!(IsDefined(preserve_state) && preserve_state))
		{
			self.turbine_health = undefined;
			self.turbine_emped = undefined;
			self.turbine_emp_time = undefined;
		}
	}
}

//Function Number: 7
watchforcleanup()
{
	self notify("turbine_cleanup");
	self endon("turbine_cleanup");
	evt = self waittill_any_return("death_or_disconnect","equip_turbine_zm_taken","equip_turbine_zm_pickup");
	if(IsDefined(self))
	{
		self cleanupoldturbine(evt == "equip_turbine_zm_pickup");
	}
}

//Function Number: 8
depower_on_disconnect(localpower)
{
	self notify("depower_on_disconnect");
	self endon("depower_on_disconnect");
	self waittill("disconnect");
	if(IsDefined(localpower))
	{
		maps/mp/zombies/_zm_power::end_local_power(localpower);
	}
}

//Function Number: 9
placeturbine(origin,angles)
{
	item = self maps/mp/zombies/_zm_equipment::placed_equipment_think("p6_anim_zm_buildable_turbine","equip_turbine_zm",origin,angles);
	return item;
}

//Function Number: 10
dropturbine()
{
	item = thread maps/mp/zombies/_zm_equipment::dropped_equipment_think("p6_anim_zm_buildable_turbine","equip_turbine_zm",self.origin,self.angles);
	if(IsDefined(item))
	{
		item.turbine_power_on = self.turbine_power_on;
		item.turbine_power_level = self.turbine_power_level;
		item.turbine_round_start = self.turbine_round_start;
		item.turbine_health = self.turbine_health;
		item.turbine_emped = self.turbine_emped;
		item.turbine_emp_time = self.turbine_emp_time;
	}

	self.turbine_is_powering_on = undefined;
	self.turbine_power_on = undefined;
	self.turbine_power_level = undefined;
	self.turbine_round_start = undefined;
	self.turbine_health = undefined;
	self.turbine_emped = undefined;
	self.turbine_emp_time = undefined;
	return item;
}

//Function Number: 11
pickupturbine(item)
{
	item.owner = self;
	self.turbine_power_on = item.turbine_power_on;
	item.turbine_power_on = undefined;
	self.turbine_power_level = item.turbine_power_level;
	self.turbine_round_start = item.turbine_round_start;
	self.turbine_health = item.turbine_health;
	item.turbine_health = undefined;
	item.turbine_power_level = undefined;
	item.turbine_round_start = undefined;
	self.turbine_emped = item.turbine_emped;
	self.turbine_emp_time = item.turbine_emp_time;
	item.turbine_emped = undefined;
	item.turbine_emp_time = undefined;
	self.turbine_is_powering_on = undefined;
}

//Function Number: 12
transferturbine(fromplayer,toplayer)
{
	while((IsDefined(toplayer.turbine_is_powering_on) && toplayer.turbine_is_powering_on) || IsDefined(fromplayer.turbine_is_powering_on) && fromplayer.turbine_is_powering_on)
	{
		wait(0.05);
	}

	if(IsDefined(fromplayer.buildableturbine) && IsDefined(fromplayer.buildableturbine.dying) && fromplayer.buildableturbine.dying)
	{
		fromplayer cleanupoldturbine(0);
	}

	if(IsDefined(toplayer.buildableturbine) && IsDefined(toplayer.buildableturbine.dying) && toplayer.buildableturbine.dying)
	{
		toplayer cleanupoldturbine(0);
	}

	buildableturbine = toplayer.buildableturbine;
	localpower = toplayer.localpower;
	turbine_power_on = toplayer.turbine_power_on;
	turbine_power_is_on = toplayer.turbine_power_is_on;
	turbine_power_level = toplayer.turbine_power_level;
	turbine_round_start = toplayer.turbine_round_start;
	turbine_health = toplayer.turbine_health;
	turbine_emped = toplayer.turbine_emped;
	turbine_emp_time = toplayer.turbine_emp_time;
	toplayer.buildableturbine = fromplayer.buildableturbine;
	fromplayer.buildableturbine = buildableturbine;
	toplayer.localpower = fromplayer.localpower;
	fromplayer.localpower = localpower;
	toplayer.turbine_power_on = fromplayer.turbine_power_on;
	fromplayer.turbine_power_on = turbine_power_on;
	toplayer.turbine_power_is_on = fromplayer.turbine_power_is_on;
	fromplayer.turbine_power_is_on = turbine_power_is_on;
	toplayer.turbine_power_level = fromplayer.turbine_power_level;
	toplayer.turbine_round_start = fromplayer.turbine_round_start;
	fromplayer.turbine_power_level = turbine_power_level;
	fromplayer.turbine_round_start = turbine_round_start;
	toplayer.turbine_health = fromplayer.turbine_health;
	fromplayer.turbine_health = turbine_health;
	toplayer.turbine_emped = fromplayer.turbine_emped;
	fromplayer.turbine_emped = turbine_emped;
	toplayer.turbine_emp_time = fromplayer.turbine_emp_time;
	fromplayer.turbine_emp_time = turbine_emp_time;
	toplayer.turbine_is_powering_on = undefined;
	fromplayer.turbine_is_powering_on = undefined;
	toplayer notify("equip_turbine_zm_taken");
	toplayer.buildableturbine.original_owner = toplayer;
	toplayer thread startturbinedeploy(toplayer.buildableturbine);
	fromplayer notify("equip_turbine_zm_taken");
	if(IsDefined(fromplayer.buildableturbine))
	{
		fromplayer thread startturbinedeploy(fromplayer.buildableturbine);
		fromplayer.buildableturbine.original_owner = fromplayer;
		fromplayer.buildableturbine.owner = fromplayer;
	}
	else
	{
		fromplayer maps/mp/zombies/_zm_equipment::equipment_release("equip_turbine_zm");
	}
}

//Function Number: 13
startturbinedeploy(weapon)
{
	self endon("death");
	self endon("disconnect");
	self endon("equip_turbine_zm_taken");
	self thread watchforcleanup();
	origin = weapon.origin;
	powerradius = 335;
	if(!(IsDefined(self.turbine_health)))
	{
		self.turbine_health = 1200;
		self.turbine_power_level = 4;
		self.turbine_power_on = 1;
		self.turbine_is_powering_on = undefined;
	}

	if(!(IsDefined(self.turbine_round_start)))
	{
		self.turbine_round_start = level.round_number;
		self.turbine_power_on = 1;
	}

	self thread turbinedecay();
	self thread turbinepowerdiminish(origin,powerradius);
	if(IsDefined(weapon))
	{
/#
		self thread debugturbine(powerradius);
#/
		self thread turbineaudio();
		self thread turbineanim();
		self thread turbinepowerthink(weapon,powerradius);
		if(IsDefined(weapon.equipment_can_move) && weapon.equipment_can_move)
		{
			self thread turbinepowermove(weapon);
		}

		self thread maps/mp/zombies/_zm_buildables::delete_on_disconnect(weapon);
		weapon waittill("death");
		self thread turbinepoweroff(origin,powerradius);
		self notify("turbine_cleanup");
	}
}

//Function Number: 14
turbine_watch_for_emp(weapon,powerradius)
{
	self endon("death");
	self endon("disconnect");
	self endon("equip_turbine_zm_taken");
	self.buildableturbine endon("death");
	if(!(should_watch_for_emp()))
	{
		return;
	}

	while(1)
	{
		level waittill("emp_detonate",origin,radius);
		if(distancesquared(origin,self.buildableturbine.origin) < radius * radius)
		{
			break;
		}
	}

	self.turbine_emped = 1;
	self.turbine_emp_time = GetTime();
	self notify("turbine_power_change");
}

//Function Number: 15
turbinepowerthink(weapon,powerradius)
{
	self endon("death");
	self endon("disconnect");
	self endon("equip_turbine_zm_taken");
	self.buildableturbine endon("death");
	origin = weapon.origin;
	self thread turbine_watch_for_emp(weapon,powerradius);
	if((IsDefined(self.turbine_power_on) && self.turbine_power_on) || IsDefined(self.turbine_emped) && self.turbine_emped)
	{
		self thread turbinepoweron(origin,powerradius);
	}

	while(IsDefined(self.buildableturbine))
	{
		self waittill("turbine_power_change");
		if(IsDefined(self.turbine_emped) && self.turbine_emped)
		{
			self thread turbinepoweroff(origin,powerradius);
			if(IsDefined(weapon))
			{
				origin = weapon.origin;
			}

			self thread turbinepoweron(origin,powerradius);
			continue;
		}

		if(!(IsDefined(self.turbine_power_is_on) && self.turbine_power_is_on))
		{
			self thread turbinepoweroff(origin,powerradius);
			continue;
		}

		if(IsDefined(weapon))
		{
			origin = weapon.origin;
		}

		self thread turbinepoweron(origin,powerradius);
	}
}

//Function Number: 16
turbinepowermove(weapon)
{
	self endon("death");
	self endon("disconnect");
	self endon("equip_turbine_zm_taken");
	self.buildableturbine endon("death");
	origin = weapon.origin;
	while(1)
	{
		if(origin != weapon.origin)
		{
			if(IsDefined(self.localpower))
			{
				self.localpower = maps/mp/zombies/_zm_power::move_local_power(self.localpower,origin);
			}

			origin = weapon.origin;
		}

		wait(0.5);
	}
}

//Function Number: 17
turbinewarmup()
{
	if(IsDefined(self.turbine_emped) && self.turbine_emped)
	{
		emp_time = level.zombie_vars["emp_perk_off_time"];
		now = GetTime();
		emp_time_left = emp_time - now - self.turbine_emp_time / 1000;
		if(emp_time_left > 0)
		{
			wait(emp_time_left);
		}

		self.turbine_emped = undefined;
		self.turbine_emp_time = undefined;
	}

	self.buildableturbine maps/mp/zombies/_zm_equipment::signal_equipment_activated(3);
	wait(0.5);
	self.buildableturbine maps/mp/zombies/_zm_equipment::signal_equipment_activated(2);
	wait(0.5);
	self.buildableturbine maps/mp/zombies/_zm_equipment::signal_equipment_activated(1);
	wait(0.5);
}

//Function Number: 18
turbinepoweron(origin,powerradius)
{
	self endon("death");
	self endon("disconnect");
	self endon("equip_turbine_zm_taken");
	self.buildableturbine endon("death");
	if(!IsDefined(self.turbine_power_is_on) && self.turbine_power_is_on && !IsDefined(self.turbine_is_powering_on) && self.turbine_is_powering_on && !IsDefined(self.buildableturbine.dying) && self.buildableturbine.dying)
	{
		self.turbine_is_powering_on = 1;
		self.buildableturbine playloopsound("zmb_turbine_loop",2);
		self turbinewarmup();
		if(IsDefined(self.localpower))
		{
			maps/mp/zombies/_zm_power::end_local_power(self.localpower);
		}

		self.localpower = undefined;
		self.turbine_power_is_on = 0;
		if(!(IsDefined(self.turbine_emped) && self.turbine_emped))
		{
			self.localpower = maps/mp/zombies/_zm_power::add_local_power(origin,powerradius);
			self thread depower_on_disconnect(self.localpower);
			self.turbine_power_is_on = 1;
			self thread turbineaudio();
		}

		self.turbine_is_powering_on = 0;
		self thread turbinefx();
		self thread turbinedecay();
	}
}

//Function Number: 19
turbinepoweroff(origin,powerradius)
{
	if(IsDefined(self.turbine_power_is_on) && self.turbine_power_is_on)
	{
		if(IsDefined(self.localpower))
		{
			maps/mp/zombies/_zm_power::end_local_power(self.localpower);
		}

		self notify("depower_on_disconnect");
		self.localpower = undefined;
		self.turbine_power_is_on = 0;
		self thread turbineaudio();
		if(!(IsDefined(self.buildableturbine.dying) && self.buildableturbine.dying))
		{
			self thread turbineanim();
		}
	}
}

//Function Number: 20
turbine_disappear_fx(origin,waittime)
{
	if(IsDefined(waittime) && waittime > 0)
	{
		wait(waittime);
	}

	playfx(level._turbine_disappear_fx,origin);
	if(IsDefined(self.buildableturbine))
	{
		playsoundatposition("zmb_turbine_explo",self.buildableturbine.origin);
	}
}

//Function Number: 21
turbinefxonce(withaoe)
{
	if(IsDefined(self) && IsDefined(self.buildableturbine) && IsDefined(self.turbine_power_is_on) && self.turbine_power_is_on)
	{
		value = 0;
		switch(self.turbine_power_level)
		{
			case "3":
			case "4":
				value = 1;
				break;

			case "2":
				value = 2;
				break;

			case "1":
				value = 3;
				break;
		}

		if(withaoe)
		{
			if(IsDefined(self.buildableturbine.equipment_can_move) && self.buildableturbine.equipment_can_move && IsDefined(self.buildableturbine.move_parent.ismoving) && self.buildableturbine.move_parent.ismoving)
			{
				value = value | 4;
			}
			else
			{
				value = value | 8;
			}
		}

		if(value && IsDefined(self.buildableturbine) && IsDefined(self.turbine_power_is_on) && self.turbine_power_is_on)
		{
			self.buildableturbine thread maps/mp/zombies/_zm_equipment::signal_equipment_activated(value);
		}
	}
}

//Function Number: 22
turbinefx()
{
	self endon("disconnect");
	self endon("equip_turbine_zm_taken");
	while(IsDefined(self) && IsDefined(self.buildableturbine) && IsDefined(self.turbine_power_is_on) && self.turbine_power_is_on)
	{
		self turbinefxonce(1);
		wait(0.5);
		self turbinefxonce(0);
		wait(0.5);
	}
}

//Function Number: 23
turbineaudio()
{
	if(!(IsDefined(self.buildableturbine)))
	{
		return;
	}

	if(!IsDefined(self.turbine_power_is_on) && self.turbine_power_is_on || IsDefined(self.turbine_emped) && self.turbine_emped)
	{
		self.buildableturbine stoploopsound();
		return;
	}

	self.buildableturbine playloopsound("zmb_turbine_loop",2);
}

//Function Number: 24
init_animtree()
{
	scriptmodelsuseanimtree(-1);
}

//Function Number: 25
turbineanim(wait_for_end)
{
	if(!(IsDefined(self.buildableturbine)))
	{
		return;
	}

	animlength = 0;
	self.buildableturbine useanimtree(-1);
	if(IsDefined(self.buildableturbine.dying) && self.buildableturbine.dying)
	{
		animlength = getanimlength(%o_zombie_buildable_turbine_death);
		self.buildableturbine setanim(%o_zombie_buildable_turbine_death);
	}
	else if(IsDefined(self.turbine_emped) && self.turbine_emped)
	{
		self.buildableturbine clearanim(%o_zombie_buildable_turbine_fullpower,0);
		return;
	}
	else
	{
		switch(self.turbine_power_level)
		{
			case "3":
			case "4":
				animlength = getanimlength(%o_zombie_buildable_turbine_fullpower);
				self.buildableturbine setanim(%o_zombie_buildable_turbine_fullpower);
				break;

			case "2":
				animlength = getanimlength(%o_zombie_buildable_turbine_halfpower);
				self.buildableturbine setanim(%o_zombie_buildable_turbine_halfpower);
				break;

			case "1":
				animlength = getanimlength(%o_zombie_buildable_turbine_neardeath);
				self.buildableturbine setanim(%o_zombie_buildable_turbine_neardeath);
				break;
		}
	}

	if(IsDefined(wait_for_end) && wait_for_end)
	{
		wait(animlength);
	}
}

//Function Number: 26
turbinedecay()
{
	self notify("turbineDecay");
	self endon("turbineDecay");
	self endon("death");
	self endon("disconnect");
	self endon("equip_turbine_zm_taken");
	self.buildableturbine endon("death");
	roundlives = 4;
	if(!(IsDefined(self.turbine_power_level)))
	{
		self.turbine_power_level = roundlives;
	}

	while(self.turbine_health > 0)
	{
		old_power_level = self.turbine_power_level;
		if(IsDefined(self.turbine_emped) && self.turbine_emped && !!IsDefined(self.turbine_is_powering_on) && self.turbine_is_powering_on)
		{
			emp_time = level.zombie_vars["emp_perk_off_time"];
			now = GetTime();
			emp_time_left = emp_time - now - self.turbine_emp_time / 1000;
			if(emp_time_left <= 0)
			{
				self.turbine_emped = undefined;
				self.turbine_emp_time = undefined;
				self.turbine_power_is_on = 0;
				old_power_level = -1;
			}
		}

		if(IsDefined(self.turbine_emped) && self.turbine_emped)
		{
			self.turbine_power_level = 0;
		}
		else if(IsDefined(self.turbine_power_is_on) && self.turbine_power_is_on)
		{
			cost = 1;
			if(IsDefined(self.localpower))
			{
				cost = cost + maps/mp/zombies/_zm_power::get_local_power_cost(self.localpower);
			}

			self.turbine_health = self.turbine_health - cost;
			if(self.turbine_health < 200)
			{
				self.turbine_power_level = 1;
			}
			else if(self.turbine_health < 600)
			{
				self.turbine_power_level = 2;
			}
			else
			{
				self.turbine_power_level = 4;
			}
		}

		if(old_power_level != self.turbine_power_level)
		{
			self notify("turbine_power_change");
			self thread turbineaudio();
			if(!(IsDefined(self.buildableturbine.dying) && self.buildableturbine.dying))
			{
				self thread turbineanim();
			}
		}

		wait(1);
	}

	self destroy_placed_turbine();
	if(IsDefined(self.buildableturbine))
	{
		turbine_disappear_fx(self.buildableturbine.origin);
	}

	self thread wait_and_take_equipment();
	self.turbine_health = undefined;
	self.turbine_power_level = undefined;
	self.turbine_round_start = undefined;
	self.turbine_power_on = undefined;
	self.turbine_emped = undefined;
	self.turbine_emp_time = undefined;
	self cleanupoldturbine();
}

//Function Number: 27
destroy_placed_turbine()
{
	if(IsDefined(self.buildableturbine))
	{
		if(IsDefined(self.buildableturbine.dying) && self.buildableturbine.dying)
		{
			while(IsDefined(self.buildableturbine))
			{
				wait(0.05);
			}

			return;
		}

		if(IsDefined(self.buildableturbine.stub))
		{
			thread maps/mp/zombies/_zm_unitrigger::unregister_unitrigger(self.buildableturbine.stub);
		}

		thread turbine_disappear_fx(self.buildableturbine.origin,0.75);
		self.buildableturbine.dying = 1;
		self turbineanim(1);
	}
}

//Function Number: 28
wait_and_take_equipment()
{
	wait(0.05);
	self thread maps/mp/zombies/_zm_equipment::equipment_release("equip_turbine_zm");
}

//Function Number: 29
turbinepowerdiminish(origin,powerradius)
{
	self endon("death");
	self endon("disconnect");
	self endon("equip_turbine_zm_taken");
	self.buildableturbine endon("death");
	while(!(IsDefined(self.buildableturbine.dying) && self.buildableturbine.dying))
	{
		if(IsDefined(self.turbine_power_level) && IsDefined(self.buildableturbine))
		{
			switch(self.turbine_power_level)
			{
				case "4":
					break;

				case "3":
					break;

				case "2":
					self.turbine_power_on = 1;
					wait(randomintrange(12,20));
					self turbinepoweroff(origin,powerradius);
					self.turbine_power_on = 0;
					wait(randomintrange(3,8));
					self turbinepoweron(origin,powerradius);
					break;

				case "1":
					self.turbine_power_on = 1;
					wait(randomintrange(3,7));
					self turbinepoweroff(origin,powerradius);
					self.turbine_power_on = 0;
					wait(randomintrange(6,12));
					self turbinepoweron(origin,powerradius);
					break;
			}
		}

		wait(0.05);
	}
}

//Function Number: 30
debugturbine(radius)
{
/#
	self endon("death");
	self endon("disconnect");
	self endon("equip_turbine_zm_taken");
	self.buildableturbine endon("death");
	for(;;)
	{
		color = (0,1,0);
		text = "";
		text = "" + self.turbine_health + "";
		text = "dying";
		color = (0,0,0);
		color = (0,0,1);
		emp_time = level.zombie_vars["emp_perk_off_time"];
		now = GetTime();
		emp_time_left = int(emp_time - now - self.turbine_emp_time / 1000);
		text = text + " emp(" + emp_time_left + ")";
		text = text + " warmup";
		color = (1,0,0);
		color = (1,0.7,0);
		color = (1,1,0);
		print3d(60 + VectorScale((0,0,1)),self.buildableturbine.origin,text,color,1,0.5);
		wait(0.05);
	}
1
Stack-Empty ? Stack-Empty : ((IsDefined(self.buildableturbine)) ? GetDvarInt(#"EB512CB7") : ((IsDefined(self.turbine_health)) ? IsDefined(self.buildableturbine.dying) && self.buildableturbine.dying : ((IsDefined(self.turbine_emped) && self.turbine_emped) ? IsDefined(self.turbine_is_powering_on) && self.turbine_is_powering_on : ((IsDefined(self.turbine_power_is_on) && self.turbine_power_is_on) ? self.turbine_health < 200 : self.turbine_health < 600))))
#/
}