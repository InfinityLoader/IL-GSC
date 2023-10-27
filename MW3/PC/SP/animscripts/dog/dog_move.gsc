/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\dog\dog_move.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 270 ms
 * Timestamp: 10/27/2023 2:17:15 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	self clearanim(%root,0.2);
	self clearanim(%german_shepherd_run_stop,0);
	if(!isdefined(self.var_3B58) && !isdefined(self.var_3B0C) && self.a.movement == "run" && !isdefined(self.disableexits) || self.disableexits == 0)
	{
		func_3B61();
	}

	thread func_3B64();
	self.var_3B58 = undefined;
	self.var_3B0C = undefined;
	if(self.a.movement == "run")
	{
		var_00 = undefined;
		var_00 = func_3B65();
		self setanimrestart(%german_shepherd_run,var_00["center"],0.2,1);
		self setanimrestart(%german_shepherd_run_lean_l,var_00["left"],0.1,1);
		self setanimrestart(%german_shepherd_run_lean_r,var_00["right"],0.1,1);
		self setflaggedanimknob("dog_run",%german_shepherd_run_knob,1,0.2,self.moveplaybackrate);
		animscripts/notetracks::func_D4F(0.1,"dog_run");
	}
	else
	{
		self setflaggedanimrestart("dog_walk",%german_shepherd_walk,1,0.2,self.moveplaybackrate);
	}

	thread animscripts/dog/dog_stop::func_3B01("normal");
	for(;;)
	{
		func_3B59();
		if(self.a.movement == "run")
		{
			if(self.disablearrivals == 0)
			{
				thread func_3B62();
			}

			self waittill("run");
			self clearanim(%german_shepherd_run_stop,0.1);
		}
	}
}

//Function Number: 2
func_3B59()
{
	self endon("killanimscript");
	self endon("stop_soon");
	self.var_10B7 = undefined;
	for(;;)
	{
		if(self.disablearrivals)
		{
			self.stopanimdistsq = 0;
		}
		else
		{
			self.stopanimdistsq = level.var_3AEE;
		}

		if(isdefined(self.var_10B7))
		{
			self [[ self.var_10B7 ]]();
			self.var_10B7 = undefined;
		}

		if(isdefined(self.var_10AB))
		{
			self [[ self.var_10AB ]]();
			continue;
		}

		func_3B5A();
	}
}

//Function Number: 3
func_3B5A()
{
	self endon("move_loop_restart");
	if(self.a.movement == "run")
	{
		var_00 = func_3B65();
		self clearanim(%german_shepherd_walk,0.3);
		self setanim(%german_shepherd_run,var_00["center"],0.2,1);
		self setanim(%german_shepherd_run_lean_l,var_00["left"],0.1,1);
		self setanim(%german_shepherd_run_lean_r,var_00["right"],0.1,1);
		self setflaggedanimknob("dog_run",%german_shepherd_run_knob,1,0.2,self.moveplaybackrate);
		animscripts/notetracks::func_D4F(0.2,"dog_run");
		return;
	}

	self clearanim(%german_shepherd_run_knob,0.3);
	self setflaggedanim("dog_walk",%german_shepherd_walk,1,0.2,self.moveplaybackrate);
	animscripts/notetracks::func_D4F(0.2,"dog_walk");
}

//Function Number: 4
func_1090()
{
	self endon("killanimscript");
	self.var_10A8 = undefined;
	for(;;)
	{
		self waittill("path_changed",var_00,var_01);
		if(isdefined(self.var_10A8) || isdefined(self.noturnanims))
		{
			continue;
		}

		if(self.a.movement != "run")
		{
			continue;
		}

		var_02 = angleclamp180(self.angles[1] - vectortoyaw(var_01));
		var_03 = func_3B5C(var_02);
		if(isdefined(var_03))
		{
			self.var_10C0 = var_03;
			self.var_10C1 = gettime();
			self.var_10AB = ::func_3B5D;
			self notify("move_loop_restart");
		}
	}
}

//Function Number: 5
func_3B5B()
{
	self endon("killanimscript");
	self.var_10A8 = undefined;
	for(;;)
	{
		if(self.var_774 > 40 && !isdefined(self.var_10AB) && !isdefined(self.var_10A8) && !isdefined(self.noturnanims) && self.a.movement == "run")
		{
			var_00 = vectortoyaw(self.var_773);
			var_01 = angleclamp180(self.angles[1] - var_00);
			var_02 = func_3B5C(var_01);
			if(isdefined(var_02))
			{
				self.var_10C0 = var_02;
				self.var_10C1 = gettime();
				self.var_10AB = ::func_3B5D;
				self notify("move_loop_restart");
			}
		}

		wait 0.05;
	}
}

//Function Number: 6
func_3B5C(param_00)
{
	var_01 = undefined;
	if(param_00 < -135)
	{
		var_01 = %german_shepherd_run_start_180_l;
	}
	else if(param_00 > 135)
	{
		var_01 = %german_shepherd_run_start_180_r;
	}
	else if(param_00 < -60)
	{
		var_01 = %german_shepherd_run_start_l;
	}
	else if(param_00 > 60)
	{
		var_01 = %german_shepherd_run_start_r;
	}

	return var_01;
}

//Function Number: 7
func_3B5D()
{
	self endon("killanimscript");
	self.var_10AB = undefined;
	var_00 = self.var_10C0;
	if(gettime() > self.var_10C1 + 50)
	{
		return;
	}

	self animmode("zonly_physics",0);
	self clearanim(%root,0.2);
	self.var_10B7 = ::func_3B5E;
	self.var_10A8 = 1;
	self setflaggedanimrestart("turnAnim",var_00,1,0.2,self.moveplaybackrate);
	self orientmode("face current");
	var_01 = getanimlength(var_00) * self.moveplaybackrate;
	animscripts/notetracks::func_D4F(var_01 * 0.2,"turnAnim");
	self orientmode("face motion");
	self animmode("none",0);
	var_02 = self.turnrate;
	self.turnrate = 0.4;
	animscripts/notetracks::func_D4F(var_01 * 0.65,"turnAnim");
	self.turnrate = var_02;
	self.var_10A8 = undefined;
}

//Function Number: 8
func_3B5E()
{
	self.var_10A8 = undefined;
	self orientmode("face default");
	self clearanim(%root,0.2);
	self animmode("none",0);
}

//Function Number: 9
func_3B5F()
{
	self endon("killanimscript");
	for(var_00 = 0;var_00 < 2;var_00++)
	{
		var_01 = vectortoangles(self.var_773);
		self orientmode("face angle",var_01);
	}
}

//Function Number: 10
func_3B60()
{
	self endon("move_loop_restart");
	if(self.var_774 == 0)
	{
		thread func_3B5B();
		return;
	}

	var_00 = self.origin;
	var_01 = level.var_3AF5 * 0.6;
	var_00 = var_00 + self.var_773 * var_01;
	var_02 = distancesquared(self.origin,self.pathgoalpos) < var_01 * var_01;
	var_03 = vectortoangles(self.var_773);
	if(!var_02 && self maymovetopoint(var_00))
	{
		var_04 = angleclamp180(var_03[1] - self.angles[1]);
		if(var_04 >= 0)
		{
			if(var_04 < 45)
			{
				var_05 = 8;
			}
			else if(var_05 < 135)
			{
				var_05 = 6;
			}
			else
			{
				var_05 = 3;
			}
		}
		else if(var_05 > -45)
		{
			var_05 = 8;
		}
		else if(var_05 > -135)
		{
			var_05 = 4;
		}
		else
		{
			var_05 = 1;
		}

		self setanimrestart(level.var_3AF8[var_05],1,0.2,1);
		var_06 = self.angles[1] + level.var_3AF7[var_05];
		var_07 = angleclamp180(var_03[1] - var_06);
		self orientmode("face angle",self.angles[1] + var_07);
		self animmode("zonly_physics",0);
		var_08 = getanimlength(level.var_3AF8[var_05]) * self.moveplaybackrate;
		animscripts/notetracks::func_D4F(var_08 * 0.6,"turnAnim");
		self orientmode("face motion");
		self animmode("none",0);
		thread func_3B5B();
		animscripts/notetracks::func_D4F(var_08 * 0.25,"turnAnim");
		return;
	}

	self orientmode("face angle",var_03[1]);
	self animmode("none");
	self.var_3AFC = self.turnrate;
	self.turnrate = 0.5;
	var_09 = angleclamp180(var_03[1] - self.angles[1]);
	if(abs(var_09) > 20)
	{
		if(var_09 > 0)
		{
			var_0A = %german_shepherd_rotate_ccw;
		}
		else
		{
			var_0A = %german_shepherd_rotate_cw;
		}

		self setflaggedanimrestart("dog_turn",var_0A,1,0.2,1);
		animscripts/shared::donotetracks("dog_turn");
		self clearanim(%german_shepherd_rotate_cw,0.2);
		self clearanim(%german_shepherd_rotate_ccw,0.2);
	}

	thread func_3B5B();
	self.turnrate = self.var_3AFC;
	self.var_3AFC = undefined;
	self orientmode("face motion");
}

//Function Number: 11
func_3B61()
{
	if(isdefined(self.pathgoalpos))
	{
		if(isdefined(self.pathgoalpos))
		{
			func_3B60();
			self clearanim(%root,0.2);
			return;
		}
	}

	self orientmode("face default");
	self setflaggedanimknobrestart("dog_prerun",%german_shepherd_run_start,1,0.2,self.moveplaybackrate);
	animscripts/shared::donotetracks("dog_prerun");
	self animmode("none",0);
	self clearanim(%root,0.2);
}

//Function Number: 12
func_3B62()
{
	self endon("killanimscript");
	self endon("run");
	self clearanim(%german_shepherd_run_knob,0.1);
	self setflaggedanimrestart("stop_anim",%german_shepherd_run_stop,1,0.2,1);
	animscripts/shared::donotetracks("stop_anim");
}

//Function Number: 13
func_3B63(param_00,param_01)
{
	maps\_utility::play_sound_on_tag_endon_death(param_00,"tag_eye");
	if(isalive(self))
	{
		self notify(param_01);
	}
}

//Function Number: 14
func_3B64()
{
	self endon("killanimscript");
	wait 0.2;
	for(;;)
	{
		var_00 = undefined;
		if(isdefined(self.var_23DB))
		{
			var_00 = "anml_dog_growl";
		}
		else if(!isdefined(self.script_nobark))
		{
			var_00 = "anml_dog_bark";
		}

		if(!isdefined(var_00))
		{
			break;
		}

		thread func_3B63(var_00,"randomRunSound");
		self waittill("randomRunSound");
		wait randomfloatrange(0.1,0.3);
	}
}

//Function Number: 15
func_3B65()
{
	var_00 = [];
	if(self.var_76C > 0)
	{
		if(self.var_76C < 0.95)
		{
			self.var_76C = 0.95;
		}

		if(var_7B["right"] > 1)
		{
		}
		else if(var_7B["right"] < 0)
		{
		}
	}
	else if(self.var_76C < 0)
	{
		if(self.var_76C > -0.95)
		{
			self.var_76C = -0.95;
		}

		if(var_7B["left"] > 1)
		{
		}

		if(var_7B["left"] < 0)
		{
		}
	}
	else
	{
	}

	return var_7B;
}