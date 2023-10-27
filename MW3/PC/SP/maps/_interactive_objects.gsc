/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_interactive_objects.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 36
 * Decompile Time: 642 ms
 * Timestamp: 10/27/2023 2:23:03 AM
*******************************************************************/

//Function Number: 1
main()
{
	common_scripts\utility::flag_init("no_ai_tv_damage");
	var_00 = 0;
	var_01 = getentarray("explodable_barrel","targetname");
	if(var_01.size)
	{
		var_00 = 1;
	}

	var_01 = getentarray("explodable_barrel","script_noteworthy");
	if(var_01.size > 0)
	{
		var_00 = 1;
	}

	if(var_00)
	{
		level.breakables_fx["barrel"]["explode"] = loadfx("props/barrelExp");
		level.breakables_fx["barrel"]["burn_start"] = loadfx("props/barrel_ignite");
		level.breakables_fx["barrel"]["burn"] = loadfx("props/barrel_fire_top");
	}

	var_02 = getentarray("oil_spill","targetname");
	if(var_02.size)
	{
		level.breakables_fx["oilspill"]["burn"] = loadfx("props/barrel_fire");
		level.breakables_fx["oilspill"]["spark"] = loadfx("impacts/small_metalhit_1");
	}

	var_03 = getentarray("tincan","targetname");
	if(var_03.size)
	{
		level.breakables_fx["tincan"] = loadfx("props/tincan_bounce");
	}

	var_04 = 0;
	var_05 = getentarray("breakable","targetname");
	if(var_05.size)
	{
		var_04 = 1;
	}

	var_05 = getentarray("breakable_vase","targetname");
	if(var_05.size)
	{
		var_04 = 1;
	}

	var_05 = getentarray("breakable box","targetname");
	if(var_01.size)
	{
		var_04 = 1;
	}

	var_05 = getentarray("breakable box","script_noteworthy");
	if(var_01.size)
	{
		var_04 = 1;
	}

	if(var_04)
	{
		level.breakables_fx["vase"] = loadfx("props/vase_water");
		level.breakables_fx["bottle"] = loadfx("props/wine_bottle");
		level.breakables_fx["box"][0] = loadfx("props/crateExp_dust");
		level.breakables_fx["box"][1] = loadfx("props/crateExp_dust");
		level.breakables_fx["box"][2] = loadfx("props/crateExp_dust");
		level.breakables_fx["box"][3] = loadfx("props/crateExp_ammo");
	}

	var_06 = getentarray("glass","targetname");
	var_06 = common_scripts\utility::array_combine(var_06,getentarray("glass","script_noteworthy"));
	if(var_06.size)
	{
		level._glass_info = [];
		level._glass_info["glass_large"]["breakfx"] = loadfx("props/car_glass_large");
		level._glass_info["glass_large"]["breaksnd"] = "veh_glass_break_large";
		level._glass_info["glass_med"]["breakfx"] = loadfx("props/car_glass_med");
		level._glass_info["glass_med"]["breaksnd"] = "veh_glass_break_small";
		level._glass_info["glass_small"]["breakfx"] = loadfx("props/car_glass_headlight");
		level._glass_info["glass_small"]["breaksnd"] = "veh_glass_break_small";
	}

	var_07 = getentarray("interactive_tv","targetname");
	if(var_07.size)
	{
		precachemodel("com_tv2_d");
		precachemodel("com_tv1");
		precachemodel("com_tv2");
		precachemodel("com_tv1_testpattern");
		precachemodel("com_tv2_testpattern");
		level.breakables_fx["tv_explode"] = loadfx("explosions/tv_explosion");
	}

	level.var_1DDE = getentarray("interactive_tv_light","targetname");
	var_08 = getentarray("destroyable_security_camera","script_noteworthy");
	if(var_08.size)
	{
		precachemodel("com_security_camera");
		precachemodel("com_security_camera_destroyed");
		level.breakables_fx["security_camera_explode"] = loadfx("props/securitycamera_explosion");
	}

	level.tv_lite_array = "barrel_mtl_explode";
	var_09 = 25;
	level.var_1DE0["orange vase"] = 1;
	level.var_1DE0["green vase"] = 1;
	level.var_1DE0["bottle"] = 1;
	level.var_1DE1 = 150;
	level.precachemodeltype = [];
	level.barrelexplodingthisframe = 0;
	level.breakables_clip = [];
	level.breakables_clip = getentarray("vase_break_remove","targetname");
	level.console_auto_aim_2nd = [];
	level.console_auto_aim_2nd = getentarray("xenon_auto_aim","targetname");
	level.var_1DE6 = getentarray("xenon_auto_aim_secondary","targetname");
	for(var_0A = 0;var_0A < level.console_auto_aim_2nd.size;var_0A++)
	{
		level.console_auto_aim_2nd[var_0A] notsolid();
	}

	for(var_0A = 0;var_0A < level.var_1DE6.size;var_0A++)
	{
		level.var_1DE6[var_0A] notsolid();
	}

	maps\_utility::set_console_status();
	if(level.console)
	{
		level.console_auto_aim_2nd = undefined;
		level.var_1DE6 = undefined;
	}

	var_0B = getentarray("breakable clip","targetname");
	for(var_0A = 0;var_0A < var_0B.size;var_0A++)
	{
		level.breakables_clip[level.breakables_clip.size] = var_0B[var_0A];
	}

	level._breakable_utility_modelarray = [];
	level._breakable_utility_modelindex = 0;
	level._breakable_utility_maxnum = var_09;
	common_scripts\utility::array_thread(getentarray("tincan","targetname"),::tincan_think);
	common_scripts\utility::array_thread(getentarray("helmet_pop","targetname"),::helmet_pop);
	common_scripts\utility::array_thread(getentarray("explodable_barrel","targetname"),::explodable_barrel_think);
	common_scripts\utility::array_thread(getentarray("explodable_barrel","script_noteworthy"),::explodable_barrel_think);
	common_scripts\utility::array_thread(getentarray("shuddering_entity","targetname"),::shuddering_entity_think);
	common_scripts\utility::array_thread(getentarray("breakable box","targetname"),::breakable_think);
	common_scripts\utility::array_thread(getentarray("breakable box","script_noteworthy"),::breakable_think);
	common_scripts\utility::array_thread(getentarray("breakable","targetname"),::breakable_think);
	common_scripts\utility::array_thread(getentarray("breakable_vase","targetname"),::breakable_think);
	common_scripts\utility::array_thread(getentarray("oil_spill","targetname"),::oil_spill_think);
	common_scripts\utility::array_thread(getentarray("glass","targetname"),::glass_logic);
	common_scripts\utility::array_thread(getentarray("interactive_tv","targetname"),::tv_logic);
	common_scripts\utility::array_thread(getentarray("destroyable_security_camera","script_noteworthy"),::security_camera_logic);
}

//Function Number: 2
security_camera_logic()
{
	self setcandamage(1);
	var_00 = undefined;
	switch(self.model)
	{
		case "com_security_camera":
			var_00 = "com_security_camera_destroyed";
			break;
	}

	self waittill("damage",var_01,var_02,var_03,var_04,var_05);
	self setmodel(var_00);
	playfxontag(level.breakables_fx["security_camera_explode"],self,"tag_deathfx");
}

//Function Number: 3
tv_logic()
{
	self setcandamage(1);
	self.damagemodel = undefined;
	self.offmodel = undefined;
	self.damagemodel = "com_tv2_d";
	self.offmodel = "com_tv2";
	self.onmodel = "com_tv2_testpattern";
	if(issubstr(self.model,"1"))
	{
		self.offmodel = "com_tv1";
		self.onmodel = "com_tv1_testpattern";
	}

	if(isdefined(self.target))
	{
		if(isdefined(level.disable_interactive_tv_use_triggers))
		{
			var_00 = getent(self.target,"targetname");
			if(isdefined(var_00))
			{
				var_00 delete();
			}
		}
		else
		{
			self.usetrig = getent(self.target,"targetname");
			self.usetrig usetriggerrequirelookat();
			self.usetrig setcursorhint("HINT_NOICON");
		}
	}

	var_01 = maps\_utility::get_array_of_closest(self.origin,level.var_1DDE,undefined,undefined,64);
	if(var_01.size)
	{
		self.lite = var_01[0];
		level.var_1DDE = common_scripts\utility::array_remove(level.var_1DDE,self.lite);
		self.liteintensity = self.lite getlightintensity();
	}

	thread tv_damage();
	if(isdefined(self.usetrig))
	{
		thread tv_off();
	}
}

//Function Number: 4
tv_off()
{
	self.usetrig endon("death");
	for(;;)
	{
		wait 0.2;
		self.usetrig waittill("trigger");
		self notify("off");
		if(self.model == self.offmodel)
		{
			self setmodel(self.onmodel);
			if(isdefined(self.lite))
			{
				self.lite setlightintensity(self.liteintensity);
			}

			continue;
		}

		self setmodel(self.offmodel);
		if(isdefined(self.lite))
		{
			self.lite setlightintensity(0);
		}
	}
}

//Function Number: 5
tv_damage()
{
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(common_scripts\utility::flag("no_ai_tv_damage"))
		{
			if(!isalive(var_01))
			{
				continue;
			}

			if(!isplayer(var_01))
			{
				continue;
			}
		}

		break;
	}

	if(isdefined(level.tvhook))
	{
		[[ level.tvhook ]]();
	}

	self notify("off");
	if(isdefined(self.usetrig))
	{
		self.usetrig notify("death");
	}

	self setmodel(self.damagemodel);
	if(isdefined(self.lite))
	{
		self.lite setlightintensity(0);
	}

	playfxontag(level.breakables_fx["tv_explode"],self,"tag_fx");
	self playsound("tv_shot_burst");
	if(isdefined(self.usetrig))
	{
		self.usetrig delete();
	}
}

//Function Number: 6
glass_logic()
{
	var_00 = undefined;
	var_01 = undefined;
	var_02 = undefined;
	var_03 = 0;
	if(isdefined(self.target))
	{
		var_02 = getent(self.target,"targetname");
	}

	if(isdefined(self.script_linkto))
	{
		var_04 = common_scripts\utility::get_links();
		var_05 = getent(var_04[0],"script_linkname");
		self linkto(var_05);
	}

	switch(self.destructible_type)
	{
		case "glass_large":
			break;

		case "glass_med":
			break;

		case "glass_small":
			break;

		default:
			break;
	}

	if(isdefined(var_02))
	{
		var_03 = 99;
		var_02 linkto(self);
		var_02 hide();
		var_01 = var_02 setcontents(0);
	}

	if(isdefined(self.script_health))
	{
		var_03 = self.script_health;
	}
	else if(isdefined(var_02))
	{
		var_03 = 99;
	}
	else
	{
		var_03 = 250;
	}

	self setcandamage(1);
	while(var_03 > 0)
	{
		self waittill("damage",var_06,var_07,var_00,var_08,var_09);
		if(!isdefined(var_00))
		{
			var_00 = (0,0,1);
		}

		if(!isdefined(var_09))
		{
			var_06 = 100000;
			continue;
		}

		if(var_09 == "MOD_GRENADE_SPLASH")
		{
			var_06 = var_06 * 1.75;
			continue;
		}

		if(var_09 == "MOD_IMPACT")
		{
			var_06 = 100000;
		}

		var_03 = var_03 - var_06;
	}

	var_0A = var_03 * -1;
	self hide();
	self notsolid();
	if(isdefined(var_02))
	{
		var_02 show();
		var_02 setcandamage(1);
		var_03 = 200 - var_0A;
		var_02 setcontents(var_01);
		while(var_03 > 0)
		{
			var_02 waittill("damage",var_06,var_0B,var_00,var_08,var_09);
			if(!isdefined(var_00))
			{
				var_00 = (0,0,1);
			}

			if(!isdefined(var_09))
			{
				var_06 = 100000;
				continue;
			}

			if(var_09 == "MOD_GRENADE_SPLASH")
			{
				var_06 = var_06 * 1.75;
				continue;
			}

			if(var_09 == "MOD_IMPACT")
			{
				break;
			}

			var_03 = var_03 - var_06;
		}

		var_02 delete();
	}

	glass_play_break_fx(self getorigin(),self.destructible_type,var_00);
	self delete();
}

//Function Number: 7
glass_play_break_fx(param_00,param_01,param_02)
{
	thread common_scripts\utility::play_sound_in_space(level._glass_info[param_01]["breaksnd"],param_00);
	playfx(level._glass_info[param_01]["breakfx"],param_00,param_02);
	level notify("glass_shatter");
}

//Function Number: 8
oil_spill_think()
{
	self.end = common_scripts\utility::getstruct(self.target,"targetname");
	self.start = common_scripts\utility::getstruct(self.end.target,"targetname");
	self.barrel = getclosestent(self.start.origin,getentarray("explodable_barrel","targetname"));
	if(isdefined(self.barrel))
	{
		self.barrel.oilspill = 1;
		thread oil_spill_burn_after();
	}

	self.extra = getent(self.target,"targetname");
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(var_04 == "MOD_MELEE" || var_04 == "MOD_IMPACT")
		{
			continue;
		}

		self.damageowner = var_01;
		playfx(level.breakables_fx["oilspill"]["spark"],var_03,var_02);
		var_03 = pointonsegmentnearesttopoint(self.start.origin,self.end.origin,var_03);
		thread oil_spill_burn_section(var_03);
		thread oil_spill_burn(var_03,self.start.origin);
		thread oil_spill_burn(var_03,self.end.origin);
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

//Function Number: 9
oil_spill_burn_after()
{
	for(;;)
	{
		self.barrel waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(var_04 == "MOD_MELEE" || var_04 == "MOD_IMPACT")
		{
			continue;
		}

		self.damageowner = var_01;
		break;
	}

	self radiusdamage(self.start.origin,4,10,10,self.damageowner);
}

//Function Number: 10
oil_spill_burn(param_00,param_01)
{
	var_02 = vectornormalize(param_01 - param_00);
	var_03 = distance(param_00,param_01);
	var_04 = 8;
	var_05 = var_02 * var_04;
	var_06 = vectortoangles(var_02);
	var_07 = anglestoright(var_06);
	var_08 = getentarray("explodable_barrel","targetname");
	var_09 = 484;
	var_0A = spawn("script_origin",param_00);
	var_0B = 0;
	for(;;)
	{
		var_03 = var_03 - var_04;
		if(var_03 < var_04 * 0.1)
		{
			break;
		}

		param_00 = param_00 + var_05 + var_07 * randomfloatrange(-6,6);
		thread oil_spill_burn_section(param_00);
		var_0B++;
		if(var_0B == 4)
		{
			badplace_cylinder("",0.5,param_00,64,64);
			var_0B = 0;
		}

		var_0A.origin = param_00;
		var_0C = [];
		var_08 = common_scripts\utility::array_removeundefined(var_08);
		for(var_0D = 0;var_0D < var_08.size;var_0D++)
		{
			var_0E = anglestoup(var_08[var_0D].angles);
			var_0F = var_08[var_0D].origin + var_0E * 22;
			var_10 = physicstrace(var_0F,var_0F + (0,0,-64));
			if(distancesquared(param_00,var_10) < var_09)
			{
				var_0C[var_0C.size] = var_08[var_0D];
				var_08[var_0D] dodamage(80 + randomfloat(10),param_00);
			}
		}

		for(var_0D = 0;var_0D < var_0C.size;var_0D++)
		{
			var_08 = common_scripts\utility::array_remove(var_08,var_0C[var_0D]);
		}

		wait 0.1;
	}

	if(!isdefined(self.barrel))
	{
		return;
	}

	if(distance(param_00,self.start.origin) < 32)
	{
		self.barrel dodamage(80 + randomfloat(10),param_00);
	}
}

//Function Number: 11
oil_spill_burn_section(param_00)
{
	var_01 = 0;
	var_02 = 0;
	playfx(level.breakables_fx["oilspill"]["burn"],param_00);
}

//Function Number: 12
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
	xenon_auto_aim();
	self.damagetaken = 0;
	self setcandamage(1);
	for(;;)
	{
		var_00 = undefined;
		var_01 = undefined;
		var_02 = undefined;
		var_03 = undefined;
		var_04 = undefined;
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(var_04 == "MOD_MELEE" || var_04 == "MOD_IMPACT")
		{
			continue;
		}

		self.damageowner = var_01;
		if(level.barrelexplodingthisframe)
		{
			wait randomfloat(1);
		}

		self.damagetaken = self.damagetaken + var_00;
		if(self.damagetaken == var_00)
		{
			thread explodable_barrel_burn();
		}
	}
}

//Function Number: 13
explodable_barrel_burn()
{
	var_00 = 0;
	var_01 = 0;
	var_02 = anglestoup(self.angles);
	var_03 = anglestoup((0,90,0));
	var_04 = vectordot(var_02,var_03);
	var_05 = (0,0,0);
	var_06 = var_02 * 44;
	if(var_04 < 0.5)
	{
		var_05 = var_02 * 22 - (0,0,30);
		var_06 = var_02 * 22 + (0,0,14);
	}

	while(self.damagetaken < level.var_1DE1)
	{
		if(!var_01)
		{
			playfx(level.breakables_fx["barrel"]["burn_start"],self.origin + var_05);
			var_01 = 1;
		}

		if(var_00 > 19)
		{
			var_00 = 0;
		}

		playfx(level.breakables_fx["barrel"]["burn"],self.origin + var_06);
		if(var_00 == 0)
		{
			self.damagetaken = self.damagetaken + 10 + randomfloat(10);
			badplace_cylinder("",1,self.origin,128,250);
		}

		var_00++;
		wait 0.05;
		if(!isdefined(self))
		{
			return;
		}
	}

	self.damagetaken = undefined;
	thread explodable_barrel_explode();
}

//Function Number: 14
explodable_barrel_explode()
{
	self notify("exploding");
	self notify("death");
	var_00 = anglestoup(self.angles);
	var_01 = anglestoup((0,90,0));
	var_02 = vectordot(var_00,var_01);
	var_03 = (0,0,0);
	if(var_02 < 0.5)
	{
		var_04 = self.origin + var_00 * 22;
		var_05 = physicstrace(var_04,var_04 + (0,0,-64));
		var_03 = var_05 - self.origin;
	}

	var_03 = var_03 + (0,0,4);
	level thread common_scripts\utility::play_sound_in_space(level.tv_lite_array,self.origin);
	playfx(level.breakables_fx["barrel"]["explode"],self.origin + var_03);
	physicsexplosionsphere(self.origin + var_03,100,80,1);
	level.barrelexplodingthisframe = 1;
	if(isdefined(self.remove))
	{
		if(common_scripts\utility::issp() && self.remove.spawnflags & 1)
		{
			self.remove connectpaths();
		}

		self.remove delete();
	}

	var_06 = 1;
	var_07 = 250;
	var_08 = 250;
	if(isdefined(self.radius))
	{
		var_08 = self.radius;
	}

	var_09 = undefined;
	if(isdefined(self.damageowner))
	{
		var_09 = self.damageowner;
		if(isplayer(var_09))
		{
			maps\_utility::arcademode_kill(self.origin,"rifle",150);
		}

		self.damageowner = undefined;
	}

	level.lastexplodingbarrel["time"] = gettime();
	level.lastexplodingbarrel["origin"] = self.origin + (0,0,30);
	level.lastexplodingbarrel["radius"] = var_08;
	self radiusdamage(self.origin + (0,0,30),var_08,var_07,var_06,var_09);
	if(randomint(2) == 0)
	{
		self setmodel("com_barrel_piece");
	}
	else
	{
		self setmodel("com_barrel_piece2");
	}

	if(var_02 < 0.5)
	{
		var_04 = self.origin + var_00 * 22;
		var_0A = physicstrace(var_04,var_04 + (0,0,-64));
		self.origin = var_0A;
		self.angles = self.angles + (0,0,90);
	}

	wait 0.05;
	level.barrelexplodingthisframe = 0;
}

//Function Number: 15
shuddering_entity_think()
{
	var_00 = 0;
	if(self.model == "prop_helmet_german_normandy")
	{
		var_00 = 1;
	}

	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04);
		if(var_00)
		{
			self vibrate(var_03,20,0.6,0.75);
		}
		else
		{
			self vibrate(var_03,0.4,0.4,0.4);
		}

		self waittill("rotatedone");
	}
}

//Function Number: 16
tincan_think()
{
	if(self.classname != "script_model")
	{
		return;
	}

	self setcandamage(1);
	self waittill("damage",var_00,var_01);
	if(isai(var_01) || isplayer(var_01))
	{
		var_02 = var_01 geteye() - (0,0,randomint(50) + 50);
	}
	else
	{
		var_02 = var_02.origin;
	}

	var_03 = vectornormalize(self.origin - var_02);
	var_03 = var_03 * 0.5 + randomfloat(1);
	self notify("death");
	playfx(level.breakables_fx["tincan"],self.origin,var_03);
	self delete();
}

//Function Number: 17
helmet_pop()
{
	if(self.classname != "script_model")
	{
		return;
	}

	xenon_auto_aim();
	self setcandamage(1);
	thread helmet_logic();
}

//Function Number: 18
helmet_logic()
{
	self waittill("damage",var_00,var_01);
	if(isai(var_01))
	{
		var_02 = var_01 geteye();
	}
	else
	{
		var_02 = var_02.origin;
	}

	var_03 = vectornormalize(self.origin - var_02);
	if(!isdefined(self.dontremove) && isplayer(var_01))
	{
		thread animscripts/death::func_ED0(var_03);
		return;
	}

	self notsolid();
	self hide();
	var_04 = spawn("script_model",self.origin + (0,0,5));
	var_04.angles = self.angles;
	var_04 setmodel(self.model);
	var_04 thread animscripts/death::func_ED0(var_03);
	self.dontremove = 0;
	self notify("ok_remove");
}

//Function Number: 19
allowbreak(param_00)
{
	if(!isdefined(level.breakingents))
	{
		return 1;
	}

	if(level.breakingents.size == 0)
	{
		return 0;
	}
	else
	{
		for(var_01 = 0;var_01 < level.breakingents.size;var_01++)
		{
			if(param_00 == level.breakingents[var_01])
			{
				return 1;
			}
		}

		return 0;
	}

	return 1;
}

//Function Number: 20
breakable_think_triggered(param_00)
{
	for(;;)
	{
		self waittill("trigger",var_01);
		param_00 notify("damage",100,var_01);
	}
}

//Function Number: 21
breakable_think()
{
	if(self.classname != "script_model")
	{
		return;
	}

	if(!isdefined(self.model))
	{
		return;
	}

	var_00 = undefined;
	if(self.model == "egypt_prop_vase1" || self.model == "egypt_prop_vase3" || self.model == "egypt_prop_vase4")
	{
		if(!isdefined(level.precachemodeltype["egypt_prop_vase_o"]))
		{
			level.precachemodeltype["egypt_prop_vase_o"] = 1;
			precachemodel("egypt_prop_vase_br2");
			precachemodel("egypt_prop_vase_br5");
			precachemodel("egypt_prop_vase_br7");
		}

		var_00 = "orange vase";
		breakable_clip();
		xenon_auto_aim();
	}
	else if(self.model == "egypt_prop_vase2" || self.model == "egypt_prop_vase5" || self.model == "egypt_prop_vase6")
	{
		if(!isdefined(level.precachemodeltype["egypt_prop_vase_g"]))
		{
			level.precachemodeltype["egypt_prop_vase_g"] = 1;
			precachemodel("egypt_prop_vase_br1");
			precachemodel("egypt_prop_vase_br3");
			precachemodel("egypt_prop_vase_br4");
			precachemodel("egypt_prop_vase_br6");
		}

		var_00 = "green vase";
		breakable_clip();
		xenon_auto_aim();
	}
	else if(self.model == "prop_crate_dak1" || self.model == "prop_crate_dak2" || self.model == "prop_crate_dak3" || self.model == "prop_crate_dak4" || self.model == "prop_crate_dak5" || self.model == "prop_crate_dak6" || self.model == "prop_crate_dak7" || self.model == "prop_crate_dak8" || self.model == "prop_crate_dak9")
	{
		if(!isdefined(level.precachemodeltype["prop_crate_dak_shard"]))
		{
			level.precachemodeltype["prop_crate_dak_shard"] = 1;
			precachemodel("prop_crate_dak_shard");
		}

		var_00 = "wood box";
		breakable_clip();
		xenon_auto_aim();
	}
	else if(self.model == "prop_winebottle_breakable")
	{
		if(!isdefined(level.precachemodeltype["prop_winebottle"]))
		{
			level.precachemodeltype["prop_winebottle"] = 1;
			precachemodel("prop_winebottle_broken_top");
			precachemodel("prop_winebottle_broken_bot");
		}

		var_00 = "bottle";
		xenon_auto_aim();
	}
	else if(self.model == "prop_diningplate_roundfloral")
	{
		if(!isdefined(level.precachemodeltype["prop_diningplate_brokenfloral"]))
		{
			level.precachemodeltype["prop_diningplate_brokenfloral"] = 1;
			precachemodel("prop_diningplate_brokenfloral1");
			precachemodel("prop_diningplate_brokenfloral2");
			precachemodel("prop_diningplate_brokenfloral3");
			precachemodel("prop_diningplate_brokenfloral4");
		}

		var_00 = "plate";
		self.plate = "round_floral";
		xenon_auto_aim();
	}
	else if(self.model == "prop_diningplate_roundplain")
	{
		if(!isdefined(level.precachemodeltype["prop_diningplate_brokenplain"]))
		{
			level.precachemodeltype["prop_diningplate_brokenplain"] = 1;
			precachemodel("prop_diningplate_brokenplain1");
			precachemodel("prop_diningplate_brokenplain2");
			precachemodel("prop_diningplate_brokenplain3");
			precachemodel("prop_diningplate_brokenplain4");
		}

		var_00 = "plate";
		self.plate = "round_plain";
		xenon_auto_aim();
	}
	else if(self.model == "prop_diningplate_roundstack")
	{
		if(!isdefined(level.precachemodeltype["prop_diningplate_brokenplain"]))
		{
			level.precachemodeltype["prop_diningplate_brokenplain"] = 1;
			precachemodel("prop_diningplate_brokenplain1");
			precachemodel("prop_diningplate_brokenplain2");
			precachemodel("prop_diningplate_brokenplain3");
			precachemodel("prop_diningplate_brokenplain4");
		}

		if(!isdefined(level.precachemodeltype["prop_diningplate_brokenfloral"]))
		{
			level.precachemodeltype["prop_diningplate_brokenfloral"] = 1;
			precachemodel("prop_diningplate_brokenfloral1");
			precachemodel("prop_diningplate_brokenfloral2");
			precachemodel("prop_diningplate_brokenfloral3");
			precachemodel("prop_diningplate_brokenfloral4");
		}

		var_00 = "plate";
		self.plate = "round_stack";
		xenon_auto_aim();
	}
	else if(self.model == "prop_diningplate_ovalfloral")
	{
		if(!isdefined(level.precachemodeltype["prop_diningplate_brokenfloral"]))
		{
			level.precachemodeltype["prop_diningplate_brokenfloral"] = 1;
			precachemodel("prop_diningplate_brokenfloral1");
			precachemodel("prop_diningplate_brokenfloral2");
			precachemodel("prop_diningplate_brokenfloral3");
			precachemodel("prop_diningplate_brokenfloral4");
		}

		var_00 = "plate";
		self.plate = "oval_floral";
		xenon_auto_aim();
	}
	else if(self.model == "prop_diningplate_ovalplain")
	{
		if(!isdefined(level.precachemodeltype["prop_diningplate_brokenplain"]))
		{
			level.precachemodeltype["prop_diningplate_brokenplain"] = 1;
			precachemodel("prop_diningplate_brokenplain1");
			precachemodel("prop_diningplate_brokenplain2");
			precachemodel("prop_diningplate_brokenplain3");
			precachemodel("prop_diningplate_brokenplain4");
		}

		var_00 = "plate";
		self.plate = "oval_plain";
		xenon_auto_aim();
	}
	else if(self.model == "prop_diningplate_ovalstack")
	{
		if(!isdefined(level.precachemodeltype["prop_diningplate_brokenplain"]))
		{
			level.precachemodeltype["prop_diningplate_brokenplain"] = 1;
			precachemodel("prop_diningplate_brokenplain1");
			precachemodel("prop_diningplate_brokenplain2");
			precachemodel("prop_diningplate_brokenplain3");
			precachemodel("prop_diningplate_brokenplain4");
		}

		if(!isdefined(level.precachemodeltype["prop_diningplate_brokenfloral"]))
		{
			level.precachemodeltype["prop_diningplate_brokenfloral"] = 1;
			precachemodel("prop_diningplate_brokenfloral1");
			precachemodel("prop_diningplate_brokenfloral2");
			precachemodel("prop_diningplate_brokenfloral3");
			precachemodel("prop_diningplate_brokenfloral4");
		}

		var_00 = "plate";
		self.plate = "oval_stack";
		xenon_auto_aim();
	}

	if(!isdefined(var_00))
	{
		return;
	}

	if(isdefined(self.target))
	{
		var_01 = getent(self.target,"targetname");
		if(isdefined(var_01) && var_01.classname == "trigger_multiple")
		{
			var_01 thread breakable_think_triggered(self);
		}
	}

	self setcandamage(1);
	thread breakable_logic(var_00);
}

//Function Number: 22
breakable_logic(param_00)
{
	var_01 = undefined;
	for(;;)
	{
		self waittill("damage",var_02,var_01);
		if(isdefined(var_01) && var_01.code_classname == "script_vehicle")
		{
			var_01 joltbody(self.origin + (0,0,-90),0.2);
		}

		if(param_00 == "wood box")
		{
			if(!allowbreak(var_01))
			{
				continue;
			}

			if(!isdefined(level.flags) || !isdefined(level.flags["Breakable Boxes"]))
			{
				break;
			}

			if(isdefined(level.flags["Breakable Boxes"]) && level.flags["Breakable Boxes"] == 1)
			{
				break;
			}

			continue;
		}

		break;
	}

	self notify("death");
	var_03 = undefined;
	var_04 = undefined;
	var_05 = 0;
	switch(param_00)
	{
		case "green vase":
		case "orange vase":
			var_03 = "bullet_large_vase";
			var_04 = level.breakables_fx["vase"];
			break;

		case "wood box":
			if(isdefined(level.crateimpactsound))
			{
				var_03 = level.crateimpactsound;
			}
			else
			{
				var_03 = "bullet_large_vase";
			}
	
			var_04 = level.breakables_fx["box"][randomint(level.breakables_fx["box"].size)];
			var_05 = 1;
			break;

		case "bottle":
			var_03 = "bullet_small_bottle";
			var_04 = level.breakables_fx["bottle"];
			break;

		case "plate":
			var_03 = "bullet_small_plate";
			break;
	}

	thread common_scripts\utility::play_sound_in_space(var_03,self.origin);
	thread make_broken_peices(self,param_00);
	if(isdefined(var_04))
	{
		playfx(var_04,self.origin);
	}

	if(var_05)
	{
		var_06 = getentarray("breakable","targetname");
		for(var_07 = 0;var_07 < var_06.size;var_07++)
		{
			var_08 = var_06[var_07];
			var_09 = abs(self.origin[0] - var_08.origin[0]);
			var_0A = abs(self.origin[1] - var_08.origin[1]);
			if(var_09 <= 20 && var_0A <= 20)
			{
				var_0B = self.origin[2] - var_08.origin[2];
				if(var_0B <= 0)
				{
					var_08 notify("damage",var_02,var_01);
				}
			}
		}
	}

	if(isdefined(self.remove))
	{
		self.remove connectpaths();
		self.remove delete();
	}

	if(!isdefined(self.dontremove))
	{
		self delete();
	}
	else
	{
		self.dontremove = 0;
	}

	self notify("ok_remove");
}

//Function Number: 23
xenon_auto_aim()
{
	if(isdefined(level.console_auto_aim_2nd) && level.console_auto_aim_2nd.size > 0)
	{
		self.autoaim = getclosestaccurantent(self.origin,level.console_auto_aim_2nd);
	}

	if(isdefined(self.autoaim))
	{
		level.console_auto_aim_2nd = common_scripts\utility::array_remove(level.console_auto_aim_2nd,self.autoaim);
		thread xenon_remove_auto_aim();
	}
}

//Function Number: 24
xenon_auto_aim_stop_logic()
{
	self notify("entered_xenon_auto_aim_stop_logic");
	self endon("entered_xenon_auto_aim_stop_logic");
	self.autoaim waittill("xenon_auto_aim_stop_logic");
	self.dontremove = undefined;
}

//Function Number: 25
xenon_remove_auto_aim(param_00)
{
	thread xenon_auto_aim_stop_logic();
	self endon("xenon_auto_aim_stop_logic");
	self.autoaim endon("xenon_auto_aim_stop_logic");
	self notify("xenon_remove_auto_aim");
	self.autoaim thread xenon_enable_auto_aim(param_00);
	self.dontremove = 1;
	self waittill("damage",var_01,var_02);
	self.autoaim disableaimassist();
	self.autoaim delete();
	if(self.dontremove)
	{
		self waittill("ok_remove");
	}

	self delete();
}

//Function Number: 26
xenon_enable_auto_aim(param_00)
{
	self endon("xenon_auto_aim_stop_logic");
	self endon("death");
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(isdefined(self.script_noteworthy) && param_00)
	{
		var_01 = "enable_xenon_autoaim_" + self.script_noteworthy;
		level waittill(var_01);
	}

	self.wait_message = 0;
	if(isdefined(self.recreate) && self.recreate == 1)
	{
		self waittill("recreate");
	}

	self enableaimassist();
}

//Function Number: 27
breakable_clip()
{
	if(isdefined(self.target))
	{
		var_00 = getent(self.target,"targetname");
		if(var_00.classname == "script_brushmodel")
		{
			self.remove = var_00;
			return;
		}
	}

	if(isdefined(level.breakables_clip) && level.breakables_clip.size > 0)
	{
		self.remove = getclosestent(self.origin,level.breakables_clip);
	}

	if(isdefined(self.remove))
	{
		level.breakables_clip = common_scripts\utility::array_remove(level.breakables_clip,self.remove);
	}
}

//Function Number: 28
make_broken_peices(param_00,param_01)
{
	var_02 = anglestoright(param_00.angles);
	var_03 = anglestoforward(param_00.angles);
	var_04 = anglestoup(param_00.angles);
	var_05 = [];
	switch(param_01)
	{
		case "orange vase":
			break;
	var_7B[var_7B.size]
	addpiece(var_03,var_04,var_05,3,2,0,param_01,(0,0,0),"egypt_prop_vase_br5")
	var_7B[var_7B.size]
	addpiece(var_03,var_04,var_05,12,10,27,param_01,(0,180,0),"egypt_prop_vase_br7")
	var_7B[var_7B.size]
	addpiece(var_03,var_04,var_05,13,-6,28,param_01,(0,245.1,0),"egypt_prop_vase_br7")
	var_7B[var_05.size]
	addpiece(var_02,var_03,var_04,-7,0,22,param_00,(0,0,0),"egypt_prop_vase_br2")
			break;

		case "green vase":
			break;
	var_7B[var_7B.size]
	addpiece(var_03,var_04,var_05,3,1,0,param_01,(0,0,0),"egypt_prop_vase_br4")
	var_7B[var_7B.size]
	addpiece(var_03,var_04,var_05,6,13,29,param_01,(0,153.5,0),"egypt_prop_vase_br6")
	var_7B[var_7B.size]
	addpiece(var_03,var_04,var_05,12,1,31,param_01,(0,348.5,0),"egypt_prop_vase_br3")
	var_7B[var_7B.size]
	addpiece(var_03,var_04,var_05,-6,-1,26,param_01,(0,0,0),"egypt_prop_vase_br1")
			break;

		case "wood box":
			break;
	var_7B[var_7B.size]
	addpiece(var_03,var_04,var_05,-10,10,5,param_01,(180,270,0),"prop_crate_dak_shard")
	var_7B[var_7B.size]
	addpiece(var_03,var_04,var_05,-10,-10,5,param_01,(180,180,0),"prop_crate_dak_shard")
	var_7B[var_7B.size]
	addpiece(var_03,var_04,var_05,10,-10,5,param_01,(180,90,0),"prop_crate_dak_shard")
	var_7B[var_7B.size]
	addpiece(var_03,var_04,var_05,10,10,5,param_01,(180,0,0),"prop_crate_dak_shard")
	var_7B[var_7B.size]
	addpiece(var_03,var_04,var_05,-10,-10,25,param_01,(0,270,0),"prop_crate_dak_shard")
	var_7B[var_7B.size]
	addpiece(var_03,var_04,var_05,10,-10,25,param_01,(0,180,0),"prop_crate_dak_shard")
	var_7B[var_7B.size]
	addpiece(var_03,var_04,var_05,10,10,25,param_01,(0,90,0),"prop_crate_dak_shard")
	var_7B[var_7B.size]
	addpiece(var_03,var_04,var_05,-10,10,25,param_01,(0,0,0),"prop_crate_dak_shard")
			break;

		case "bottle":
			var_7B[var_7B.size - 1].type = "bottle_top";
			var_7B[var_7B.size - 1].type = "bottle_bot";
			break;
	var_7B[var_7B.size]
	addpiece(var_03,var_04,var_05,0,0,0,param_01,(0,0,0),"prop_winebottle_broken_bot")
	var_7B[var_7B.size]
	addpiece(var_03,var_04,var_05,0,0,10,param_01,(0,0,0),"prop_winebottle_broken_top")
			break;

		case "plate":
			switch(param_01.plate)
			{
				case "round_floral":
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					break;
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-4,2,0.5,param_01,(0,146.8,0),"prop_diningplate_brokenfloral4")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,1,2,0.5,param_01,(0,150.2,0),"prop_diningplate_brokenfloral3")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,3,-2,0.5,param_01,(0,149.8,0),"prop_diningplate_brokenfloral2")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-3,-4,0.5,param_01,(0,150,0),"prop_diningplate_brokenfloral1")
					break;
	
				case "round_plain":
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					break;
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-4,2,0.5,param_01,(0,146.8,0),"prop_diningplate_brokenplain4")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,1,2,0.5,param_01,(0,150.2,0),"prop_diningplate_brokenplain3")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,3,-2,0.5,param_01,(0,149.8,0),"prop_diningplate_brokenplain2")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-3,-4,0.5,param_01,(0,150,0),"prop_diningplate_brokenplain1")
					break;
	
				case "round_stack":
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					break;
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-4,2,4.5,param_01,(0,146.8,0),"prop_diningplate_brokenfloral4")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,1,2,4.5,param_01,(0,150.2,0),"prop_diningplate_brokenfloral3")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,3,-2,4.5,param_01,(0,149.8,0),"prop_diningplate_brokenfloral2")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-3,-4,4.5,param_01,(0,150,0),"prop_diningplate_brokenfloral1")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,2,4,2.5,param_01,(0,56.8,0),"prop_diningplate_brokenplain4")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,2,-1,2.5,param_01,(0,60.2,0),"prop_diningplate_brokenplain3")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-1,-3,2.5,param_01,(0,59.8,0),"prop_diningplate_brokenplain2")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-4,3,2.5,param_01,(0,60,0),"prop_diningplate_brokenplain1")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-4,2,0.5,param_01,(0,146.8,0),"prop_diningplate_brokenfloral4")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,1,2,0.5,param_01,(0,150.2,0),"prop_diningplate_brokenfloral3")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,3,-2,0.5,param_01,(0,149.8,0),"prop_diningplate_brokenfloral2")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-3,-4,0.5,param_01,(0,150,0),"prop_diningplate_brokenfloral1")
					break;
	
				case "oval_floral":
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					break;
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-3,-3,0.5,param_01,(0,246.7,0),"prop_diningplate_brokenfloral4")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-2,5,0.5,param_01,(0,102.3,0),"prop_diningplate_brokenfloral4")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,4,2,0.5,param_01,(0,150.2,0),"prop_diningplate_brokenfloral3")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-6,1,0.5,param_01,(0,352.2,0),"prop_diningplate_brokenfloral2")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,4,-4,0.5,param_01,(0,205.9,0),"prop_diningplate_brokenfloral1")
					break;
	
				case "oval_plain":
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					break;
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-3,-3,0.5,param_01,(0,246.7,0),"prop_diningplate_brokenplain4")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-2,5,0.5,param_01,(0,102.3,0),"prop_diningplate_brokenplain4")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,4,2,0.5,param_01,(0,150.2,0),"prop_diningplate_brokenplain3")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-6,1,0.5,param_01,(0,352.2,0),"prop_diningplate_brokenplain2")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,4,-4,0.5,param_01,(0,205.9,0),"prop_diningplate_brokenplain1")
					break;
	
				case "oval_stack":
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					var_7B[var_7B.size - 1].type = "plate";
					break;
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,3,4,2.5,param_01,(0,66.7,0),"prop_diningplate_brokenplain4")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,2,-4,2.5,param_01,(0,282.3,0),"prop_diningplate_brokenplain4")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-4,-1,2.5,param_01,(0,330.2,0),"prop_diningplate_brokenplain3")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,6,0,2.5,param_01,(0,172.2,0),"prop_diningplate_brokenplain2")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-4,5,2.5,param_01,(0,25.9,0),"prop_diningplate_brokenplain1")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-3,-3,0.5,param_01,(0,246.7,0),"prop_diningplate_brokenfloral4")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-2,5,0.5,param_01,(0,102.3,0),"prop_diningplate_brokenfloral4")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,4,2,0.5,param_01,(0,150.2,0),"prop_diningplate_brokenfloral3")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,-6,1,0.5,param_01,(0,352.2,0),"prop_diningplate_brokenfloral2")
		var_7B[var_7B.size]
		addpiece(var_03,var_04,var_05,4,-4,0.5,param_01,(0,205.9,0),"prop_diningplate_brokenfloral1")
					break;
			}
			break;

		default:
			break;
	}

	common_scripts\utility::array_thread(var_7B,::pieces_move,param_01.origin);
	if(isdefined(level.var_1DE0[var_02]) && level.var_1DE0[var_02] == 1)
	{
		var_06 = var_7B[0].origin[2];
		for(var_07 = 0;var_07 < var_7B.size;var_07++)
		{
			if(var_06 > var_7B[var_07].origin[2])
			{
				var_06 = var_7B[var_07].origin[2];
			}
		}

		common_scripts\utility::array_thread(var_7B,::pieces_collision,var_06);
		return;
	}

	wait 2;
	for(var_07 = 0;var_07 < var_7B.size;var_07++)
	{
		if(isdefined(var_7B[var_07]))
		{
			var_7B[var_07] delete();
		}
	}
}

//Function Number: 29
list_add(param_00)
{
	if(isdefined(level._breakable_utility_modelarray[level._breakable_utility_modelindex]))
	{
		level._breakable_utility_modelarray[level._breakable_utility_modelindex] delete();
	}

	level._breakable_utility_modelarray[level._breakable_utility_modelindex] = param_00;
	level._breakable_utility_modelindex++;
	if(!level._breakable_utility_modelindex < level._breakable_utility_maxnum)
	{
		level._breakable_utility_modelindex = 0;
	}
}

//Function Number: 30
pieces_move(param_00)
{
	self endon("do not kill");
	if(isdefined(self.type) && self.type == "bottle_bot")
	{
		return;
	}

	var_01 = spawn("script_origin",self.origin);
	self linkto(var_01);
	var_02 = self.origin + (randomfloat(10) - 5,randomfloat(10) - 5,randomfloat(10) + 5);
	var_03 = undefined;
	if(isdefined(self.type) && self.type == "bottle_top")
	{
		var_03 = (randomfloat(40) - 20,randomfloat(40) - 20,70 + randomfloat(15));
		var_04 = 1;
		var_05 = 1;
		var_06 = 1;
		if(randomint(100) > 50)
		{
			var_04 = -1;
		}

		if(randomint(100) > 50)
		{
			var_05 = -1;
		}

		if(randomint(100) > 50)
		{
			var_06 = -1;
		}

		var_01 rotatevelocity((250 * var_04,250 * var_05,randomfloat(100) * var_06),2,0,0.5);
	}
	else if(isdefined(self.type) && self.type == "plate")
	{
		var_03 = vectornormalize(var_02 - param_00);
		var_03 = var_03 * 125 + randomfloat(25);
		if(randomint(100) > 50)
		{
			var_01 rotateroll(800 + randomfloat(4000) * -1,5,0,0);
		}
		else
		{
			var_01 rotateroll(800 + randomfloat(4000),5,0,0);
		}
	}
	else
	{
		var_03 = vectornormalize(var_02 - param_00);
		var_03 = var_03 * 60 + randomfloat(50);
		if(randomint(100) > 50)
		{
			var_01 rotateroll(800 + randomfloat(1000) * -1,5,0,0);
		}
		else
		{
			var_01 rotateroll(800 + randomfloat(1000),5,0,0);
		}
	}

	var_01 movegravity(var_03,5);
	wait 5;
	if(isdefined(self))
	{
		self unlink();
	}

	var_01 delete();
}

//Function Number: 31
pieces_collision(param_00)
{
	self endon("death");
	wait 0.1;
	var_01 = bullettrace(self.origin,self.origin - (0,0,50000),0,undefined);
	var_02 = var_01["position"];
	while(self.origin[2] > var_02[2])
	{
		wait 0.05;
	}

	self unlink();
	self.origin = (self.origin[0],self.origin[1],var_02[2]);
	self notify("do not kill");
	self unlink();
}

//Function Number: 32
addpiece(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = 1;
	var_0A = param_00;
	var_0B = param_01;
	var_0C = param_02;
	var_0A = var_0A * param_04 * var_09;
	var_0B = var_0B * param_03 * var_09;
	var_0C = var_0C * param_05 * var_09;
	var_0D = param_06.origin + var_0A + var_0B + var_0C;
	var_0E = spawn("script_model",var_0D);
	var_0E setmodel(param_08);
	var_0E.modelscale = var_09;
	var_0E.angles = param_06.angles + param_07;
	list_add(var_0E);
	return var_0E;
}

//Function Number: 33
getfurthestent(param_00,param_01)
{
	if(param_01.size < 1)
	{
		return;
	}

	var_02 = distance(param_01[0] getorigin(),param_00);
	var_03 = param_01[0];
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		var_05 = distance(param_01[var_04] getorigin(),param_00);
		if(var_05 < var_02)
		{
			continue;
		}

		var_02 = var_05;
		var_03 = param_01[var_04];
	}

	return var_03;
}

//Function Number: 34
getclosestent(param_00,param_01)
{
	if(param_01.size < 1)
	{
		return;
	}

	var_02 = 256;
	var_03 = undefined;
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		var_05 = distance(param_01[var_04] getorigin(),param_00);
		if(var_05 >= var_02)
		{
			continue;
		}

		var_02 = var_05;
		var_03 = param_01[var_04];
	}

	return var_03;
}

//Function Number: 35
getclosestaccurantent(param_00,param_01)
{
	if(param_01.size < 1)
	{
		return;
	}

	var_02 = 8;
	var_03 = undefined;
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		var_05 = distance(param_01[var_04] getorigin(),param_00);
		if(var_05 >= var_02)
		{
			continue;
		}

		var_02 = var_05;
		var_03 = param_01[var_04];
	}

	return var_03;
}

//Function Number: 36
getclosestaiment(param_00,param_01)
{
	if(param_01.size < 1)
	{
		return;
	}

	var_02 = 1000000;
	var_03 = undefined;
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		var_05 = distance(param_01[var_04] getorigin(),param_00);
		if(var_05 >= var_02)
		{
			continue;
		}

		var_02 = var_05;
		var_03 = param_01[var_04];
	}

	return var_03;
}