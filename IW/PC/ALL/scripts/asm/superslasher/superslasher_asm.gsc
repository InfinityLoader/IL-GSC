/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\superslasher\superslasher_asm.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 79
 * Decompile Time: 4180 ms
 * Timestamp: 10/27/2023 12:02:21 AM
*******************************************************************/

//Function Number: 1
superslasher_init(param_00,param_01,param_02,param_03)
{
	self.var_2303.var_7257 = spawnstruct();
	self.var_2303.var_7257.var_7254 = "left";
	self.var_2303.var_7257.time = gettime();
	self.var_2303.var_4C86 = spawnstruct();
	self.var_2CC = 32;
	self.sharpturnnotifydist = 160;
	var_04 = self method_80FD("jump_to_roof",0);
	var_05 = getmovedelta(var_04);
	var_06 = getangledelta(var_04);
	level.superslasherjumptoroofangles = (0,angleclamp180(level.superslasherrooftopangles[1] - 180 - var_06),0);
	level.superslashergotogroundspot = level.superslasherrooftopspot - rotatevector(var_05,level.superslasherjumptoroofangles);
}

//Function Number: 2
ss_play(param_00,param_01,param_02,param_03,param_04)
{
	self endon(param_01 + "_finished");
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	if(!isdefined(param_04))
	{
		param_04 = lib_0A1A::func_2341(param_00,param_01);
	}

	scripts\mp\agents\_scriptedagents::func_CED2(param_01,var_05,self.var_BCE4,param_01,"end",param_04);
}

//Function Number: 3
superslasher_playmoveloop(param_00,param_01,param_02,param_03)
{
	self.var_1198.var_2BE4 = 1;
	scripts\asm\shared\mp\move_v2::playmoveloopv2(param_00,param_01,param_02,param_03);
}

//Function Number: 4
superslasher_playmoveloop_clean(param_00,param_01,param_02,param_03)
{
	self.var_1198.var_2BE4 = undefined;
}

//Function Number: 5
ss_play_groundidle(param_00,param_01,param_02,param_03)
{
	self.var_1198.bidle = 1;
	lib_0F3C::func_B050(param_00,param_01,param_02,param_03);
}

//Function Number: 6
ss_play_groundidle_clean(param_00,param_01,param_02)
{
	self.var_1198.bidle = undefined;
}

//Function Number: 7
ss_play_roofidle(param_00,param_01,param_02,param_03)
{
	self method_828A("noclip");
	self method_8289("face angle abs",level.superslasherrooftopangles);
	lib_0F3C::func_B050(param_00,param_01,param_02,param_03);
}

//Function Number: 8
ss_play_rooftaunt(param_00,param_01,param_02,param_03)
{
	self method_828A("noclip");
	self method_8289("face angle abs",level.superslasherrooftopangles);
	lib_0F3C::func_CEA8(param_00,param_01,param_02,param_03);
}

//Function Number: 9
ss_play_rooftaunt_clean(param_00,param_01,param_02)
{
	self method_828A("gravity");
}

//Function Number: 10
ss_play_jumptoground(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self.var_1198.buninterruptibleanim = 1;
	self method_8281("anim deltas");
	self method_828A("noclip");
	thread ss_play_jtog_waitmigrate(param_01);
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 11
ss_play_jtog_waitmigrate(param_00)
{
	self endon(param_00 + "_finished");
	level waittill("host_migration_begin");
	self.var_1198.bjumptogroundborked = 1;
}

//Function Number: 12
ss_play_jumptoground_clean(param_00,param_01,param_02)
{
	self method_8282(1,1);
	self method_828A("gravity");
	self.var_1198.buninterruptibleanim = undefined;
	if(isdefined(self.var_1198.bjumptogroundborked) || self.origin[2] > -116)
	{
		self setorigin(level.superslashergotogroundspot + (0,0,24));
		self.var_1198.bjumptogroundborked = undefined;
	}
}

//Function Number: 13
ss_play_jumptoground_nt(param_00,param_01,param_02,param_03)
{
	if(param_00 == "land")
	{
		thread scripts\asm\superslasher\superslasher_actions::superslasher_dogroundpoundimpact();
	}
}

//Function Number: 14
ss_play_jumpscale(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_04 - self.origin;
	var_06 = vectortoangles((var_05[0],var_05[1],0));
	if(isdefined(param_03))
	{
		var_07 = getmovedelta(param_03);
		param_04 = param_04 - rotatevector(var_07,var_06);
		var_05 = param_04 - self.origin;
	}

	self method_8281("anim deltas");
	self method_8289("face angle abs",var_06);
	self method_828A("noclip");
	var_08 = getmovedelta(param_02);
	var_09 = length2d(var_08);
	var_0A = length2d(var_05);
	var_0B = var_0A / var_09;
	var_0C = max(var_05[2] / var_08[2],0);
	var_0D = 1;
	self method_8282(var_0B,var_0C);
	scripts\mp\agents\_scriptedagents::func_CED2(param_00,param_01,var_0D,param_00,"end");
}

//Function Number: 15
ss_play_jumptoroof(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self.var_1198.buninterruptibleanim = 1;
	var_04 = level.superslasherrooftopspot;
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	var_06 = self method_80FD(param_01,var_05);
	var_07 = level.superslasherjumptoroofangles;
	self method_8281("anim deltas");
	self method_8289("face angle abs",var_07);
	self method_828A("noclip");
	thread ss_play_jtog_waitmigrate(param_01);
	lib_0A1D::func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 16
ss_play_jumptoroof_clean(param_00,param_01,param_02)
{
	self method_828A("gravity");
	self.var_1198.buninterruptibleanim = undefined;
	if(isdefined(self.var_1198.bjumptogroundborked) || self.origin[2] < 340)
	{
		self setorigin(level.superslasherrooftopspot);
		self.var_1198.bjumptogroundborked = undefined;
	}

	if(lib_0A1A::func_232B(param_01,"end"))
	{
		self.var_2303.turndata = spawnstruct();
		self.var_2303.turndata = angleclamp180(level.superslasherrooftopangles[1] - self.angles[1]);
	}
}

//Function Number: 17
ss_play_groundpound(param_00,param_01,param_02,param_03)
{
	self playsoundonmovingent("zmb_vo_supslasher_attack_ground_pound");
	ss_play(param_00,param_01,param_02,param_03,::ss_play_groundpound_nt);
}

//Function Number: 18
ss_play_groundpound_nt(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		thread scripts\asm\superslasher\superslasher_actions::superslasher_dogroundpoundimpact();
	}
}

//Function Number: 19
ss_play_summonsawblades(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread scripts\asm\superslasher\superslasher_actions::superslasher_dosummonedsawblades();
	ss_play(param_00,param_01,param_02,param_03);
}

//Function Number: 20
ss_play_sawcharge_start(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	if(isdefined(self.var_1198.throwsawchargetime))
	{
		var_05 = self method_80FD(param_01,var_04);
		var_06 = getanimlength(var_05);
		self.var_1198.throwsawchargelooptime = max(self.var_1198.throwsawchargetime - var_06,0);
	}

	var_07 = lib_0A1A::func_2341(param_00,param_01);
	scripts\mp\agents\_scriptedagents::func_CED2(param_01,var_04,self.var_BCE4,param_01,"end",var_07);
}

//Function Number: 21
ss_play_sawcharge_start_clean(param_00,param_01,param_02)
{
	self.var_1198.throwsawchargetime = undefined;
}

//Function Number: 22
ss_play_sawcharge(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread lib_0F3C::func_B050(param_00,param_01,param_02,param_03);
	wait(self.var_1198.throwsawchargelooptime);
	lib_0A1A::func_2330(param_01,"saw_charge_loop_complete");
}

//Function Number: 23
ss_play_sawcharge_clean(param_00,param_01,param_02)
{
	self.var_1198.throwsawchargelooptime = undefined;
}

//Function Number: 24
ss_play_throwsaw(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = 1;
	self.throwsawprevturnspeed = self method_827F();
	if(isdefined(self.var_1198.throwsawtarget))
	{
		thread superslasher_faceenemyhelper(self.var_1198.throwsawtarget,var_04 * 1000,param_01);
	}

	ss_play(param_00,param_01,param_02,param_03,::ss_play_throwsaw_nt);
}

//Function Number: 25
ss_play_throwsaw_nt(param_00,param_01,param_02,param_03)
{
	if(param_00 == "throw")
	{
		scripts\asm\superslasher\superslasher_actions::superslasher_dothrownsaw();
	}
}

//Function Number: 26
ss_play_throwsaw_clean(param_00,param_01,param_02)
{
	self method_8288(self.throwsawprevturnspeed);
	self.throwsawprevturnspeed = undefined;
}

//Function Number: 27
ss_play_throwsawfan_nt(param_00,param_01,param_02,param_03)
{
	if(param_00 == "throw")
	{
		thread scripts\asm\superslasher\superslasher_actions::superslasher_dosawfan();
	}
}

//Function Number: 28
ss_play_summon(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	scripts\mp\agents\_scriptedagents::func_CED1(param_01,var_04,self.var_BCE4,2 / self.var_BCE4);
	thread scripts\asm\superslasher\superslasher_actions::superslasher_summonminions(param_03);
	scripts\mp\agents\_scriptedagents::func_1384C(param_01,"end",param_01,var_04);
}

//Function Number: 29
ss_play_wires(param_00,param_01,param_02,param_03)
{
	thread scripts\asm\superslasher\superslasher_actions::superslasher_domaskchange(1,"roof");
	ss_play(param_00,param_01,param_02,undefined);
}

//Function Number: 30
ss_play_shockwave_start(param_00,param_01,param_02,param_03)
{
	self playsoundonmovingent("zmb_vo_supslasher_attack_shockwave_build_start");
	self method_8289("face angle abs",level.superslasherrooftopangles);
	lib_0F3C::func_CEA8(param_00,param_01,param_02,param_03);
}

//Function Number: 31
ss_play_shockwave_loop(param_00,param_01,param_02,param_03)
{
	var_04 = 1;
	self playsoundonmovingent("zmb_vo_supslasher_attack_shockwave_build");
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	self method_82AF(param_01,var_05,self.var_BCE4);
	wait(var_04);
	lib_0A1A::func_2330(param_01,"shockwave_loop_complete");
}

//Function Number: 32
ss_play_shockwave_finish(param_00,param_01,param_02,param_03)
{
	ss_play(param_00,param_01,param_02,undefined,::ss_play_shockwave_nt);
}

//Function Number: 33
ss_play_shockwave_nt(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		thread scripts\asm\superslasher\superslasher_actions::domaskattack(0,"roof");
	}
}

//Function Number: 34
ss_play_summonsharks(param_00,param_01,param_02,param_03)
{
	self playsoundonmovingent("zmb_vo_supslasher_attack_summon");
	thread scripts\asm\superslasher\superslasher_actions::superslasher_domaskchange(2,"ground");
	ss_play(param_00,param_01,param_02,undefined);
}

//Function Number: 35
ss_play_trapped(param_00,param_01,param_02,param_03)
{
	thread func_126BB(param_01,self.var_1198.trapduration);
	self playsoundonmovingent("zmb_vo_supslasher_pain");
	lib_0F3C::func_B050(param_00,param_01,param_02,param_03);
}

//Function Number: 36
func_126BB(param_00,param_01)
{
	self endon(param_00 + "_finished");
	wait(param_01);
	lib_0A1A::func_2330(param_00,"trap_end");
}

//Function Number: 37
ss_play_trapped_clean(param_00,param_01,param_02)
{
	self.var_1198.trapduration = undefined;
	self.var_1198.btraprequested = undefined;
}

//Function Number: 38
ss_play_jumpmove_start(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = self.var_1198.jumptargetpos;
	thread scripts\asm\superslasher\superslasher_actions::dogroundjumpattackfx(var_04);
	var_05 = var_04 - self.origin;
	var_06 = vectortoangles((var_05[0],var_05[1],0));
	var_07 = length(var_05);
	self method_8281("anim deltas");
	self method_8289("face angle abs",var_06);
	self method_828A("noclip");
	self method_8282(1,3);
	self playsoundonmovingent("zmb_vo_supslasher_jump");
	ss_play(param_00,param_01,param_02,param_03);
}

//Function Number: 39
ss_play_jumpmove_nt(param_00,param_01,param_02,param_03)
{
	if(param_00 == "takeoff")
	{
		self.var_1198.binair = 1;
		return;
	}

	if(param_00 == "land")
	{
		thread scripts\asm\superslasher\superslasher_actions::superslasher_dogroundpoundimpact();
		self.var_1198.binair = undefined;
		scripts\asm\superslasher\superslasher_actions::groundjumpattackfxcleanup();
		self playsoundonmovingent("zmb_vo_supslasher_attack_land");
	}
}

//Function Number: 40
func_A4DA()
{
	self.var_1198.binair = undefined;
	scripts\asm\superslasher\superslasher_actions::groundjumpattackfxcleanup();
	self.var_1198.jumptargetpos = undefined;
	self method_828A("gravity");
	self method_8282(1,1);
}

//Function Number: 41
ss_play_jumpmove_start_clean(param_00,param_01,param_02)
{
	self method_8282(1,1);
	if(!lib_0A1A::func_232B(param_01,"end"))
	{
		func_A4DA();
	}
}

//Function Number: 42
ss_play_jumpmove(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = self.var_1198.jumptargetpos;
	self.var_1198.buninterruptibleanim = 1;
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	var_06 = self method_80FD(param_01,var_05);
	var_07 = lib_0A1D::func_235A(param_01,"end");
	var_08 = self method_80FD(param_01,var_07);
	self.var_1198.binair = 1;
	ss_play_jumpscale(param_01,var_05,var_06,var_08,var_04);
}

//Function Number: 43
ss_play_jumpmove_clean(param_00,param_01,param_02)
{
	self.var_1198.buninterruptibleanim = undefined;
	if(!lib_0A1A::func_232B(param_01,"end"))
	{
		func_A4DA();
	}
}

//Function Number: 44
ss_play_jumpmove_end(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = self method_80FD(param_01,var_04);
	var_06 = getmovedelta(var_05);
	var_07 = scripts\common\trace::func_48CC(1);
	var_08 = self.var_1198.jumptargetpos;
	var_09 = scripts\common\trace::func_3A09(self.origin,self.origin - (0,0,60),self.var_257,self.height,self.angles,self,var_07);
	if(var_09["fraction"] < 1 && var_09["normal"][2] > 0)
	{
		var_08 = var_09["position"];
	}

	var_0A = max(var_08[2] - self.origin[2] / var_06[2],0);
	self method_8282(1,var_0A);
	self method_8281("anim deltas");
	self method_828A("noclip");
	scripts\mp\agents\_scriptedagents::func_CED2(param_01,var_04,self.var_BCE4,param_01,"end",lib_0A1A::func_2341(param_00,param_01));
}

//Function Number: 45
ss_play_jumpmove_end_clean(param_00,param_01,param_02)
{
	func_A4DA();
	lib_0A1A::func_232F("jumpmoveanim","end");
}

//Function Number: 46
superslasher_shouldstartarrival(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_233))
	{
		return 0;
	}

	if(!lib_0A1A::func_232B(param_01,"cover_approach"))
	{
		return 0;
	}

	var_04 = gettime();
	var_05 = 250;
	if(var_04 - self.var_2303.var_7257.time > var_05)
	{
		return 0;
	}

	var_06 = 128;
	var_07 = self.var_233 - self.origin;
	var_08 = length(var_07);
	if(var_08 > var_06)
	{
		return 0;
	}

	var_09 = gettime() - self.var_2303.var_7257.time;
	if(var_09 < 250 || var_09 > 400)
	{
		return 0;
	}

	var_0A = self.var_15C;
	if(isdefined(self.var_205) || isdefined(self.var_28B))
	{
		var_0A = 0;
	}

	self.var_2303.var_11068 = func_3722(param_00,param_02,self.var_233,var_0A,0);
	if(!isdefined(self.var_2303.var_11068))
	{
		return 0;
	}

	return 1;
}

//Function Number: 47
func_3722(param_00,param_01,param_02,param_03,param_04)
{
	param_02 = self.var_233;
	var_05 = self.angles;
	var_06 = param_02 - self.origin;
	var_07 = length2dsquared(var_06);
	var_08 = lib_0F3C::func_3E96(param_00,param_01);
	var_09 = self method_80FD(param_01,var_08);
	var_0A = getmovedelta(var_09);
	var_0B = getangledelta3d(var_09);
	var_0C = rotatevector(var_0A,self.angles);
	var_0D = var_0C + self.origin;
	var_0E = 0;
	var_0F = distancesquared(var_0D,param_02);
	if(var_0F > param_03 * param_03)
	{
		var_0E = 1;
	}

	var_10 = getclosestpointonnavmesh(var_0D,self);
	var_11 = self method_84AC();
	if(!navisstraightlinereachable(var_11,var_10,self))
	{
		return undefined;
	}

	if(var_0E)
	{
		var_0C = rotatevector(var_0A,var_05 - var_0B);
		var_12 = param_02 - var_0C;
	}
	else if(distance2dsquared(var_11,var_0E) > 4)
	{
		var_0D = rotatevector(var_0B,var_06 - var_0C);
		var_12 = var_11 - var_0D;
	}
	else
	{
		var_12 = self.origin;
	}

	var_13 = spawnstruct();
	var_13.var_2C9 = var_09;
	var_13.var_3F = 4;
	var_13.var_2C5 = var_12;
	var_13.var_3E = var_0B[1];
	var_13.var_130 = var_05;
	var_13.var_1F3 = var_0A;
	var_13.animindex = var_08;
	return var_13;
}

//Function Number: 48
ss_play_arrival(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = self.var_2303.var_11068;
	self.var_2303.var_11068 = undefined;
	var_05 = self.angles;
	if(isdefined(self.var_233))
	{
		var_06 = distance2d(self.origin,self.var_233);
		var_07 = var_06 / length2d(var_04.var_1F3);
		self method_8282(var_07,1);
		if(var_06 > 12)
		{
			var_08 = vectortoyaw(self.var_233 - self.origin);
			var_05 = (0,var_08,0);
		}
	}

	self method_8289("face angle abs",var_05);
	self method_8281("anim deltas");
	scripts\mp\agents\_scriptedagents::func_CED2(param_01,var_04.animindex,self.var_BCD6,param_01,"end");
}

//Function Number: 49
ss_play_arrival_clean(param_00,param_01,param_02)
{
	self method_8282(1,1);
}

//Function Number: 50
ss_play_meleecharge(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	thread superslasher_faceenemyhelper(self.var_3135.var_B64D,500,param_01);
	self method_8282(2,1);
	lib_0F3C::func_B050(param_00,param_01,param_02,param_03);
}

//Function Number: 51
ss_play_meleecharge_clean(param_00,param_01,param_02)
{
	self method_8282(1,1);
}

//Function Number: 52
superslasher_shouldmovemelee(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_233))
	{
		return 0;
	}

	if(!lib_0A1B::func_2953())
	{
		return 0;
	}

	return 1;
}

//Function Number: 53
superslasher_faceenemyhelper(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		self endon(param_02 + "_finished");
	}

	var_03 = gettime() + param_01;
	while(gettime() <= var_03 && isdefined(param_00) && isalive(param_00))
	{
		var_04 = param_00.origin - self.origin;
		if(length2dsquared(var_04) > 1024)
		{
			var_05 = vectortoyaw(var_04);
			self method_8289("face angle abs",(0,var_05,0));
		}

		wait(0.05);
	}

	self method_8289("face angle abs",self.angles);
}

//Function Number: 54
ss_play_standmelee(param_00,param_01,param_02,param_03)
{
	thread superslasher_faceenemyhelper(self.var_3135.var_B64D,500,param_01);
	ss_play(param_00,param_01,param_02,param_03);
}

//Function Number: 55
ss_play_movemelee(param_00,param_01,param_02,param_03)
{
	if(lib_0A1B::func_2957(param_00,param_01))
	{
		thread superslasher_faceenemyhelper(self.var_3135.var_B64D,1000,param_01);
	}
	else
	{
		self method_8289("face angle abs",self.angles);
	}

	ss_play(param_00,param_01,param_02,param_03);
}

//Function Number: 56
ss_play_movemelee_nt(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		scripts\asm\superslasher\superslasher_actions::superslasher_domeleedamage();
	}
}

//Function Number: 57
ss_play_stomp(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = self.var_1198.stomptarget;
	thread superslasher_faceenemyhelper(var_04,1500,param_01);
	self playsoundonmovingent("zmb_vo_supslasher_attack_stomp");
	ss_play(param_00,param_01,param_02,param_03,::ss_play_stomp_nt);
}

//Function Number: 58
ss_play_stomp_nt(param_00,param_01,param_02,param_03)
{
	if(param_00 == "hit")
	{
		scripts\asm\superslasher\superslasher_actions::superslasher_dostompattack(self.var_1198.stompdist);
	}
}

//Function Number: 59
superslasher_needstoturn(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_233))
	{
		var_04 = vectortoyaw(self method_813A());
		var_05 = angleclamp180(var_04 - self.angles[1]);
		if(abs(var_05) >= 35)
		{
			var_06 = anglestoforward(self.angles);
			var_07 = self.origin + var_06 * 128;
			if(navtrace(self.origin,var_07,self))
			{
				self.var_2303.turndata = var_05;
				return 1;
			}
		}
	}
	else if(isdefined(self.var_3135.target))
	{
		var_08 = self.var_3135.target getvelocity();
		var_09 = self.var_3135.target.origin + var_08;
		var_0A = var_09 - self.origin;
		var_0B = vectortoyaw(var_0A);
		var_0C = angleclamp180(var_0B - self.angles[1]);
		if(abs(var_0C) >= 35)
		{
			self.var_2303.turndata = var_0C;
			return 1;
		}
	}

	return 0;
}

//Function Number: 60
superslasher_chooseanim_turn(param_00,param_01,param_02)
{
	var_03 = self.var_2303.turndata;
	if(var_03 > 0)
	{
		var_04 = int(180 + var_03 + 10 / 45);
	}
	else
	{
		var_04 = int(180 + var_04 - 10 / 45);
	}

	var_05 = ["2r","3","6","9","8","7","4","1","2l"];
	return var_05[var_04];
}

//Function Number: 61
ss_play_turn(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = self method_80FD(param_01,var_04);
	var_06 = getanimlength(var_05);
	var_07 = 0.75;
	var_08 = self.var_2303.turndata;
	self.var_2303.turndata = undefined;
	self method_8289("face angle abs",self.angles);
	self method_8281("anim deltas");
	self.var_1198.bcommittedtoanim = 1;
	scripts\mp\agents\_scriptedagents::func_CED1(param_01,var_04,self.var_BCD6,var_06 - var_07 / self.var_BCD6);
	lib_0A1A::func_2330(param_01,"turn_done");
}

//Function Number: 62
ss_play_turn_clean(param_00,param_01,param_02)
{
	self.var_1198.bcommittedtoanim = undefined;
}

//Function Number: 63
superslasher_onroof(param_00,param_01,param_02,param_03)
{
	return self.var_1198.bonroof;
}

//Function Number: 64
superslasher_gotogroundrequested(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.bgroundrequested);
}

//Function Number: 65
superslasher_gotoroofrequested(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.broofrequested);
}

//Function Number: 66
superslasher_shouldroofjumpagain(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.iroofjump) && self.var_1198.iroofjump == 0;
}

//Function Number: 67
superslasher_tauntrequested(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.btauntrequested);
}

//Function Number: 68
superslasher_shouldsummon(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.bsummonrequested);
}

//Function Number: 69
superslasher_groundpoundrequested(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.bgroundpoundrequested);
}

//Function Number: 70
superslasher_shouldsummonsawblades(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.bsummonsawbladesrequested);
}

//Function Number: 71
superslasher_shouldthrowsaw(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.bthrowsawrequested);
}

//Function Number: 72
superslasher_shouldthrowsawfan(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.bthrowsawfanrequested);
}

//Function Number: 73
superslasher_shouldjumpmove(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.bjumpmoverequested) && isdefined(self.var_1198.jumptargetpos);
}

//Function Number: 74
superslasher_wiresrequested(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.bwiresrequested);
}

//Function Number: 75
superslasher_shockwaverequested(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.bshockwaverequested);
}

//Function Number: 76
superslasher_sharksrequested(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.bsharksrequested);
}

//Function Number: 77
superslasher_shouldsawchargeloop(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.throwsawchargelooptime) && self.var_1198.throwsawchargelooptime > 0;
}

//Function Number: 78
superslasher_stomprequested(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.bstomprequested);
}

//Function Number: 79
superslasher_shoulddointro(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.bintrorequested);
}