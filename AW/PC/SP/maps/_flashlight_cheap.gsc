/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_flashlight_cheap.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 165 ms
 * Timestamp: 10/27/2023 1:58:51 AM
*******************************************************************/

//Function Number: 1
cheap_flashlight_init()
{
	precachemodel("com_flashlight_on_physics");
	flashlight_fx();
}

//Function Number: 2
add_cheap_flashlight(param_00,param_01,param_02)
{
	var_03 = self;
	var_04 = "tag_flash";
	if(isdefined(param_00) && param_00 == "flashlight")
	{
		var_05 = self gettagorigin("tag_inhand");
		var_06 = self gettagangles("tag_inhand");
		self.flashlight = spawn("script_model",var_05);
		self.flashlight setmodel("com_flashlight_on_physics");
		self.flashlight.angles = var_06;
		self.flashlight linkto(self,"tag_inhand");
		var_03 = self.flashlight;
		var_04 = "tag_light";
	}

	if(isdefined(param_02))
	{
		playfxontag(common_scripts\utility::getfx(param_02),var_03,var_04);
	}
	else
	{
		playfxontag(common_scripts\utility::getfx("flashlight0"),var_03,var_04);
	}

	thread fake_spotlight(var_04,param_01,var_04,param_02);
	thread remove_flashlight_upon_combat();
}

//Function Number: 3
remove_cheap_flashlight(param_00,param_01,param_02)
{
	var_03 = self;
	var_04 = "tag_flash";
	if(isdefined(param_00) && param_00 == "flashlight")
	{
		self.flashlight notify("kill_fx_before_death");
	}
}

//Function Number: 4
remove_flashlight_upon_combat()
{
	self endon("death");
	self.flashlight endon("death");
	self waittill("enemy");
	if(self.prevscript != "scripted")
	{
		cheap_flashlight_hide(self);
	}
}

//Function Number: 5
fake_spotlight(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self.flashlight endon("death");
	if(isdefined(self.flashlight))
	{
		var_04 = self.flashlight;
	}
	else
	{
		var_04 = self;
	}

	if(!isdefined(param_01))
	{
		param_01 = 400;
	}

	thread monitor_flashlight_death(param_00,var_04,param_02,param_03);
	thread monitor_flashlight_owner_death(param_00,var_04,param_02,param_03);
	maps\_utility::disable_long_death();
	var_04.light_tag = common_scripts\utility::spawn_tag_origin();
	playfxontag(common_scripts\utility::getfx("point_amber"),var_04.light_tag,"tag_origin");
	for(;;)
	{
		var_05 = var_04 gettagorigin(param_00);
		var_06 = var_04 gettagangles(param_00);
		var_07 = anglestoforward(var_06);
		var_08 = bullettrace(var_05 + var_07 * 7,var_05 + var_07 * param_01,1,var_04,0);
		var_09 = bullettrace(var_08["position"],var_08["position"] + var_07 * -20,1,var_04,0);
		var_04.light_tag.origin = var_09["position"];
		wait 0.05;
	}
}

//Function Number: 6
kill_flashlight_fx(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01.light_tag))
	{
		killfxontag(common_scripts\utility::getfx("point_amber"),param_01.light_tag,"tag_origin");
	}

	if(isdefined(param_01) && isdefined(param_02))
	{
		if(isdefined(param_03))
		{
			killfxontag(common_scripts\utility::getfx(param_03),param_01,param_02);
			return;
		}

		killfxontag(common_scripts\utility::getfx("flashlight0"),param_01,param_02);
	}
}

//Function Number: 7
monitor_flashlight_owner_death(param_00,param_01,param_02,param_03)
{
	self.flashlight endon("death");
	self waittill("death");
	kill_flashlight_fx(param_00,param_01,param_02,param_03);
}

//Function Number: 8
monitor_flashlight_death(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self.flashlight waittill("kill_fx_before_death");
	kill_flashlight_fx(param_00,param_01,param_02,param_03);
	self.flashlight hide();
	wait 0.05;
	self.flashlight delete();
}

//Function Number: 9
flashlight_fx()
{
	level._effect["point_amber"] = loadfx("vfx/lights/lab/point_flashlight_lab");
	level._effect["flashlight0"] = loadfx("vfx/lights/lab/flashlight_lab");
}

//Function Number: 10
cheap_flashlight_hide(param_00)
{
	if(isdefined(param_00.flashlight))
	{
		param_00.lastreacttime = gettime();
		param_00 remove_cheap_flashlight("flashlight");
	}
}

//Function Number: 11
cheap_flashlight_show(param_00)
{
	if(!isdefined(param_00.flashlight))
	{
		param_00 add_cheap_flashlight("flashlight");
	}
}