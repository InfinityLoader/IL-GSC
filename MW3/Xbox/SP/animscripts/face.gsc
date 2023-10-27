/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\face.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 13
 * Decompile Time: 242 ms
 * Timestamp: 10/27/2023 2:30:22 AM
*******************************************************************/

//Function Number: 1
initcharacterface()
{
	if(!level.usefacialanims)
	{
		return;
	}

	if(!isdefined(self.a.currentdialogimportance))
	{
		self.a.currentdialogimportance = 0;
		self.a.idleface = level.alertface;
		self.var_82A = [];
		self.facelastnotifynum = 0;
	}
}

//Function Number: 2
saygenericdialogue(param_00)
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
			var_03 = level.numfriendlyvoices;
			break;

		default:
			var_02 = "enemy";
			var_03 = level.numenemyvoices;
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
	thread playfacethread(var_04,var_06,var_05);
}

//Function Number: 3
setidlefacedelayed(param_00)
{
	animscripts/battlechatter::playbattlechatter();
	self.a.idleface = param_00;
}

//Function Number: 4
setidleface(param_00)
{
	if(!level.usefacialanims)
	{
		return;
	}

	animscripts/battlechatter::playbattlechatter();
	self.a.idleface = param_00;
	playidleface();
}

//Function Number: 5
sayspecificdialogue(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread playfacethread(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 6
chooseanimfromset(param_00)
{
}

//Function Number: 7
playidleface()
{
}

//Function Number: 8
playfacethread(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self.a.facialanimdone = 1;
	self.a.facialsounddone = 1;
	if(isdefined(param_03))
	{
		if(isdefined(param_01))
		{
			self playsoundatviewheight(param_01,"animscript facesound" + param_03,1);
			thread waitforfacesound(param_03);
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

	initcharacterface();
	if(!isdefined(param_00) && !isdefined(param_01))
	{
		if(isdefined(param_03))
		{
			wait 0;
			self.faceresult = "failed";
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

	if(param_02 <= self.a.currentdialogimportance && isdefined(param_04) && param_04 == "wait")
	{
		var_06 = self.var_82A.size;
		var_07 = self.facelastnotifynum + 1;
		self.var_82A[var_06]["facialanim"] = param_00;
		self.var_82A[var_06]["soundAlias"] = param_01;
		self.var_82A[var_06]["importance"] = param_02;
		self.var_82A[var_06]["notifyString"] = param_03;
		self.var_82A[var_06]["waitOrNot"] = param_04;
		self.var_82A[var_06]["timeToWait"] = param_05;
		self.var_82A[var_06]["notifyNum"] = var_07;
		thread playface_waitfornotify("animscript face stop waiting " + self.var_82A[var_06]["notifyNum"],"Face done waiting","Face done waiting");
		if(isdefined(param_05))
		{
			thread playface_waitfortime(param_05,"Face done waiting","Face done waiting");
		}

		self waittill("Face done waiting");
		var_06 = undefined;
		for(var_08 = 0;var_08 < self.var_82A.size;var_08++)
		{
			if(self.var_82A[var_08]["notifyNum"] == var_07)
			{
				var_06 = var_08;
				break;
			}
		}

		if(self.a.facewaitforresult == "notify")
		{
			playfacethread(self.var_82A[var_06]["facialanim"],self.var_82A[var_06]["soundAlias"],self.var_82A[var_06]["importance"],self.var_82A[var_06]["notifyString"]);
		}
		else if(isdefined(param_03))
		{
			self.faceresult = "failed";
			self notify(param_03);
		}

		for(var_08 = var_06 + 1;var_08 < self.var_82A.size;var_08++)
		{
			self.var_82A[var_08 - 1]["facialanim"] = self.var_82A[var_08]["facialanim"];
			self.var_82A[var_08 - 1]["soundAlias"] = self.var_82A[var_08]["soundAlias"];
			self.var_82A[var_08 - 1]["importance"] = self.var_82A[var_08]["importance"];
			self.var_82A[var_08 - 1]["notifyString"] = self.var_82A[var_08]["notifyString"];
			self.var_82A[var_08 - 1]["waitOrNot"] = self.var_82A[var_08]["waitOrNot"];
			self.var_82A[var_08 - 1]["timeToWait"] = self.var_82A[var_08]["timeToWait"];
			self.var_82A[var_08 - 1]["notifyNum"] = self.var_82A[var_08]["notifyNum"];
		}

		self.var_82A[self.var_82A.size - 1] = undefined;
		return;
	}

	if(param_02 >= self.a.currentdialogimportance)
	{
		self notify("end current face");
		self endon("end current face");
		if(isdefined(param_03))
		{
			if(isdefined(self.a.currentdialognotifystring))
			{
				self.faceresult = "interrupted";
				self notify(self.a.currentdialognotifystring);
			}
		}

		self.a.currentdialogimportance = param_02;
		self.a.currentdialogsound = param_01;
		self.a.currentdialognotifystring = param_03;
		self.a.facialanimdone = 1;
		self.a.facialsounddone = 1;
		if(isdefined(param_00))
		{
			self setflaggedanimknobrestart("animscript faceanim",param_00,1,0.1,1);
			self.a.facialanimdone = 0;
			thread waitforfacialanim();
		}

		if(isdefined(param_01))
		{
			self playsoundatviewheight(param_01,"animscript facesound",1);
			self.a.facialsounddone = 0;
			thread waitforfacesound();
		}

		while(!self.a.facialanimdone || !self.a.facialsounddone)
		{
			self waittill("animscript facedone");
		}

		self.a.currentdialogimportance = 0;
		self.a.currentdialogsound = undefined;
		self.a.currentdialognotifystring = undefined;
		if(isdefined(param_03))
		{
			self.faceresult = "finished";
			self notify(param_03);
		}

		if(isdefined(self.var_82A) && self.var_82A.size > 0)
		{
			var_09 = 0;
			var_0A = 1;
			for(var_08 = 0;var_08 < self.var_82A.size;var_08++)
			{
				if(self.var_82A[var_08]["importance"] > var_09)
				{
					var_09 = self.var_82A[var_08]["importance"];
					var_0A = var_08;
				}
			}

			self notify("animscript face stop waiting " + self.var_82A[var_0A]["notifyNum"]);
			return;
		}

		if(isai(self))
		{
			playidleface();
			return;
		}

		return;
	}

	if(isdefined(param_03))
	{
		self.faceresult = "failed";
		self notify(param_03);
		return;
	}
}

//Function Number: 9
waitforfacialanim()
{
	self endon("death");
	self endon("end current face");
	animscripts/shared::donotetracks("animscript faceanim");
	self.a.facialanimdone = 1;
	self notify("animscript facedone");
}

//Function Number: 10
waitforfacesound(param_00)
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
playface_waitfortime(param_00,param_01,param_02)
{
	self endon("death");
	self endon(param_02);
	wait param_00;
	self.a.facewaitforresult = "time";
	self notify(param_01);
}

//Function Number: 13
initlevelface()
{
	anim.numfriendlyvoices = 8;
	anim.numenemyvoices = 8;
}