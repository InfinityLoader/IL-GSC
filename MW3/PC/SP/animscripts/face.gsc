/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\face.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 231 ms
 * Timestamp: 10/27/2023 2:18:18 AM
*******************************************************************/

//Function Number: 1
func_0C3A()
{
	if(!level.usefacialanims)
	{
		return;
	}

	if(!isdefined(self.a.var_C3C))
	{
		self.a.var_C3C = 0;
		self.a.var_C3E = level.var_C3D;
		self.var_C3F = [];
		self.var_C40 = 0;
	}
}

//Function Number: 2
func_0C41(param_00)
{
	var_01 = undefined;
	switch(self.voice)
	{
		case "seal":
		case "taskforce":
		case "french":
		case "pmc":
		case "czech":
		case "delta":
		case "american":
			var_02 = "friendly";
			var_03 = level.var_C42;
			break;

		default:
			var_02 = "enemy";
			var_03 = level.var_C43;
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

		case "death":
			var_05 = 1;
			break;

		default:
			var_05 = 0.3;
			break;
	}

	var_06 = "generic_" + param_00 + "_" + var_02;
	thread func_0C49(var_04,var_06,var_05);
}

//Function Number: 3
func_0C44(param_00)
{
	animscripts/battlechatter::func_ABF();
	self.a.var_C3E = param_00;
}

//Function Number: 4
func_0C45(param_00)
{
	if(!level.usefacialanims)
	{
		return;
	}

	animscripts/battlechatter::func_ABF();
	self.a.var_C3E = param_00;
	func_0C48();
}

//Function Number: 5
func_0C46(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread func_0C49(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 6
func_0C47(param_00)
{
}

//Function Number: 7
func_0C48()
{
}

//Function Number: 8
func_0C49(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self.a.var_C4A = 1;
	self.a.var_C4B = 1;
	if(isdefined(param_03))
	{
		if(isdefined(param_01))
		{
			self playsoundatviewheight(param_01,"animscript facesound" + param_03,1);
			thread func_0C52(param_03);
		}
	}
	else
	{
		self playsoundatviewheight(param_01);
	}

	if(!level.usefacialanims)
	{
		return;
	}

	func_0C3A();
	if(!isdefined(param_00) && !isdefined(param_01))
	{
		if(isdefined(param_03))
		{
			wait 0;
			self.var_C4C = "failed";
			self notify(param_03);
		}

		return;
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

	if(param_02 <= self.a.var_C3C && isdefined(param_04) && param_04 == "wait")
	{
		var_06 = self.var_C3F.size;
		var_07 = self.var_C40 + 1;
		self.var_C3F[var_06]["facialanim"] = param_00;
		self.var_C3F[var_06]["soundAlias"] = param_01;
		self.var_C3F[var_06]["importance"] = param_02;
		self.var_C3F[var_06]["notifyString"] = param_03;
		self.var_C3F[var_06]["waitOrNot"] = param_04;
		self.var_C3F[var_06]["timeToWait"] = param_05;
		self.var_C3F[var_06]["notifyNum"] = var_07;
		thread func_0C53("animscript face stop waiting " + self.var_C3F[var_06]["notifyNum"],"Face done waiting","Face done waiting");
		if(isdefined(param_05))
		{
			thread func_0C54(param_05,"Face done waiting","Face done waiting");
		}

		self waittill("Face done waiting");
		var_06 = undefined;
		for(var_08 = 0;var_08 < self.var_C3F.size;var_08++)
		{
			if(self.var_C3F[var_08]["notifyNum"] == var_07)
			{
				var_06 = var_08;
				break;
			}
		}

		if(self.a.var_C4D == "notify")
		{
			func_0C49(self.var_C3F[var_06]["facialanim"],self.var_C3F[var_06]["soundAlias"],self.var_C3F[var_06]["importance"],self.var_C3F[var_06]["notifyString"]);
		}
		else if(isdefined(param_03))
		{
			self.var_C4C = "failed";
			self notify(param_03);
		}

		for(var_08 = var_06 + 1;var_08 < self.var_C3F.size;var_08++)
		{
			self.var_C3F[var_08 - 1]["facialanim"] = self.var_C3F[var_08]["facialanim"];
			self.var_C3F[var_08 - 1]["soundAlias"] = self.var_C3F[var_08]["soundAlias"];
			self.var_C3F[var_08 - 1]["importance"] = self.var_C3F[var_08]["importance"];
			self.var_C3F[var_08 - 1]["notifyString"] = self.var_C3F[var_08]["notifyString"];
			self.var_C3F[var_08 - 1]["waitOrNot"] = self.var_C3F[var_08]["waitOrNot"];
			self.var_C3F[var_08 - 1]["timeToWait"] = self.var_C3F[var_08]["timeToWait"];
			self.var_C3F[var_08 - 1]["notifyNum"] = self.var_C3F[var_08]["notifyNum"];
		}

		self.var_C3F[self.var_C3F.size - 1] = undefined;
		return;
	}

	if(param_02 >= self.a.var_C3C)
	{
		self notify("end current face");
		self endon("end current face");
		if(isdefined(param_03))
		{
			if(isdefined(self.a.var_C4E))
			{
				self.var_C4C = "interrupted";
				self notify(self.a.var_C4E);
			}
		}

		self.a.var_C3C = param_02;
		self.a.var_C4F = param_01;
		self.a.var_C4E = param_03;
		self.a.var_C4A = 1;
		self.a.var_C4B = 1;
		if(isdefined(param_00))
		{
			self setflaggedanimknobrestart("animscript faceanim",param_00,1,0.1,1);
			self.a.var_C4A = 0;
			thread func_0C50();
		}

		if(isdefined(param_01))
		{
			self playsoundatviewheight(param_01,"animscript facesound",1);
			self.a.var_C4B = 0;
			thread func_0C52();
		}

		while(!self.a.var_C4A || !self.a.var_C4B)
		{
			self waittill("animscript facedone");
		}

		self.a.var_C3C = 0;
		self.a.var_C4F = undefined;
		self.a.var_C4E = undefined;
		if(isdefined(param_03))
		{
			self.var_C4C = "finished";
			self notify(param_03);
		}

		if(isdefined(self.var_C3F) && self.var_C3F.size > 0)
		{
			var_09 = 0;
			var_0A = 1;
			for(var_08 = 0;var_08 < self.var_C3F.size;var_08++)
			{
				if(self.var_C3F[var_08]["importance"] > var_09)
				{
					var_09 = self.var_C3F[var_08]["importance"];
					var_0A = var_08;
				}
			}

			self notify("animscript face stop waiting " + self.var_C3F[var_0A]["notifyNum"]);
			return;
		}

		if(isai(self))
		{
			func_0C48();
			return;
		}

		return;
	}

	if(isdefined(param_03))
	{
		self.var_C4C = "failed";
		self notify(param_03);
		return;
	}
}

//Function Number: 9
func_0C50()
{
	self endon("death");
	self endon("end current face");
	animscripts/shared::donotetracks("animscript faceanim");
	self.a.var_C4A = 1;
	self notify("animscript facedone");
}

//Function Number: 10
func_0C52(param_00)
{
	self endon("death");
	self waittill("animscript facesound" + param_00);
	self notify(param_00);
}

//Function Number: 11
func_0C53(param_00,param_01,param_02)
{
	self endon("death");
	self endon(param_02);
	self waittill(param_00);
	self.a.var_C4D = "notify";
	self notify(param_01);
}

//Function Number: 12
func_0C54(param_00,param_01,param_02)
{
	self endon("death");
	self endon(param_02);
	wait param_00;
	self.a.var_C4D = "time";
	self notify(param_01);
}

//Function Number: 13
func_0C55()
{
	anim.var_C42 = 8;
	anim.var_C43 = 8;
}