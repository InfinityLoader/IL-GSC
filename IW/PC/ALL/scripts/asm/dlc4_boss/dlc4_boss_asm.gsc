/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\dlc4_boss\dlc4_boss_asm.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 107
 * Decompile Time: 5442 ms
 * Timestamp: 10/27/2023 12:01:42 AM
*******************************************************************/

//Function Number: 1
asminit(param_00,param_01,param_02,param_03)
{
	lib_0C75::func_13F9A(param_00,param_01,param_02,param_03);
	self.fnactionvalidator = ::isvalidaction;
	if(!isdefined(level.dlc4_boss_arrival_data))
	{
		analyzemovementanims();
	}

	var_04 = self method_80FD("move_arrival",4);
	self.var_1198.movearrivaldist = length(getmovedelta(var_04,0,1));
	var_04 = self method_80FD("move_back_arrival",0);
	self.var_1198.movebackarrivaldist = length(getmovedelta(var_04,0,1));
	var_04 = self method_80FD("drop_move_arrival",0);
	self.var_1198.dropmovearrivaldist = length(getmovedelta(var_04,0,1));
}

//Function Number: 2
analyzemovementanims()
{
	level.dlc4_boss_arrival_data = [];
	level.dlc4_boss_move_data = [];
	for(var_00 = 1;var_00 <= 9;var_00++)
	{
		if(var_00 == 5)
		{
			continue;
		}

		var_01 = var_00;
		var_02 = lib_0A1A::func_2358("move_arrival",var_01);
		var_03 = self method_80FD("move_arrival",var_02);
		var_04 = getmovedelta(var_03,0,1);
		level.dlc4_boss_arrival_data[var_00] = var_04;
		level.dlc4_boss_arrival_time[var_00] = getanimlength(var_03);
		var_01 = var_00;
		var_02 = lib_0A1A::func_2358("move_loop",var_01);
		var_03 = self method_80FD("move_loop",var_02);
		var_04 = getmovedelta(var_03,0,1);
		level.dlc4_boss_move_data[var_00] = var_04;
		level.dlc4_boss_move_time[var_00] = getanimlength(var_03);
		var_02 = lib_0A1A::func_2358("move_exit",var_01);
		var_03 = self method_80FD("move_exit",var_02);
		var_04 = getmovedelta(var_03,0,1);
		level.dlc4_boss_exit_data[var_00] = var_04;
		level.dlc4_boss_exit_time[var_00] = getanimlength(var_03);
	}
}

//Function Number: 3
isvalidaction(param_00)
{
	switch(param_00)
	{
		case "drop_move":
		case "black_hole":
		case "ground_vul":
		case "air_pound":
		case "move":
		case "teleport":
		case "ground_pound":
		case "turn":
		case "death":
		case "eclipse":
		case "temp_idle":
		case "throw":
		case "tornado":
		case "summon":
		case "clap":
		case "fireball":
		case "taunt":
		case "fly_over":
			return 1;
	}

	return 0;
}

//Function Number: 4
shouldplayentranceanim(param_00,param_01,param_02,param_03)
{
	thread introfx();
	return 1;
}

//Function Number: 5
introfx()
{
	var_00 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	self.vo_ent = spawn("script_origin",self gettagorigin("tag_origin"));
	self.vo_ent linkto(self);
	playfx(var_00.air_pound_rise_fx,self.arenacenter);
	wait(0.1);
	playsoundatpos(self.arenacenter,"zmb_ground_spawn_dirt");
	self.vo_ent playsound("final_meph_intro");
	var_01 = gettime() + 4400;
	while(gettime() < var_01)
	{
		earthquake(0.35,3,self.arenacenter,750);
		scripts\common\utility::func_136F7();
		playrumbleonposition("artillery_rumble",self.arenacenter);
		wait(0.2);
	}

	wait(2.1);
	earthquake(0.4,1,self.arenacenter,750);
	scripts\common\utility::func_136F7();
	playrumbleonposition("artillery_rumble",self.arenacenter);
	wait(1.1);
	earthquake(0.4,1,self.arenacenter,750);
	scripts\common\utility::func_136F7();
	playrumbleonposition("artillery_rumble",self.arenacenter);
}

//Function Number: 6
playmoveexit(param_00,param_01,param_02,param_03)
{
	self method_8289("face angle abs",self.angles);
	var_04 = self.var_1198;
	var_04.desireddir = vectornormalize(var_04.var_C053[var_04.desirednode].origin - self.origin);
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	var_06 = self method_80FD(param_01,var_05);
	if(self.var_1198.smoothmotion)
	{
		thread adjustlookahead(param_01);
	}

	thread applyallmotiontowardsdesireddir(param_01,var_06,getdvarfloat("dlc4_boss_in_out_scale",1),0);
	if(self.var_1198.facecenter)
	{
		thread staylookingatcenter(param_01);
	}

	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 7
loopbossmoveanim(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = self method_80FD(param_01,var_04);
	if(self.var_1198.smoothmotion)
	{
		thread adjustlookahead(param_01);
	}

	thread applyallmotiontowardsdesireddir(param_01,var_05,1,1);
	if(self.var_1198.facecenter)
	{
		thread staylookingatcenter(param_01);
	}

	lib_0F3C::func_B050(param_00,param_01,param_02,param_03);
}

//Function Number: 8
playmovearrival(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = self method_80FD(param_01,var_04);
	if(self.var_1198.smoothmotion)
	{
		thread adjustlookahead(param_01);
	}

	thread applyallmotiontowardsdesireddir(param_01,var_05,getdvarfloat("dlc4_boss_in_out_scale",1),0);
	if(self.var_1198.facecenter)
	{
		thread staylookingatcenter(param_01);
	}

	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 9
choosebossmoveanim(param_00,param_01,param_02)
{
	var_03 = self.var_1198.currentmovedirindex;
	return lib_0A1A::func_2358(param_01,var_03);
}

//Function Number: 10
choosebossarrivalanim(param_00,param_01,param_02)
{
	var_03 = self.var_1198.currentmovedirindex;
	return lib_0A1A::func_2358(param_01,var_03);
}

//Function Number: 11
applyallmotiontowardsdesireddir(param_00,param_01,param_02,param_03)
{
	self endon(param_00 + "_finished");
	param_02 = param_02 * getdvarfloat("dlc4_boss_strafe_speed",1);
	var_04 = 0;
	var_05 = getanimlength(param_01);
	while(var_04 < var_05)
	{
		var_06 = self.var_1198;
		var_07 = var_06.var_C053[var_06.desirednode].origin;
		var_08 = var_04 / var_05;
		var_09 = var_04 + 0.05 / var_05;
		var_0A = 0;
		if(var_09 > 1)
		{
			if(param_03)
			{
				var_0A = length2d(getmovedelta(param_01,var_08,1)) * param_02;
				var_04 = 0;
				var_08 = 0;
				var_09 = var_09 - 1;
			}
			else
			{
				var_09 = 1;
			}
		}

		var_0B = getmovedelta(param_01,var_08,var_09);
		var_0A = var_0A + length2d(var_0B) * param_02;
		var_0C = self.origin + self.var_1198.desireddir * var_0A;
		self setorigin(var_0C - (0,0,1),0);
		wait(0.05);
		var_04 = var_04 + 0.05;
	}
}

//Function Number: 12
adjustlookahead(param_00)
{
	self endon(param_00 + "_finished");
	var_01 = self.var_1198;
	var_02 = scripts\asm\dlc4\dlc4_asm::gettunedata().look_ahead_radius;
	var_03 = scripts\asm\dlc4\dlc4_asm::gettunedata().look_ahead_speed;
	var_04 = var_01.var_C053.size;
	var_05 = var_01.lookaheadnextnode - var_01.lookaheadcurrnode;
	for(;;)
	{
		var_06 = distance2dsquared(self.origin,var_01.lookaheadorigin);
		if(var_06 < var_02 * var_02)
		{
			for(var_07 = var_03;var_07 > 0;var_07 = 0)
			{
				var_08 = distance2d(var_01.lookaheadorigin,var_01.var_C053[var_01.lookaheadnextnode].origin);
				if(var_08 < var_07)
				{
					var_07 = var_07 - var_08;
					var_01.lookaheadorigin = var_01.var_C053[var_01.lookaheadnextnode].origin;
					var_01.lookaheadcurrnode = var_01.lookaheadnextnode;
					var_01.lookaheadnextnode = var_01.lookaheadcurrnode + var_05 + var_04 % var_04;
					continue;
				}

				var_09 = vectornormalize(var_01.var_C053[var_01.lookaheadnextnode].origin - var_01.var_C053[var_01.lookaheadcurrnode].origin);
				var_01.lookaheadorigin = var_01.lookaheadorigin + var_09 * var_07;
			}
		}

		self.var_1198.desireddir = vectornormalize(var_01.lookaheadorigin - self.origin * (1,1,0));
		wait(0.05);
	}
}

//Function Number: 13
staylookingatcenter(param_00)
{
	self endon(param_00 + "_finished");
	for(;;)
	{
		facearenacenter();
		wait(0.05);
	}
}

//Function Number: 14
playstrafefireball(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = self method_80FD(param_01,var_04);
	if(self.var_1198.smoothmotion)
	{
		thread adjustlookahead(param_01);
	}

	thread applyallmotiontowardsdesireddir(param_01,var_05,1,0);
	if(self.var_1198.facecenter)
	{
		thread staylookingatcenter(param_01);
	}

	lib_0F3C::func_CEA8(param_00,param_01,param_02,param_03);
}

//Function Number: 15
choosestrafefireballanim(param_00,param_01,param_02)
{
	var_03 = self.var_1198.currentmovedirindex;
	return lib_0A1A::func_2358(param_01,var_03);
}

//Function Number: 16
strafefireballnotehandler(param_00,param_01,param_02,param_03)
{
	var_04 = getspecialenemy();
	var_05 = self.arenacenter;
	if(isdefined(var_04))
	{
		var_05 = var_04.origin;
	}

	if(param_00 == "fireleft")
	{
		thread strafefireballburst("j_mid_le_3",var_05,param_01);
		return;
	}

	if(param_00 == "fireright")
	{
		thread strafefireballburst("j_mid_ri_3",var_05,param_01);
		return;
	}

	if(param_00 == "fireboth")
	{
		thread strafefireballburst("j_thumb_ri_3",var_05,param_01);
		return;
	}
}

//Function Number: 17
strafefireballburst(param_00,param_01,param_02)
{
	self endon(param_02 + "_finished");
	var_03 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	var_04 = randomintrange(var_03.min_burst_count,var_03.max_burst_count);
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		var_06 = self gettagorigin(param_00);
		var_07 = (randomfloatrange(var_03.sawblade_min_offset,var_03.sawblade_max_offset),randomfloatrange(var_03.sawblade_min_offset,var_03.sawblade_max_offset),0);
		var_08 = magicbullet(var_03.sawblade_weapon,var_06,param_01 + var_07,self);
		var_08 thread fireballimpactfx();
		wait(var_03.sawblade_burst_interval);
	}
}

//Function Number: 18
playfireball(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.fireballtargetpos))
	{
		self.fireballtargetpos = self.arenacenter;
	}

	faceposition(self.fireballtargetpos);
	lib_0F3C::func_CEA8(param_00,param_01,param_02,param_03);
}

//Function Number: 19
choosefireballanim(param_00,param_01,param_02)
{
	var_03 = randomfloat(1);
	if(var_03 < 0.33)
	{
		return lib_0A1A::func_2358(param_01,"left");
	}

	if(var_03 < 0.66)
	{
		return lib_0A1A::func_2358(param_01,"right");
	}

	return lib_0A1A::func_2358(param_01,"both");
}

//Function Number: 20
fireball_note_handler(param_00,param_01,param_02,param_03)
{
	var_04 = self.fireballtargetpos;
	if(param_00 == "fireleft")
	{
		var_05 = self gettagorigin("j_mid_le_3");
		fireballburst(param_01,var_05,var_04);
		return;
	}

	if(param_00 == "fireright")
	{
		var_05 = self gettagorigin("j_mid_ri_3");
		fireballburst(param_01,var_05,var_04);
		return;
	}

	if(param_00 == "fireboth")
	{
		var_05 = self gettagorigin("j_thumb_ri_3");
		fireballburst(param_01,var_05,var_04);
		return;
	}
}

//Function Number: 21
fireballburst(param_00,param_01,param_02)
{
	self endon(param_00 + "_finished");
	var_03 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	var_04 = randomintrange(var_03.min_burst_count,var_03.max_burst_count);
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		var_06 = (randomfloatrange(var_03.sawblade_min_offset,var_03.sawblade_max_offset),randomfloatrange(var_03.sawblade_min_offset,var_03.sawblade_max_offset),0);
		var_07 = magicbullet(var_03.sawblade_weapon,param_01,param_02 + var_06,self);
		var_07 thread fireballimpactfx();
		wait(var_03.sawblade_burst_interval);
	}
}

//Function Number: 22
fireballimpactfx()
{
	self waittill("death");
	if(!isdefined(self) || !isdefined(self.origin))
	{
		return;
	}

	earthquake(0.3,1,self.origin,128);
	playrumbleonposition("grenade_rumble",self.origin);
}

//Function Number: 23
clap_note_handler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "fire")
	{
		thread handleclapprojectile();
	}
}

//Function Number: 24
doclapdamage()
{
	level endon("rockwall_end");
	var_00 = getent("rockwall_trig","targetname");
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(!var_01 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(!isdefined(var_01.var_C85F))
		{
			playfxontagforclients(level._effect["vfx_dlc4_player_burn_flames"],var_01,"tag_eye",var_01);
			var_01.var_C85F = 1;
			var_01 dodamage(15,var_00.origin,level.dlc4_boss,level.dlc4_boss,"MOD_UNKNOWN","iw7_electrictrap_zm");
			var_01 thread scripts\cp\maps\cp_final\cp_final_final_boss::func_E069();
			continue;
		}
	}
}

//Function Number: 25
handleclapprojectile()
{
	self.claponarena = 1;
	var_00 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	var_01 = anglestoforward(self.angles);
	var_02 = var_00.staff_projectile_range / var_00.staff_projectile_speed;
	var_03 = var_00.staff_projectile_speed * var_00.staff_projectile_interval;
	var_04 = var_03 / 2;
	var_05 = self.origin + var_01 * var_04;
	var_06 = gettime() + var_02 * 1650;
	var_07 = spawn("script_model",var_05);
	var_07 setmodel(var_00.ratking_staff_projectile_model);
	var_07 show();
	var_07.angles = var_01 + (0,90,0);
	var_08 = getent("rockwall_clip","targetname");
	var_08.angles = var_01 + (0,90,0);
	var_08.origin = var_05;
	var_08 linkto(var_07);
	var_08 thread doclapdamage();
	var_07 playsoundonmovingent("cp_final_meph_rock_spires");
	level.rockwall_forming = 1;
	while(gettime() < var_06)
	{
		doclaplethaldamage(var_05,var_04,var_00.staff_projectile_z_delta,var_00.staff_projectile_damage);
		var_07 moveto(var_05,var_00.staff_projectile_interval);
		earthquake(0.35,1,var_05,256);
		wait(var_00.staff_projectile_interval);
		var_05 = var_05 + var_01 * var_03;
		var_07.angles = vectortoangles(var_05 - var_07.origin);
		var_09 = anglestoforward(var_07.angles);
		playfx(level._effect["vfx_clap_wall_raise"],var_05,anglestoforward(var_07.angles),anglestoup(var_07.angles));
		playrumbleonposition("grenade_rumble",var_05);
	}

	level.rockwall_forming = undefined;
	var_0A = function_027A(var_08.origin,(2000,64,200),var_07.angles);
	wait(0.15);
	var_07 delete();
	wait(10);
	destroynavobstacle(var_0A);
	var_08 unlink();
	var_08.origin = var_08.origin + (0,0,-200);
	self.claponarena = 0;
	level notify("rockwall_end");
}

//Function Number: 26
doclaplethaldamage(param_00,param_01,param_02,param_03)
{
	param_01 = param_01 + 64;
	var_04 = param_01 * param_01;
	var_05 = scripts\common\trace::func_48CC(1);
	var_06 = scripts\common\trace::func_DCED(param_00 + (0,0,param_02),param_00 - (0,0,param_02),self,var_05);
	param_00 = getgroundposition(param_00,8);
	foreach(var_08 in level.players)
	{
		if(!isalive(var_08))
		{
			continue;
		}

		var_09 = distance2dsquared(param_00,var_08.origin);
		if(var_09 > var_04)
		{
			continue;
		}

		if(abs(param_00[2] - var_08.origin[2]) > param_02)
		{
			continue;
		}

		if(!scripts\cp\_laststand::player_in_laststand(var_08) && lib_0F74::func_1002C(var_08))
		{
			continue;
		}

		var_08 thread warp_to_closest();
		var_08 dodamage(param_03,param_00,self,self,"MOD_IMPACT");
	}
}

//Function Number: 27
warp_to_closest()
{
	self endon("disconnect");
	while(scripts\common\utility::istrue(level.rockwall_forming))
	{
		wait(0.05);
	}

	self setorigin(getclosestpointonnavmesh(self.origin));
}

//Function Number: 28
unlink_from_anchor()
{
	wait(0.5);
	self unlink(1);
}

//Function Number: 29
playsummonanim(param_00,param_01,param_02,param_03)
{
	self playsound("final_meph_eclipse");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_04,self.var_C081);
}

//Function Number: 30
summon_note_handler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		summonskeletons();
	}
}

//Function Number: 31
summonskeletons()
{
	var_00 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	foreach(var_02 in var_00.var_108FB)
	{
		spawnzombie(var_00.summon_agent_type,var_02);
	}
}

//Function Number: 32
setup_summoned_zombie(param_00)
{
	self endon("death");
	wait(2);
	if(!isalive(self))
	{
		return;
	}

	if(param_00 == "skeleton")
	{
		self setscriptablepartstate("eyes","red_eyes");
		self setscriptablepartstate("burning","active");
		return;
	}

	if(param_00 == "generic_zombie")
	{
		self setscriptablepartstate("eyes","yellow_eyes");
	}
}

//Function Number: 33
tornado_note_handler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "tornado_start")
	{
		level thread firetornado(self);
	}
}

//Function Number: 34
firetornado(param_00)
{
	var_01 = spawnfx(level._effect["vfx_fire_tornado_lg"],param_00.arenacenter + (0,0,5));
	wait(0.2);
	param_00 playsound("final_meph_throw_big");
	triggerfx(var_01);
	wait(0.05);
	var_02 = spawn("trigger_radius",param_00.arenacenter,0,156,96);
	var_02 thread firetornadodamage();
	playsoundatpos(param_00.arenacenter + (0,0,5),"cp_final_meph_tornado_big_spawn");
	wait(3);
	var_03 = scripts\common\utility::getstructarray("tornado_start","targetname");
	foreach(var_05 in var_03)
	{
		level thread createfiretornado(var_05);
		wait(0.05);
	}

	var_07 = scripts\common\utility::random(var_03);
	var_08 = scripts\common\utility::random(var_03);
	wait(1);
	level thread createfiretornado(var_07);
	level thread createfiretornado(var_08);
	wait(2);
	var_02 delete();
	wait(1);
	var_01 delete();
}

//Function Number: 35
createfiretornado(param_00)
{
	var_01 = spawn("trigger_radius",param_00.origin,0,96,96);
	var_02 = spawn("script_model",param_00.origin);
	wait(0.05);
	var_02 setmodel("tag_origin_fire_tornado");
	var_01 enablelinkto();
	var_01 linkto(var_02);
	var_01 thread firetornadodamage();
	wait(0.05);
	var_02 playloopsound("cp_final_meph_tornado_small_lp");
	var_02 moveto(scripts\common\utility::random(scripts\common\utility::getstructarray(param_00.target,"targetname")).origin,3);
	var_02 waittill("movedone");
	var_02 stoploopsound();
	playsoundatpos(var_02.origin,"cp_final_meph_tornado_small_end");
	var_01 delete();
	wait(1);
	var_02 delete();
}

//Function Number: 36
firetornadodamage()
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!var_00 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(!isdefined(var_00.var_C85F))
		{
			playfxontagforclients(level._effect["vfx_dlc4_player_burn_flames"],var_00,"tag_eye",var_00);
			var_00.var_C85F = 1;
			var_00 dodamage(40,self.origin,self,self,"MOD_UNKNOWN","iw7_electrictrap_zm");
			var_00 thread scripts\cp\maps\cp_final\cp_final_final_boss::func_E069();
			continue;
		}
	}
}

//Function Number: 37
ground_pound_start_note_handler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "fire")
	{
		thread doteleporttocenter(param_01);
	}
}

//Function Number: 38
ground_pound_pound_note_handler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "fire")
	{
		var_04 = scripts\asm\dlc4\dlc4_asm::gettunedata();
		self radiusdamage(self.origin,var_04.ss_groundpound_radius,var_04.ss_groundpound_max_damage,var_04.ss_groundpound_min_damage,self,"MOD_IMPACT");
	}
}

//Function Number: 39
groundpoundexit(param_00,param_01,param_02,param_03)
{
	thread doteleporttodesirednode(param_01);
}

//Function Number: 40
throw_note_handler(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	var_05 = undefined;
	var_06 = getspecialenemy();
	var_05 = self.arenacenter;
	if(isdefined(var_06))
	{
		var_05 = var_06.origin;
	}

	if(param_00 == "fireleft")
	{
		var_04 = self gettagorigin("j_mid_le_3");
		throwmeteor(param_01,"LEFT",var_05);
		return;
	}

	if(param_00 == "fireright")
	{
		var_04 = self gettagorigin("j_mid_ri_3");
		throwmeteor(param_01,"RIGHT",var_05);
		return;
	}

	if(param_00 == "fireboth")
	{
		var_04 = self gettagorigin("j_thumb_ri_3");
		throwmeteor(param_01,"CENTER",var_05);
		return;
	}
}

//Function Number: 41
throwmeteor(param_00,param_01,param_02)
{
	self playsound("final_meph_throw_quick");
	self endon(param_00 + "_finished");
	var_03 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	if(distance2dsquared(self.origin,param_02) < distance2dsquared(self.origin,self.arenacenter))
	{
		param_02 = self.arenacenter;
	}

	var_04 = vectortoangles(self.origin - param_02 * (1,1,0));
	var_05 = undefined;
	var_04 = (0 - var_03.throw_starting_pitch,var_04[1],var_04[2]);
	if(param_01 == "LEFT")
	{
		var_04 = (var_04[0],var_04[1] - var_03.throw_side_yaw,var_04[2]);
	}
	else if(param_01 == "RIGHT")
	{
		var_04 = (var_04[0],var_04[1] + var_03.throw_side_yaw,var_04[2]);
	}

	var_06 = scripts\common\trace::func_48BC(1,0,0,0,1,0,0);
	var_07 = [];
	foreach(var_09 in scripts\mp\_mp_agent::func_7D94("zombie"))
	{
		if(var_09.agent_type != "dlc4_boss")
		{
			var_07[var_07.size] = var_09;
		}
	}

	foreach(var_0C in level.players)
	{
		var_07[var_07.size] = var_0C;
	}

	while(var_04[0] > -40)
	{
		var_04 = (var_04[0] - var_03.throw_fidelity,var_04[1],var_04[2]);
		var_05 = anglestoforward(var_04) * var_03.throw_distance;
		if(scripts\common\trace::func_109DF(param_02 + var_05,param_02,var_03.throw_meteor_radius,var_07,var_06))
		{
			break;
		}
	}

	var_0E = magicbullet(var_03.throw_weapon,param_02 + var_05,param_02,self);
	var_0E playloopsound("cp_final_meph_asteroid_lp_01");
	level thread play_asteroid_tellsfx(param_02);
	var_0E waittill("death");
	playsoundatpos(var_0E.origin,"cp_final_meph_asteroid_explo");
	earthquake(0.55,1,var_0E.origin,1200);
	playrumbleonposition("artillery_rumble",var_0E.origin);
}

//Function Number: 42
play_asteroid_tellsfx(param_00)
{
	wait(2);
	playsoundatpos(param_00,"cp_final_meph_asteroid_incoming");
}

//Function Number: 43
choosethrowanim(param_00,param_01,param_02)
{
	var_03 = randomfloat(1);
	if(var_03 < 0.33)
	{
		return lib_0A1A::func_2358(param_01,"left");
	}

	if(var_03 < 0.66)
	{
		return lib_0A1A::func_2358(param_01,"right");
	}

	return lib_0A1A::func_2358(param_01,"both");
}

//Function Number: 44
air_pound_rise_play(param_00,param_01,param_02,param_03)
{
	function_0277("dlc4_boss_repulsor",-1,self.arenacenter,150,1);
	self.var_BE6F = function_027A(self.arenacenter,(100,100,100),(0,0,0));
	self playsound("final_meph_intro");
	thread airpoundrisefx();
	lib_0F3C::func_CEA8(param_00,param_01,param_02,param_03);
}

//Function Number: 45
air_pound_attack_note_handler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		var_04 = scripts\asm\dlc4\dlc4_asm::gettunedata();
		playfx(var_04.air_pound_pound_fx,self.arenacenter);
		earthquake(var_04.air_pound_pound_rumble_scale,var_04.air_pound_pound_rumble_duration,self.arenacenter,var_04.air_pound_pound_rumble_radius);
		playrumbleonposition("artillery_rumble",self.arenacenter);
		playsoundatpos(self.arenacenter,var_04.air_pound_pound_sfx);
		self radiusdamage(self.arenacenter,var_04.ss_groundpound_radius,var_04.ss_groundpound_max_damage,var_04.ss_groundpound_min_damage,self,"MOD_IMPACT");
	}
}

//Function Number: 46
airpoundrisefx()
{
	var_00 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	playfx(var_00.air_pound_rise_fx,self.arenacenter);
	var_01 = gettime() + 4000;
	playsoundatpos(self.arenacenter,"zmb_ground_spawn_dirt");
	while(gettime() < var_01)
	{
		earthquake(var_00.air_pound_rise_rumble_scale,var_00.air_pound_rise_rumble_duration,self.arenacenter,var_00.air_pound_rise_rumble_radius);
		scripts\common\utility::func_136F7();
		playrumbleonposition("artillery_rumble",self.arenacenter);
		wait(0.2);
	}
}

//Function Number: 47
playgroundvulidle(param_00,param_01,param_02,param_03)
{
	self.groundvultimer = scripts\asm\dlc4\dlc4_asm::gettunedata().ground_vul_time;
	thread playgroundvulidlehelper(param_01);
	lib_0F3C::func_B050(param_00,param_01,param_02,param_03);
}

//Function Number: 48
playgroundvulidlehelper(param_00)
{
	self endon(param_00 + "_finished");
	while(self.groundvultimer > 0)
	{
		self.groundvultimer = self.groundvultimer - 50;
		wait(0.05);
	}
}

//Function Number: 49
groundvulteleportintransition(param_00,param_01,param_02,param_03)
{
	if(lib_0A1A::func_232B(param_01,"teleport_finished"))
	{
		self.teleportedin = 1;
	}

	return self.teleportedin && !self.claponarena;
}

//Function Number: 50
playgroundvulland(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	function_0277("dlc4_boss_repulsor",-1,self.arenacenter,150,1);
	self.var_BE6F = function_027A(self.arenacenter,(100,100,100),(0,0,0));
	if(level.fbd.bossstate == "LAST_STAND")
	{
		lib_0F3C::func_CEA8(param_00,param_01,param_02,param_03);
		self.cantakedamage = 1;
		return;
	}

	var_05 = scripts\mp\_mp_agent::func_7D95(var_04.summon_agent_type);
	var_06 = var_04.summon_max_total["" + level.players.size];
	var_07 = min(level.players.size * var_04.zombies_per_person,var_06 - var_05.size);
	for(var_08 = 0;var_08 < var_07;var_08++)
	{
		var_09 = 1 * var_08 * 360 / var_07;
		var_0A = self.arenacenter[0] + cos(var_09) * var_04.zombies_summon_radius;
		var_0B = self.arenacenter[1] + sin(var_09) * var_04.zombies_summon_radius;
		var_0C = (var_0A,var_0B,self.arenacenter[2]);
		spawnzombie("skeleton",var_0C);
	}

	lib_0F3C::func_CEA8(param_00,param_01,param_02,param_03);
}

//Function Number: 51
playgroundvullaunch(param_00,param_01,param_02,param_03)
{
	self.groundvultimer = undefined;
	scripts\cp\maps\cp_final\cp_final_final_boss::cleanupweakspot(level.fbd.activecircle);
	level notify("FINAL_BOSS_STAGE_FAILED");
	playanimandteleport(param_00,param_01,param_02,param_03);
}

//Function Number: 52
groundvulidletransition(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.groundvultimer) || self.groundvultimer > 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 53
groundvulidleterminate(param_00,param_01,param_02)
{
	self.vulnerable = 0;
}

//Function Number: 54
groundvulhurttransition(param_00,param_01,param_02,param_03)
{
	return isdefined(level.fbd.sectioncomplete) && level.fbd.sectioncomplete;
}

//Function Number: 55
groundvuldeathtransition(param_00,param_01,param_02,param_03)
{
	return isdefined(level.fbd.sectioncomplete) && level.fbd.sectioncomplete && level.fbd.victory;
}

//Function Number: 56
choosegroundvulhurtanim(param_00,param_01,param_02)
{
	if(level.fbd.bossstate == "FRENZIED")
	{
		return lib_0A1A::func_2358(param_01,"frenzied_hurt");
	}

	return lib_0A1A::func_2358(param_01,"ground_vul_hurt");
}

//Function Number: 57
groundvullaunchnotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "flames_on")
	{
		self setscriptablepartstate("flames","on");
		self setscriptablepartstate("circle_" + level.fbd.activecircle.index,"off");
	}

	teleportnotehandler(param_00,param_01,param_02,param_03);
}

//Function Number: 58
groundvulhurtnotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		var_04 = scripts\asm\dlc4\dlc4_asm::gettunedata();
		playfx(var_04.air_pound_pound_fx,self.arenacenter);
		earthquake(var_04.air_pound_pound_rumble_scale,var_04.air_pound_pound_rumble_duration,self.arenacenter,var_04.air_pound_pound_rumble_radius);
		playrumbleonposition("artillery_rumble",self.arenacenter);
		playsoundatpos(self.arenacenter,var_04.air_pound_pound_sfx);
		self radiusdamage(self.origin,var_04.ground_pound_radius,var_04.ground_pound_max_damage,var_04.ground_pound_min_damage,self,"MOD_IMPACT");
		var_05 = scripts\mp\_mp_agent::func_7D94("zombie");
		foreach(var_07 in var_05)
		{
			if(var_07.agent_type != "dlc4_boss")
			{
				var_07 dodamage(var_07.health * 10,self.arenacenter);
			}
		}
	}
	else if(param_00 == "flames_on")
	{
		self setscriptablepartstate("flames","on");
	}

	teleportnotehandler(param_00,param_01,param_02,param_03);
}

//Function Number: 59
loopdropmovedown(param_00,param_01,param_02,param_03)
{
	self.dropdowntimer = scripts\asm\dlc4\dlc4_asm::gettunedata().drop_down_time;
	thread playdropmovedownhelper(param_01);
	lib_0F3C::func_B050(param_00,param_01,param_02,param_03);
}

//Function Number: 60
playdropmovedownhelper(param_00)
{
	self endon(param_00 + "_finished");
	while(self.dropdowntimer > 0)
	{
		self.dropdowntimer = self.dropdowntimer - 50;
		wait(0.05);
	}

	thread doteleporttodesirednode(param_00,1);
}

//Function Number: 61
dropmovedowntransition(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.dropdowntimer) || self.dropdowntimer > 0)
	{
		return 0;
	}

	self playsound("final_meph_ground_swipe");
	self setscriptablepartstate("flame_trail","off");
	self.dropdowntimer = undefined;
	return 1;
}

//Function Number: 62
dropmoveuptransition(param_00,param_01,param_02,param_03)
{
	var_04 = self.var_1198.var_C053[self.var_1198.var_4BF7].origin;
	var_05 = self.var_1198.dropmovearrivaldist * self.var_1198.dropmovearrivaldist;
	return distancesquared(self.origin,var_04) <= var_05;
}

//Function Number: 63
playflyoverexit(param_00,param_01,param_02,param_03)
{
	self method_8282(scripts\asm\dlc4\dlc4_asm::gettunedata().fly_over_speed,1);
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 64
flyoverlooptransition(param_00,param_01,param_02,param_03)
{
	var_04 = self.var_1198;
	var_05 = var_04.var_C053[var_04.desirednode].origin;
	var_06 = distance2dsquared(var_05,self.origin);
	var_07 = var_04.flyoverarrivaldist * var_04.flyoverarrivaldist;
	if(var_06 <= var_07)
	{
		self.var_1198.flyoverarrivaldist = undefined;
		return 1;
	}

	return 0;
}

//Function Number: 65
terminateflyoverarrival(param_00,param_01,param_02)
{
	self method_8282(1,1);
}

//Function Number: 66
flyoverloopnotehandler(param_00,param_01,param_02,param_03)
{
}

//Function Number: 67
black_hole_start_note_handler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "start_blackhole")
	{
		thread createmephblackhole();
	}
}

//Function Number: 68
playblackholeloop(param_00,param_01,param_02,param_03)
{
	self.blackholetimer = scripts\asm\dlc4\dlc4_asm::gettunedata().black_hole_duration;
	thread playblackholeloophelper(param_01);
	lib_0F3C::func_B050(param_00,param_01,param_02,param_03);
}

//Function Number: 69
playblackholeloophelper(param_00)
{
	self endon(param_00 + "_finished");
	while(self.blackholetimer > 0)
	{
		self.blackholetimer = self.blackholetimer - 50;
		wait(0.05);
	}
}

//Function Number: 70
blackholelooptransition(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.blackholetimer) || self.blackholetimer > 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 71
black_hole_end_note_handler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "blackhole_end")
	{
		self notify("stop_blackhole");
	}
}

//Function Number: 72
eclipse_note_handler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "start_eclipse")
	{
		thread create_eclipse();
		return;
	}

	if(param_00 == "start_wave")
	{
		thread doeclipsespecialwave();
		thread eclipsespecialwavetimer();
	}
}

//Function Number: 73
doeclipsespecialwave()
{
	self endon("death");
	level endon("ECLIPSE_SPAWN_COMPLETE");
	var_00 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	self.eclipseactive = 1;
	var_01 = self.unlockedactions.size;
	var_02 = var_00.base_spawn_interval;
	var_03 = var_00.specialwavesdata["BASIC_" + var_01];
	var_04 = var_00.specialwavesdata["PHANTOM_" + var_01];
	var_05 = var_03 + var_04;
	var_06 = [];
	for(var_07 = 0;var_07 < var_03;var_07++)
	{
		if(randomfloat(1) > 0.5)
		{
			var_06[var_06.size] = "generic_zombie";
			continue;
		}

		var_06[var_06.size] = "alien_goon";
	}

	for(var_07 = 0;var_07 < var_04;var_07++)
	{
		var_06[var_06.size] = "alien_phantom";
	}

	var_06 = scripts\common\utility::array_randomize(var_06);
	for(var_07 = 0;var_07 < var_05;var_07++)
	{
		while(scripts\mp\_mp_agent::func_7D95("all").size >= 24)
		{
			scripts\common\utility::func_136F7();
		}

		scripts\aitypes\dlc4_boss\behaviors::computespawnpoints(1,scripts\mp\_mp_agent::func_7D94("zombie"));
		if(isdefined(var_00.var_108FB[0]))
		{
			spawnzombie(var_06[var_07],var_00.var_108FB[0]);
		}

		wait(var_02);
		var_02 = var_02 * var_00.spawn_interval_decay;
	}

	var_08 = var_00.specialwavesdata["SPECIAL_" + var_01];
	while(scripts\mp\_mp_agent::func_7D94("zombie").size + var_08.size > 24)
	{
		wait(1);
	}

	scripts\aitypes\dlc4_boss\behaviors::computespawnpoints(var_08.size,scripts\mp\_mp_agent::func_7D94("zombie"));
	for(var_07 = 0;var_07 < var_08.size;var_07++)
	{
		if(isdefined(var_00.var_108FB[var_07]))
		{
			spawnzombie(var_08[var_07],var_00.var_108FB[var_07]);
		}
	}

	while(scripts\mp\_mp_agent::func_7D94("zombie").size > 1)
	{
		wait(1);
	}

	wait(1);
	level notify("ECLIPSE_SPAWN_COMPLETE");
}

//Function Number: 74
eclipsespecialwavetimer()
{
	level endon("ECLIPSE_SPAWN_COMPLETE");
	var_00 = gettime();
	var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata().eclipse_duration;
	while(gettime() < var_00 + var_01)
	{
		wait(1);
	}

	level notify("ECLIPSE_SPAWN_COMPLETE");
}

//Function Number: 75
create_eclipse()
{
	var_00 = getent("eclipse_blocker","targetname");
	if(!isdefined(var_00.var_C38F))
	{
		var_00.var_C38F = var_00.origin;
	}

	var_01 = spawnfx(level._effect["vfx_boss_sun_blocker"],(-17910.3,966.038,5116),anglestoforward((43.4021,347.643,-7.50797)),anglestoup((43.4021,347.643,-7.50797)));
	triggerfx(var_01);
	playsoundatpos((-17910.3,966.038,5116),"cp_final_meph_eclipse_rock_forming");
	wait(1);
	var_00 moveto((-17391.3,400,3900),1.25);
	level.current_vision_set = "cp_final_meph_eclipse";
	function_0237("cp_final_meph_eclipse",1);
	level waittill("ECLIPSE_SPAWN_COMPLETE");
	var_02 = spawnfx(level._effect["vfx_sun_blocker_end"],(-17910.3,966.038,5116),anglestoforward((43.4021,347.643,-7.50797)),anglestoup((43.4021,347.643,-7.50797)));
	triggerfx(var_02);
	var_01 delete();
	function_0237("cp_final_meph",1);
	level.current_vision_set = "cp_final_meph";
	var_00 moveto(var_00.var_C38F,1.25);
	thread createarmageddon();
}

//Function Number: 76
createarmageddon()
{
	var_00 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	var_01 = var_00.safe_zone_radius * var_00.safe_zone_radius;
	wait(0.5);
	var_02 = gettime() + var_00.var_2174;
	var_03 = self.unlockedactions.size;
	var_04 = pow(var_00.meteor_period_stage_decay,var_03);
	var_05 = var_00.meteor_min_period * var_04;
	var_06 = var_00.meteor_max_period * var_04;
	while(gettime() < var_02)
	{
		var_07 = sqrt(randomfloat(1)) * var_00.meteor_target_radius;
		var_08 = randomfloat(360);
		var_09 = self.arenacenter[0] + var_07 * cos(var_08);
		var_0A = self.arenacenter[1] + var_07 * sin(var_08);
		var_0B = (var_09,var_0A,self.arenacenter[2]);
		var_0C = distance2dsquared(var_0B,(-13165,74,-46));
		var_0D = distance2dsquared(var_0B,(-13263,-767,-46));
		if(var_0C > var_01 && var_0D > var_01)
		{
			magicbullet("iw7_dlc4eclipse_mp",(-17910.3,966.038,5116),var_0B);
		}

		wait(randomfloatrange(var_05,var_06));
	}

	foreach(var_0F in scripts\mp\_mp_agent::func_7D94("zombie"))
	{
		if(var_0F.agent_type != "dlc4_boss")
		{
			var_0F dodamage(var_0F.health * 10,self.arenacenter);
		}
	}

	wait(5);
	self.eclipseactive = 0;
}

//Function Number: 77
shouldgointolaststand(param_00,param_01,param_02,param_03)
{
	return level.fbd.bossstate == "LAST_STAND" && scripts\asm\dlc4\dlc4_asm::isanimdone(param_00,param_01,param_02,param_03);
}

//Function Number: 78
shouldplaydeath(param_00,param_01,param_02,param_03)
{
	return level.fbd.victory && scripts\asm\dlc4\dlc4_asm::isanimdone(param_00,param_01,param_02,param_03);
}

//Function Number: 79
death_note_handler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "fadeout")
	{
		level thread meph_victory();
	}
}

//Function Number: 80
death_ground_idle_note_handler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "idle_pain")
	{
		self playsound("final_meph_pain_teleport");
	}
}

//Function Number: 81
meph_victory()
{
	scripts\cp\maps\cp_final\cp_final::disablepas();
	scripts\cp\_vo::func_F60C(1);
	foreach(var_01 in level.players)
	{
		scripts\cp\maps\cp_final\cp_final_vo::clear_up_all_vo(var_01);
		var_01 method_82C0("bink_fadeout_amb",0.66);
	}

	level notify("FINAL_BOSS_VICTORY");
	if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		foreach(var_01 in level.players)
		{
			var_01 thread scripts\cp\_utility::func_CF90(0.25,20,0.25,0,1);
		}

		level thread scripts\cp\zombies\direct_boss_fight::success_sequence(undefined,6);
		return;
	}

	foreach(var_03 in level.players)
	{
		var_03 thread scripts\cp\_utility::func_CF90(0.25,1,0.25,0,1);
		var_03 scripts\cp\_merits::func_D9AD("mt_dlc4_troll2");
		var_03 setplayerdata("cp","meritState","mt_dc_camo",1);
	}

	setomnvar("zm_boss_splash",7);
	wait(0.55);
	scripts\cp\_utility::play_bink_video("sysload_o3",32,0);
	wait(33);
	foreach(var_03 in level.players)
	{
		var_03 method_8070(0.3);
	}

	level thread [[ level.endgame ]]("axis",level.end_game_string_index["win"]);
}

//Function Number: 82
smallpain()
{
	self.soulhealth = self.soulhealth - 1;
	if(self.soulhealth == 0)
	{
		self.soulhealth = 999;
		if(self.interruptable)
		{
			self notify("pain");
			self.var_1198.painnotifytime = 100;
			scripts\aitypes\dlc4_boss\behaviors::setnextaction("ground_vul");
			level notify(scripts\asm\dlc4\dlc4_asm::gettunedata().soul_health_depleted_notify);
			self notify("stop_blackhole");
			self.blackholetimer = undefined;
			return;
		}

		self.soulhealth = 1;
	}
}

//Function Number: 83
shouldterminateaction()
{
	if(isdefined(self.terminateaction) && self.terminateaction)
	{
		self.terminateaction = 0;
		return 1;
	}

	return 0;
}

//Function Number: 84
choosepainmovinganim(param_00,param_01,param_02)
{
	var_03 = self.var_1198.currentmovedirindex;
	return lib_0A1A::func_2358(param_01,var_03);
}

//Function Number: 85
painterminate(param_00,param_01,param_02)
{
}

//Function Number: 86
playpain(param_00,param_01,param_02,param_03)
{
	self.terminateaction = 1;
	self.vulnerable = 1;
	lib_0F3C::func_CEA8(param_00,param_01,param_02,param_03);
}

//Function Number: 87
playmovingpain(param_00,param_01,param_02,param_03)
{
	self.terminateaction = 1;
	self.vulnerable = 1;
	playmoveexit(param_00,param_01,param_02,param_03);
}

//Function Number: 88
playlaststandloop(param_00,param_01,param_02,param_03)
{
	level.laststandfx = spawnfx(level._effect["soul_bomb"],self.arenacenter + (0,0,450));
	triggerfx(level.laststandfx);
	playsoundatpos(self.arenacenter + (0,0,450),"cp_final_meph_final_soul_bomb_start");
	level.dlc4_boss playloopsound("cp_final_meph_final_soul_bomb_lp");
	thread laststandmonitor();
	lib_0F3C::func_B050(param_00,param_01,param_02,param_03);
}

//Function Number: 89
laststandmonitor()
{
	self endon("death");
	level endon("FINAL_BOSS_VICTORY");
	if(!isdefined(level.laststand_vo))
	{
		level.laststand_vo = 1;
		level thread scripts\cp\maps\cp_final\cp_final_final_boss::play_meph_vo(level.dlc4_boss scripts\cp\_utility::func_78BC(),"nag_meph_damage",1);
	}

	var_00 = scripts\asm\dlc4\dlc4_asm::gettunedata().last_stand_time;
	for(var_01 = scripts\asm\dlc4\dlc4_asm::gettunedata().last_stand_victory_min_time;var_00 > 0;var_01 = var_01 - 50)
	{
		scripts\common\utility::func_136F7();
		if(var_01 <= 0)
		{
			if(self.laststandhealth <= 0 && !level.fbd.victory)
			{
				scripts\cp\maps\cp_final\cp_final_final_boss::victory();
				return;
			}
		}

		var_00 = var_00 - 50;
	}

	self stoploopsound();
	self playsound("cp_final_meph_nuke");
	wait(1);
	playfx(level._effect["soul_bomb_exp"],self.arenacenter + (0,0,450));
	level.laststandfx delete();
	self.frenziedhealth = 999999;
	scripts\cp\maps\cp_final\cp_final::disablepas();
	level thread [[ level.endgame ]]("axis",level.end_game_string_index["kia"]);
}

//Function Number: 90
fightending(param_00,param_01,param_02)
{
}

//Function Number: 91
playanimandteleport(param_00,param_01,param_02,param_03)
{
	thread teleportwhenanimdone(param_01,param_03);
	lib_0F3C::func_CEA8(param_00,param_01,param_02,param_03);
}

//Function Number: 92
teleportnotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "teleport_start")
	{
		self playsound("cp_final_teleport_build_and_out_lr");
		var_04 = self gettagorigin("tag_origin");
		var_05 = self gettagangles("tag_origin");
		playfx(level._effect["boss_teleport_start"],var_04,anglestoforward(var_05),(0,0,1));
		var_04 = self gettagorigin("tag_fx_clavicle_4_ri");
		var_05 = self gettagangles("tag_fx_clavicle_4_ri");
		playfx(level._effect["boss_teleport_start_left"],var_04,anglestoforward(var_05),(0,0,1));
		function_0278("dlc4_boss_repulsor");
		if(isdefined(self.var_BE6F))
		{
			destroynavobstacle(self.var_BE6F);
		}
	}
}

//Function Number: 93
teleportendnotehandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "teleport_end")
	{
		self playsound("cp_final_teleport_in_lr");
		var_04 = self gettagorigin("tag_origin");
		var_05 = self gettagangles("tag_origin");
		playfx(level._effect["boss_teleport_end"],var_04,anglestoforward(var_05),(0,0,1));
		var_04 = self gettagorigin("tag_fx_clavicle_4_ri");
		var_05 = self gettagangles("tag_fx_clavicle_4_ri");
		playfx(level._effect["boss_teleport_end_left"],var_04,anglestoforward(var_05),(0,0,1));
	}
}

//Function Number: 94
teleportwhenanimdone(param_00,param_01)
{
	self endon(param_00 + "_finished");
	for(;;)
	{
		if(lib_0A1A::func_232B(param_00,"end"))
		{
			if(param_01 == "center")
			{
				thread doteleporttocenter(param_00);
			}
			else
			{
				thread doteleporttodesirednode(param_00);
			}

			return;
		}

		wait(0.05);
	}
}

//Function Number: 95
checkteleportdone(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1A::func_232B(param_01,"teleport_finished");
	return var_04;
}

//Function Number: 96
doteleporttocenter(param_00)
{
	self method_85B7(1);
	wait(0.5);
	while(isdefined(self.doinggroundvul) && self.doinggroundvul && isdefined(self.claponarena) && self.claponarena)
	{
		scripts\common\utility::func_136F7();
	}

	func_11663(self.arenacenter);
	thread showlater();
	lib_0A1A::func_2330(param_00,"teleport_finished");
}

//Function Number: 97
doteleporttodesirednode(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	self method_85B7(1);
	wait(0.5);
	teleporttodesirednode(param_01);
	facearenacenter();
	thread showlater();
	lib_0A1A::func_2330(param_00,"teleport_finished");
}

//Function Number: 98
teleporttodesirednode(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = self.var_1198.var_C053[self.var_1198.desirednode].origin;
	if(param_00)
	{
		var_01 = (var_01[0],var_01[1],self.origin[2]);
	}

	func_11663(var_01);
	self.var_1198.var_4BF7 = self.var_1198.desirednode;
}

//Function Number: 99
func_11663(param_00)
{
	self setorigin(param_00 - (0,0,1),0);
	self.var_1198.var_4BF7 = self.var_1198.desirednode;
}

//Function Number: 100
facearenacenter()
{
	faceposition(self.arenacenter);
}

//Function Number: 101
facedesirednode()
{
	faceposition(self.var_1198.var_C053[self.var_1198.desirednode].origin);
}

//Function Number: 102
faceposition(param_00)
{
	var_01 = param_00 - self.origin * (1,1,0);
	var_02 = vectortoangles(var_01);
	self method_8289("face angle abs",var_02);
}

//Function Number: 103
showlater()
{
	wait(0.5);
	self method_85B7(0);
	if(level.fbd.bossstate == "LAST_STAND")
	{
		self.cantakedamage = 1;
	}
}

//Function Number: 104
createmephblackhole()
{
	var_00 = self.arenacenter + (0,0,85);
	if(!isdefined(level.blackhole_scriptable))
	{
		level.blackhole_physics_vol = physics_volumecreate(var_00,500);
		level.blackhole_physics_vol method_852C(1,var_00,500);
		level.blackhole_scriptable = spawn("script_model",var_00);
		level.blackhole_scriptable setmodel("tag_origin_demon_blackhole");
	}

	var_01 = function_02AF(self,"demon_blackhole_zm",var_00);
	level.blackhole_physics_vol method_8526(1);
	level.blackhole_physics_vol method_8529(1);
	level.blackhole_scriptable setscriptablepartstate("vortexEnd","neutral");
	level.blackhole_scriptable setscriptablepartstate("vortexUpdate","active_cp",0);
	level thread mephbhquake(var_00,self);
	self waittill("stop_blackhole");
	var_01 delete();
	level.blackhole_scriptable setscriptablepartstate("vortexStart","neutral",0);
	level.blackhole_scriptable setscriptablepartstate("vortexUpdate","neutral",0);
	level.blackhole_scriptable setscriptablepartstate("vortexEnd","active",0);
	level.blackhole_physics_vol method_8526(0);
	level.blackhole_physics_vol method_8529(0);
	wait(2);
	level.blackhole_scriptable setscriptablepartstate("vortexEnd","neutral",0);
}

//Function Number: 105
mephbhquake(param_00,param_01)
{
	param_01 endon("stop_blackhole");
	for(;;)
	{
		earthquake(0.3,2,param_00,500);
		playrumbleonposition("grenade_rumble",param_00);
		wait(0.25);
		foreach(var_03 in level.players)
		{
			if(!var_03 scripts\cp\_utility::is_valid_player())
			{
				continue;
			}

			if(distance2d(var_03.origin,param_00) <= 100)
			{
				var_03 dodamage(var_03.health + 100,param_00,param_01,param_01,"MOD_EXPLOSIVE");
				continue;
			}

			if(distance2d(var_03.origin,param_00) < 250)
			{
				var_03 shellshock("default_nosound",0.5);
			}
		}
	}
}

//Function Number: 106
spawnzombie(param_00,param_01)
{
	var_02 = scripts\asm\dlc4\dlc4_asm::gettunedata();
	var_03 = spawnstruct();
	var_03.origin = param_01;
	var_03.angles = vectortoangles(self.arenacenter - var_03.origin);
	if(param_00 == "skeleton" || param_00 == "generic_zombie")
	{
		var_03.var_EE79 = "ground_spawn_no_boards";
		var_03.var_ECF5 = "spawn_ground";
		var_03.script_fxid = "dirt";
	}
	else if(param_00 == "alien_goon")
	{
		scripts\cp\zombies\cp_final_spawning::func_1B99(var_03);
	}
	else if(param_00 == "alien_phantom")
	{
		scripts\cp\zombies\cp_final_spawning::func_3115(var_03);
	}
	else if(param_00 == "alien_rhino" || param_00 == "zombie_clown" || param_00 == "karatemaster" || param_00 == "slasher")
	{
		scripts\cp\zombies\cp_final_spawning::func_3115(var_03);
	}

	var_04 = var_03 scripts\cp\zombies\zombies_spawning::func_1081B(param_00,1);
	if(!isdefined(var_04))
	{
		return;
	}

	var_04.entered_playspace = 1;
	var_04.dont_cleanup = 1;
	var_04.var_594C = 1;
	if(param_00 == "skeleton" || param_00 == "generic_zombie")
	{
		var_04.maxhealth = var_02.skeleton_health;
		var_04.health = var_02.skeleton_health;
		var_04 thread setup_summoned_zombie(param_00);
	}

	if(param_00 == "alien_goon" || param_00 == "alien_phantom" || param_00 == "alien_rhino")
	{
		var_04 method_80BB(1,1);
		if(param_00 == "alien_goon")
		{
			var_04.maxhealth = int(var_02.skeleton_health / 2);
			var_04.health = int(var_02.skeleton_health / 2);
		}
	}

	if(param_00 == "slasher")
	{
		level.slasher_level = 0;
		var_04.allowpain = 0;
	}

	if(param_00 == "zombie_clown" || param_00 == "karatemaster")
	{
		var_04.maxhealth = 3200;
		var_04.health = 3200;
	}
}

//Function Number: 107
getspecialenemy()
{
	if(randomfloat(1) > scripts\asm\dlc4\dlc4_asm::gettunedata().chance_to_target_charger)
	{
		var_00 = level.fbd.playerschargingcircle.size;
		if(var_00 > 0)
		{
			var_01 = level.fbd.playerschargingcircle[randomint(var_00)];
			self.myenemy = var_01;
		}
	}

	return scripts\asm\dlc4\dlc4_asm::getenemy();
}