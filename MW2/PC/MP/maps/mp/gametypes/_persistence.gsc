/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_persistence.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

init()
{
	level.persistentdatainfo = [];
	maps\mp\gametypes\_class::init();
	maps\mp\gametypes\_rank::init();
	maps\mp\gametypes\_missions::init();
	maps\mp\gametypes\_playercards::init();
	level thread updatebufferedstats();
}

initbufferedstats()
{
	self.bufferedstats = [];
	self.bufferedstats["totalShots"] = self getplayerdata("totalShots");
	self.bufferedstats["accuracy"] = self getplayerdata("accuracy");
	self.bufferedstats["misses"] = self getplayerdata("misses");
	self.bufferedstats["hits"] = self getplayerdata("hits");
	self.bufferedstats["timePlayedAllies"] = self getplayerdata("timePlayedAllies");
	self.bufferedstats["timePlayedOpfor"] = self getplayerdata("timePlayedOpfor");
	self.bufferedstats["timePlayedOther"] = self getplayerdata("timePlayedOther");
	self.bufferedstats["timePlayedTotal"] = self getplayerdata("timePlayedTotal");
	self.bufferedchildstats = [];
	self.bufferedchildstats["round"] = [];
	self.bufferedchildstats["round"]["timePlayed"] = self getplayerdata("round", "timePlayed");
}

statget(dataname)
{
	return self getplayerdata(dataname);
}

statset(dataname, value)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	self setplayerdata(dataname, value);
}

statadd(dataname, value)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	curvalue = self getplayerdata(dataname);
	self setplayerdata(dataname, value + curvalue);
}

statgetchild(parent, child)
{
	return self getplayerdata(parent, child);
}

statsetchild(parent, child, value)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	self setplayerdata(parent, child, value);
}

stataddchild(parent, child, value)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	curvalue = self getplayerdata(parent, child);
	self setplayerdata(parent, child, curvalue + value);
}

statgetchildbuffered(parent, child)
{
	return self.bufferedchildstats[parent][child];
}

statsetchildbuffered(parent, child, value)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	self.bufferedchildstats[parent][child] = value;
}

stataddchildbuffered(parent, child, value)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	curvalue = statgetchildbuffered(parent, child);
	statsetchildbuffered(parent, child, curvalue + value);
}

statgetbuffered(dataname)
{
	return self.bufferedstats[dataname];
}

statsetbuffered(dataname, value)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	self.bufferedstats[dataname] = value;
}

stataddbuffered(dataname, value)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	curvalue = statgetbuffered(dataname);
	statsetbuffered(dataname, curvalue + value);
}

updatebufferedstats()
{
	wait 0.15;
	nexttoupdate = 0;
	while(!level.gameended)
	{
		nexttoupdate++;
		if(nexttoupdate >= level.players.size)
		{
			nexttoupdate = 0;
		}

		if(isdefined(level.players[nexttoupdate]))
		{
			level.players[nexttoupdate] writebufferedstats();
		}

		wait 2;
	}

	foreach(player in level.players)
	{
		player writebufferedstats();
	}
}

writebufferedstats()
{
	foreach(statname, statval in self.bufferedstats)
	{
		self setplayerdata(statname, statval);
	}

	foreach(statname, statval in self.bufferedchildstats)
	{
		foreach(childstatname, childstatval in statval)
		{
			self setplayerdata(statname, childstatname, childstatval);
		}
	}
}