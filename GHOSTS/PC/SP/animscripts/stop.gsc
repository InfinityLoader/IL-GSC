/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\stop.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 215 ms
 * Timestamp: 10/27/2023 1:24:32 AM
*******************************************************************/

//Function Number: 1
init_animset_idle()
{
	var_00 = [];
	var_00["stand"][0] = [%casual_stand_idle,%casual_stand_idle_twitch,%casual_stand_idle_twitchb];
	var_00["stand"][1] = [%casual_stand_v2_idle,%casual_stand_v2_twitch_radio,%casual_stand_v2_twitch_shift,%casual_stand_v2_twitch_talk];
	var_00["stand_cqb"][0] = [%cqb_stand_idle,%cqb_stand_twitch];
	var_00["crouch"][0] = [%casual_crouch_idle];
	level.archetypes["soldier"]["idle"] = var_00;
	var_00 = [];
	var_00["stand"][0] = [2,1,1];
	var_00["stand"][1] = [10,4,7,4];
	var_00["stand_cqb"][0] = [2,1];
	var_00["crouch"][0] = [6];
	level.archetypes["soldier"]["idle_weights"] = var_00;
	var_00 = [];
	var_00["stand"] = %casual_stand_idle_trans_in;
	var_00["crouch"] = %casual_crouch_idle_in;
	level.archetypes["soldier"]["idle_transitions"] = var_00;
}

//Function Number: 2
func_4FDD()
{
	if(isdefined(self.var_5613))
	{
	}

	if(isdefined(self.var_2214))
	{
		if(isdefined(self.var_2214["stop"]))
		{
			[[ self.var_2214["stop"] ]]();
		}
	}

	self notify("stopScript");
	self endon("killanimscript");
	[[ self.exception["stop_immediate"] ]]();
	thread delayedexception();
	animscripts/utility::func_4622("stop");
	if(isdefined(self.var_78ED))
	{
		func_78EE();
	}

	animscripts/utility::func_633A();
	thread func_7061();
	thread animscripts/reactions::func_63BF();
	var_00 = isdefined(self.customidleanimset);
	if(!var_00)
	{
		if(self.a.var_8DB5["right"] == "none" && self.a.var_8DB5["left"] == "none")
		{
			var_00 = 1;
		}
		else if(angleclamp180(self getmuzzleangle()[0]) > 20)
		{
			var_00 = 1;
		}
	}

	if(self.swimmer && !isdefined(self.enemy))
	{
		var_01 = animscripts/exit_node::getexitnode();
		if(isdefined(var_01))
		{
			self setflaggedanimknoballrestart("idle",self.customidleanimset["stand"],%body,1,0.5,self.animplaybackrate);
			func_84BE(var_01.angles[1]);
		}
		else
		{
			self orientmode("face angle",self.angles[1]);
		}
	}

	for(;;)
	{
		var_02 = getdesiredidlepose();
		if(var_02 == "prone")
		{
			var_00 = 1;
			func_6202();
			continue;
		}

		if(self.a.var_60B1 != var_02)
		{
			self clearanim(%root,0.3);
			var_00 = 0;
		}

		animscripts/setposemovement::func_70A7(var_02,"stop");
		if(!var_00)
		{
			func_8271(var_02,self.a.var_43E4);
			var_00 = 1;
			continue;
		}

		func_6015(var_02,self.a.var_43E4);
	}
}

//Function Number: 3
func_84BE(param_00)
{
	var_01 = self.angles[1];
	var_02 = angleclamp180(param_00 - var_01);
	if(-20 < var_02 && var_02 < 20)
	{
		func_687C(param_00,2);
	}

	var_03 = animscripts/swim::func_3C1D("idle_turn");
	if(var_02 < -80)
	{
		var_04 = var_03[2];
	}
	else if(var_03 < -20)
	{
		var_04 = var_04[3];
	}
	else if(var_03 < 80)
	{
		var_04 = var_04[5];
	}
	else
	{
		var_04 = var_04[6];
	}

	var_05 = getanimlength(var_04);
	var_06 = abs(var_02) / self.turnrate;
	var_06 = var_06 / 1000;
	var_07 = var_05 / var_06;
	self orientmode("face angle",param_00);
	self setflaggedanimrestart("swim_turn",var_04,1,0.2,var_07 * self.moveplaybackrate);
	animscripts/shared::func_2986("swim_turn");
	self clearanim(var_04,0.2);
}

//Function Number: 4
func_687C(param_00,param_01)
{
	self orientmode("face angle",param_00);
	while(angleclamp(param_00 - self.angles[1]) > param_01)
	{
		wait(0.1);
	}
}

//Function Number: 5
func_7061()
{
	self endon("death");
	self waittill("killanimscript");
	self.laststoppedtime = gettime();
}

//Function Number: 6
func_78EE()
{
	self endon("stop_specialidle");
	var_00 = self.var_78ED;
	self animmode("gravity");
	self orientmode("face current");
	self clearanim(%root,0.2);
	for(;;)
	{
		self setflaggedanimrestart("special_idle",var_00[randomint(var_00.size)],1,0.2,self.animplaybackrate);
		self waittillmatch("end","special_idle");
	}
}

//Function Number: 7
getdesiredidlepose()
{
	var_00 = animscripts/utility::func_3A52();
	if(isdefined(var_00))
	{
		var_01 = var_00.angles[1];
		var_02 = var_00.type;
	}
	else
	{
		var_01 = self.desiredangle;
		var_02 = "node was undefined";
	}

	animscripts/face::func_7052(level.alertface);
	var_03 = animscripts/utility::choosepose();
	if(var_02 == "Cover Stand" || var_02 == "Conceal Stand")
	{
		var_03 = animscripts/utility::choosepose("stand");
	}
	else if(var_02 == "Cover Crouch" || var_02 == "Conceal Crouch")
	{
		var_03 = animscripts/utility::choosepose("crouch");
	}
	else if(var_02 == "Cover Prone" || var_02 == "Conceal Prone")
	{
		var_03 = animscripts/utility::choosepose("prone");
	}

	return var_03;
}

//Function Number: 8
func_8271(param_00,param_01)
{
	if(animscripts/utility::func_48A0() && self.a.var_60B1 == "stand")
	{
		param_00 = "stand_cqb";
	}

	var_02 = animscripts/utility::func_4F5D("idle_transitions");
	if(isdefined(var_02[param_00]))
	{
		var_03 = var_02[param_00];
		self setflaggedanimknoballrestart("idle_transition",var_03,%body,1,0.2,self.animplaybackrate);
		animscripts/shared::func_2986("idle_transition");
	}
}

//Function Number: 9
func_6015(param_00,param_01)
{
	if(animscripts/utility::func_48A0() && self.a.var_60B1 == "stand")
	{
		param_00 = "stand_cqb";
	}

	var_02 = undefined;
	if(isdefined(self.customidleanimset) && isdefined(self.customidleanimset[param_00]))
	{
		if(isarray(self.customidleanimset[param_00]))
		{
			var_03 = animscripts/utility::anim_array(self.customidleanimset[param_00],self.customidleanimweights[param_00]);
		}
		else
		{
			var_03 = self.customidleanimset[param_01];
			var_04 = param_00 + "_add";
			if(isdefined(self.customidleanimset[var_04]))
			{
				var_02 = self.customidleanimset[var_04];
			}
		}
	}
	else if(isdefined(level.var_63D3) && param_01 == "stand" || param_01 == "stand_cqb" && isdefined(self.busereadyidle) && self.busereadyidle == 1)
	{
		var_03 = animscripts/utility::anim_array(level.var_63D3["stand"][0],level.var_63D4["stand"][0]);
	}
	else
	{
		var_05 = animscripts/utility::func_4F5D("idle");
		var_06 = animscripts/utility::func_4F5D("idle_weights");
		param_01 = param_01 % var_05[param_00].size;
		var_03 = animscripts/utility::anim_array(var_05[param_00][param_01],var_06[param_00][param_01]);
	}

	var_07 = 0.2;
	if(gettime() == self.a.var_6D18)
	{
		var_07 = 0.5;
	}

	if(isdefined(var_02))
	{
		self setanimknoball(var_03,%body,1,var_07,1);
		self setanim(%add_idle);
		self setflaggedanimknoballrestart("idle",var_02,%add_idle,1,var_07,self.animplaybackrate);
	}
	else
	{
		self setflaggedanimknoballrestart("idle",var_03,%body,1,var_07,self.animplaybackrate);
	}

	animscripts/shared::func_2986("idle");
}

//Function Number: 10
func_6202()
{
	if(self.a.var_60B1 != "prone")
	{
		var_00["stand_2_prone"] = %stand_2_prone;
		var_00["crouch_2_prone"] = %crouch_2_prone;
		var_01 = var_00[self.a.var_60B1 + "_2_prone"];
		self setflaggedanimknoballrestart("trans",var_01,%body,1,0.2,1);
		animscripts/shared::func_2986("trans");
		self.a.var_5486 = "stop";
		self setproneanimnodes(-45,45,%prone_legs_down,%exposed_modern,%prone_legs_up);
	}

	thread func_8715();
	if(randomint(10) < 3)
	{
		var_02 = animscripts/utility::lookupanim("cover_prone","twitch");
		var_03 = var_02[randomint(var_02.size)];
		self setflaggedanimknoball("prone_idle",var_03,%exposed_modern,1,0.2);
	}
	else
	{
		self setanimknoball(animscripts/utility::lookupanim("cover_prone","straight_level"),%exposed_modern,1,0.2);
		self setflaggedanimknob("prone_idle",animscripts/utility::lookupanim("cover_prone","exposed_idle")[0],1,0.2);
	}

	self waittillmatch("end","prone_idle");
	self notify("kill UpdateProneThread");
}

//Function Number: 11
func_8715()
{
	self endon("killanimscript");
	self endon("kill UpdateProneThread");
	for(;;)
	{
		animscripts/cover_prone::func_8716(0.1);
		wait(0.1);
	}
}

//Function Number: 12
delayedexception()
{
	self endon("killanimscript");
	wait(0.05);
	[[ self.exception["stop"] ]]();
}