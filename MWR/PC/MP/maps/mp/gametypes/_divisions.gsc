/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_divisions.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 525 ms
 * Timestamp: 10/27/2023 2:37:45 AM
*******************************************************************/

//Function Number: 1
checkforseason1start()
{
	if(!isvalidplayer())
	{
		return;
	}

	if(isdefined(level.iszombiegame) && level.iszombiegame)
	{
		return;
	}

	if(isdefined(level.ishorde) && level.ishorde)
	{
		return;
	}

	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(isdefined(self.pers["division"]) && isdefined(self.pers["division"]["seasonStart"]))
	{
		return;
	}

	var_00 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"currentSeason");
	var_01 = getdvarint("scr_game_season");
	if(var_01 > 0 && var_00 == 0)
	{
		self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"division",0);
		self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"mmr",-31768);
		self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionRelegationCounter",0);
		self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionChallengePlayed",0);
		self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionChallengeWon",0);
		self setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","matchPrediction",0);
		self setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","matchDp",0);
		self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"currentSeason",var_01);
		self.pers["division"]["seasonStart"] = 1;
	}
}

//Function Number: 2
init()
{
	if(maps\mp\_utility::invirtuallobby())
	{
		return;
	}

	if(getdvarint("scr_game_division") == 1)
	{
		level.teammmr["allies"] = 0;
		level.teammmr["axis"] = 0;
		thread onrankedmatchstart();
		thread onmatchend();
		return;
	}

	thread onnonrankedmatchstart();
}

//Function Number: 3
isvalidplayer()
{
	return !isbot(self) && !isagent(self) && !istestclient(self);
}

//Function Number: 4
onnonrankedmatchstart()
{
	level endon("game_win");
	level endon("exitLevel_called");
	foreach(var_01 in level.players)
	{
		var_01 checkforseason1start();
		var_01 clearmatchprediction();
		var_01.pers["division"]["index"] = 0;
	}

	for(;;)
	{
		level waittill("connected",var_01);
		var_01 checkforseason1start();
		var_01 clearmatchprediction();
		var_01.pers["division"]["index"] = 0;
	}
}

//Function Number: 5
onrankedmatchstart()
{
	level endon("game_win");
	level endon("exitLevel_called");
	foreach(var_01 in level.players)
	{
		var_01 thread onplayerconnect();
	}

	for(;;)
	{
		level waittill("connected",var_01);
		var_01 thread onplayerconnect();
	}
}

//Function Number: 6
onplayerconnect()
{
	level endon("game_win");
	level endon("exitLevel_called");
	if(isvalidplayer())
	{
		checkforseason1start();
		initloss();
		self method_8542(self.pers["division"]["init"]["dp"]);
	}
}

//Function Number: 7
onmatchend()
{
	level endon("exitLevel_called");
	for(;;)
	{
		level waittill("game_win",var_00);
		if(!isdefined(var_00) || var_00 != "axis" && var_00 != "allies" && var_00 != "tie")
		{
			continue;
		}

		calculateteammmrs();
		checkforfeit();
		foreach(var_02 in level.players)
		{
			if(!var_02 isvalidplayer())
			{
				continue;
			}

			var_02 calculatematchprediction();
			var_03 = var_02.pers["division"]["init"]["dp"];
			if(var_02.pers["division"]["wonByForfeit"] || var_02.team == var_00)
			{
				var_02 ondivisionwin(var_03);
			}
			else if(var_00 == "tie")
			{
				var_02 ondivisiontie(var_03);
			}
			else
			{
				var_02 ondivisionloss(var_03);
			}

			var_04 = var_02 getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"division");
			var_02 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","matchDp",var_04 - var_03 + 128);
			var_02 setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"rankedPlaylistLockTime",0);
		}

		break;
	}
}

//Function Number: 8
ondivisionwin(param_00)
{
	getdivisionpointrange(param_00);
	if(!isdefined(self.pers["division"]["minDP"]))
	{
		return;
	}

	var_01 = getdivisionpointsdelta(self.pers["division"]["matchPrediction"],"win");
	var_02 = self.pers["division"]["init"]["deltaDP"];
	setplayermmr(var_01);
	savematchprediction("win");
	self.pers["division"]["dp"] = param_00;
	if(self.pers["division"]["minDP"] == param_00)
	{
		self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionRelegationCounter",self.pers["division"]["init"]["relegation"]);
	}

	if(isdefined(self.pers["division"]["maxDP"]))
	{
		if(self.pers["division"]["maxDP"] == param_00)
		{
			if(self.pers["division"]["init"]["winBits"] > 0)
			{
				self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"division",param_00 + 1);
				self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionRelegationCounter",0);
			}
			else
			{
				self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"division",param_00);
			}

			updatedivisionchallengestatus(1);
			return;
		}

		self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"division",int(min(float(self.pers["division"]["maxDP"]),float(param_00 + var_01))));
		return;
	}

	self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"division",param_00 + var_01);
}

//Function Number: 9
ondivisionloss(param_00)
{
	getdivisionpointrange(param_00);
	if(!isdefined(self.pers["division"]["minDP"]))
	{
		return;
	}

	var_01 = getdivisionpointsdelta(self.pers["division"]["matchPrediction"],"loss");
	var_02 = self.pers["division"]["init"]["deltaDP"];
	var_03 = var_01 - var_02;
	savematchprediction("loss");
	if(var_03 == 0)
	{
		return;
	}

	setplayermmr(var_01);
	if(isdefined(self.pers["division"]["maxDP"]) && self.pers["division"]["maxDP"] == param_00)
	{
		return;
	}

	if(self.pers["division"]["minDP"] == param_00)
	{
		return;
	}

	self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"division",int(max(float(self.pers["division"]["minDP"]),float(param_00 + var_01))));
}

//Function Number: 10
ondivisiontie(param_00)
{
	getdivisionpointrange(param_00);
	if(!isdefined(self.pers["division"]["minDP"]))
	{
		return;
	}

	var_01 = getdivisionpointsdelta(self.pers["division"]["matchPrediction"],"tie");
	var_02 = self.pers["division"]["init"]["deltaDP"];
	var_03 = var_01 - var_02;
	savematchprediction("tie");
	if(var_03 == 0)
	{
		return;
	}

	setplayermmr(var_01);
	if(self.pers["division"]["minDP"] == param_00)
	{
		self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionRelegationCounter",self.pers["division"]["init"]["relegation"]);
	}

	if(isdefined(self.pers["division"]["maxDP"]))
	{
		if(self.pers["division"]["maxDP"] == param_00)
		{
			self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"division",param_00);
			self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionChallengePlayed",self.pers["division"]["init"]["playBits"]);
			self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionChallengeWon",self.pers["division"]["init"]["winBits"]);
			return;
		}
		else if(var_01 > 0)
		{
			self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"division",int(min(float(self.pers["division"]["maxDP"]),float(param_00 + var_01))));
			return;
		}
	}

	self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"division",int(max(float(self.pers["division"]["minDP"]),float(param_00 + var_01))));
}

//Function Number: 11
initloss()
{
	if(isdefined(self.pers["division"]) && isdefined(self.pers["division"]["init"]))
	{
		return;
	}

	clearmatchprediction();
	var_00 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"division");
	var_01 = int(tablelookup("mp/divisiontable.csv",0,"forfeit",1));
	getdivisionchallengestatus();
	getmmr();
	if(self.pers["division"]["wins"] >= 2 || self.pers["division"]["losses"] >= 2)
	{
		cleardivisionchallengestatus();
	}

	if(self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionRelegationCounter") >= 3)
	{
		self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionRelegationCounter",0);
	}

	self.pers["division"]["init"]["dp"] = var_00;
	self.pers["division"]["init"]["deltaDP"] = var_01;
	self.pers["division"]["init"]["relegation"] = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionRelegationCounter");
	self.pers["division"]["init"]["playBits"] = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionChallengePlayed");
	self.pers["division"]["init"]["winBits"] = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionChallengeWon");
	self.pers["division"]["init"]["MMR"] = self.pers["division"]["MMR"];
	thread updatelockouttime();
	self.pers["division"]["dp"] = var_00;
	getdivisionpointrange(var_00);
	if(!isdefined(self.pers["division"]["minDP"]))
	{
		return;
	}

	setplayermmr(var_01);
	if(isdefined(self.pers["division"]["maxDP"]) && self.pers["division"]["maxDP"] == var_00)
	{
		self.pers["division"]["losses"]++;
		if(self.pers["division"]["losses"] >= 2)
		{
			self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"division",self.pers["division"]["minDP"] + getdivisionresetoffset());
		}
		else
		{
		}

		updatedivisionchallengestatus(0);
		return;
	}

	if(self.pers["division"]["minDP"] == var_00)
	{
		if(self.pers["division"]["minDP"] > 0)
		{
			var_02 = self.pers["division"]["init"]["relegation"] + 1;
			if(var_02 >= 3)
			{
				getdivisionpointrange(var_00 - 1);
				self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"division",self.pers["division"]["minDP"] + getdivisionresetoffset());
			}
			else
			{
			}

			self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionRelegationCounter",var_02);
			return;
		}

		return;
	}

	self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"division",int(max(float(self.pers["division"]["minDP"]),float(var_01 + var_02))));
}

//Function Number: 12
updatelockouttime()
{
	level endon("exitLevel_called");
	level endon("game_win");
	self endon("disconnect");
	for(;;)
	{
		if(isremovedentity(self))
		{
			break;
		}

		self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"rankedPlaylistLockTime",gettimeutc());
		wait(10);
	}
}

//Function Number: 13
getdivisionpointrange(param_00)
{
	var_01 = tablegetrowcount("mp/divisiontable.csv");
	var_02 = tablelookuprownum("mp/divisiontable.csv",0,"bronze");
	for(var_03 = var_02;var_03 < var_01;var_03++)
	{
		var_04 = tablelookupbyrow("mp/divisiontable.csv",var_03,2);
		if(!isdefined(var_04) || var_04 == "")
		{
			self.pers["division"]["minDP"] = int(tablelookupbyrow("mp/divisiontable.csv",var_03,1));
			self.pers["division"]["maxDP"] = undefined;
			self.pers["division"]["index"] = var_03 - var_02;
			return;
		}

		var_05 = int(var_04);
		if(param_00 <= var_05)
		{
			self.pers["division"]["minDP"] = int(tablelookupbyrow("mp/divisiontable.csv",var_03,1));
			self.pers["division"]["maxDP"] = var_05;
			self.pers["division"]["index"] = var_03 - var_02;
			return;
		}
	}

	self.pers["division"]["minDP"] = undefined;
	self.pers["division"]["maxDP"] = undefined;
}

//Function Number: 14
getdivisionchallengestatus()
{
	var_00 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionChallengePlayed");
	var_01 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionChallengeWon");
	var_02 = 0;
	var_03 = 0;
	for(var_04 = 0;var_04 < 3;var_04++)
	{
		if(var_00 >> var_04 & 1)
		{
			if(var_01 >> var_04 & 1)
			{
				var_02++;
			}
			else
			{
				var_03++;
			}

			continue;
		}

		break;
	}

	self.pers["division"]["wins"] = var_02;
	self.pers["division"]["losses"] = var_03;
}

//Function Number: 15
cleardivisionchallengestatus()
{
	self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionChallengePlayed",0);
	self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionChallengeWon",0);
	self.pers["division"]["wins"] = 0;
	self.pers["division"]["losses"] = 0;
}

//Function Number: 16
updatedivisionchallengestatus(param_00)
{
	var_01 = self.pers["division"]["init"]["playBits"];
	var_02 = self.pers["division"]["init"]["winBits"];
	var_01 = var_01 << 1 | 1;
	var_02 = var_02 << 1;
	if(param_00)
	{
		var_02 = var_02 | 1;
	}

	self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionChallengePlayed",var_01);
	self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"divisionChallengeWon",var_02);
}

//Function Number: 17
getmmr()
{
	var_00 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"mmr");
	var_00 = var_00 - -32768;
	self.pers["division"]["MMR"] = var_00;
}

//Function Number: 18
savemmr()
{
	var_00 = self.pers["division"]["MMR"] + -32768;
	self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"mmr",var_00);
}

//Function Number: 19
savematchprediction(param_00)
{
	var_01 = 8;
	var_02 = self.pers["division"]["matchPrediction"];
	if(var_02 == "win")
	{
		var_01 = var_01 | 1;
	}
	else if(var_02 == "loss")
	{
		var_01 = var_01 | 2;
	}

	if(param_00 == "win")
	{
		var_01 = var_01 | 16;
	}
	else if(param_00 == "loss")
	{
		var_01 = var_01 | 32;
	}

	self setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","matchPrediction",var_01);
}

//Function Number: 20
clearmatchprediction()
{
	if(!isvalidplayer())
	{
		return;
	}

	self setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","matchPrediction",0);
}

//Function Number: 21
calculateteammmrs()
{
	var_00["axis"] = 0;
	var_00["allies"] = 0;
	level.teammmr["axis"] = 0;
	level.teammmr["allies"] = 0;
	foreach(var_02 in level.players)
	{
		if(!var_02 isvalidplayer())
		{
			continue;
		}

		if(!isdefined(var_02.team) || var_02.team != "allies" && var_02.team != "axis")
		{
			continue;
		}

		if(!isdefined(var_02.pers["division"]["init"]["MMR"]))
		{
			continue;
		}

		var_00[var_02.team]++;
		level.teammmr[var_02.team] = level.teammmr[var_02.team] + var_02.pers["division"]["init"]["MMR"];
	}

	if(var_00["axis"] > 0)
	{
		level.teammmr["axis"] = level.teammmr["axis"] / var_00["axis"];
	}

	if(var_00["allies"] > 0)
	{
		level.teammmr["allies"] = level.teammmr["allies"] / var_00["allies"];
	}
}

//Function Number: 22
calculatematchprediction()
{
	if(!isdefined(self.pers["division"]["init"]["MMR"]))
	{
		return;
	}

	var_00 = self.pers["division"]["init"]["MMR"];
	var_01 = var_00;
	self.pers["division"]["matchPrediction"] = "tie";
	if(!isdefined(self.team))
	{
		return;
	}
	else if(self.team == "axis")
	{
		var_01 = level.teammmr["allies"];
	}
	else if(self.team == "allies")
	{
		var_01 = level.teammmr["axis"];
	}
	else
	{
		return;
	}

	if(var_00 < var_01 - 25)
	{
		self.pers["division"]["matchPrediction"] = "loss";
	}

	if(var_00 > var_01 + 25)
	{
		self.pers["division"]["matchPrediction"] = "win";
	}
}

//Function Number: 23
getdivisionpointsdelta(param_00,param_01)
{
	var_02 = tablelookuprownum("mp/divisiontable.csv",0,param_00);
	if(param_01 == "win")
	{
		return int(tablelookupbyrow("mp/divisiontable.csv",var_02,1));
	}

	if(param_01 == "loss")
	{
		return int(tablelookupbyrow("mp/divisiontable.csv",var_02,3));
	}

	return int(tablelookupbyrow("mp/divisiontable.csv",var_02,2));
}

//Function Number: 24
getdivisionresetoffset()
{
	return int(tablelookup("mp/divisiontable.csv",0,"resetOffset",1));
}

//Function Number: 25
setplayermmr(param_00)
{
	if(!isdefined(self.pers["division"]["init"]["MMR"]))
	{
		return;
	}

	var_01 = self.pers["division"]["init"]["MMR"];
	if(param_00 < 0 && var_01 < 0 - param_00)
	{
		param_00 = 0 - var_01;
	}

	if(65535 - var_01 < param_00)
	{
		param_00 = 65535 - var_01;
	}

	var_01 = var_01 + param_00;
	self.pers["division"]["MMR"] = var_01;
	savemmr();
}

//Function Number: 26
checkforfeit()
{
	var_00["allies"] = 0;
	var_00["axis"] = 0;
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02.team) && isdefined(var_00[var_02.team]))
		{
			var_00[var_02.team]++;
		}
	}

	foreach(var_02 in level.players)
	{
		if(isdefined(var_02.team))
		{
			if(var_02.team == "allies" && var_00["axis"] == 0)
			{
				var_02.pers["division"]["wonByForfeit"] = 1;
				continue;
			}

			if(var_02.team == "axis" && var_00["allies"] == 0)
			{
				var_02.pers["division"]["wonByForfeit"] = 1;
				continue;
			}

			var_02.pers["division"]["wonByForfeit"] = 0;
		}
	}
}