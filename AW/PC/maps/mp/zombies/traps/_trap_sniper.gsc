/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\traps\_trap_sniper.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 114 ms
 * Timestamp: 4/22/2024 2:13:20 AM
*******************************************************************/

//Function Number: 1
init()
{
	precachelaser("trap_zm");
	level._effect["trap_sniper_tracer"] = loadfx("vfx/map/mp_zombie_brg/brg_sniper_tracer");
	level.sniperzombietargetlocations = ["J_Shoulder_RI","J_Shoulder_LE","J_Hip_LE","J_Hip_RI","J_Head"];
	level.sniperdogtargetlocations = ["r_frontLeg0_JNT","r_frontLeg1_JNT","l_backLeg0_JNT","l_backLeg1_JNT","J_Spine4","J_Head"];
}

//Function Number: 2
spawnsniperent(param_00,param_01)
{
	var_02 = spawn("script_model",param_00.origin);
	var_02.start_origin = param_00.origin;
	var_02.start_angles = param_00.angles;
	var_02 setmodel("tag_laser");
	var_02 laseron("trap_zm");
	var_03 = common_scripts\utility::getstruct(param_00.target,"targetname");
	var_02.lasertargetent = var_03;
	var_02 thread lerplasertotarget(param_01);
	var_02 thread findvalidtargets(var_03,param_01);
	var_02 thread sniper_trap_audio(param_01);
	return var_02;
}

//Function Number: 3
findvalidtargets(param_00,param_01)
{
	self endon("death");
	for(;;)
	{
		wait(0.05);
		var_02 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
		var_02 = sortbydistance(var_02,self.origin,2048);
		foreach(var_04 in var_02)
		{
			if(var_04.agentteam == level.playerteam || maps\mp\zombies\_util::is_true(var_04.inspawnanim))
			{
				var_02 = common_scripts\utility::array_remove(var_02,var_04);
			}

			if(isdefined(var_04.sniperclaimed) && var_04.sniperclaimed == 1)
			{
				var_02 = common_scripts\utility::array_remove(var_02,var_04);
			}
		}

		if(isdefined(var_02[0]) && isalive(var_02[0]))
		{
			self.lasertargetent = var_02[0];
			self.lasertargetent.sniperclaimed = 1;
			sniperthink(self.lasertargetent,param_01);
			continue;
		}

		self.lasertargetent = param_00;
	}
}

//Function Number: 4
lerplasertotarget(param_00)
{
	self endon("death");
	for(;;)
	{
		while(isdefined(self.lasertargetent))
		{
			if(isai(self.lasertargetent) && isalive(self.lasertargetent))
			{
				var_01 = snipercheckaitype(self.lasertargetent);
				var_02 = self.lasertargetent gettagorigin(common_scripts\utility::random(var_01));
			}
			else
			{
				var_02 = self.lasertargetent.origin + common_scripts\utility::randomvectorrange(-50,50);
			}

			var_03 = vectortoangles(var_02 - self.origin);
			var_04 = 0;
			var_05 = 1000;
			var_06 = gettime();
			while(var_04 < 1)
			{
				var_04 = clamp(gettime() - var_06 / var_05,0,1);
				self.angles = vectorlerp(self.angles,var_03,var_04);
				wait(0.05);
			}

			wait(0.05);
		}

		wait(0.05);
	}
}

//Function Number: 5
snipercheckaitype(param_00)
{
	if(isdefined(param_00.agent_type) && param_00.agent_type == "zombie_dog")
	{
		return level.sniperdogtargetlocations;
	}

	return level.sniperzombietargetlocations;
}

//Function Number: 6
sniperthink(param_00,param_01)
{
	param_01 endon("snipers_off");
	param_00 endon("death");
	var_02 = self.origin;
	for(;;)
	{
		var_03 = randomfloatrange(1.5,5);
		param_00 common_scripts\utility::waittill_any_timeout(var_03,"death");
		var_04 = param_00 gettagorigin(common_scripts\utility::random(snipercheckaitype(param_00))) + common_scripts\utility::randomvectorrange(-5,5);
		var_05 = vectornormalize(var_04 - var_02);
		playfx(common_scripts\utility::getfx("trap_sniper_tracer"),var_02,var_05,(0,0,1));
		magicbullet("trap_sniper_zm_mp",var_02,var_04,param_01.owner);
		playsoundatpos(self.origin,"sniper_shot_extra_report");
	}
}

//Function Number: 7
sniper_trap_audio(param_00)
{
	var_01 = spawn("script_origin",param_00.origin);
	playsoundatpos(param_00.origin,"sniper_start_front");
	playsoundatpos((2508,-514,555),"sniper_servo_start_left");
	playsoundatpos((3779,-2179,555),"sniper_servo_start_right");
	param_00 waittill("snipers_off");
	playsoundatpos(param_00.origin,"sniper_stop_front");
	playsoundatpos((2508,-514,555),"sniper_servo_stop_left");
	playsoundatpos((3779,-2179,555),"sniper_servo_stop_right");
	wait 0.05;
	var_01 delete();
}