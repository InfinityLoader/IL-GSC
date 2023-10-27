/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_interactive_objects.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 9
 * Decompile Time: 29 ms
 * Timestamp: 10/27/2023 3:06:29 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;

//Function Number: 1
init()
{
	level.barrelexplodingthisframe = 0;
	qbarrels = 0;
	all_barrels = [];
	barrels = getentarray("explodable_barrel","targetname");
	if(IsDefined(barrels) && barrels.size > 0)
	{
		qbarrels = 1;
		for(i = 0;i < barrels.size;i++)
		{
			all_barrels[all_barrels.size] = barrels[i];
		}
	}

	barrels = getentarray("explodable_barrel","script_noteworthy");
	if(IsDefined(barrels) && barrels.size > 0)
	{
		qbarrels = 1;
		for(i = 0;i < barrels.size;i++)
		{
			all_barrels[all_barrels.size] = barrels[i];
		}
	}

	if(qbarrels)
	{
		precachemodel("global_explosive_barrel");
		level.barrelburn = 100;
		level.barrelhealth = 250;
		level.barrelingsound = "exp_redbarrel_ignition";
		level.barrelexpsound = "exp_redbarrel";
		level.breakables_fx["barrel"]["burn_start"] = loadfx("destructibles/fx_barrel_ignite");
		level.breakables_fx["barrel"]["burn"] = loadfx("destructibles/fx_barrel_fire_top");
		level.breakables_fx["barrel"]["explode"] = loadfx("destructibles/fx_dest_barrelexp");
		array_thread(all_barrels,::explodable_barrel_think);
	}

	qcrates = 0;
	all_crates = [];
	crates = getentarray("flammable_crate","targetname");
	if(IsDefined(crates) && crates.size > 0)
	{
		qcrates = 1;
		for(i = 0;i < crates.size;i++)
		{
			all_crates[all_crates.size] = crates[i];
		}
	}

	crates = getentarray("flammable_crate","script_noteworthy");
	if(IsDefined(crates) && crates.size > 0)
	{
		qcrates = 1;
		for(i = 0;i < crates.size;i++)
		{
			all_crates[all_crates.size] = crates[i];
		}
	}

	if(qcrates)
	{
		precachemodel("global_flammable_crate_jap_piece01_d");
		level.crateburn = 100;
		level.cratehealth = 200;
		level.breakables_fx["ammo_crate"]["burn_start"] = loadfx("destructibles/fx_ammobox_ignite");
		level.breakables_fx["ammo_crate"]["burn"] = loadfx("destructibles/fx_ammobox_fire_top");
		level.breakables_fx["ammo_crate"]["explode"] = loadfx("destructibles/fx_ammoboxExp");
		level.crateignsound = "Ignition_ammocrate";
		level.crateexpsound = "Explo_ammocrate";
		array_thread(all_crates,::flammable_crate_think);
	}

	if(!qbarrels && !qcrates)
	{
	}

//Function Number: 2
explodable_barrel_think()
{
	if(self.classname != "script_model")
	{
		return;
	}

	self endon("exploding");
	self breakable_clip();
	self.health = level.barrelhealth;
	self setcandamage(1);
	self.targetname = "explodable_barrel";
	if(sessionmodeiszombiesgame())
	{
		self.removeexplodable = 1;
	}

	for(;;)
	{
		self waittill("damage",amount,attacker,direction_vec,p,type);
/#
		println("BARRELDAMAGE: " + type);
#/
		if(type == "MOD_MELEE" || type == "MOD_IMPACT")
		{
			continue;
		}

		if(IsDefined(self.script_requires_player) && self.script_requires_player && !isplayer(attacker))
		{
			continue;
		}

		if(IsDefined(self.script_selfisattacker) && self.script_selfisattacker)
		{
			self.damageowner = self;
		}
		else
		{
			self.damageowner = attacker;
		}

		self.health = self.health - amount;
		if(self.health <= level.barrelburn)
		{
			self thread explodable_barrel_burn();
		}
	}
}

//Function Number: 3
explodable_barrel_burn()
{
	count = 0;
	startedfx = 0;
	up = AnglesToUp(VectorScale((0,1,0)));
	worldup = AnglesToUp(VectorScale((0,1,0)));
	dot = vectordot(up,worldup);
	offset1 = (0,0,0);
	offset2 = 44 * VectorScale((0,0,1));
	if(dot < 0.5)
	{
		offset1 = 30 - VectorScale((0,0,1));
		offset2 = 14 + VectorScale((0,0,1));
	}

	while(self.health > 0)
	{
		if(!(startedfx))
		{
			playfx(level.breakables_fx["barrel"]["burn_start"],self.origin + offset1);
			level thread play_sound_in_space(level.barrelingsound,self.origin);
			startedfx = 1;
		}

		if(count > 20)
		{
			count = 0;
		}

		playfx(level.breakables_fx["barrel"]["burn"],self.origin + offset2);
		self playloopsound("barrel_fuse");
		if(count == 0)
		{
			self.health = self.health - 10 + randomint(10);
		}

		count++;
		wait(0.05);
	}

	level notify("explosion_started",22 * VectorScale((0,0,1)),up,22 * VectorScale((0,0,1)),up,up,90,90);
	self thread explodable_barrel_explode();
}

//Function Number: 4
explodable_barrel_explode()
{
	self notify("exploding");
	self death_notify_wrapper();
	up = AnglesToUp(VectorScale((0,1,0)));
	worldup = AnglesToUp(VectorScale((0,1,0)));
	dot = vectordot(up,worldup);
	offset = (0,0,0);
	if(dot < 0.5)
	{
		start = 22 + VectorScale(up);
		trace = physicstrace(start,64 + VectorScale((0,0,-1)));
		end = trace["position"];
		offset = end - self.origin;
	}

	offset = 4 + VectorScale((0,0,1));
	mindamage = 1;
	maxdamage = 250;
	blastradius = 250;
	level thread play_sound_in_space(level.barrelexpsound,self.origin);
	playfx(level.breakables_fx["barrel"]["explode"],self.origin + offset);
	physicsexplosionsphere(self.origin + offset,100,80,1,maxdamage,mindamage);
	level.barrelexplodingthisframe = 1;
	if(IsDefined(self.remove))
	{
		self.remove delete();
	}

	if(IsDefined(self.radius))
	{
		blastradius = self.radius;
	}

	self radiusdamage(56 + VectorScale((0,0,1)),self.origin,blastradius,maxdamage,mindamage);
	attacker = undefined;
	if(IsDefined(self.damageowner))
	{
		attacker = self.damageowner;
	}

	level.lastexplodingbarrel["time"] = GetTime();
	level.lastexplodingbarrel["origin"] = 30 + VectorScale((0,0,1));
	if(IsDefined(self.removeexplodable))
	{
		self hide();
	}
	else
	{
		self setmodel("global_explosive_barrel");
	}

	if(dot < 0.5)
	{
		start = 22 + VectorScale(up);
		trace = physicstrace(start,64 + VectorScale((0,0,-1)));
		pos = trace["position"];
		self.origin = pos;
		self.angles = 90 + VectorScale((0,0,1));
	}

	wait(0.05);
	level.barrelexplodingthisframe = 0;
}

//Function Number: 5
flammable_crate_think()
{
	if(self.classname != "script_model")
	{
		return;
	}

	self endon("exploding");
	self breakable_clip();
	self.health = level.cratehealth;
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",amount,attacker,direction_vec,p,type);
		if(IsDefined(self.script_requires_player) && self.script_requires_player && !isplayer(attacker))
		{
			continue;
		}

		if(IsDefined(self.script_selfisattacker) && self.script_selfisattacker)
		{
			self.damageowner = self;
		}
		else
		{
			self.damageowner = attacker;
		}

		if(level.barrelexplodingthisframe)
		{
			wait(randomfloat(1));
		}

		self.health = self.health - amount;
		if(self.health <= level.crateburn)
		{
			self thread flammable_crate_burn();
		}
	}
}

//Function Number: 6
flammable_crate_burn()
{
	count = 0;
	startedfx = 0;
	up = AnglesToUp(VectorScale((0,1,0)));
	worldup = AnglesToUp(VectorScale((0,1,0)));
	dot = vectordot(up,worldup);
	offset1 = (0,0,0);
	offset2 = 44 * VectorScale((0,0,1));
	if(dot < 0.5)
	{
		offset1 = 30 - VectorScale((0,0,1));
		offset2 = 14 + VectorScale((0,0,1));
	}

	while(self.health > 0)
	{
		if(!(startedfx))
		{
			playfx(level.breakables_fx["ammo_crate"]["burn_start"],self.origin);
			level thread play_sound_in_space(level.crateignsound,self.origin);
			startedfx = 1;
		}

		if(count > 20)
		{
			count = 0;
		}

		playfx(level.breakables_fx["ammo_crate"]["burn"],self.origin);
		if(count == 0)
		{
			self.health = self.health - 10 + randomint(10);
		}

		count++;
		wait(0.05);
	}

	self thread flammable_crate_explode();
}

//Function Number: 7
flammable_crate_explode()
{
	self notify("exploding");
	self death_notify_wrapper();
	up = AnglesToUp(VectorScale((0,1,0)));
	worldup = AnglesToUp(VectorScale((0,1,0)));
	dot = vectordot(up,worldup);
	offset = (0,0,0);
	if(dot < 0.5)
	{
		start = 22 + VectorScale(up);
		trace = physicstrace(start,64 + VectorScale((0,0,-1)));
		end = trace["position"];
		offset = end - self.origin;
	}

	offset = 4 + VectorScale((0,0,1));
	mindamage = 1;
	maxdamage = 250;
	blastradius = 250;
	level thread play_sound_in_space(level.crateexpsound,self.origin);
	playfx(level.breakables_fx["ammo_crate"]["explode"],self.origin);
	physicsexplosionsphere(self.origin + offset,100,80,1,maxdamage,mindamage);
	level.barrelexplodingthisframe = 1;
	if(IsDefined(self.remove))
	{
		self.remove delete();
	}

	if(IsDefined(self.radius))
	{
		blastradius = self.radius;
	}

	attacker = undefined;
	if(IsDefined(self.damageowner))
	{
		attacker = self.damageowner;
	}

	self radiusdamage(30 + VectorScale((0,0,1)),self.origin,blastradius,maxdamage,mindamage);
	self setmodel("global_flammable_crate_jap_piece01_d");
	if(dot < 0.5)
	{
		start = 22 + VectorScale(up);
		trace = physicstrace(start,64 + VectorScale((0,0,-1)));
		pos = trace["position"];
		self.origin = pos;
		self.angles = 90 + VectorScale((0,0,1));
	}

	wait(0.05);
	level.barrelexplodingthisframe = 0;
}

//Function Number: 8
breakable_clip()
{
	if(IsDefined(self.target))
	{
		targ = getent(self.target,"targetname");
		if(targ.classname == "script_brushmodel")
		{
			self.remove = targ;
			return;
		}
	}

	if(IsDefined(level.breakables_clip) && level.breakables_clip.size > 0)
	{
		self.remove = getclosestent(self.origin,level.breakables_clip);
	}

	if(IsDefined(self.remove))
	{
		arrayremovevalue(level.breakables_clip,self.remove);
	}
}

//Function Number: 9
getclosestent(org,array)
{
	if(array.size < 1)
	{
		return;
	}

	dist = 256;
	ent = undefined;
	for(i = 0;i < array.size;i++)
	{
		newdist = distance(array[i] getorigin(),org);
		if(newdist >= dist)
		{
		}
		else
		{
			dist = newdist;
			ent = array[i];
		}
	}

	return ent;
}