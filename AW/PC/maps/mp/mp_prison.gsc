/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_prison.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 795 ms
 * Timestamp: 4/22/2024 2:18:09 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\mp_prison_precache::main();
	maps\createart\mp_prison_art::main();
	maps\mp\mp_prison_fx::main();
	maps\mp\mp_prison_lighting::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_prison");
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.mapcustomkillstreakfunc = ::prisoncustomkillstreakfunc;
	level.orbitalsupportoverridefunc = ::prisonpaladinoverrides;
	thread goliathvolumes();
	level.dronevisionset = "mp_instinct_osp";
	level.dronelightset = "mp_prison_drone";
	thread ambientanimation();
}

//Function Number: 2
goliathvolumes()
{
	level.goliath_bad_landing_volumes = getentarray("goliath_bad_landing_volume","targetname");
}

//Function Number: 3
prisoncustomkillstreakfunc()
{
	level thread maps\mp\killstreaks\streak_mp_prison::init();
}

//Function Number: 4
set_lighting_values()
{
	if(isusinghdr())
	{
		for(;;)
		{
			level waittill("connected",var_00);
			var_00 setclientdvars("r_tonemap","1","r_tonemapLockAutoExposureAdjust","0","r_tonemapAutoExposureAdjust","0");
		}
	}
}

//Function Number: 5
prisonpaladinoverrides()
{
	level.orbitalsupportoverrides.spawnheight = 7500;
	level.orbitalsupportoverrides.spawnradius = 4500;
	level.orbitalsupportoverrides.leftarc = 40;
	level.orbitalsupportoverrides.rightarc = 40;
	level.orbitalsupportoverrides.toparc = -38;
	level.orbitalsupportoverrides.bottomarc = 78;
}

//Function Number: 6
ambientanimation()
{
	var_00 = getentarray("guard_tower_radar","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread rotateradar();
	}
}

//Function Number: 7
rotateradar()
{
	if(!isdefined(level.rotatetime))
	{
		level.rotatetime = 20;
	}

	for(;;)
	{
		self rotatevelocity((0,-100,0),level.rotatetime);
		wait(level.rotatetime);
	}
}

//Function Number: 8
setupriotsuppresionsystem()
{
	precachelocationselector("map_artillery_selector");
	precachestring(&"KILLSTREAKS_MP_PRISON");
	precacheitem("mp_prison_gas");
	level.gasedvisionset = "mp_prison_gas";
	level.gas_alarm_sfx_alias = "mp_prison_gas_on_siren";
	level.gate_spark_fx = "gate_sparks";
	level._effect[level.gate_spark_fx] = loadfx("vfx/sparks/electrical_sparks_oneshot");
	var_00 = getentarray("gas_trigger","targetname");
	thread gasfieldsoff();
	if(var_00.size > 0)
	{
		precacheshellshock("mp_prison_gas");
		foreach(var_02 in var_00)
		{
			var_02 thread common_scripts\_dynamic_world::triggertouchthink(::playerenterarea,::playerleavearea);
		}

		thread onplayerconnect();
	}

	thread gasvisualssetup();
	thread setupgates();
	thread monitorriotsuppressionsystem();
}

//Function Number: 9
monitorriotsuppressionsystem()
{
	level endon("debug_mp_prison_gas");
	level.dynamiceventcount = 3;
	var_00 = 2;
	var_01 = maps\mp\_utility::gettimelimit();
	var_02 = gettime() + var_00 * 1000;
	var_03 = var_01 / level.dynamiceventcount * 60 * 1000;
	for(var_04 = 1;var_04 < level.dynamiceventcount;var_04++)
	{
		if(var_01 > 0)
		{
			var_02 = gettime() + var_03;
		}
		else
		{
			var_02 = gettime() + var_00 * 1000;
		}

		while(gettime() < var_02)
		{
			wait(1);
		}

		startriotsuppressionsystem();
	}
}

//Function Number: 10
startriotsuppressionsystem()
{
	var_00 = 20;
	thread gasvisualswarningstart();
	thread movegates();
	thread rotategates();
	thread rotategatesconstant();
	thread gas_alarm_on_vo();
	wait(5);
	thread gasvisualsstart();
	thread aud_gas_sfx();
	gasfieldson();
	wait(var_00);
	level notify("stop_gas_sfx");
	thread resetgates();
	thread resetrotategates();
	thread resetrotategateconstant();
	thread gas_alarm_off_vo();
	gasfieldsoff();
}

//Function Number: 11
aud_gas_sfx()
{
	var_00 = (-2666,1305,828);
	var_01 = (-2282,1305,840);
	var_02 = (-2026,1305,840);
	var_03 = (-1557,1305,840);
	var_04 = (-1512,903,840);
	var_05 = (-2024,903,840);
	var_06 = (-2411,903,840);
	var_07 = (-2666,903,840);
	var_08 = [var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07];
	foreach(var_0A in var_08)
	{
		thread maps\mp\_audio::snd_play_in_space("mp_prison_gas_valve_start",var_0A);
		thread maps\mp\_audio::snd_play_loop_in_space("mp_prison_gas_lp",var_0A,"stop_gas_sfx",2.2);
	}
}

//Function Number: 12
gas_alarm_on_vo()
{
	var_00 = spawn("script_origin",(-2143,1108,946));
	var_00 playsound("mp_prison_gas_on");
}

//Function Number: 13
gas_alarm_off_vo()
{
	var_00 = spawn("script_origin",(-2143,1108,946));
	var_00 playsound("mp_prison_gas_off_02");
}

//Function Number: 14
gasvisualssetup()
{
	if(!isdefined(level.mp_prison_killstreak))
	{
		level.mp_prison_killstreak = spawnstruct();
	}

	if(!isdefined(level.mp_prison_killstreak.gas_tags))
	{
		var_00 = common_scripts\utility::getstructarray("gas_org","targetname");
		level.mp_prison_killstreak.gas_tags = [];
		foreach(var_02 in var_00)
		{
			var_03 = var_02 common_scripts\utility::spawn_tag_origin();
			var_03 show();
			level.mp_prison_killstreak.gas_tags[level.mp_prison_killstreak.gas_tags.size] = var_03;
		}
	}

	if(!isdefined(level.mp_prison_killstreak.gas_warning_light_tags))
	{
		var_00 = common_scripts\utility::getstructarray("flashing_red_light","targetname");
		level.mp_prison_killstreak.gas_warning_light_tags = [];
		foreach(var_02 in var_00)
		{
			var_03 = var_02 common_scripts\utility::spawn_tag_origin();
			var_03 show();
			level.mp_prison_killstreak.gas_warning_light_tags[level.mp_prison_killstreak.gas_warning_light_tags.size] = var_03;
		}
	}
}

//Function Number: 15
gasvisualswarningstart()
{
	foreach(var_01 in level.mp_prison_killstreak.gas_warning_light_tags)
	{
		var_01 thread playloopingsoundonorigin();
	}

	activateclientexploder(10);
}

//Function Number: 16
setupgates()
{
	var_00 = getentarray("moving_gate","targetname");
	level.mp_prison_killstreak.gates = [];
	foreach(var_02 in var_00)
	{
		var_03 = spawnstruct();
		var_02.originalpos = var_02.origin;
		var_03.gate = var_02;
		var_04 = common_scripts\utility::getstruct(var_02.target,"targetname");
		var_03.dest = var_04;
		var_05 = getent(var_04.target,"targetname");
		var_05.originalpos = var_05.origin;
		var_03.collision = var_05;
		var_06 = common_scripts\utility::getstruct(var_05.target,"targetname");
		var_07 = var_06 common_scripts\utility::spawn_tag_origin();
		var_07 show();
		var_07 linkto(var_02);
		var_08 = common_scripts\utility::getstruct(var_06.target,"targetname");
		var_09 = var_08 common_scripts\utility::spawn_tag_origin();
		var_09 show();
		var_09 linkto(var_02);
		var_03.sparks = [var_07,var_09];
		level.mp_prison_killstreak.gates[level.mp_prison_killstreak.gates.size] = var_03;
	}

	var_00 = getentarray("rotating_gate","targetname");
	level.mp_prison_killstreak.rotating_gates = [];
	foreach(var_02 in var_00)
	{
		var_03 = spawnstruct();
		var_02.originalpos = var_02.origin;
		var_02.originalrot = var_02.angles;
		var_03.gate = var_02;
		var_04 = common_scripts\utility::getstruct(var_02.target,"targetname");
		var_03.dest = var_04;
		var_05 = getent(var_04.target,"targetname");
		var_05.originalpos = var_05.origin;
		var_05.angles = var_02.angles + (0,-90,0);
		var_05.originalrot = var_05.angles;
		var_03.collision = var_05;
		var_06 = common_scripts\utility::getstruct(var_05.target,"targetname");
		var_07 = var_06 common_scripts\utility::spawn_tag_origin();
		var_07 show();
		var_07 linkto(var_02);
		var_08 = common_scripts\utility::getstruct(var_06.target,"targetname");
		var_09 = var_08 common_scripts\utility::spawn_tag_origin();
		var_09 show();
		var_09 linkto(var_02);
		var_03.sparks = [var_07,var_09];
		if(isdefined(var_08.target))
		{
			var_0C = getent(var_08.target,"targetname");
			var_03.kill_vol = var_0C;
			var_03.kill_vol common_scripts\utility::trigger_off_proc();
		}

		level.mp_prison_killstreak.rotating_gates[level.mp_prison_killstreak.rotating_gates.size] = var_03;
	}

	var_00 = getentarray("rotating_gate_constant","targetname");
	level.mp_prison_killstreak.rotating_gate_constant = [];
	foreach(var_02 in var_00)
	{
		var_03 = spawnstruct();
		var_02.originalpos = var_02.origin;
		var_02.originalrot = var_02.angles;
		var_03.gate = var_02;
		var_04 = common_scripts\utility::getstruct(var_02.target,"targetname");
		var_03.dest = var_04;
		var_06 = common_scripts\utility::getstruct(var_04.target,"targetname");
		if(!isdefined(var_06))
		{
			continue;
		}

		var_07 = var_06 common_scripts\utility::spawn_tag_origin();
		var_07 show();
		var_07 linkto(var_02);
		var_08 = common_scripts\utility::getstruct(var_06.target,"targetname");
		if(!isdefined(var_08))
		{
			var_07 delete();
			continue;
		}

		var_09 = var_08 common_scripts\utility::spawn_tag_origin();
		var_09 show();
		var_09 linkto(var_02);
		var_03.sparks = [var_07,var_09];
		level.mp_prison_killstreak.rotating_gate_constant[level.mp_prison_killstreak.rotating_gate_constant.size] = var_03;
	}
}

//Function Number: 17
movegates()
{
	var_00 = 0.5;
	foreach(var_02 in level.mp_prison_killstreak.gates)
	{
		var_02.gate moveto(var_02.dest.origin,var_00,0.1,0.2);
		var_02.collision moveto(var_02.dest.origin,var_00,0.1,0.2);
		var_02 thread bouncegate(var_00);
	}
}

//Function Number: 18
rotategates()
{
	var_00 = 0.5;
	foreach(var_02 in level.mp_prison_killstreak.rotating_gates)
	{
		var_02 thread gatefxon();
		var_02.gate moveto(var_02.dest.origin,var_00,0.1,0.2);
		var_02.gate rotateto(var_02.dest.angles,var_00,0.1,0.2);
		var_02.collision rotateto(var_02.dest.angles - (0,90,0),var_00,0.1,0.2);
		var_02.collision moveto(var_02.dest.origin,var_00,0.1,0.2);
	}

	wait(var_00);
	foreach(var_02 in level.mp_prison_killstreak.rotating_gates)
	{
		var_02 thread gatefxoff();
	}
}

//Function Number: 19
rotategatesconstant()
{
	foreach(var_01 in level.mp_prison_killstreak.rotating_gate_constant)
	{
		var_01 thread rotategatebounce();
	}
}

//Function Number: 20
rotategatebounce()
{
	self endon("stop_bounce");
	for(;;)
	{
		var_00 = randomfloatrange(0.1,0.5);
		thread gatefxon();
		self.gate moveto(self.dest.origin,var_00,0.05,0.05);
		self.gate rotateto(self.dest.angles,var_00,0.05,0.05);
		wait(var_00);
		self.gate moveto(self.gate.originalpos,var_00,0.05,0.05);
		self.gate rotateto(self.gate.originalrot,var_00,0.05,0.05);
		thread gatefxoff();
		wait(randomfloatrange(0.1,1));
	}
}

//Function Number: 21
resetrotategateconstant()
{
	var_00 = 0.5;
	foreach(var_02 in level.mp_prison_killstreak.rotating_gate_constant)
	{
		var_02 notify("stop_bounce");
	}

	wait(0.5);
	foreach(var_02 in level.mp_prison_killstreak.rotating_gate_constant)
	{
		var_02 thread gatefxon();
		var_02.gate moveto(var_02.gate.originalpos,var_00,0.05,0.05);
		var_02.gate rotateto(var_02.gate.originalrot,var_00,0.05,0.05);
	}

	wait(var_00);
	foreach(var_02 in level.mp_prison_killstreak.rotating_gate_constant)
	{
		var_02 thread gatefxoff();
	}
}

//Function Number: 22
resetrotategates()
{
	var_00 = 0.5;
	foreach(var_02 in level.mp_prison_killstreak.rotating_gates)
	{
		var_02 thread gatefxon();
		if(isdefined(var_02.kill_vol))
		{
			var_02.kill_vol common_scripts\utility::trigger_on_proc();
		}

		var_02.gate moveto(var_02.gate.originalpos,var_00,0.1,0.2);
		var_02.gate rotateto(var_02.gate.originalrot,var_00,0.1,0.2);
		var_02.collision rotateto(var_02.collision.originalrot,var_00,0.1,0.2);
		var_02.collision moveto(var_02.collision.originalpos,var_00,0.1,0.2);
	}

	wait(var_00);
	foreach(var_02 in level.mp_prison_killstreak.rotating_gates)
	{
		if(isdefined(var_02.kill_vol))
		{
			var_02.kill_vol common_scripts\utility::trigger_off_proc();
		}

		var_02 thread gatefxoff();
	}
}

//Function Number: 23
resetgates()
{
	var_00 = 0.5;
	foreach(var_02 in level.mp_prison_killstreak.gates)
	{
		var_02 notify("stop_bounce");
	}

	wait(0.5);
	foreach(var_02 in level.mp_prison_killstreak.gates)
	{
		var_02 thread gatefxon();
		var_02.gate moveto(var_02.gate.originalpos,var_00,0.1,0.2);
		var_02.collision moveto(var_02.collision.originalpos,var_00,0.1,0.2);
	}

	wait(var_00);
	foreach(var_02 in level.mp_prison_killstreak.gates)
	{
		var_02 thread gatefxoff();
	}
}

//Function Number: 24
bouncegate(param_00)
{
	self endon("stop_bounce");
	thread gatefxon();
	wait(param_00);
	thread gatefxoff();
	var_01 = anglestoforward(vectortoangles(self.dest.origin - self.gate.originalpos));
	var_02 = var_01 * 2;
	for(;;)
	{
		var_03 = randomfloatrange(0.1,0.5);
		var_04 = randomfloatrange(0.1,0.5);
		thread gatefxon();
		self.gate moveto(self.gate.origin + var_02,var_03,0.05,0.05);
		wait(var_03);
		self.gate moveto(self.dest.origin,var_04,0.05,0.05);
		wait(var_04);
		thread gatefxoff();
		wait(randomfloat(2));
	}
}

//Function Number: 25
gatefxon()
{
	self endon("stop_sparks");
	for(;;)
	{
		foreach(var_01 in self.sparks)
		{
			playfxontag(common_scripts\utility::getfx(level.gate_spark_fx),var_01,"tag_origin");
		}

		wait(randomfloatrange(0.5,1));
	}
}

//Function Number: 26
gatefxoff()
{
	self notify("stop_sparks");
	foreach(var_01 in self.sparks)
	{
		stopfxontag(common_scripts\utility::getfx(level.gate_spark_fx),var_01,"tag_origin");
	}
}

//Function Number: 27
gasvisualsstart()
{
	activateclientexploder(20);
}

//Function Number: 28
gasvisualsend()
{
}

//Function Number: 29
playloopingsoundonorigin()
{
	wait(3.5);
	thread maps\mp\_utility::playsoundinspace(level.gas_alarm_sfx_alias,self.origin);
}

//Function Number: 30
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.numareas = 0;
	}
}

//Function Number: 31
playerenterarea(param_00)
{
	self.numareas++;
	if(self.numareas == 1)
	{
		gaseffect();
	}
}

//Function Number: 32
playerleavearea(param_00)
{
	self.numareas--;
	if(self.numareas != 0)
	{
		return;
	}

	self.poison = 0;
	self notify("leftTrigger");
	if(isdefined(self.gasoverlay))
	{
		self.gasoverlay fadeoutblackout(0.1,0);
	}
}

//Function Number: 33
gasfieldson()
{
	var_00 = getentarray("gas_trigger","targetname");
	foreach(var_02 in var_00)
	{
		var_02 common_scripts\utility::trigger_on();
	}
}

//Function Number: 34
gasfieldsoff()
{
	var_00 = getentarray("gas_trigger","targetname");
	foreach(var_02 in var_00)
	{
		var_02 common_scripts\utility::trigger_off();
	}
}

//Function Number: 35
soundwatcher(param_00)
{
	common_scripts\utility::waittill_any("death","leftTrigger");
	self stoploopsound();
}

//Function Number: 36
gaseffect()
{
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("leftTrigger");
	self.poison = 0;
	thread soundwatcher(self);
	for(;;)
	{
		self.poison++;
		switch(self.poison)
		{
			case 1:
				self viewkick(1,self.origin);
				break;
	
			case 3:
				self shellshock("mp_prison_gas",4);
				self viewkick(3,self.origin);
				dogasdamage(25);
				break;
	
			case 4:
				self shellshock("mp_prison_gas",5);
				self viewkick(15,self.origin);
				thread blackout();
				dogasdamage(45);
				break;
	
			case 6:
				self shellshock("mp_prison_gas",5);
				self viewkick(75,self.origin);
				dogasdamage(80);
				break;
	
			case 8:
				self shellshock("mp_prison_gas",5);
				self viewkick(127,self.origin);
				dogasdamage(175);
				break;
		}

		wait(1);
	}

	wait(5);
}

//Function Number: 37
blackout()
{
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("leftTrigger");
	if(!isdefined(self.gasoverlay))
	{
		self.gasoverlay = newclienthudelem(self);
		self.gasoverlay.x = 0;
		self.gasoverlay.y = 0;
		self.gasoverlay setshader("black",640,480);
		self.gasoverlay.alignx = "left";
		self.gasoverlay.aligny = "top";
		self.gasoverlay.horzalign = "fullscreen";
		self.gasoverlay.vertalign = "fullscreen";
		self.gasoverlay.alpha = 0;
	}

	var_00 = 1;
	var_01 = 2;
	var_02 = 0.25;
	var_03 = 1;
	var_04 = 5;
	var_05 = 100;
	var_06 = 0;
	for(;;)
	{
		while(self.poison > 1)
		{
			var_07 = var_05 - var_04;
			var_06 = self.poison - var_04 / var_07;
			if(var_06 < 0)
			{
				var_06 = 0;
			}
			else if(var_06 > 1)
			{
				var_06 = 1;
			}

			var_08 = var_01 - var_00;
			var_09 = var_00 + var_08 * 1 - var_06;
			var_0A = var_03 - var_02;
			var_0B = var_02 + var_0A * var_06;
			var_0C = var_06 * 0.5;
			if(var_06 == 1)
			{
				break;
			}

			var_0D = var_09 / 2;
			self.gasoverlay fadeinblackout(var_0D,var_0B);
			self.gasoverlay fadeoutblackout(var_0D,var_0C);
			wait(var_06 * 0.5);
		}

		if(var_06 == 1)
		{
			break;
		}

		if(self.gasoverlay.alpha != 0)
		{
			self.gasoverlay fadeoutblackout(1,0);
		}

		wait(0.05);
	}

	self.gasoverlay fadeinblackout(2,0);
}

//Function Number: 38
dogasdamage(param_00)
{
	self thread [[ level.callbackplayerdamage ]](self,self,param_00,0,"MOD_SUICIDE","mp_prison_gas",self.origin,(0,0,0) - self.origin,"none",0);
}

//Function Number: 39
fadeinblackout(param_00,param_01)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	wait(param_00);
}

//Function Number: 40
fadeoutblackout(param_00,param_01)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	wait(param_00);
}