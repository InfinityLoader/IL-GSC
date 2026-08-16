/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_fx.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

initfx()
{
	if(!isdefined(level.func))
	{
		level.func = [];
	}

	if(!isdefined(level.func["create_triggerfx"]))
	{
		level.func["create_triggerfx"] = ::create_triggerfx;
	}

	level.exploderfunction = ::common_scripts\utility::exploder_before_load;
	waittillframeend;
	waittillframeend;
	level.exploderfunction = ::common_scripts\utility::exploder_after_load;
	for(i = 0;i < level.createfxent.size;i++)
	{
		ent = level.createfxent[i];
		ent common_scripts\_createfx::set_forward_and_up_vectors();
		if(ent.v["type"] == "loopfx")
		{
			ent thread loopfxthread();
		}

		if(ent.v["type"] == "oneshotfx")
		{
			ent thread oneshotfxthread();
		}

		if(ent.v["type"] == "soundfx")
		{
			ent thread create_loopsound();
		}
	}
}

print_org(fxcommand, fxid, fxpos, waittime)
{
	if(getdvar("debug") == "1")
	{
		return;
	}
}

oneshotfx(fxid, fxpos, waittime, fxpos2)
{
}

exploderfx(num, fxid, fxpos, waittime, fxpos2, firefx, firefxdelay, firefxsound, fxsound, fxquake, fxdamage, soundalias, repeat, delay_min, delay_max, damage_radius, firefxtimeout, exploder_group)
{
	if(1)
	{
		ent = common_scripts\utility::createexploder(fxid);
		ent.v["origin"] = fxpos;
		ent.v["angles"] = (0,0,0);
		if(isdefined(fxpos2))
		{
			ent.v["angles"] = vectortoangles(fxpos2 - fxpos);
		}

		ent.v["delay"] = waittime;
		ent.v["exploder"] = num;
		return;
	}

	fx = spawn("script_origin", (0,0,0));
	fx.origin = fxpos;
	fx.angles = vectortoangles(fxpos2 - fxpos);
	fx.script_exploder = num;
	fx.script_fxid = fxid;
	fx.script_delay = waittime;
	fx.script_firefx = firefx;
	fx.script_firefxdelay = firefxdelay;
	fx.script_firefxsound = firefxsound;
	fx.script_sound = fxsound;
	fx.script_earthquake = fxquake;
	fx.script_damage = fxdamage;
	fx.script_radius = damage_radius;
	fx.script_soundalias = soundalias;
	fx.script_firefxtimeout = firefxtimeout;
	fx.script_repeat = repeat;
	fx.script_delay_min = delay_min;
	fx.script_delay_max = delay_max;
	fx.script_exploder_group = exploder_group;
	forward = anglestoforward(fx.angles);
	forward = common_scripts\utility::vector_multiply(forward, 150);
	fx.targetpos = fxpos + forward;
	if(!isdefined(level._script_exploders))
	{
		level._script_exploders = [];
	}

	level._script_exploders[level._script_exploders.size] = fx;
	common_scripts\_createfx::createfx_showorigin(fxid, fxpos, waittime, fxpos2, "exploderfx", fx, undefined, firefx, firefxdelay, firefxsound, fxsound, fxquake, fxdamage, soundalias, repeat, delay_min, delay_max, damage_radius, firefxtimeout);
}

loopfx(fxid, fxpos, waittime, fxpos2, fxstart, fxstop, timeout)
{
	ent = common_scripts\utility::createloopeffect(fxid);
	ent.v["origin"] = fxpos;
	ent.v["angles"] = (0,0,0);
	if(isdefined(fxpos2))
	{
		ent.v["angles"] = vectortoangles(fxpos2 - fxpos);
	}

	ent.v["delay"] = waittime;
}

create_looper()
{
	self.looper = playloopedfx(level._effect[self.v["fxid"]], self.v["delay"], self.v["origin"], 0, self.v["forward"], self.v["up"]);
	create_loopsound();
}

create_loopsound()
{
	self notify("stop_loop");
	if(isdefined(self.v["soundalias"]) && self.v["soundalias"] != "nil")
	{
		if(isdefined(self.v["stopable"]) && self.v["stopable"])
		{
			if(isdefined(self.looper))
			{
				self.looper thread common_scripts\utility::loop_fx_sound(self.v["soundalias"], self.v["origin"], "death");
				return;
			}

			thread common_scripts\utility::loop_fx_sound(self.v["soundalias"], self.v["origin"], "stop_loop");
			return;
		}

		if(isdefined(self.looper))
		{
			self.looper thread common_scripts\utility::loop_fx_sound(self.v["soundalias"], self.v["origin"]);
			return;
		}

		thread common_scripts\utility::loop_fx_sound(self.v["soundalias"], self.v["origin"]);
		return;
	}
}

loopfxthread()
{
	common_scripts\utility::waitframe();
	if(isdefined(self.fxstart))
	{
		level waittill("start fx" + self.fxstart);
	}

	for(;;)
	{
		create_looper();
		if(isdefined(self.timeout))
		{
			thread loopfxstop(self.timeout);
		}

		if(isdefined(self.fxstop))
		{
			level waittill("stop fx" + self.fxstop);
		}
		else
		{
			return;
		}

		if(isdefined(self.looper))
		{
			self.looper delete();
		}

		if(isdefined(self.fxstart))
		{
			level waittill("start fx" + self.fxstart);
			continue;
		}

		return;
	}
}

loopfxchangeid(ent)
{
	self endon("death");
	ent waittill("effect id changed", change);
}

loopfxchangeorg(ent)
{
	self endon("death");
	for(;;)
	{
		ent waittill("effect org changed", change);
		self.origin = change;
	}
}

loopfxchangedelay(ent)
{
	self endon("death");
	ent waittill("effect delay changed", change);
}

loopfxdeletion(ent)
{
	self endon("death");
	ent waittill("effect deleted");
	self delete();
}

loopfxstop(timeout)
{
	self endon("death");
	wait timeout;
	self.looper delete();
}

loopsound(sound, pos, waittime)
{
	level thread loopsoundthread(sound, pos, waittime);
}

loopsoundthread(sound, pos, waittime)
{
	org = spawn("script_origin", pos);
	org.origin = pos;
	org playloopsound(sound);
}

gunfireloopfx(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax)
{
	thread gunfireloopfxthread(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax);
}

gunfireloopfxthread(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax)
{
	level endon("stop all gunfireloopfx");
	common_scripts\utility::waitframe();
	if(betweensetsmax < betweensetsmin)
	{
		temp = betweensetsmax;
		betweensetsmax = betweensetsmin;
		betweensetsmin = temp;
	}

	betweensetsbase = betweensetsmin;
	betweensetsrange = betweensetsmax - betweensetsmin;
	if(shotdelaymax < shotdelaymin)
	{
		temp = shotdelaymax;
		shotdelaymax = shotdelaymin;
		shotdelaymin = temp;
	}

	shotdelaybase = shotdelaymin;
	shotdelayrange = shotdelaymax - shotdelaymin;
	if(shotsmax < shotsmin)
	{
		temp = shotsmax;
		shotsmax = shotsmin;
		shotsmin = temp;
	}

	shotsbase = shotsmin;
	shotsrange = shotsmax - shotsmin;
	fxent = spawnfx(level._effect[fxid], fxpos);
	fxent willneverchange();
	for(;;)
	{
		shotnum = shotsbase + randomint(shotsrange);
		for(i = 0;i < shotnum;i++)
		{
			triggerfx(fxent);
			wait shotdelaybase + randomfloat(shotdelayrange);
		}

		wait betweensetsbase + randomfloat(betweensetsrange);
	}
}

gunfireloopfxvec(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax)
{
	thread gunfireloopfxvecthread(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax);
}

gunfireloopfxvecthread(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax)
{
	level endon("stop all gunfireloopfx");
	common_scripts\utility::waitframe();
	if(betweensetsmax < betweensetsmin)
	{
		temp = betweensetsmax;
		betweensetsmax = betweensetsmin;
		betweensetsmin = temp;
	}

	betweensetsbase = betweensetsmin;
	betweensetsrange = betweensetsmax - betweensetsmin;
	if(shotdelaymax < shotdelaymin)
	{
		temp = shotdelaymax;
		shotdelaymax = shotdelaymin;
		shotdelaymin = temp;
	}

	shotdelaybase = shotdelaymin;
	shotdelayrange = shotdelaymax - shotdelaymin;
	if(shotsmax < shotsmin)
	{
		temp = shotsmax;
		shotsmax = shotsmin;
		shotsmin = temp;
	}

	shotsbase = shotsmin;
	shotsrange = shotsmax - shotsmin;
	fxpos2 = vectornormalize(fxpos2 - fxpos);
	fxent = spawnfx(level._effect[fxid], fxpos, fxpos2);
	fxent willneverchange();
	for(;;)
	{
		shotnum = shotsbase + randomint(shotsrange);
		for(i = 0;i < int(shotnum / level.fxfireloopmod);i++)
		{
			triggerfx(fxent);
			delay = shotdelaybase + randomfloat(shotdelayrange) * level.fxfireloopmod;
			if(delay < 0.05)
			{
				delay = 0.05;
			}

			wait delay;
		}

		wait shotdelaybase + randomfloat(shotdelayrange);
		wait betweensetsbase + randomfloat(betweensetsrange);
	}
}

setfireloopmod(value)
{
	level.fxfireloopmod = 1 / value;
}

setup_fx()
{
	if(!isdefined(self.script_fxid) || !isdefined(self.script_fxcommand) || !isdefined(self.script_delay))
	{
		return;
	}

	if(isdefined(self.model))
	{
		if(self.model == "toilet")
		{
			thread burnville_paratrooper_hack();
			return;
		}
	}

	org = undefined;
	if(isdefined(self.target))
	{
		ent = getent(self.target, "targetname");
		if(isdefined(ent))
		{
			org = ent.origin;
		}
	}

	fxstart = undefined;
	if(isdefined(self.script_fxstart))
	{
		fxstart = self.script_fxstart;
	}

	fxstop = undefined;
	if(isdefined(self.script_fxstop))
	{
		fxstop = self.script_fxstop;
	}

	if(self.script_fxcommand == "OneShotfx")
	{
		oneshotfx(self.script_fxid, self.origin, self.script_delay, org);
	}

	if(self.script_fxcommand == "loopfx")
	{
		loopfx(self.script_fxid, self.origin, self.script_delay, org, fxstart, fxstop);
	}

	if(self.script_fxcommand == "loopsound")
	{
		loopsound(self.script_fxid, self.origin, self.script_delay);
	}

	self delete();
}

burnville_paratrooper_hack()
{
	normal = (0,0,self.angles[1]);
	id = level._effect[self.script_fxid];
	origin = self.origin;
	wait 1;
	level thread burnville_paratrooper_hack_loop(normal, origin, id);
	self delete();
}

burnville_paratrooper_hack_loop(normal, origin, id)
{
	for(;;)
	{
		playfx(id, origin);
		wait 30 + randomfloat(40);
	}
}

create_triggerfx()
{
	if(!verify_effects_assignment(self.v["fxid"]))
	{
		return;
	}

	self.looper = spawnfx(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
	triggerfx(self.looper, self.v["delay"]);
	self.looper willneverchange();
	create_loopsound();
}

verify_effects_assignment(effectid)
{
	if(isdefined(level._effect[effectid]))
	{
		return 1;
	}

	if(!isdefined(level._missing_fx))
	{
		level._missing_fx = [];
	}

	level._missing_fx[self.v["fxid"]] = effectid;
	verify_effects_assignment_print(effectid);
	return 0;
}

verify_effects_assignment_print(effectid)
{
	level notify("verify_effects_assignment_print");
	level endon("verify_effects_assignment_print");
	wait 0.05;
	keys = getarraykeys(level._missing_fx);
	foreach(key in keys)
	{
	}
}

oneshotfxthread()
{
	common_scripts\utility::waitframe();
	if(self.v["delay"] > 0)
	{
		wait self.v["delay"];
	}

	[[ level.func["create_triggerfx"] ]]();
}