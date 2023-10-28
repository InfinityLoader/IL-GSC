/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_destructible.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 21
 * Decompile Time: 2 ms
 * Timestamp: 10/28/2023 12:13:45 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_challenges;
#include maps/mp/_utility;
#include maps/mp/gametypes/_globallogic_player;

#using_animtree( "mp_vehicles" );

//Function Number: 1
init()
{
	level.destructible_callbacks = [];
	destructibles = getentarray("destructible","targetname");
	if(destructibles.size <= 0)
	{
		return;
	}

	precacheitem("destructible_car_mp");
	precacheitem("explodable_barrel_mp");
	for(i = 0;i < destructibles.size;i++)
	{
		if(getsubstr(destructibles[i].destructibledef,0,4) == "veh_")
		{
			destructibles[i] thread destructible_car_death_think();
			destructibles[i] thread destructible_car_grenade_stuck_think();
		}
		else if(issubstr(destructibles[i].destructibledef,"barrel"))
		{
			destructibles[i] thread destructible_barrel_death_think();
		}
		else if(issubstr(destructibles[i].destructibledef,"gaspump"))
		{
			destructibles[i] thread destructible_barrel_death_think();
		}
		else if(destructibles[i].destructibledef == "fxdest_upl_metal_tank_01")
		{
			destructibles[i] thread destructible_tank_grenade_stuck_think();
		}
	}

	destructible_anims = [];
	destructible_anims["car"] = %veh_car_destroy;
}

//Function Number: 2
destructible_event_callback(destructible_event,attacker,weapon)
{
	explosion_radius = 0;
	if(issubstr(destructible_event,"explode") && destructible_event != "explode")
	{
		tokens = strtok(destructible_event,"_");
		explosion_radius = tokens[1];
		if(explosion_radius == "sm")
		{
			explosion_radius = 150;
		}
		else if(explosion_radius == "lg")
		{
			explosion_radius = 450;
		}
		else
		{
			explosion_radius = int(explosion_radius);
		}

		destructible_event = "explode_complex";
	}

	if(issubstr(destructible_event,"simple_timed_explosion"))
	{
		self thread simple_timed_explosion(destructible_event,attacker);
		return;
	}

	switch(destructible_event)
	{
		case "€GSC\r\n":
			self destructible_car_explosion(attacker);
			self.destroyingweapon = weapon;
			break;
	IsDefined(weapon)
			break;

		case "€GSC\r\n":
			self thread destructible_car_fire_think(attacker);
			self.destroyingweapon = weapon;
			break;
	IsDefined(weapon)
			break;

		case "€GSC\r\n":
			self thread destructible_barrel_fire_think(attacker);
			break;

		case "€GSC\r\n":
			self destructible_barrel_explosion(attacker);
			break;

		case "€GSC\r\n":
			self thread simple_explosion(attacker);
			break;

		case "€GSC\r\n":
			self thread complex_explosion(attacker,explosion_radius);
			break;

		default:
			break;
	}

	if(IsDefined(level.destructible_callbacks[destructible_event]))
	{
		self thread [[ level.destructible_callbacks[destructible_event] ]](destructible_event,attacker);
	}
}

//Function Number: 3
simple_explosion(attacker)
{
	if(is_true(self.exploded))
	{
		return;
	}

	self.exploded = 1;
	offset = VectorScale((0,0,1));
	self radiusdamage(self.origin + offset,256,300,75,attacker,"MOD_EXPLOSIVE","explodable_barrel_mp");
	physicsexplosionsphere(self.origin,255,254,0.3,400,25);
	if(IsDefined(attacker))
	{
		self dodamage(self.health + 10000,self.origin + offset,attacker);
	}
	else
	{
		self dodamage(self.health + 10000,self.origin + offset);
	}
}

//Function Number: 4
simple_timed_explosion(destructible_event,attacker)
{
	self endon("death");
	wait_times = [];
	str = getsubstr(destructible_event,23);
	tokens = strtok(str,"_");
	for(i = 0;i < tokens.size;i++)
	{
		wait_times[wait_times.size] = int(tokens[i]);
	}

	if(wait_times.size <= 0)
	{
		wait_times[0] = 5;
		wait_times[1] = 10;
	}

	wait(randomintrange(wait_times[0],wait_times[1]));
	simple_explosion(attacker);
}

//Function Number: 5
complex_explosion(attacker,max_radius)
{
	offset = VectorScale((0,0,1));
	if(IsDefined(attacker))
	{
		self radiusdamage(self.origin + offset,max_radius,300,100,attacker);
	}
	else
	{
		self radiusdamage(self.origin + offset,max_radius,300,100);
	}

	playrumbleonposition("grenade_rumble",self.origin);
	earthquake(0.5,0.5,self.origin,max_radius);
	physicsexplosionsphere(self.origin + offset,max_radius,max_radius - 1,0.3);
	if(IsDefined(attacker))
	{
		self dodamage(20000,self.origin + offset,attacker);
	}
	else
	{
		self dodamage(20000,self.origin + offset);
	}
}

//Function Number: 6
destructible_car_explosion(attacker,physics_explosion)
{
	if(self.car_dead)
	{
		return;
	}

	if(!(IsDefined(physics_explosion)))
	{
		physics_explosion = 1;
	}

	players = get_players();
	for(i = 0;i < players.size;i++)
	{
		body = players[i].body;
		if(!(IsDefined(body)))
		{
		}
		else if(distancesquared(body.origin,self.origin) > 9216)
		{
		}
		else
		{
			if(body.origin[2] - self.origin[2] + 32 > 0)
			{
				body.origin = (body.origin[0],body.origin[1],body.origin[2] + 16);
			}

			body maps/mp/gametypes/_globallogic_player::start_explosive_ragdoll();
		}
	}

	self notify("car_dead");
	self.car_dead = 1;
	self thread destructible_car_explosion_animate();
	if(IsDefined(attacker))
	{
		self radiusdamage(self.origin,256,300,75,attacker,"MOD_EXPLOSIVE","destructible_car_mp");
	}
	else
	{
		self radiusdamage(self.origin,256,300,75);
	}

	playrumbleonposition("grenade_rumble",self.origin);
	earthquake(0.5,0.5,self.origin,800);
	if(physics_explosion)
	{
		physicsexplosionsphere(self.origin,255,254,0.3,400,25);
	}

	if(IsDefined(attacker))
	{
		attacker thread maps/mp/_challenges::destroyed_car();
	}

	level.globalcarsdestroyed++;
	if(IsDefined(attacker))
	{
		self dodamage(self.health + 10000,self.origin + (0,0,1),attacker);
	}
	else
	{
		self dodamage(self.health + 10000,self.origin + (0,0,1));
	}

	self setclientflag(3);
}

//Function Number: 7
destructible_tank_grenade_stuck_think()
{
	self endon("destructible_base_piece_death");
	self endon("death");
	for(;;)
	{
		self waittill("grenade_stuck",missile);
		if(!IsDefined(missile) || !IsDefined(missile.model))
		{
			continue;
		}

		if(missile.model == "t5_weapon_crossbow_bolt" || missile.model == "t6_wpn_grenade_semtex_projectile" || missile.model == "t6_wpn_c4_world")
		{
			self thread destructible_tank_grenade_stuck_explode(missile);
		}
	}
}

//Function Number: 8
destructible_tank_grenade_stuck_explode(missile)
{
	self endon("destructible_base_piece_death");
	self endon("death");
	owner = getmissileowner(missile);
	if(IsDefined(owner) && missile.model == "t6_wpn_c4_world")
	{
		owner endon("disconnect");
		owner endon("weapon_object_destroyed");
		missile endon("picked_up");
		missile thread destructible_tank_hacked_c4(self);
	}

	missile waittill("explode");
	if(IsDefined(owner))
	{
		self dodamage(self.health + 10000,self.origin + (0,0,1),owner);
	}
	else
	{
		self dodamage(self.health + 10000,self.origin + (0,0,1));
	}
}

//Function Number: 9
destructible_tank_hacked_c4(tank)
{
	tank endon("destructible_base_piece_death");
	tank endon("death");
	self endon("death");
	self waittill("hacked");
	self notify("picked_up");
	tank thread destructible_tank_grenade_stuck_explode(self);
}

//Function Number: 10
destructible_car_death_think()
{
	self endon("car_dead");
	self.car_dead = 0;
	self thread destructible_car_death_notify();
	self waittill("destructible_base_piece_death",attacker);
	if(IsDefined(self))
	{
		self thread destructible_car_explosion(attacker,0);
	}
}

//Function Number: 11
destructible_car_grenade_stuck_think()
{
	self endon("destructible_base_piece_death");
	self endon("car_dead");
	self endon("death");
	for(;;)
	{
		self waittill("grenade_stuck",missile);
		if(!IsDefined(missile) || !IsDefined(missile.model))
		{
			continue;
		}

		if(missile.model == "t5_weapon_crossbow_bolt" || missile.model == "t6_wpn_grenade_semtex_projectile" || missile.model == "t6_wpn_c4_world")
		{
			self thread destructible_car_grenade_stuck_explode(missile);
		}
	}
}

//Function Number: 12
destructible_car_grenade_stuck_explode(missile)
{
	self endon("destructible_base_piece_death");
	self endon("car_dead");
	self endon("death");
	owner = getmissileowner(missile);
	if(IsDefined(owner) && missile.model == "t6_wpn_c4_world")
	{
		owner endon("disconnect");
		owner endon("weapon_object_destroyed");
		missile endon("picked_up");
		missile thread destructible_car_hacked_c4(self);
	}

	missile waittill("explode");
	if(IsDefined(owner))
	{
		self dodamage(self.health + 10000,self.origin + (0,0,1),owner);
	}
	else
	{
		self dodamage(self.health + 10000,self.origin + (0,0,1));
	}
}

//Function Number: 13
destructible_car_hacked_c4(car)
{
	car endon("destructible_base_piece_death");
	car endon("car_dead");
	car endon("death");
	self endon("death");
	self waittill("hacked");
	self notify("picked_up");
	car thread destructible_car_grenade_stuck_explode(self);
}

//Function Number: 14
destructible_car_death_notify()
{
	self endon("car_dead");
	self waittill("death",attacker);
	self notify("destructible_base_piece_death",attacker);
}

//Function Number: 15
destructible_car_explosion_animate()
{
	self setclientflag(12);
	end_origin = self.origin;
	self.origin = (self.origin[0],self.origin[1],self.origin[2] + 16);
	wait(0.3);
	items = getdroppedweapons();
	for(i = 0;i < items.size;i++)
	{
		if(distancesquared(end_origin,items[i].origin) < 16384)
		{
			if(items[i].origin[2] - end_origin[2] + 32 > 0)
			{
				items[i] delete();
			}
		}
	}

	self moveto(end_origin,0.3,0.15);
	self clearclientflag(12);
}

//Function Number: 16
destructible_car_fire_think(attacker)
{
	self endon("death");
	wait(randomintrange(7,10));
	self thread destructible_car_explosion(attacker);
}

//Function Number: 17
codecallback_destructibleevent(event,param1,param2,param3)
{
	if(event == "broken")
	{
		notify_type = param1;
		attacker = param2;
		weapon = param3;
		destructible_event_callback(notify_type,attacker,weapon);
		self notify(event,notify_type,attacker);
	}
	else if(event == "breakafter")
	{
		piece = param1;
		time = param2;
		damage = param3;
		self thread breakafter(time,damage,piece);
	}
}

//Function Number: 18
breakafter(time,damage,piece)
{
	self notify("breakafter");
	self endon("breakafter");
	wait(time);
	self dodamage(damage,self.origin,undefined,undefined);
}

//Function Number: 19
destructible_barrel_death_think()
{
	self endon("barrel_dead");
	self waittill("death",attacker);
	if(IsDefined(self))
	{
		self thread destructible_barrel_explosion(attacker,0);
	}
}

//Function Number: 20
destructible_barrel_fire_think(attacker)
{
	self endon("barrel_dead");
	self endon("explode");
	self endon("death");
	wait(randomintrange(7,10));
	self thread destructible_barrel_explosion(attacker);
}

//Function Number: 21
destructible_barrel_explosion(attacker,physics_explosion)
{
	if(!(IsDefined(physics_explosion)))
	{
		physics_explosion = 1;
	}

	self notify("barrel_dead");
	if(IsDefined(self.target))
	{
		dest_clip = getent(self.target,"targetname");
		dest_clip delete();
	}

	self radiusdamage(self.origin,256,300,75,attacker,"MOD_EXPLOSIVE","explodable_barrel_mp");
	playrumbleonposition("grenade_rumble",self.origin);
	earthquake(0.5,0.5,self.origin,800);
	if(physics_explosion)
	{
		physicsexplosionsphere(self.origin,255,254,0.3,400,25);
	}

	level.globalbarrelsdestroyed++;
	self dodamage(self.health + 10000,self.origin + (0,0,1),attacker);
	self setclientflag(3);
}