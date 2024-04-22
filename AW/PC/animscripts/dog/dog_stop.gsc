/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: dog\dog_stop.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 36
 * Decompile Time: 403 ms
 * Timestamp: 4/22/2024 1:58:50 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.shark_functions))
	{
		if(issubstr(self.model,"shark"))
		{
			self [[ level.shark_functions["stop"] ]]();
			return;
		}
	}

	self endon("killanimscript");
	self clearanim(%body,0.2);
	self setanim(%dog_idle_knob);
	thread waitforstatechange();
	self.dognextidletwitchtime = getdognexttwitchtime();
	self.moveanimtype = "walk";
	self.idleanimtype = undefined;
	for(;;)
	{
		if(self isdogbeingdriven())
		{
			dodrivenidle();
			continue;
		}

		if(isdefined(self.specialidleanim))
		{
			dospecialidle();
			continue;
		}

		var_00 = dogstop_getnode();
		if(!self isdogbeingdriven() && !isdefined(self.bidlelooking) || !self.bidlelooking)
		{
			var_01 = 262144;
			var_02 = self.doghandler;
			if(isdefined(var_02))
			{
				if(isdefined(var_02.node) && isdefined(var_00))
				{
					var_03 = var_02.origin - self.origin;
					turntoangle(vectortoyaw(var_03));
				}
				else
				{
					var_04 = 65536;
					var_05 = 6400;
					var_06 = distancesquared(self.origin,var_02.origin);
					if(var_06 < var_05)
					{
						turntoangle(var_02.angles[1]);
					}
					else if(var_06 < var_04)
					{
						var_03 = var_02.origin - self.origin;
						var_07 = vectortoyaw(var_03);
						turntoangle(var_07);
					}
				}
			}
			else if((!isdefined(var_00) || !issubstr(var_00.type,"Cover") || isdefined(self.favoriteenemy)) && isdefined(self.enemy) && isalive(self.enemy) && self seerecently(self.enemy,5) || distancesquared(self.origin,self.enemy.origin) < var_01)
			{
				var_08 = self.enemy.origin - self.origin;
				turntoangle(vectortoyaw(var_08));
			}
			else if(isdefined(var_00) && shouldfacenodedir(var_00))
			{
				turntoangle(var_00.angles[1]);
			}

			self orientmode("face angle",self.angles[1]);
		}

		if(isdefined(self.customidleanimset))
		{
			stoplookatidle();
			docustomidle();
			continue;
		}

		var_09 = getdefaultidlestate();
		if(var_09 == "casualidle")
		{
			if(isdefined(self.idlelookattargets))
			{
				dolookatidle();
			}
			else
			{
				stoplookatidle();
				playidleanim("casualidle",getdogstopanim("casualidle"),0,0.5,2);
			}
		}
		else if(var_09 == "attackidle")
		{
			if(isdefined(self.idlelookattargets) && isdefined(self.aggresivelookat))
			{
				dolookatidle();
			}
			else
			{
				stopidlesound();
				stoplookatidle();
				var_0A = !isdefined(self.enemy) || distance2dsquared(self.origin,self.enemy.origin) > 589824;
				if(var_0A && gettime() > self.dognextidletwitchtime)
				{
					var_0B = chooseattackidle();
					playidleanim("attackidle",getdogstopanim(var_0B),0,0.2,-1);
					self.dognextidletwitchtime = getdognexttwitchtime();
				}
				else
				{
					playidleanim("attackidle",getdogstopanim("attackidle"),0,0.5,0.5);
				}
			}
		}
		else
		{
			stopidlesound();
			stoplookatidle();
			playidleanim(var_09,getdogstopanim(var_09),0,0.5,2);
		}
	}
}

//Function Number: 2
end_script()
{
	if(isdefined(self.prevturnrate))
	{
		self.turnrate = self.prevturnrate;
		self.prevturnrate = undefined;
	}

	self.dogturnadjust = undefined;
	self.dogturnrate = undefined;
	self.dognextidletwitchtime = undefined;
	self.currenttrackingyawspeed = undefined;
	self.currenttrackingyaw = undefined;
	stopidlesound();
	stoplookatidle();
}

//Function Number: 3
playidleanim(param_00,param_01,param_02,param_03,param_04)
{
	self endon("killIdleAnim");
	if(isdefined(self.idleanimtype) && self.idleanimtype != param_00)
	{
		var_05 = getdogstoptransitionanim(self.idleanimtype,param_00);
		if(isdefined(var_05))
		{
			self setflaggedanimknobrestart("dog_idle_transition",var_05,1,0.2,self.animplaybackrate);
			animscripts\shared::donotetracks("dog_idle_transition");
			param_03 = 0.2;
		}
	}

	self.idleanimtype = param_00;
	if(param_02)
	{
		self setflaggedanimknobrestart("dog_idle",param_01,1,param_03,self.animplaybackrate);
	}
	else
	{
		self setflaggedanimknob("dog_idle",param_01,1,param_03,self.animplaybackrate);
	}

	if(param_04 > 0)
	{
		animscripts\notetracks::donotetracksfortime(param_04,"dog_idle");
		return;
	}

	animscripts\shared::donotetracks("dog_idle");
}

//Function Number: 4
waitforstatechange()
{
	self endon("killanimscript");
	var_00 = self isdogbeingdriven();
	var_01 = self.defaultidlestateoverride;
	for(;;)
	{
		var_02 = self isdogbeingdriven();
		if(var_02 != var_00)
		{
			killidleanim();
			var_00 = var_02;
			self orientmode("face angle",self.angles[1]);
		}
		else if(animscripts\dog\dog_move::aredifferent(self.defaultidlestateoverride,var_01))
		{
			killidleanim();
			var_01 = self.defaultidlestateoverride;
		}

		wait(0.1);
	}
}

//Function Number: 5
killidleanim()
{
	self notify("killIdleAnim");
	stoplookatidle();
}

//Function Number: 6
shouldfacenodedir(param_00)
{
	return param_00.type == "Guard" || param_00.type == "Exposed" || issubstr(param_00.type,"Cover ");
}

//Function Number: 7
getturnanim(param_00)
{
	var_01 = getdefaultidlestate();
	if(var_01 == "casualidle" || var_01 == "sniffidle")
	{
		if(param_00 < -135 || param_00 > 135)
		{
			return getdogstopanim("casual_turn_180");
		}

		if(param_00 < 0)
		{
			return getdogstopanim("casual_turn_right");
		}

		return getdogstopanim("casual_turn_left");
	}

	if(param_00 < -135 || param_00 > 135)
	{
		return getdogstopanim("attack_turn_180");
	}

	if(param_00 < 0)
	{
		return getdogstopanim("attack_turn_right");
	}

	return getdogstopanim("attack_turn_left");
}

//Function Number: 8
handledogturnnotetracks(param_00)
{
	if(param_00 == "turn_begin")
	{
		var_01 = angleclamp180(self.angles[1] + self.dogturnadjust);
		self.dogturnadjust = undefined;
		self.prevturnrate = self.turnrate;
		self.turnrate = self.dogturnrate;
		self.dogturnrate = undefined;
		self orientmode("face angle",var_01);
		return;
	}

	if(param_00 == "turn_end")
	{
		self.turnrate = self.prevturnrate;
		self.prevturnrate = undefined;
	}
}

//Function Number: 9
turntoangle(param_00,param_01)
{
	self endon("killIdleAnim");
	var_02 = self.angles[1];
	var_03 = angleclamp180(param_00 - var_02);
	if(-0.5 < var_03 && var_03 < 0.5)
	{
		return;
	}

	if(-15 < var_03 && var_03 < 15)
	{
		rotatetoangle(param_00,2);
		return;
	}

	stopidlesound();
	var_04 = getturnanim(var_03);
	var_05 = getanimlength(var_04);
	var_06 = getangledelta(var_04);
	var_07 = 0.2;
	if(var_05 < 0.7)
	{
		var_07 = 0.05;
	}

	if(isdefined(param_01) && param_01)
	{
		self animmode("zonly_physics");
	}
	else
	{
		self animmode("angle deltas");
	}

	self setanim(%dog_idle_knob,1,var_07);
	self setflaggedanimknobrestart("dog_turn",var_04,1,var_07);
	if(animhasnotetrack(var_04,"turn_begin") && animhasnotetrack(var_04,"turn_end"))
	{
		var_08 = getnotetracktimes(var_04,"turn_begin");
		var_09 = getnotetracktimes(var_04,"turn_end");
		var_0A = var_09[0] - var_08[0] * var_05;
		self.dogturnadjust = angleclamp180(var_03 - var_06);
		self.dogturnrate = max(abs(self.dogturnadjust) / var_0A / 1000,0.01);
		self orientmode("face angle",self.angles[1]);
		animscripts\shared::donotetracks("dog_turn",::handledogturnnotetracks);
	}
	else
	{
		self.prevturnrate = self.turnrate;
		self.turnrate = max(abs(angleclamp180(var_03 - var_06)) / var_05 / 1000,0.01);
		self orientmode("face angle",angleclamp180(param_00 - var_06));
		animscripts\shared::donotetracks("dog_turn");
		self.turnrate = self.prevturnrate;
		self.prevturnrate = undefined;
	}

	self clearanim(var_04,0.2);
	self animmode("none");
}

//Function Number: 10
rotatetoangle(param_00,param_01)
{
	self orientmode("face angle",param_00);
	while(abs(angleclamp180(param_00 - self.angles[1])) > param_01)
	{
		wait(0.1);
	}
}

//Function Number: 11
shouldcoveridle()
{
	var_00 = dogstop_getnode();
	if(isdefined(var_00) && issubstr(var_00.type,"Cover"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 12
chooseattackidle()
{
	var_00 = ["attackidle_twitch_1","attackidle_twitch_2"];
	var_01 = [1,1];
	if(!isdefined(self.script_nobark) || !self.script_nobark)
	{
		var_02 = var_00.size;
		var_00[var_02] = "attackidle_bark";
		var_01[var_02] = 4;
	}

	var_03 = 0;
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_03 + var_01[var_02];
	}

	var_04 = randomint(var_03);
	var_05 = 0;
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_05 = var_05 + var_01[var_02];
		if(var_04 < var_05)
		{
			return var_00[var_02];
		}
	}
}

//Function Number: 13
dodrivenidle()
{
	playidlesound(self.customidlesound);
	playidleanim("sneakstandidle",getdogstopanim("sneakstandidle"),0,0.5,-1);
}

//Function Number: 14
dospecialidle()
{
	if(isarray(self.specialidleanim))
	{
		var_00 = self.specialidleanim[randomint(self.specialidleanim.size)];
	}
	else
	{
		var_00 = self.specialidleanim;
	}

	playidlesound(self.customidlesound);
	playidleanim("specialidle",var_00,0,0.5,-1);
}

//Function Number: 15
docustomidle()
{
	if(isarray(self.customidleanimset))
	{
		if(isdefined(self.customidleanimweights))
		{
			var_00 = animscripts\utility::anim_array(self.customidleanimset,self.customidleanimweights);
		}
		else
		{
			var_00 = self.customidleanimset[randomint(self.customidleanimset.size)];
		}
	}
	else
	{
		var_00 = self.customidleanimset;
	}

	playidlesound(self.customidlesound);
	playidleanim("customidle",var_00,0,0.5,-1);
}

//Function Number: 16
dolookatidle()
{
	if(!isdefined(self.bidlelooking) || !self.bidlelooking)
	{
		self.bidlelooking = 1;
		thread lookatidleupdate();
	}

	wait(0.5);
}

//Function Number: 17
stoplookatidle()
{
	if(!isdefined(self.bidlelooking) || !self.bidlelooking)
	{
		return;
	}

	self.bidlelooking = undefined;
	self.idletrackloop = undefined;
	self notify("endIdleLookAt");
	self clearanim(%look_2,1);
	self clearanim(%look_4,1);
	self clearanim(%look_6,1);
	self clearanim(%look_8,1);
}

//Function Number: 18
lookatidleupdate()
{
	self endon("killanimscript");
	self endon("endIdleLookAt");
	while(isdefined(self.idlelookattargets) && isarray(self.idlelookattargets) && self.idlelookattargets.size > 0)
	{
		var_00 = getlookattarget(self.lookattarget);
		self.lookattarget = var_00;
		if(!isdefined(self.idletrackloop))
		{
			thread idletrackloop();
		}

		var_01 = 3 + randomfloat(3);
		wait(var_01);
	}

	stoplookatidle();
}

//Function Number: 19
getlookattarget(param_00)
{
	if(isdefined(self.alwayslookatfirsttarget) && self.alwayslookatfirsttarget && self.idlelookattargets.size > 0)
	{
		return self.idlelookattargets[0];
	}

	var_01 = isdefined(param_00);
	if(self.idlelookattargets.size == 1)
	{
		if(var_01)
		{
			return undefined;
		}
		else
		{
			return self.idlelookattargets[0];
		}
	}

	if(var_01)
	{
		var_02 = randomint(100);
		if(var_02 < 33)
		{
			return undefined;
		}
	}

	var_03 = self.idlelookattargets;
	var_04 = [];
	var_05 = 0;
	var_06 = !var_01;
	for(var_07 = 0;var_07 < var_03.size;var_07++)
	{
		if(!var_06 && var_03[var_07] == param_00)
		{
			var_08 = var_03.size - 1;
			if(var_07 != var_08)
			{
				var_03[var_07] = var_03[var_08];
			}

			var_03[var_08] = undefined;
			var_06 = 1;
			if(var_07 == var_08)
			{
				break;
			}
		}

		var_09 = distance2dsquared(self.origin,var_03[var_07].origin);
		var_04[var_07] = 1 / var_09;
		var_05 = var_05 + var_04[var_07];
	}

	var_0A = randomfloat(var_05);
	var_0B = 0;
	for(var_07 = 0;var_07 < var_03.size;var_07++)
	{
		var_0B = var_0B + var_04[var_07];
		if(var_0A < var_0B)
		{
			return var_03[var_07];
		}
	}
}

//Function Number: 20
idletrackloop()
{
	self endon("killanimscript");
	self endon("endIdleLookAt");
	self.idletrackloop = 1;
	self clearanim(%dog_idle_knob,0.2);
	self setanimknob(getdogstopanimbase(),1,0.5);
	self setanimknoblimited(getdogstopanimlook("2"),1,0);
	self setanimknoblimited(getdogstopanimlook("4"),1,0);
	self setanimknoblimited(getdogstopanimlook("6"),1,0);
	self setanimknoblimited(getdogstopanimlook("8"),1,0);
	var_00 = 90;
	var_01 = -100;
	var_02 = -25;
	var_03 = 25;
	self.currenttrackingyaw = 0;
	self.currenttrackingyawspeed = 0;
	for(;;)
	{
		var_04 = self geteye();
		if(isdefined(self.lookattarget))
		{
			var_05 = self.lookattarget geteye();
			var_06 = var_05 - var_04;
			var_07 = vectortoangles(var_06);
		}
		else
		{
			var_07 = self.angles;
		}

		var_08 = angleclamp180(var_07[1] - self.angles[1]);
		var_09 = angleclamp180(var_07[0] - self.angles[0]);
		if(var_08 > var_00 || var_08 < var_01)
		{
			self.currenttrackingyaw = 0;
			self.currenttrackingyawspeed = 0;
			turntoangle(self.angles[1] + var_08 * 0.75);
			self setanimknob(getdogstopanimbase(),1,0.1);
			continue;
		}

		var_0A = calctrackingyaw(var_08,self.currenttrackingyaw,self.currenttrackingyawspeed);
		self.currenttrackingyaw = var_0A;
		var_0B = 0;
		var_0C = 0;
		var_0D = 0;
		var_0E = 0;
		if(var_0A > 0)
		{
			var_0B = clamp(var_0A / var_00,0,1);
		}
		else
		{
			var_0C = clamp(var_0A / var_01,0,1);
		}

		if(var_09 < 0)
		{
			var_0D = clamp(var_09 / var_02,0,1);
		}
		else
		{
			var_0E = clamp(var_09 / var_03,0,1);
		}

		self setanimlimited(%look_2,var_0E,1);
		self setanimlimited(%look_4,var_0B,0.1);
		self setanimlimited(%look_6,var_0C,0.1);
		self setanimlimited(%look_8,var_0D,1);
		wait(0.05);
	}
}

//Function Number: 21
calctrackingyaw(param_00,param_01,param_02)
{
	var_03 = 90;
	var_04 = -100;
	var_05 = 1;
	var_06 = 0.5;
	var_07 = 6;
	var_08 = clamp(param_00,var_04,var_03);
	var_09 = angleclamp180(var_08 - param_01);
	if(var_08 > param_01)
	{
		if(param_02 >= 0 && !needtodecelforarrival(var_09,param_02,var_06))
		{
			var_0A = param_02 + var_05;
		}
		else if(var_03 >= 0)
		{
			var_0A = var_03 - var_07;
		}
		else
		{
			var_0A = var_03 + var_07;
		}
	}
	else if(var_03 <= 0 && !needtodecelforarrival(var_0A,var_03,var_07))
	{
		var_0A = var_03 - var_06;
	}
	else if(var_03 <= 0)
	{
		var_0A = var_03 + var_07;
	}
	else
	{
		var_0A = var_03 - var_07;
	}

	var_0A = clamp(var_0A,-1 * var_07,var_07);
	if(var_08 >= param_01 && param_01 + var_0A > var_08)
	{
		var_0A = var_08 - param_01;
	}
	else if(var_08 <= param_01 && param_01 + var_0A < var_08)
	{
		var_0A = var_08 - param_01;
	}

	var_0B = param_01 + var_0A;
	self.currenttrackingyawspeed = var_0A;
	return var_0B;
}

//Function Number: 22
needtodecelforarrival(param_00,param_01,param_02)
{
	if(param_01 == 0)
	{
		return 0;
	}

	var_03 = abs(param_00);
	var_04 = abs(param_01);
	param_02 = abs(param_02);
	while(var_03 > 0)
	{
		var_03 = var_03 - var_04;
		var_04 = var_04 - param_02;
		if(var_04 < 0)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 23
dogstop_getnode()
{
	if(isdefined(self.node))
	{
		return self.node;
	}

	return self.prevnode;
}

//Function Number: 24
getdefaultidlestate(param_00)
{
	if(isdefined(self.defaultidlestateoverride))
	{
		return self.defaultidlestateoverride;
	}

	var_01 = isdefined(self.enemy) && isalive(self.enemy);
	var_02 = var_01 && distancesquared(self.origin,self.enemy.origin) < 1000000 && isdefined(self.favoriteenemy) || self seerecently(self.enemy,5);
	var_03 = dogstop_getnode();
	if(isdefined(self.aggresivelookat))
	{
		return "attackidle";
	}

	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(isdefined(var_03) && !param_00 || distance(self.origin,var_03.origin) <= 32)
	{
		if(var_03.type == "Guard")
		{
			if(var_02)
			{
				return "attackidle";
			}
			else
			{
				return "alertidle";
			}
		}
		else if(issubstr(var_03.type,"Cover"))
		{
			return "sneakidle";
		}
		else if(var_01)
		{
			if(var_02)
			{
				return "attackidle";
			}
			else
			{
				return "alertidle";
			}
		}
	}

	if(var_02)
	{
		return "attackidle";
	}

	if(animscripts\dog\dog_move::shouldsniff())
	{
		return "sniffidle";
	}

	return "casualidle";
}

//Function Number: 25
should_growl()
{
	if(isdefined(self.script_growl))
	{
		return 1;
	}

	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(!isalive(self.enemy))
	{
		return 1;
	}

	return !self cansee(self.enemy);
}

//Function Number: 26
lookattarget(param_00)
{
	self endon("killanimscript");
	self endon("stop tracking");
	self clearanim(%german_shepherd_look_2,0);
	self clearanim(%german_shepherd_look_4,0);
	self clearanim(%german_shepherd_look_6,0);
	self clearanim(%german_shepherd_look_8,0);
	self setdefaultaimlimits();
	self.rightaimlimit = 90;
	self.leftaimlimit = -90;
	self setanimlimited(level.doglookpose[param_00][2],1,0);
	self setanimlimited(level.doglookpose[param_00][4],1,0);
	self setanimlimited(level.doglookpose[param_00][6],1,0);
	self setanimlimited(level.doglookpose[param_00][8],1,0);
	animscripts\track::setanimaimweight(1,0.2);
	animscripts\track::trackloop(%german_shepherd_look_2,%german_shepherd_look_4,%german_shepherd_look_6,%german_shepherd_look_8);
}

//Function Number: 27
playidlesound(param_00)
{
	if(!animscripts\dog\dog_move::aredifferent(self.idlesound,param_00))
	{
		return;
	}

	stopidlesound();
	if(isdefined(param_00))
	{
		thread loopidlesound(param_00);
	}
}

//Function Number: 28
loopidlesound(param_00)
{
	self endon("killanimscript");
	var_01 = spawn("script_origin",self.origin);
	var_01.angles = self.angles;
	var_01 linkto(self);
	self.idlesoundorigin = var_01;
	self.idlesound = param_00;
	for(;;)
	{
		var_01 playsound(param_00,"dog_idle_sound");
		var_02 = idlesound_waitfordoneordeath(var_01,"dog_idle_sound");
		if(!isdefined(var_02))
		{
			break;
		}
	}
}

//Function Number: 29
idlesound_waitfordoneordeath(param_00,param_01)
{
	self endon("death");
	param_00 endon("death");
	param_00 waittill(param_01);
	return 1;
}

//Function Number: 30
stopidlesound()
{
	if(isdefined(self.idlesoundorigin))
	{
		if(self.idlesoundorigin iswaitingonsound())
		{
			self.idlesoundorigin stopsounds();
			wait(0.05);
		}

		self.idlesoundorigin delete();
		self.idlesoundorigin = undefined;
		self.idlesound = undefined;
	}
}

//Function Number: 31
getdognexttwitchtime()
{
	if(isdefined(self.script_nobark) && self.script_nobark)
	{
		return gettime() + 4000 + randomint(3000);
	}

	return gettime() + 1000 + randomint(1000);
}

//Function Number: 32
getdogstopanimbase()
{
	if(isdefined(self.aggresivelookat))
	{
		return getdogstopanim("attackidle_base");
	}

	return getdogstopanim("casualidle_base");
}

//Function Number: 33
getdogstopanimlook(param_00)
{
	if(isdefined(self.aggresivelookat))
	{
		return getdogstopanim("attackidle_look_" + param_00);
	}

	return getdogstopanim("casualidle_look_" + param_00);
}

//Function Number: 34
getdogstopanim(param_00)
{
	var_01 = animscripts\utility::lookupdoganim("stop",param_00);
	return var_01;
}

//Function Number: 35
getdogstoptransitionanim(param_00,param_01)
{
	var_02 = animscripts\utility::lookupdoganim("stop","transition");
	if(isdefined(var_02[param_00]) && isdefined(var_02[param_00][param_01]))
	{
		return var_02[param_00][param_01];
	}

	return undefined;
}

//Function Number: 36
initdogarchetype_stop()
{
	var_00 = [];
	var_00["attackidle"] = %iw6_dog_attackidle;
	var_00["attack_turn_left"] = %iw6_dog_attackidle_turn_4;
	var_00["attack_turn_right"] = %iw6_dog_attackidle_turn_6;
	var_00["attack_turn_180"] = %iw6_dog_attackidle_turn_2;
	var_00["attackidle_base"] = %iw6_dog_attackidle_base;
	var_00["attackidle_look_2"] = %iw6_dog_attackidle_2;
	var_00["attackidle_look_8"] = %iw6_dog_attackidle_8;
	var_00["alertidle"] = %iw6_dog_alertidle;
	var_00["attackidle_bark"] = %iw6_dog_attackidle_bark;
	var_00["attackidle_twitch_1"] = %iw6_dog_attackidle_twitch_1;
	var_00["attackidle_twitch_2"] = %iw6_dog_attackidle_twitch_2;
	var_00["casualidle"] = %iw6_dog_casualidle;
	var_00["casual_turn_left"] = %iw6_dog_casualidle_turn_4;
	var_00["casual_turn_right"] = %iw6_dog_casualidle_turn_6;
	var_00["casual_turn_180"] = %iw6_dog_casualidle_turn_2;
	var_00["casualidle_base"] = %iw6_dog_casualidle_base;
	var_00["casualidle_look_2"] = %iw6_dog_casualidle_2;
	var_00["casualidle_look_4"] = %iw6_dog_casualidle_4;
	var_00["casualidle_look_6"] = %iw6_dog_casualidle_6;
	var_00["casualidle_look_8"] = %iw6_dog_casualidle_8;
	var_00["sneakstandidle"] = %iw6_dog_sneak_stand_idle;
	var_00["sneakidle"] = %iw6_dog_sneakidle;
	var_00["sniffidle"] = %iw6_dog_sniff_idle;
	var_00["transition"] = [];
	var_00["transition"]["casualidle"] = [];
	var_00["transition"]["casualidle"]["sneakidle"] = %iw6_dog_idle_2_sneak_idle;
	var_00["transition"]["casualidle"]["alertidle"] = %iw6_dog_idle_2_alert_idle;
	var_00["transition"]["casualidle"]["attackidle"] = %iw6_dog_idle_2_alert_idle;
	var_00["transition"]["alertidle"] = [];
	var_00["transition"]["alertidle"]["casualidle"] = %iw6_dog_alert_2_casual_idle;
	var_00["transition"]["alertidle"]["sneakidle"] = %iw6_dog_idle_2_sneak_idle;
	var_00["transition"]["attackidle"] = [];
	var_00["transition"]["attackidle"]["casualidle"] = %iw6_dog_alert_2_casual_idle;
	var_00["transition"]["attackidle"]["sneakidle"] = %iw6_dog_idle_2_sneak_idle;
	var_00["transition"]["sneakidle"] = [];
	var_00["transition"]["sneakidle"]["casualidle"] = %iw6_dog_sneak_2_casual_idle;
	var_00["transition"]["sneakidle"]["alertidle"] = %iw6_dog_sneak_2_casual_idle;
	var_00["transition"]["sneakidle"]["attackidle"] = %iw6_dog_sneak_2_casual_idle;
	level.archetypes["dog"]["stop"] = var_00;
}