/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\face.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 274 ms
 * Timestamp: 10/27/2023 1:23:59 AM
*******************************************************************/

//Function Number: 1
initcharacterface()
{
	if(!level.var_87B9)
	{
		return;
	}

	if(!isdefined(self.a.currentdialogimportance))
	{
		self.a.currentdialogimportance = 0;
		self.a.var_43E1 = level.alertface;
		self.var_311F = [];
		self.var_311B = 0;
	}
}

//Function Number: 2
func_6AB2(param_00)
{
	var_01 = undefined;
	switch(self.voice)
	{
		case "pmc":
		case "czech":
		case "french":
		case "delta":
		case "taskforce":
		case "seal":
		case "american":
			var_02 = "friendly";
			var_03 = level.numfriendlyvoices;
			break;

		default:
			var_02 = "enemy";
			var_03 = level.var_5783;
			break;
	}

	var_01 = 1 + self getentitynumber() % var_03;
	var_02 = var_02 + "_" + var_01;
	var_04 = undefined;
	switch(param_00)
	{
		case "meleeattack":
		case "meleecharge":
			var_05 = 0.5;
			break;

		case "flashbang":
			var_05 = 0.7;
			break;

		case "pain":
			var_05 = 0.9;
			break;

		case "dogdeathlongplr":
		case "dogdeathshortplr":
		case "dogdeathlong":
		case "dogdeathshort":
		case "death":
			var_05 = 1;
			break;

		default:
			var_05 = 0.3;
			break;
	}

	var_06 = undefined;
	if(isdefined(self.var_37A8))
	{
		var_06 = self.var_37A8 + "_" + param_00 + "_" + var_02;
		if(!soundexists(var_06))
		{
			var_06 = "generic_" + param_00 + "_" + var_02;
		}
	}
	else
	{
		var_06 = "generic_" + param_00 + "_" + var_02;
	}

	thread func_6003(var_04,var_06,var_05);
}

//Function Number: 3
func_7053(param_00)
{
	animscripts/battlechatter::func_5D4E();
	self.a.var_43E1 = param_00;
}

//Function Number: 4
func_7052(param_00)
{
	if(!level.var_87B9)
	{
	}

	animscripts/battlechatter::func_5D4E();
	self.a.var_43E1 = param_00;
	playidleface();
}

//Function Number: 5
func_6AB5(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread func_6003(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 6
func_1BF0(param_00)
{
}

//Function Number: 7
playidleface()
{
}

//Function Number: 8
func_6003(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self.a.var_3123 = 1;
	self.a.var_3126 = 1;
	if(isdefined(param_03))
	{
		if(isdefined(param_01))
		{
			self playsoundatviewheight(param_01,"animscript facesound" + param_03,1);
			thread func_8AE3(param_03);
		}
	}
	else
	{
		self playsoundatviewheight(param_01);
	}

	if(!level.var_87B9)
	{
	}

	initcharacterface();
	if(!isdefined(param_00) && !isdefined(param_01))
	{
		if(isdefined(param_03))
		{
			wait(0);
			self.faceresult = "failed";
			self notify(param_03);
		}
	}

	self endon("death");
	if(isstring(param_02))
	{
		switch(param_02)
		{
			case "any":
				param_02 = 0.1;
				break;

			case "pain":
				param_02 = 0.9;
				break;

			case "death":
				param_02 = 1;
				break;
		}
	}

	if(param_02 <= self.a.currentdialogimportance && isdefined(param_04) && param_04 == "wait")
	{
		var_06 = self.var_311F.size;
		var_07 = self.var_311B + 1;
		self.var_311F[var_06]["facialanim"] = param_00;
		self.var_311F[var_06]["soundAlias"] = param_01;
		self.var_311F[var_06]["importance"] = param_02;
		self.var_311F[var_06]["notifyString"] = param_03;
		self.var_311F[var_06]["waitOrNot"] = param_04;
		self.var_311F[var_06]["timeToWait"] = param_05;
		self.var_311F[var_06]["notifyNum"] = var_07;
		thread playface_waitfornotify("animscript face stop waiting " + self.var_311F[var_06]["notifyNum"],"Face done waiting","Face done waiting");
		if(isdefined(param_05))
		{
			thread func_6002(param_05,"Face done waiting","Face done waiting");
		}

		self waittill("Face done waiting");
		var_06 = undefined;
		for(var_08 = 0;var_08 < self.var_311F.size;var_08++)
		{
			if(self.var_311F[var_08]["notifyNum"] == var_07)
			{
				var_06 = var_08;
				break;
			}
		}

		if(self.a.facewaitforresult == "notify")
		{
			func_6003(self.var_311F[var_06]["facialanim"],self.var_311F[var_06]["soundAlias"],self.var_311F[var_06]["importance"],self.var_311F[var_06]["notifyString"]);
		}
		else if(isdefined(param_03))
		{
			self.faceresult = "failed";
			self notify(param_03);
		}

		for(var_08 = var_06 + 1;var_08 < self.var_311F.size;var_08++)
		{
			self.var_311F[var_08 - 1]["facialanim"] = self.var_311F[var_08]["facialanim"];
			self.var_311F[var_08 - 1]["soundAlias"] = self.var_311F[var_08]["soundAlias"];
			self.var_311F[var_08 - 1]["importance"] = self.var_311F[var_08]["importance"];
			self.var_311F[var_08 - 1]["notifyString"] = self.var_311F[var_08]["notifyString"];
			self.var_311F[var_08 - 1]["waitOrNot"] = self.var_311F[var_08]["waitOrNot"];
			self.var_311F[var_08 - 1]["timeToWait"] = self.var_311F[var_08]["timeToWait"];
			self.var_311F[var_08 - 1]["notifyNum"] = self.var_311F[var_08]["notifyNum"];
		}

		self.var_311F[self.var_311F.size - 1] = undefined;
	}

	if(param_02 >= self.a.currentdialogimportance)
	{
		self notify("end current face");
		self endon("end current face");
		if(isdefined(param_03))
		{
			if(isdefined(self.a.var_21F2))
			{
				self.faceresult = "interrupted";
				self notify(self.a.var_21F2);
			}
		}

		self.a.currentdialogimportance = param_02;
		self.a.var_21F3 = param_01;
		self.a.var_21F2 = param_03;
		self.a.var_3123 = 1;
		self.a.var_3126 = 1;
		if(isdefined(param_00))
		{
			maps\_anim::disabledefaultfacialanims();
			self setflaggedanimknobrestart("animscript faceanim",param_00,1,0.1,1);
			self.a.var_3123 = 0;
			thread func_8AE4();
		}
		else
		{
			maps\_anim::disabledefaultfacialanims(0);
		}

		if(isdefined(param_01))
		{
			self playsoundatviewheight(param_01,"animscript facesound",1);
			self.a.var_3126 = 0;
			thread func_8AE3();
		}

		while(!self.a.var_3123 || !self.a.var_3126)
		{
			self waittill("animscript facedone");
		}

		self.a.currentdialogimportance = 0;
		self.a.var_21F3 = undefined;
		self.a.var_21F2 = undefined;
		if(isdefined(param_03))
		{
			self.faceresult = "finished";
			self notify(param_03);
		}

		if(isdefined(self.var_311F) && self.var_311F.size > 0)
		{
			var_09 = 0;
			var_0A = 1;
			for(var_08 = 0;var_08 < self.var_311F.size;var_08++)
			{
				if(self.var_311F[var_08]["importance"] > var_09)
				{
					var_09 = self.var_311F[var_08]["importance"];
					var_0A = var_08;
				}
			}

			self notify("animscript face stop waiting " + self.var_311F[var_0A]["notifyNum"]);
		}

		if(isai(self))
		{
			playidleface();
		}
	}

	if(isdefined(param_03))
	{
		self.faceresult = "failed";
		self notify(param_03);
	}
}

//Function Number: 9
func_8AE4()
{
	self endon("death");
	self endon("end current face");
	animscripts/shared::func_2986("animscript faceanim");
	self.a.var_3123 = 1;
	self notify("animscript facedone");
	maps\_anim::disabledefaultfacialanims(0);
}

//Function Number: 10
func_8AE3(param_00)
{
	self endon("death");
	self waittill("animscript facesound" + param_00);
	self notify(param_00);
}

//Function Number: 11
playface_waitfornotify(param_00,param_01,param_02)
{
	self endon("death");
	self endon(param_02);
	self waittill(param_00);
	self.a.facewaitforresult = "notify";
	self notify(param_01);
}

//Function Number: 12
func_6002(param_00,param_01,param_02)
{
	self endon("death");
	self endon(param_02);
	wait(param_00);
	self.a.facewaitforresult = "time";
	self notify(param_01);
}

//Function Number: 13
func_4633()
{
	anim.numfriendlyvoices = 8;
	anim.var_5783 = 8;
	func_460D();
}

//Function Number: 14
func_460D()
{
	anim.facial = [];
	level.facial["pain"] = [%facial_pain_1,%facial_pain_2,%facial_pain_3,%facial_pain_4];
	level.facial["aim"] = [%facial_aim_1,%facial_aim_2];
	level.facial["run"] = [%facial_run_1,%facial_run_2];
	level.facial["corner_stand_L"] = [%facial_corner_stand_l_1,%facial_corner_stand_l_2];
	level.facial["corner_stand_R"] = [%facial_corner_stand_r_1,%facial_corner_stand_r_2];
	level.facial["death"] = [%facial_death_1,%facial_death_2,%facial_death_3,%facial_death_4];
}

//Function Number: 15
animhasfacialoverride(param_00)
{
	return animhasnotetrack(param_00,"facial_override");
}

//Function Number: 16
func_6004(param_00,param_01,param_02)
{
	if(isdefined(self.bdisabledefaultfacialanims) && self.bdisabledefaultfacialanims)
	{
		self clearanim(%head,0.2);
	}

	if(isdefined(param_00) && animhasfacialoverride(param_00))
	{
		self clearanim(%head,0.2);
	}

	if(!isdefined(level.facial[param_01]))
	{
	}

	if(isdefined(param_02) && param_02 >= 0 && param_02 < level.facial[param_01].size)
	{
		var_03 = param_02;
	}
	else
	{
		var_03 = randomint(level.facial[param_02].size);
	}

	var_04 = level.facial[param_01][var_03];
	self setanimknob(var_04);
	return var_03;
}