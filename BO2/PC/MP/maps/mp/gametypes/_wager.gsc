/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_wager.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 39
 * Decompile Time: 69 ms
 * Timestamp: 10/27/2023 3:00:16 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/gametypes/_class;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_globallogic_audio;
#include maps/mp/gametypes/_globallogic_score;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_persistence;
#include maps/mp/gametypes/_rank;
#include maps/mp/killstreaks/_killstreaks;
#include maps/mp/teams/_teams;

//Function Number: 1
init()
{
	precachestring(&"MP_HEADS_UP");
	precachestring(&"MP_U2_ONLINE");
	precachestring(&"MP_BONUS_ACQUIRED");
	if(gamemodeismode(level.gamemode_wager_match) && !ispregame())
	{
		level.wagermatch = 1;
		if(!(IsDefined(game["wager_pot"])))
		{
			game["wager_pot"] = 0;
			game["wager_initial_pot"] = 0;
		}

		game["dialog"]["wm_u2_online"] = "boost_gen_02";
		game["dialog"]["wm_in_the_money"] = "boost_gen_06";
		game["dialog"]["wm_oot_money"] = "boost_gen_07";
		level.poweruplist = [];
		level thread onplayerconnect();
		level thread helpgameend();
	}
	else
	{
		level.wagermatch = 0;
	}

	level.takelivesondeath = 1;
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",player);
		player thread ondisconnect();
		player thread initwagerplayer();
	}
}

//Function Number: 3
initwagerplayer()
{
	self endon("disconnect");
	self waittill("spawned_player");
	if(!(IsDefined(self.pers["wager"])))
	{
		self.pers["wager"] = 1;
		self.pers["wager_sideBetWinnings"] = 0;
		self.pers["wager_sideBetLosses"] = 0;
	}

	if((IsDefined(level.inthemoneyonradar) && level.inthemoneyonradar) || IsDefined(level.firstplaceonradar) && level.firstplaceonradar)
	{
		self.pers["hasRadar"] = 1;
		self.hasspyplane = 1;
	}
	else
	{
		self.pers["hasRadar"] = 0;
		self.hasspyplane = 0;
	}

	self thread deductplayerante();
}

//Function Number: 4
ondisconnect()
{
	level endon("game_ended");
	self endon("player_eliminated");
	self waittill("disconnect");
	level notify("player_eliminated");
}

//Function Number: 5
deductplayerante()
{
	if(IsDefined(self.pers["hasPaidWagerAnte"]))
	{
		return;
	}

	waittillframeend;
	codpoints = self maps/mp/gametypes/_rank::getcodpointsstat();
	wagerbet = GetDvarInt(#"E4C48E3D");
	if(wagerbet > codpoints)
	{
		wagerbet = codpoints;
	}

	codpoints = codpoints - wagerbet;
	self maps/mp/gametypes/_rank::setcodpointsstat(codpoints);
	if(!(self islocaltohost()))
	{
		self incrementescrowforplayer(wagerbet);
	}

	game["wager_pot"] = game["wager_pot"] + wagerbet;
	game["wager_initial_pot"] = game["wager_initial_pot"] + wagerbet;
	self.pers["hasPaidWagerAnte"] = 1;
	self addplayerstat("LIFETIME_BUYIN",wagerbet);
	self addrecentearningstostat(0 - wagerbet);
	if(IsDefined(level.onwagerplayerante))
	{
		[[ level.onwagerplayerante ]](self,wagerbet);
	}

	self thread maps/mp/gametypes/_persistence::uploadstatssoon();
}

//Function Number: 6
incrementescrowforplayer(amount)
{
	if(!IsDefined(self) || !isplayer(self))
	{
		return;
	}

	if(!(IsDefined(game["escrows"])))
	{
		game["escrows"] = [];
	}

	playerxuid = self getxuid();
	if(!(IsDefined(playerxuid)))
	{
		return;
	}

	escrowstruct = spawnstruct();
	escrowstruct.xuid = playerxuid;
	escrowstruct.amount = amount;
	game["escrows"][game["escrows"].size] = escrowstruct;
}

//Function Number: 7
clearescrows()
{
	if(!(IsDefined(game["escrows"])))
	{
		return;
	}

	escrows = game["escrows"];
	numescrows = escrows.size;
	for(i = 0;i < numescrows;i++)
	{
		escrowstruct = escrows[i];
	}

	game["escrows"] = [];
}

//Function Number: 8
addrecentearningstostat(recentearnings)
{
	currearnings = self maps/mp/gametypes/_persistence::getrecentstat(1,0,"score");
	self maps/mp/gametypes/_persistence::setrecentstat(1,0,"score",currearnings + recentearnings);
}

//Function Number: 9
prematchperiod()
{
	if(!(level.wagermatch))
	{
	}

//Function Number: 10
finalizewagerround()
{
	if(level.wagermatch == 0)
	{
		return;
	}

	determinewagerwinnings();
	if(IsDefined(level.onwagerfinalizeround))
	{
		[[ level.onwagerfinalizeround ]]();
	}
}

//Function Number: 11
determinewagerwinnings()
{
	shouldcalculatewinnings = !IsDefined(level.dontcalcwagerwinnings) || !level.dontcalcwagerwinnings;
	if(!(shouldcalculatewinnings))
	{
		return;
	}

	if(!(level.teambased))
	{
		calculatefreeforallpayouts();
	}
	else
	{
		calculateteampayouts();
	}
}

//Function Number: 12
calculatefreeforallpayouts()
{
	playerrankings = level.placement["all"];
	payoutpercentages = array(0.5,0.3,0.2);
	if(playerrankings.size == 2)
	{
		payoutpercentages = array(0.7,0.3);
	}
	else if(playerrankings.size == 1)
	{
		payoutpercentages = array(1);
	}

	setwagerwinningsonplayers(level.players,0);
	if(IsDefined(level.hostforcedend) && level.hostforcedend)
	{
		wagerbet = GetDvarInt(#"E4C48E3D");
		for(i = 0;i < playerrankings.size;i++)
		{
			if(!(playerrankings[i] islocaltohost()))
			{
				playerrankings[i].wagerwinnings = wagerbet;
			}
		}
	}
	else if(level.players.size == 1)
	{
		game["escrows"] = undefined;
		return;
	}
	else
	{
		currentpayoutpercentage = 0;
		cumulativepayoutpercentage = payoutpercentages[0];
		playergroup = [];
		playergroup[playergroup.size] = playerrankings[0];
		for(i = 1;i < playerrankings.size;i++)
		{
			if(playerrankings[i].pers["score"] < playergroup[0].pers["score"])
			{
				setwagerwinningsonplayers(playergroup,int(game["wager_pot"] * cumulativepayoutpercentage / playergroup.size));
				playergroup = [];
				cumulativepayoutpercentage = 0;
			}

			playergroup[playergroup.size] = playerrankings[i];
			currentpayoutpercentage++;
			if(IsDefined(payoutpercentages[currentpayoutpercentage]))
			{
				cumulativepayoutpercentage = cumulativepayoutpercentage + payoutpercentages[currentpayoutpercentage];
			}
		}

		setwagerwinningsonplayers(playergroup,int(game["wager_pot"] * cumulativepayoutpercentage / playergroup.size));
	}
}

//Function Number: 13
calculateplacesbasedonscore()
{
	level.playerplaces = array([],[],[]);
	playerrankings = level.placement["all"];
	placementscores = array(playerrankings[0].pers["score"],-1,-1);
	currentplace = 0;
	for(index = 0;index < playerrankings.size && currentplace < placementscores.size;index++)
	{
		player = playerrankings[index];
		if(player.pers["score"] < placementscores[currentplace])
		{
			currentplace++;
			if(currentplace >= level.playerplaces.size)
			{
				break;
			}

			placementscores[currentplace] = player.pers["score"];
		}

		level.playerplaces[currentplace][level.playerplaces[currentplace].size] = player;
	}
}

//Function Number: 14
calculateteampayouts()
{
	winner = maps/mp/gametypes/_globallogic::determineteamwinnerbygamestat("teamScores");
	if(winner == "tie")
	{
		calculatefreeforallpayouts();
		return;
	}

	playersonwinningteam = [];
	for(index = 0;index < level.players.size;index++)
	{
		player = level.players[index];
		player.wagerwinnings = 0;
		if(player.pers["team"] == winner)
		{
			playersonwinningteam[playersonwinningteam.size] = player;
		}
	}

	if(playersonwinningteam.size == 0)
	{
		setwagerwinningsonplayers(level.players,GetDvarInt(#"E4C48E3D"));
		return;
	}

	winningssplit = int(game["wager_pot"] / playersonwinningteam.size);
	setwagerwinningsonplayers(playersonwinningteam,winningssplit);
}

//Function Number: 15
setwagerwinningsonplayers(players,amount)
{
	for(index = 0;index < players.size;index++)
	{
		players[index].wagerwinnings = amount;
	}
}

//Function Number: 16
finalizewagergame()
{
	level.wagergamefinalized = 1;
	if(level.wagermatch == 0)
	{
		return;
	}

	determinewagerwinnings();
	determinetopearners();
	players = level.players;
	wait(0.5);
	playerrankings = level.wagertopearners;
	for(index = 0;index < players.size;index++)
	{
		player = players[index];
		if(IsDefined(player.pers["wager_sideBetWinnings"]))
		{
			payoutwagerwinnings(player,player.wagerwinnings + player.pers["wager_sideBetWinnings"]);
		}
		else
		{
			payoutwagerwinnings(player,player.wagerwinnings);
		}

		if(player.wagerwinnings > 0)
		{
			maps/mp/gametypes/_globallogic_score::updatewinstats(player);
		}
	}

	clearescrows();
}

//Function Number: 17
payoutwagerwinnings(player,winnings)
{
	if(winnings == 0)
	{
		return;
	}

	codpoints = player maps/mp/gametypes/_rank::getcodpointsstat();
	player maps/mp/gametypes/_rank::setcodpointsstat(codpoints + winnings);
	player addplayerstat("LIFETIME_EARNINGS",winnings);
	player addrecentearningstostat(winnings);
}

//Function Number: 18
determinetopearners()
{
	topwinnings = array(-1,-1,-1);
	level.wagertopearners = [];
	for(index = 0;index < level.players.size;index++)
	{
		player = level.players[index];
		if(!(IsDefined(player.wagerwinnings)))
		{
			player.wagerwinnings = 0;
		}

		if(player.wagerwinnings > topwinnings[0])
		{
			topwinnings[2] = topwinnings[1];
			topwinnings[1] = topwinnings[0];
			topwinnings[0] = player.wagerwinnings;
			level.wagertopearners[2] = level.wagertopearners[1];
			level.wagertopearners[1] = level.wagertopearners[0];
			level.wagertopearners[0] = player;
		}
		else if(player.wagerwinnings > topwinnings[1])
		{
			topwinnings[2] = topwinnings[1];
			topwinnings[1] = player.wagerwinnings;
			level.wagertopearners[2] = level.wagertopearners[1];
			level.wagertopearners[1] = player;
		}
		else if(player.wagerwinnings > topwinnings[2])
		{
			topwinnings[2] = player.wagerwinnings;
			level.wagertopearners[2] = player;
		}
	}
}

//Function Number: 19
postroundsidebet()
{
	if(IsDefined(level.sidebet) && level.sidebet)
	{
		level notify("side_bet_begin");
		level waittill("side_bet_end");
	}
}

//Function Number: 20
sidebettimer()
{
	level endon("side_bet_end");
	secondstowait = level.sidebetendtime - GetTime() / 1000;
	if(secondstowait < 0)
	{
		secondstowait = 0;
	}

	wait(secondstowait);
	for(playerindex = 0;playerindex < level.players.size;playerindex++)
	{
		if(IsDefined(level.players[playerindex]))
		{
			level.players[playerindex] closemenu();
		}
	}

	level notify("side_bet_end");
}

//Function Number: 21
sidebetallbetsplaced()
{
	secondsleft = level.sidebetendtime - GetTime() / 1000;
	if(secondsleft <= 3)
	{
		return;
	}

	level.sidebetendtime = GetTime() + 3000;
	wait(3);
	for(playerindex = 0;playerindex < level.players.size;playerindex++)
	{
		if(IsDefined(level.players[playerindex]))
		{
			level.players[playerindex] closemenu();
		}
	}

	level notify("side_bet_end");
}

//Function Number: 22
setupblankrandomplayer(takeweapons,chooserandombody,weapon)
{
	if(!IsDefined(chooserandombody) || chooserandombody)
	{
		if(!(IsDefined(self.pers["wagerBodyAssigned"])))
		{
			self assignrandombody();
			self.pers["wagerBodyAssigned"] = 1;
		}

		self maps/mp/teams/_teams::set_player_model(self.team,weapon);
	}

	self clearperks();
	self.killstreak = [];
	self.pers["killstreaks"] = [];
	self.pers["killstreak_has_been_used"] = [];
	self.pers["killstreak_unique_id"] = [];
	if(!IsDefined(takeweapons) || takeweapons)
	{
		self takeallweapons();
	}

	if(IsDefined(self.pers["hasRadar"]) && self.pers["hasRadar"])
	{
		self.hasspyplane = 1;
	}

	if(IsDefined(self.powerups) && IsDefined(self.powerups.size))
	{
		for(i = 0;i < self.powerups.size;i++)
		{
			self applypowerup(self.powerups[i]);
		}
	}

	self setradarvisibility();
}

//Function Number: 23
assignrandombody()
{
}

//Function Number: 24
queuewagerpopup(message,points,submessage,announcement)
{
	self endon("disconnect");
	size = self.wagernotifyqueue.size;
	self.wagernotifyqueue[size] = spawnstruct();
	self.wagernotifyqueue[size].message = message;
	self.wagernotifyqueue[size].points = points;
	self.wagernotifyqueue[size].submessage = submessage;
	self.wagernotifyqueue[size].announcement = announcement;
	self notify("received award");
}

//Function Number: 25
helpgameend()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("player_eliminated");
		if(!IsDefined(level.numlives) || !level.numlives)
		{
			continue;
		}

		wait(0.05);
		players = level.players;
		playersleft = 0;
		for(i = 0;i < players.size;i++)
		{
			if(IsDefined(players[i].pers["lives"]) && players[i].pers["lives"] > 0)
			{
				playersleft++;
			}
		}

		if(playersleft == 2)
		{
			for(i = 0;i < players.size;i++)
			{
				players[i] queuewagerpopup(&"MP_HEADS_UP",0,&"MP_U2_ONLINE","wm_u2_online");
				players[i].pers["hasRadar"] = 1;
				players[i].hasspyplane = 1;
				level.activeuavs[players[i] getentitynumber()]++;
			}
		}
	}
}

//Function Number: 26
setradarvisibility()
{
	prevscoreplace = self.prevscoreplace;
	if(!(IsDefined(prevscoreplace)))
	{
		prevscoreplace = 1;
	}

	if(IsDefined(level.inthemoneyonradar) && level.inthemoneyonradar)
	{
		if(prevscoreplace <= 3 && IsDefined(self.score) && self.score > 0)
		{
			self unsetperk("specialty_gpsjammer");
		}
		else
		{
			self setperk("specialty_gpsjammer");
		}
	}
	else if(IsDefined(level.firstplaceonradar) && level.firstplaceonradar)
	{
		if(prevscoreplace == 1 && IsDefined(self.score) && self.score > 0)
		{
			self unsetperk("specialty_gpsjammer");
		}
		else
		{
			self setperk("specialty_gpsjammer");
		}
	}
}

//Function Number: 27
playerscored()
{
	self notify("wager_player_scored");
	self endon("wager_player_scored");
	wait(0.05);
	maps/mp/gametypes/_globallogic::updateplacement();
	for(i = 0;i < level.placement["all"].size;i++)
	{
		prevscoreplace = level.placement["all"][i].prevscoreplace;
		if(!(IsDefined(prevscoreplace)))
		{
			prevscoreplace = 1;
		}

		currentscoreplace = i + 1;
		for(j = i - 1;j >= 0;j--)
		{
			if(level.placement["all"][i].score == level.placement["all"][j].score)
			{
				currentscoreplace--;
			}
		}

		wasinthemoney = prevscoreplace <= 3;
		isinthemoney = currentscoreplace <= 3;
		if(!wasinthemoney && isinthemoney)
		{
			level.placement["all"][i] wagerannouncer("wm_in_the_money");
		}
		else if(wasinthemoney && !isinthemoney)
		{
			level.placement["all"][i] wagerannouncer("wm_oot_money");
		}

		level.placement["all"][i].prevscoreplace = currentscoreplace;
		level.placement["all"][i] setradarvisibility();
	}
}

//Function Number: 28
wagerannouncer(dialog,group)
{
	self maps/mp/gametypes/_globallogic_audio::leaderdialogonplayer(dialog,group);
}

//Function Number: 29
createpowerup(name,type,displayname,iconmaterial)
{
	powerup = spawnstruct();
	powerup.name = [];
	powerup.name[0] = name;
	powerup.type = type;
	powerup.displayname = displayname;
	powerup.iconmaterial = iconmaterial;
	return powerup;
}

//Function Number: 30
addpowerup(name,type,displayname,iconmaterial)
{
	if(!(IsDefined(level.poweruplist)))
	{
		level.poweruplist = [];
	}

	for(i = 0;i < level.poweruplist.size;i++)
	{
		if(level.poweruplist[i].displayname == displayname)
		{
			level.poweruplist[i].name[level.poweruplist[i].name.size] = name;
			return;
		}
	}

	powerup = createpowerup(name,type,displayname,iconmaterial);
	level.poweruplist[level.poweruplist.size] = powerup;
}

//Function Number: 31
copypowerup(powerup)
{
	return createpowerup(powerup.name[0],powerup.type,powerup.displayname,powerup.iconmaterial);
}

//Function Number: 32
applypowerup(powerup)
{
	switch(powerup.type)
	{
		case "primary":
			self giveweapon(powerup.name[0]);
			self switchtoweapon(powerup.name[0]);
			break;

		case "secondary":
			self giveweapon(powerup.name[0]);
			break;

		case "equipment":
			self giveweapon(powerup.name[0]);
			self maps/mp/gametypes/_class::setweaponammooverall(powerup.name[0],1);
			self setactionslot(1,"weapon",powerup.name[0]);
			break;

		case "primary_grenade":
			self setoffhandprimaryclass(powerup.name[0]);
			self giveweapon(powerup.name[0]);
			self setweaponammoclip(powerup.name[0],2);
			break;

		case "secondary_grenade":
			self setoffhandsecondaryclass(powerup.name[0]);
			self giveweapon(powerup.name[0]);
			self setweaponammoclip(powerup.name[0],2);
			break;

		case "perk":
			i = 0;
			for(;;)
			{
				self setperk(powerup.name[i]);
				i++;
			}
	
			break;
	i < powerup.name.size
			break;

		case "killstreak":
			self maps/mp/killstreaks/_killstreaks::givekillstreak(powerup.name[0]);
			break;

		case "score_multiplier":
			self.scoremultiplier = powerup.name[0];
			break;
	}
}

//Function Number: 33
givepowerup(powerup,doanimation)
{
	if(!(IsDefined(self.powerups)))
	{
		self.powerups = [];
	}

	powerupindex = self.powerups.size;
	self.powerups[powerupindex] = copypowerup(powerup);
	for(i = 0;i < powerup.name.size;i++)
	{
		self.powerups[powerupindex].name[self.powerups[powerupindex].name.size] = powerup.name[i];
	}

	self applypowerup(self.powerups[powerupindex]);
	self thread showpowerupmessage(powerupindex,doanimation);
}

//Function Number: 34
pulsepowerupicon(powerupindex)
{
	if(!IsDefined(self) || !IsDefined(self.powerups) || !IsDefined(self.powerups[powerupindex]) || !IsDefined(self.powerups[powerupindex].hud_elem_icon))
	{
		return;
	}

	self endon("disconnect");
	self endon("delete");
	self endon("clearing_powerups");
	pulsepercent = 1.5;
	pulsetime = 0.5;
	hud_elem = self.powerups[powerupindex].hud_elem_icon;
	if(IsDefined(hud_elem.animating) && hud_elem.animating)
	{
		return;
	}

	origx = hud_elem.x;
	origy = hud_elem.y;
	origwidth = hud_elem.width;
	origheight = hud_elem.height;
	bigwidth = origwidth * pulsepercent;
	bigheight = origheight * pulsepercent;
	xoffset = bigwidth - origwidth / 2;
	yoffset = bigheight - origheight / 2;
	hud_elem scaleovertime(0.05,int(bigwidth),int(bigheight));
	hud_elem moveovertime(0.05);
	hud_elem.x = origx - xoffset;
	hud_elem.y = origy - yoffset;
	wait(0.05);
	hud_elem scaleovertime(pulsetime,origwidth,origheight);
	hud_elem moveovertime(pulsetime);
	hud_elem.x = origx;
	hud_elem.y = origy;
}

//Function Number: 35
showpowerupmessage(powerupindex,doanimation)
{
	self endon("disconnect");
	self endon("delete");
	self endon("clearing_powerups");
	if(!(IsDefined(doanimation)))
	{
		doanimation = 1;
	}

	wasinprematch = level.inprematchperiod;
	powerupstarty = 320;
	powerupspacing = 40;
	if(self issplitscreen())
	{
		powerupstarty = 120;
		powerupspacing = 35;
	}

	if(IsDefined(self.powerups[powerupindex].hud_elem))
	{
		self.powerups[powerupindex].hud_elem destroy();
	}

	self.powerups[powerupindex].hud_elem = newclienthudelem(self);
	self.powerups[powerupindex].hud_elem.fontscale = 1.5;
	self.powerups[powerupindex].hud_elem.x = -125;
	self.powerups[powerupindex].hud_elem.y = powerupstarty - powerupspacing * powerupindex;
	self.powerups[powerupindex].hud_elem.alignx = "left";
	self.powerups[powerupindex].hud_elem.aligny = "middle";
	self.powerups[powerupindex].hud_elem.horzalign = "user_right";
	self.powerups[powerupindex].hud_elem.vertalign = "user_top";
	self.powerups[powerupindex].hud_elem.color = (1,1,1);
	self.powerups[powerupindex].hud_elem.foreground = 1;
	self.powerups[powerupindex].hud_elem.hidewhendead = 0;
	self.powerups[powerupindex].hud_elem.hidewheninmenu = 1;
	self.powerups[powerupindex].hud_elem.hidewheninkillcam = 1;
	self.powerups[powerupindex].hud_elem.archived = 0;
	self.powerups[powerupindex].hud_elem.alpha = 0;
	self.powerups[powerupindex].hud_elem settext(self.powerups[powerupindex].displayname);
	bigiconsize = 40;
	iconsize = 32;
	if(IsDefined(self.powerups[powerupindex].hud_elem_icon))
	{
		self.powerups[powerupindex].hud_elem_icon destroy();
	}

	if(doanimation)
	{
		self.powerups[powerupindex].hud_elem_icon = self createicon(self.powerups[powerupindex].iconmaterial,bigiconsize,bigiconsize);
		self.powerups[powerupindex].hud_elem_icon.animating = 1;
	}
	else
	{
		self.powerups[powerupindex].hud_elem_icon = self createicon(self.powerups[powerupindex].iconmaterial,iconsize,iconsize);
	}

	self.powerups[powerupindex].hud_elem_icon.x = self.powerups[powerupindex].hud_elem.x - 5 - iconsize / 2 - bigiconsize / 2;
	self.powerups[powerupindex].hud_elem_icon.y = powerupstarty - powerupspacing * powerupindex - bigiconsize / 2;
	self.powerups[powerupindex].hud_elem_icon.horzalign = "user_right";
	self.powerups[powerupindex].hud_elem_icon.vertalign = "user_top";
	self.powerups[powerupindex].hud_elem_icon.color = (1,1,1);
	self.powerups[powerupindex].hud_elem_icon.foreground = 1;
	self.powerups[powerupindex].hud_elem_icon.hidewhendead = 0;
	self.powerups[powerupindex].hud_elem_icon.hidewheninmenu = 1;
	self.powerups[powerupindex].hud_elem_icon.hidewheninkillcam = 1;
	self.powerups[powerupindex].hud_elem_icon.archived = 0;
	self.powerups[powerupindex].hud_elem_icon.alpha = 1;
	if(!wasinprematch && doanimation)
	{
		self thread queuewagerpopup(self.powerups[powerupindex].displayname,0,&"MP_BONUS_ACQUIRED");
	}

	pulsetime = 0.5;
	if(doanimation)
	{
		self.powerups[powerupindex].hud_elem fadeovertime(pulsetime);
		self.powerups[powerupindex].hud_elem_icon scaleovertime(pulsetime,iconsize,iconsize);
		self.powerups[powerupindex].hud_elem_icon.width = iconsize;
		self.powerups[powerupindex].hud_elem_icon.height = iconsize;
		self.powerups[powerupindex].hud_elem_icon moveovertime(pulsetime);
	}

	self.powerups[powerupindex].hud_elem.alpha = 1;
	self.powerups[powerupindex].hud_elem_icon.x = self.powerups[powerupindex].hud_elem.x - 5 - iconsize;
	self.powerups[powerupindex].hud_elem_icon.y = powerupstarty - powerupspacing * powerupindex - iconsize / 2;
	if(doanimation)
	{
		wait(pulsetime);
	}

	if(level.inprematchperiod)
	{
		level waittill("prematch_over");
	}
	else if(doanimation)
	{
		wait(pulsetime);
	}

	if(wasinprematch && doanimation)
	{
		self thread queuewagerpopup(self.powerups[powerupindex].displayname,0,&"MP_BONUS_ACQUIRED");
	}

	wait(1.5);
	for(i = 0;i <= powerupindex;i++)
	{
		self.powerups[i].hud_elem fadeovertime(0.25);
		self.powerups[i].hud_elem.alpha = 0;
	}

	wait(0.25);
	for(i = 0;i <= powerupindex;i++)
	{
		self.powerups[i].hud_elem_icon moveovertime(0.25);
		self.powerups[i].hud_elem_icon.x = 0 - iconsize;
		self.powerups[i].hud_elem_icon.horzalign = "user_right";
	}

	self.powerups[powerupindex].hud_elem_icon.animating = 0;
}

//Function Number: 36
clearpowerups()
{
	self notify("clearing_powerups");
	if(IsDefined(self.powerups) && IsDefined(self.powerups.size))
	{
		for(i = 0;i < self.powerups.size;i++)
		{
			if(IsDefined(self.powerups[i].hud_elem))
			{
				self.powerups[i].hud_elem destroy();
			}

			if(IsDefined(self.powerups[i].hud_elem_icon))
			{
				self.powerups[i].hud_elem_icon destroy();
			}
		}
	}

	self.powerups = [];
}

//Function Number: 37
trackwagerweaponusage(name,incvalue,statname)
{
	if(!(IsDefined(self.wagerweaponusage)))
	{
		self.wagerweaponusage = [];
	}

	if(!(IsDefined(self.wagerweaponusage[name])))
	{
		self.wagerweaponusage[name] = [];
	}

	if(!(IsDefined(self.wagerweaponusage[name][statname])))
	{
		self.wagerweaponusage[name][statname] = 0;
	}

	self.wagerweaponusage[name][statname] = self.wagerweaponusage[name][statname] + incvalue;
}

//Function Number: 38
gethighestwagerweaponusage(statname)
{
	if(!(IsDefined(self.wagerweaponusage)))
	{
		return undefined;
	}

	bestweapon = undefined;
	highestvalue = 0;
	wagerweaponsused = getarraykeys(self.wagerweaponusage);
	for(i = 0;i < wagerweaponsused.size;i++)
	{
		weaponstats = self.wagerweaponusage[wagerweaponsused[i]];
		if(!IsDefined(weaponstats[statname]) || !getbaseweaponitemindex(wagerweaponsused[i]))
		{
		}
		else if(!IsDefined(bestweapon) || weaponstats[statname] > highestvalue)
		{
			bestweapon = wagerweaponsused[i];
			highestvalue = weaponstats[statname];
		}
	}

	return bestweapon;
}

//Function Number: 39
setwagerafteractionreportstats()
{
	topweapon = self gethighestwagerweaponusage("kills");
	topkills = 0;
	if(IsDefined(topweapon))
	{
		topkills = self.wagerweaponusage[topweapon]["kills"];
	}
	else
	{
		topweapon = self gethighestwagerweaponusage("timeUsed");
	}

	if(!(IsDefined(topweapon)))
	{
		topweapon = "";
	}

	self maps/mp/gametypes/_persistence::setafteractionreportstat("topWeaponItemIndex",getbaseweaponitemindex(topweapon));
	self maps/mp/gametypes/_persistence::setafteractionreportstat("topWeaponKills",topkills);
	if(IsDefined(level.onwagerawards))
	{
		self [[ level.onwagerawards ]]();
	}
	else
	{
		for(i = 0;i < 3;i++)
		{
			self maps/mp/gametypes/_persistence::setafteractionreportstat("wagerAwards",0,i);
		}
	}
}