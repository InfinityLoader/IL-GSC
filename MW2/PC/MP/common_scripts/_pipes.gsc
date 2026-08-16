/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_pipes.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	level._pipe_fx_time = 25;
	pipes = getentarray("pipe_shootable", "targetname");
	if(!pipes.size)
	{
		return;
	}

	level._pipes = spawnstruct();
	level._pipes.num_pipe_fx = 0;
	pipes thread precachefx();
	pipes thread methodsinit();
	waittillframeend;
	common_scripts\utility::array_thread(pipes, ::pipesetup);
}

pipesetup()
{
	self setcandamage(1);
	self setcanradiusdamage(0);
	self.pipe_fx_array = [];
	node = undefined;
	if(isdefined(self.target))
	{
		node = common_scripts\utility::getstruct(self.target, "targetname");
		self.a = node.origin;
		vec = anglestoforward(node.angles);
		vec = common_scripts\utility::vector_multiply(vec, 128);
		self.b = self.a + vec;
	}
	else
	{
		vec = anglestoforward(self.angles);
		vec1 = common_scripts\utility::vector_multiply(vec, 64);
		self.a = self.origin + vec1;
		vec1 = common_scripts\utility::vector_multiply(vec, -64);
		self.b = self.origin + vec1;
	}

	thread pipe_wait_loop();
}

pipe_wait_loop()
{
	p = (0,0,0);
	hastakendamage = 0;
	remaining = 4;
	for(;;)
	{
		self waittill("damage", damage, other, direction_vec, p, type);
		if(hastakendamage)
		{
			if(randomint(100) <= 33)
			{
				continue;
			}
		}

		hastakendamage = 1;
		result = pipe_logic(direction_vec, p, type, other);
		if(result)
		{
			remaining--;
		}

		if(remaining <= 0)
		{
			break;
		}
	}

	self setcandamage(0);
}

pipe_logic(direction_vec, p, type, damageowner)
{
	if(level._pipes.num_pipe_fx > 8)
	{
		return 0;
	}

	if(!isdefined(level._pipes._pipe_methods[type]))
	{
		p = pipe_calc_nofx(p, type);
	}
	else
	{
		p = self [[ level._pipes._pipe_methods[type] ]](p, type);
	}

	if(!isdefined(p))
	{
		return 0;
	}

	if(isdefined(damageowner.classname) && damageowner.classname == "worldspawn")
	{
		return 0;
	}

	foreach(value in self.pipe_fx_array)
	{
		if(distancesquared(p, value.origin) < 25)
		{
			return 0;
		}
	}

	vec = vectorfromlinetopoint(self.a, self.b, p);
	thread pipefx(p, vec, damageowner);
	return 1;
}

pipefx(p, vec, damageowner)
{
	time = level._pipes.fx_time[self.script_noteworthy];
	intervals = int(level._pipe_fx_time / time);
	hitsnd = level._pipes._sound[self.script_noteworthy + "_hit"];
	loopsnd = level._pipes._sound[self.script_noteworthy + "_loop"];
	endsnd = level._pipes._sound[self.script_noteworthy + "_end"];
	snd = spawn("script_origin", p);
	snd hide();
	snd playsound(hitsnd);
	snd playloopsound(loopsnd);
	self.pipe_fx_array[self.pipe_fx_array.size] = snd;
	level._pipes.num_pipe_fx++;
	if(common_scripts\utility::issp() || self.script_noteworthy != "steam")
	{
		thread pipe_damage(p, vec, damageowner, snd);
	}

	playfx(level._pipes._effect[self.script_noteworthy], p, vec);
	wait time;
	intervals--;
	while(level._pipes.num_pipe_fx <= 8 && intervals > 0)
	{
		playfx(level._pipes._effect[self.script_noteworthy], p, vec);
		wait time;
		intervals--;
	}

	snd playsound(endsnd);
	wait 0.5;
	snd stoploopsound(loopsnd);
	snd delete();
	self.pipe_fx_array = common_scripts\utility::array_removeundefined(self.pipe_fx_array);
	level._pipes.num_pipe_fx--;
}

pipe_damage(p, vec, damageowner, fx)
{
	if(!allow_pipe_damage())
	{
		return;
	}

	fx endon("death");
	origin = fx.origin + common_scripts\utility::vector_multiply(vectornormalize(vec), 40);
	dmg = level._pipes._dmg[self.script_noteworthy];
	for(;;)
	{
		if(!isdefined(self.damageowner))
		{
			self radiusdamage(origin, 36, dmg, dmg * 0.75, undefined, "MOD_TRIGGER_HURT");
		}
		else
		{
			self radiusdamage(origin, 36, dmg, dmg * 0.75, damageowner, "MOD_TRIGGER_HURT");
		}

		wait 0.4;
	}
}

allow_pipe_damage()
{
	if(!common_scripts\utility::issp())
	{
		return 0;
	}

	if(!isdefined(level.pipesdamage))
	{
		return 1;
	}

	return level.pipesdamage;
}

methodsinit()
{
	level._pipes._pipe_methods = [];
	level._pipes._pipe_methods["MOD_UNKNOWN"] = ::pipe_calc_splash;
	level._pipes._pipe_methods["MOD_PISTOL_BULLET"] = ::pipe_calc_ballistic;
	level._pipes._pipe_methods["MOD_RIFLE_BULLET"] = ::pipe_calc_ballistic;
	level._pipes._pipe_methods["MOD_GRENADE"] = ::pipe_calc_splash;
	level._pipes._pipe_methods["MOD_GRENADE_SPLASH"] = ::pipe_calc_splash;
	level._pipes._pipe_methods["MOD_PROJECTILE"] = ::pipe_calc_splash;
	level._pipes._pipe_methods["MOD_PROJECTILE_SPLASH"] = ::pipe_calc_splash;
	level._pipes._pipe_methods["MOD_TRIGGER_HURT"] = ::pipe_calc_splash;
	level._pipes._pipe_methods["MOD_EXPLOSIVE"] = ::pipe_calc_splash;
	level._pipes._pipe_methods["MOD_EXPLOSIVE_BULLET"] = ::pipe_calc_splash;
}

pipe_calc_ballistic(p, type)
{
	return p;
}

pipe_calc_splash(p, type)
{
	vec = vectornormalize(vectorfromlinetopoint(self.a, self.b, p));
	p = pointonsegmentnearesttopoint(self.a, self.b, p);
	return p + common_scripts\utility::vector_multiply(vec, 4);
}

pipe_calc_nofx(p, type)
{
	return undefined;
}

precachefx()
{
	steam = 0;
	fire = 0;
	foreach(value in self)
	{
		if(value.script_noteworthy == "water")
		{
			value.script_noteworthy = "steam";
		}

		if(value.script_noteworthy == "steam")
		{
			value willneverchange();
			steam = 1;
			continue;
		}

		if(value.script_noteworthy == "fire")
		{
			value willneverchange();
			fire = 1;
			continue;
		}
	}

	if(steam)
	{
		level._pipes._effect["steam"] = loadfx("impacts/pipe_steam");
		level._pipes._sound["steam_hit"] = "mtl_steam_pipe_hit";
		level._pipes._sound["steam_loop"] = "mtl_steam_pipe_hiss_loop";
		level._pipes._sound["steam_end"] = "mtl_steam_pipe_hiss_loop_end";
		level._pipes.fx_time["steam"] = 3;
		level._pipes._dmg["steam"] = 5;
	}

	if(fire)
	{
		level._pipes._effect["fire"] = loadfx("impacts/pipe_fire");
		level._pipes._sound["fire_hit"] = "mtl_gas_pipe_hit";
		level._pipes._sound["fire_loop"] = "mtl_gas_pipe_flame_loop";
		level._pipes._sound["fire_end"] = "mtl_gas_pipe_flame_end";
		level._pipes.fx_time["fire"] = 3;
		level._pipes._dmg["fire"] = 5;
		return;
	}
}