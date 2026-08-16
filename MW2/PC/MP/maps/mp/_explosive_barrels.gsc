/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_explosive_barrels.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	qbarrels = 0;
	precacheitem("barrel_mp");
	barrels = getentarray("explodable_barrel", "targetname");
	if(isdefined(barrels) && barrels.size > 0)
	{
		qbarrels = 1;
	}

	barrels = getentarray("explodable_barrel", "script_noteworthy");
	if(isdefined(barrels) && barrels.size > 0)
	{
		qbarrels = 1;
	}

	if(qbarrels)
	{
		level.breakables_fx["barrel"]["explode"] = loadfx("props/barrelExp");
		level.breakables_fx["barrel"]["burn_start"] = loadfx("props/barrel_ignite");
		level.breakables_fx["barrel"]["burn"] = loadfx("props/barrel_fire_top");
	}

	oilspill = getentarray("oil_spill", "targetname");
	if(isdefined(oilspill) && oilspill.size > 0)
	{
		level.breakables_fx["oilspill"]["burn"] = loadfx("props/barrel_fire");
		level.breakables_fx["oilspill"]["spark"] = loadfx("impacts/small_metalhit_1");
	}

	level.barrelexpsound = "explo_metal_rand";
	level.barrelhealth = 150;
	maxbrokenpieces = 25;
	level.precachemodeltype = [];
	level.barrelexplodingthisframe = 0;
	level.breakables_clip = [];
	temp = getentarray("breakable clip", "targetname");
	for(i = 0;i < temp.size;i++)
	{
		level.breakables_clip[level.breakables_clip.size] = temp[i];
	}

	level._breakable_utility_modelarray = [];
	level._breakable_utility_modelindex = 0;
	level._breakable_utility_maxnum = maxbrokenpieces;
	common_scripts\utility::array_thread(getentarray("explodable_barrel", "targetname"), ::explodable_barrel_think);
	common_scripts\utility::array_thread(getentarray("oil_spill", "targetname"), ::oil_spill_think);
}

oil_spill_think()
{
	self.end = getstruct(self.target, "targetname");
	self.start = getstruct(self.end.target, "targetname");
	self.barrel = getclosestent(self.start.origin, getentarray("explodable_barrel", "targetname"));
	self.extra = getent(self.target, "targetname");
	self setcandamage(1);
	if(isdefined(self.barrel))
	{
		self.barrel.oilspill = 1;
		thread oil_spill_burn_after();
	}

	for(;;)
	{
		self waittill("damage", other, damage, direction_vec, p, type);
		if(type == "MOD_MELEE" || type == "MOD_IMPACT")
		{
			continue;
		}

		self.damageowner = other;
		playfx(level.breakables_fx["oilspill"]["spark"], p, direction_vec);
		thread oil_spill_burn_section(p);
		thread oil_spill_burn(p, self.start.origin);
		thread oil_spill_burn(p, self.end.origin);
		break;
	}

	if(isdefined(self.barrel))
	{
		self.barrel waittill("exploding");
	}

	self.extra delete();
	self hide();
	wait 10;
	self delete();
}

getclosestent(org, array)
{
	if(array.size < 1)
	{
		return;
	}

	dist = 256;
	ent = undefined;
	for(i = 0;i < array.size;i++)
	{
		newdist = distance(array[i] getorigin(), org);
		if(newdist >= dist)
		{
			continue;
		}

		dist = newdist;
		ent = array[i];
	}

	return ent;
}

oil_spill_burn_after()
{
	for(;;)
	{
		self.barrel waittill("damage", amount, attacker, direction_vec, p, type);
		if(type == "MOD_MELEE" || type == "MOD_IMPACT")
		{
			continue;
		}

		break;
	}

	self.damageowner = attacker;
	if(!isdefined(self.damageowner))
	{
		self radiusdamage(self.origin, 4, 10, 10);
		return;
	}

	self radiusdamage(self.origin, 4, 10, 10, self.damageowner);
}

oil_spill_burn(p, dest)
{
	forward = vectornormalize(dest - p);
	dist = distance(p, dest);
	range = 8;
	interval = common_scripts\utility::vector_multiply(forward, range);
	angle = vectortoangles(forward);
	right = anglestoright(angle);
	barrels = getentarray("explodable_barrel", "targetname");
	distsqr = 484;
	test = spawn("script_origin", p);
	test hide();
	num = 0;
	for(;;)
	{
		dist = dist - range;
		if(dist < range * 0.1)
		{
			break;
		}

		p = p + interval + common_scripts\utility::vector_multiply(right, randomfloatrange(-6, 6));
		thread oil_spill_burn_section(p);
		num++;
		if(num == 4)
		{
			num = 0;
		}

		test.origin = p;
		remove = [];
		barrels = common_scripts\utility::array_removeundefined(barrels);
		for(i = 0;i < barrels.size;i++)
		{
			vec = anglestoup(barrels[i].angles);
			start = barrels[i].origin + common_scripts\utility::vector_multiply(vec, 22);
			pos = physicstrace(start, start + (0,0,-64));
			if(distancesquared(p, pos) < distsqr)
			{
				remove[remove.size] = barrels[i];
				d = 80 + randomfloat(10);
				if(!isdefined(self.damageowner))
				{
					self radiusdamage(barrels[i].origin, 4, d, d);
				}
				else
				{
					self radiusdamage(barrels[i].origin, 4, d, d, self.damageowner);
				}
			}
		}

		for(i = 0;i < remove.size;i++)
		{
			barrels = common_scripts\utility::array_remove(barrels, remove[i]);
		}

		wait 0.1;
	}

	if(!isdefined(self.barrel))
	{
		return;
	}

	if(distance(p, self.start.origin) < 32)
	{
		d = 80 + randomfloat(10);
		if(!isdefined(self.damageowner))
		{
			self radiusdamage(self.barrel.origin, 4, d, d);
			return;
		}

		self radiusdamage(self.barrel.origin, 4, d, d, self.damageowner);
		return;
	}
}

oil_spill_burn_section(p)
{
	count = 0;
	time = 0;
	playfx(level.breakables_fx["oilspill"]["burn"], p);
	while(time < 5)
	{
		if(!isdefined(self.damageowner))
		{
			self radiusdamage(p, 32, 5, 1);
		}
		else
		{
			self radiusdamage(p, 32, 5, 1, self.damageowner);
		}

		time = time + 1;
		wait 1;
	}
}

explodable_barrel_think()
{
	if(self.classname != "script_model")
	{
		return;
	}

	if(!isdefined(level.precachemodeltype["com_barrel_benzin"]))
	{
		level.precachemodeltype["com_barrel_benzin"] = 1;
		precachemodel("com_barrel_piece");
		precachemodel("com_barrel_piece2");
	}

	self endon("exploding");
	breakable_clip();
	self.damagetaken = 0;
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage", amount, attacker, direction_vec, p, type);
		if(type == "MOD_MELEE" || type == "MOD_IMPACT")
		{
			continue;
		}

		self.damagetype = type;
		self.damageowner = attacker;
		if(level.barrelexplodingthisframe)
		{
			wait randomfloat(1);
		}

		self.damagetaken = self.damagetaken + amount;
		if(self.damagetaken == amount)
		{
			thread explodable_barrel_burn();
		}
	}
}

explodable_barrel_burn()
{
	count = 0;
	startedfx = 0;
	up = anglestoup(self.angles);
	worldup = anglestoup((0,90,0));
	dot = vectordot(up, worldup);
	offset1 = (0,0,0);
	offset2 = common_scripts\utility::vector_multiply(up, 44);
	if(dot < 0.5)
	{
		offset1 = common_scripts\utility::vector_multiply(up, 22) - (0,0,30);
		offset2 = common_scripts\utility::vector_multiply(up, 22) + (0,0,14);
	}

	if(self.damagetype != "MOD_GRENADE_SPLASH" && self.damagetype != "MOD_GRENADE")
	{
		while(self.damagetaken < level.barrelhealth)
		{
			if(!startedfx)
			{
				playfx(level.breakables_fx["barrel"]["burn_start"], self.origin + offset1);
				startedfx = 1;
			}

			if(count > 20)
			{
				count = 0;
			}

			playfx(level.breakables_fx["barrel"]["burn"], self.origin + offset2);
			if(count == 0)
			{
				self.damagetaken = self.damagetaken + 10 + randomfloat(10);
			}

			count++;
			wait 0.05;
		}
	}

	thread explodable_barrel_explode();
}

explodable_barrel_explode()
{
	self notify("exploding");
	self notify("death");
	up = anglestoup(self.angles);
	worldup = anglestoup((0,90,0));
	dot = vectordot(up, worldup);
	offset = (0,0,0);
	if(dot < 0.5)
	{
		start = self.origin + common_scripts\utility::vector_multiply(up, 22);
		end = physicstrace(start, start + (0,0,-64));
		offset = end - self.origin;
	}

	offset = offset + (0,0,4);
	self playsound(level.barrelexpsound);
	playfx(level.breakables_fx["barrel"]["explode"], self.origin + offset);
	level.barrelexplodingthisframe = 1;
	if(isdefined(self.remove))
	{
		self.remove delete();
	}

	phyexpmagnitude = 2;
	mindamage = 1;
	maxdamage = 250;
	blastradius = 250;
	if(isdefined(self.radius))
	{
		blastradius = self.radius;
	}

	if(!isdefined(self.damageowner))
	{
		self radiusdamage(self.origin + (0,0,30), blastradius, maxdamage, mindamage, undefined, "MOD_EXPLOSIVE", "barrel_mp");
	}
	else
	{
		self radiusdamage(self.origin + (0,0,30), blastradius, maxdamage, mindamage, self.damageowner, "MOD_EXPLOSIVE", "barrel_mp");
	}

	physicsexplosionsphere(self.origin + (0,0,30), blastradius, blastradius / 2, phyexpmagnitude);
	maps\mp\gametypes\_shellshock::barrel_earthquake();
	if(randomint(2) == 0)
	{
		self setmodel("com_barrel_piece");
	}
	else
	{
		self setmodel("com_barrel_piece2");
	}

	self setcandamage(0);
	if(dot < 0.5)
	{
		start = self.origin + common_scripts\utility::vector_multiply(up, 22);
		pos = physicstrace(start, start + (0,0,-64));
		self.origin = pos;
		self.angles = self.angles + (0,0,90);
	}

	wait 0.05;
	level.barrelexplodingthisframe = 0;
}

getstruct(name, type)
{
	if(!isdefined(level.struct_class_names))
	{
		return undefined;
	}

	array = level.struct_class_names[type][name];
	if(!isdefined(array))
	{
		return undefined;
	}

	if(array.size > 1)
	{
		return undefined;
	}

	return array[0];
}

breakable_clip()
{
	if(isdefined(self.target))
	{
		targ = getent(self.target, "targetname");
		if(targ.classname == "script_brushmodel")
		{
			self.remove = targ;
			return;
		}
	}

	if(isdefined(level.breakables_clip) && level.breakables_clip.size > 0)
	{
		self.remove = getclosestent(self.origin, level.breakables_clip);
	}

	if(isdefined(self.remove))
	{
		level.breakables_clip = common_scripts\utility::array_remove(level.breakables_clip, self.remove);
		return;
	}
}