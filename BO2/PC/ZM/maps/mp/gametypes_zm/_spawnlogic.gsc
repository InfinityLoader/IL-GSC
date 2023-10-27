/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes_zm\_spawnlogic.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 64
 * Decompile Time: 260 ms
 * Timestamp: 10/27/2023 3:02:44 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/gametypes_zm/_callbacksetup;
#include maps/mp/gametypes_zm/_gameobjects;
#include maps/mp/gametypes_zm/_spawnlogic;

//Function Number: 1
onplayerconnect()
{
	level waittill("connected",player);
}

//Function Number: 2
findboxcenter(mins,maxs)
{
	center = (0,0,0);
	center = maxs - mins;
	center = (center[0] / 2,center[1] / 2,center[2] / 2) + mins;
	return center;
}

//Function Number: 3
expandmins(mins,point)
{
	if(mins[0] > point[0])
	{
		mins = (point[0],mins[1],mins[2]);
	}

	if(mins[1] > point[1])
	{
		mins = (mins[0],point[1],mins[2]);
	}

	if(mins[2] > point[2])
	{
		mins = (mins[0],mins[1],point[2]);
	}

	return mins;
}

//Function Number: 4
expandmaxs(maxs,point)
{
	if(maxs[0] < point[0])
	{
		maxs = (point[0],maxs[1],maxs[2]);
	}

	if(maxs[1] < point[1])
	{
		maxs = (maxs[0],point[1],maxs[2]);
	}

	if(maxs[2] < point[2])
	{
		maxs = (maxs[0],maxs[1],point[2]);
	}

	return maxs;
}

//Function Number: 5
addspawnpointsinternal(team,spawnpointname)
{
	oldspawnpoints = [];
	if(level.teamspawnpoints[team].size)
	{
		oldspawnpoints = level.teamspawnpoints[team];
	}

	level.teamspawnpoints[team] = getspawnpointarray(spawnpointname);
	if(!(IsDefined(level.spawnpoints)))
	{
		level.spawnpoints = [];
	}

	for(index = 0;index < level.teamspawnpoints[team].size;index++)
	{
		spawnpoint = level.teamspawnpoints[team][index];
		if(!(IsDefined(spawnpoint.inited)))
		{
			spawnpoint spawnpointinit();
			level.spawnpoints[level.spawnpoints.size] = spawnpoint;
		}
	}

	for(index = 0;index < oldspawnpoints.size;index++)
	{
		origin = oldspawnpoints[index].origin;
		level.spawnmins = expandmins(level.spawnmins,origin);
		level.spawnmaxs = expandmaxs(level.spawnmaxs,origin);
		level.teamspawnpoints[team][level.teamspawnpoints[team].size] = oldspawnpoints[index];
	}

	if(!(level.teamspawnpoints[team].size))
	{
/#
		println("^1ERROR: No " + spawnpointname + " spawnpoints found in level!");
#/
		maps/mp/gametypes_zm/_callbacksetup::abortlevel();
		wait(1);
	}
}

//Function Number: 6
clearspawnpoints()
{
	foreach(team in level.teams)
	{
		level.teamspawnpoints[team] = [];
	}

	level.spawnpoints = [];
	level.unified_spawn_points = undefined;
}

//Function Number: 7
addspawnpoints(team,spawnpointname)
{
	addspawnpointclassname(spawnpointname);
	addspawnpointteamclassname(team,spawnpointname);
	addspawnpointsinternal(team,spawnpointname);
}

//Function Number: 8
rebuildspawnpoints(team)
{
	level.teamspawnpoints[team] = [];
	for(index = 0;index < level.spawn_point_team_class_names[team].size;index++)
	{
		addspawnpointsinternal(team,level.spawn_point_team_class_names[team][index]);
	}
}

//Function Number: 9
placespawnpoints(spawnpointname)
{
	addspawnpointclassname(spawnpointname);
	spawnpoints = getspawnpointarray(spawnpointname);
/#
	level.extraspawnpointsused = [];
IsDefined(level.extraspawnpointsused)
#/
	if(!(spawnpoints.size))
	{
/#
		println("^1No " + spawnpointname + " spawnpoints found in level!");
#/
		maps/mp/gametypes_zm/_callbacksetup::abortlevel();
		wait(1);
		return;
	}

	for(index = 0;index < spawnpoints.size;index++)
	{
		spawnpoints[index] spawnpointinit();
/#
		spawnpoints[index].fakeclassname = spawnpointname;
		level.extraspawnpointsused[level.extraspawnpointsused.size] = spawnpoints[index];
#/
	}
}

//Function Number: 10
dropspawnpoints(spawnpointname)
{
	spawnpoints = getspawnpointarray(spawnpointname);
	if(!(spawnpoints.size))
	{
/#
		println("^1No " + spawnpointname + " spawnpoints found in level!");
#/
		return;
	}

	for(index = 0;index < spawnpoints.size;index++)
	{
		spawnpoints[index] placespawnpoint();
	}
}

//Function Number: 11
addspawnpointclassname(spawnpointclassname)
{
	if(!(IsDefined(level.spawn_point_class_names)))
	{
		level.spawn_point_class_names = [];
	}

	level.spawn_point_class_names[level.spawn_point_class_names.size] = spawnpointclassname;
}

//Function Number: 12
addspawnpointteamclassname(team,spawnpointclassname)
{
	level.spawn_point_team_class_names[team][level.spawn_point_team_class_names[team].size] = spawnpointclassname;
}

//Function Number: 13
getspawnpointarray(classname)
{
	spawnpoints = getentarray(classname,"classname");
	if(!IsDefined(level.extraspawnpoints) || !IsDefined(level.extraspawnpoints[classname]))
	{
		return spawnpoints;
	}

	for(i = 0;i < level.extraspawnpoints[classname].size;i++)
	{
		spawnpoints[spawnpoints.size] = level.extraspawnpoints[classname][i];
	}

	return spawnpoints;
}

//Function Number: 14
spawnpointinit()
{
	spawnpoint = self;
	origin = spawnpoint.origin;
	if(!(level.spawnminsmaxsprimed))
	{
		level.spawnmins = origin;
		level.spawnmaxs = origin;
		level.spawnminsmaxsprimed = 1;
	}
	else
	{
		level.spawnmins = expandmins(level.spawnmins,origin);
		level.spawnmaxs = expandmaxs(level.spawnmaxs,origin);
	}

	spawnpoint placespawnpoint();
	spawnpoint.forward = AnglesToForward(spawnpoint.angles);
	spawnpoint.sighttracepoint = 50 + VectorScale((0,0,1));
	spawnpoint.inited = 1;
}

//Function Number: 15
getteamspawnpoints(team)
{
	return level.teamspawnpoints[team];
}

//Function Number: 16
getspawnpoint_final(spawnpoints,useweights)
{
	bestspawnpoint = undefined;
	if(!IsDefined(spawnpoints) || spawnpoints.size == 0)
	{
		return undefined;
	}

	if(!(IsDefined(useweights)))
	{
		useweights = 1;
	}

	if(useweights)
	{
		bestspawnpoint = getbestweightedspawnpoint(spawnpoints);
		thread spawnweightdebug(spawnpoints);
	}
	else
	{
		for(i = 0;i < spawnpoints.size;i++)
		{
			if(IsDefined(self.lastspawnpoint) && self.lastspawnpoint == spawnpoints[i])
			{
			}
			else if(positionwouldtelefrag(spawnpoints[i].origin))
			{
			}
			else
			{
				bestspawnpoint = spawnpoints[i];
				break;
			}
		}

		if(!(IsDefined(bestspawnpoint)))
		{
			if(IsDefined(self.lastspawnpoint) && !positionwouldtelefrag(self.lastspawnpoint.origin))
			{
				for(i = 0;i < spawnpoints.size;i++)
				{
					if(spawnpoints[i] == self.lastspawnpoint)
					{
						bestspawnpoint = spawnpoints[i];
						break;
					}
				}
			}
		}
	}

	if(!(IsDefined(bestspawnpoint)))
	{
		if(useweights)
		{
			bestspawnpoint = spawnpoints[randomint(spawnpoints.size)];
		}
		else
		{
			bestspawnpoint = spawnpoints[0];
		}
	}

	self finalizespawnpointchoice(bestspawnpoint);
/#
	self storespawndata(spawnpoints,useweights,bestspawnpoint);
#/
	return bestspawnpoint;
}

//Function Number: 17
finalizespawnpointchoice(spawnpoint)
{
	time = GetTime();
	self.lastspawnpoint = spawnpoint;
	self.lastspawntime = time;
	spawnpoint.lastspawnedplayer = self;
	spawnpoint.lastspawntime = time;
}

//Function Number: 18
getbestweightedspawnpoint(spawnpoints)
{
	maxsighttracedspawnpoints = 3;
	for(try = 0;try <= maxsighttracedspawnpoints;try++)
	{
		bestspawnpoints = [];
		bestweight = undefined;
		bestspawnpoint = undefined;
		for(i = 0;i < spawnpoints.size;i++)
		{
			if(!IsDefined(bestweight) || spawnpoints[i].weight > bestweight)
			{
				if(positionwouldtelefrag(spawnpoints[i].origin))
				{
				}
				else
				{
					bestspawnpoints = [];
					bestspawnpoints[0] = spawnpoints[i];
					bestweight = spawnpoints[i].weight;
					if(spawnpoints[i].weight == bestweight)
					{
						if(positionwouldtelefrag(spawnpoints[i].origin))
						{
						}
						else
						{
							bestspawnpoints[bestspawnpoints.size] = spawnpoints[i];
						}
					}
				}
			}
		}

		if(bestspawnpoints.size == 0)
		{
			return undefined;
		}

		bestspawnpoint = bestspawnpoints[randomint(bestspawnpoints.size)];
		if(try == maxsighttracedspawnpoints)
		{
			return bestspawnpoint;
		}

		if(IsDefined(bestspawnpoint.lastsighttracetime) && bestspawnpoint.lastsighttracetime == GetTime())
		{
			return bestspawnpoint;
		}

		if(!(lastminutesighttraces(bestspawnpoint)))
		{
			return bestspawnpoint;
		}

		penalty = getlospenalty();
/#
		bestspawnpoint.spawndata[bestspawnpoint.spawndata.size] = "Last minute sight trace: -" + penalty;
level.storespawndata || level.debugspawning
#/
		bestspawnpoint.weight = bestspawnpoint.weight - penalty;
		bestspawnpoint.lastsighttracetime = GetTime();
	}
}

//Function Number: 19
checkbad(spawnpoint)
{
/#
	i = 0;
	for(;;)
	{
		player = level.players[i];
		losexists = bullettracepassed(50 + VectorScale((0,0,1)),player.origin,spawnpoint.sighttracepoint,0);
		thread badspawnline(spawnpoint.sighttracepoint,50 + VectorScale((0,0,1)),player.origin,self.name);
		i++;
	}
(!isalive(player) || player.sessionstate != "playing") ? level.teambased && player.team == self.team : (undefined ? losexists : player.name)
i < level.players.size
#/
}

//Function Number: 20
badspawnline(start,end,name1,name2)
{
/#
	dist = distance(start,end);
	i = 0;
	for(;;)
	{
		line(start,end,(1,0,0));
		print3d(start,"Bad spawn! " + name1 + ", dist = " + dist);
		print3d(end,name2);
		wait(0.05);
		i++;
	}
i < 200
#/
}

//Function Number: 21
storespawndata(spawnpoints,useweights,bestspawnpoint)
{
/#
	return;
	level.storespawndata = GetDvarInt(#"96EBB72E");
	return;
	level.spawngameid = randomint(100);
	level.spawnid = 0;
	return;
	level.spawnid++;
	file = openfile("spawndata.txt","append");
	fprintfields(file,level.spawngameid + "." + level.spawnid + "," + spawnpoints.size + "," + self.name);
	i = 0;
	for(;;)
	{
		str = vectostr(spawnpoints[i].origin) + ",";
		str = str + "1,";
		str = str + "0,";
		str = str + "0,";
		str = str + spawnpoints[i].weight + ",";
		spawnpoints[i].spawndata = [];
		spawnpoints[i].sightchecks = [];
		str = str + spawnpoints[i].spawndata.size + ",";
		j = 0;
		for(;;)
		{
			str = str + spawnpoints[i].spawndata[j] + ",";
			j++;
		}
		str = str + spawnpoints[i].sightchecks.size + ",";
		j = 0;
		for(;;)
		{
			str = str + spawnpoints[i].sightchecks[j].penalty + "," + vectostr(spawnpoints[i].origin) + ",";
			j++;
		}
		fprintfields(file,str);
		i++;
	}
	obj = spawnstruct();
	getallalliedandenemyplayers(obj);
	numallies = 0;
	numenemies = 0;
	str = "";
	i = 0;
	for(;;)
	{
		numallies++;
		str = str + vectostr(obj.allies[i].origin) + ",";
		i++;
	}
	i = 0;
	for(;;)
	{
		numenemies++;
		str = str + vectostr(obj.enemies[i].origin) + ",";
		i++;
	}
	str = numallies + "," + numenemies + "," + str;
	fprintfields(file,str);
	otherdata = [];
	index = otherdata.size;
	otherdata[index] = spawnstruct();
	otherdata[index].origin = 20 + VectorScale((0,0,1));
	otherdata[index].text = "Bomb holder";
	index = otherdata.size;
	otherdata[index] = spawnstruct();
	otherdata[index].origin = level.bombpos;
	otherdata[index].text = "Bomb";
	i = 0;
	for(;;)
	{
		index = otherdata.size;
		otherdata[index] = spawnstruct();
		otherdata[index].origin = level.flags[i].origin;
		otherdata[index].text = level.flags[i].useobj maps/mp/gametypes_zm/_gameobjects::getownerteam() + " flag";
		i++;
	}
	str = otherdata.size + ",";
	i = 0;
	for(;;)
	{
		str = str + vectostr(otherdata[i].origin) + "," + otherdata[i].text + ",";
		i++;
	}
	fprintfields(file,str);
	closefile(file);
	thisspawnid = level.spawngameid + "." + level.spawnid;
	self.thisspawnid = thisspawnid;
IsDefined(self.thisspawnid)
i < otherdata.size
i < level.flags.size
IsDefined(level.flags)
(IsDefined(level.bombguy)) ? level.bombguy.origin : IsDefined(level.bombpos)
i < obj.enemies.size
(j < spawnpoints[i].sightchecks.size) ? i < obj.allies.size : obj.allies[i] == self
j < spawnpoints[i].spawndata.size
IsDefined(spawnpoints[i].sightchecks)
IsDefined(spawnpoints[i].spawndata)
(IsDefined(level.spawnid)) ? ((bestspawnpoint.classname == "mp_global_intermission") ? i < spawnpoints.size : spawnpoints[i] == bestspawnpoint) : useweights
level.storespawndata
!IsDefined(level.storespawndata) || !level.storespawndata
#/
}

//Function Number: 22
readspawndata(desiredid,relativepos)
{
/#
	file = openfile("spawndata.txt","read");
	return;
	oldspawndata = level.curspawndata;
	level.curspawndata = undefined;
	prev = undefined;
	prevthisplayer = undefined;
	lookingfornextthisplayer = 0;
	lookingfornext = 0;
	return;
	for(;;)
	{
		break;
		data = spawnstruct();
		data.id = fgetarg(file,0);
		numspawns = int(fgetarg(file,1));
		break;
		data.playername = fgetarg(file,2);
		data.spawnpoints = [];
		data.friends = [];
		data.enemies = [];
		data.otherdata = [];
		i = 0;
		for(;;)
		{
			break;
			spawnpoint = spawnstruct();
			spawnpoint.origin = strtovec(fgetarg(file,0));
			spawnpoint.winner = int(fgetarg(file,1));
			spawnpoint.weight = int(fgetarg(file,2));
			spawnpoint.data = [];
			spawnpoint.sightchecks = [];
			data.minweight = spawnpoint.weight;
			data.maxweight = spawnpoint.weight;
			data.minweight = spawnpoint.weight;
			data.maxweight = spawnpoint.weight;
			argnum = 4;
			numdata = int(fgetarg(file,3));
			break;
			j = 0;
			for(;;)
			{
				spawnpoint.data[spawnpoint.data.size] = fgetarg(file,argnum);
				argnum++;
				j++;
			}
			numsightchecks = int(fgetarg(file,argnum));
			argnum++;
			break;
			j = 0;
			for(;;)
			{
				index = spawnpoint.sightchecks.size;
				spawnpoint.sightchecks[index] = spawnstruct();
				spawnpoint.sightchecks[index].penalty = int(fgetarg(file,argnum));
				argnum++;
				spawnpoint.sightchecks[index].origin = strtovec(fgetarg(file,argnum));
				argnum++;
				j++;
			}
			data.spawnpoints[data.spawnpoints.size] = spawnpoint;
			i++;
		}
		data.minweight = -1;
		data.maxweight = 0;
		data.minweight = data.minweight - 1;
		break;
		numfriends = int(fgetarg(file,0));
		numenemies = int(fgetarg(file,1));
		break;
		argnum = 2;
		i = 0;
		for(;;)
		{
			data.friends[data.friends.size] = strtovec(fgetarg(file,argnum));
			argnum++;
			i++;
		}
		i = 0;
		for(;;)
		{
			data.enemies[data.enemies.size] = strtovec(fgetarg(file,argnum));
			argnum++;
			i++;
		}
		break;
		numotherdata = int(fgetarg(file,0));
		argnum = 1;
		i = 0;
		for(;;)
		{
			otherdata = spawnstruct();
			otherdata.origin = strtovec(fgetarg(file,argnum));
			argnum++;
			otherdata.text = fgetarg(file,argnum);
			argnum++;
			data.otherdata[data.otherdata.size] = otherdata;
			i++;
		}
		level.curspawndata = prevthisplayer;
		break;
		level.curspawndata = prev;
		break;
		level.curspawndata = data;
		break;
		lookingfornextthisplayer = 1;
		continue;
		level.curspawndata = data;
		break;
		lookingfornext = 1;
		level.curspawndata = data;
		break;
		prev = data;
		prevthisplayer = data;
	}
	closefile(file);
IsDefined(oldspawndata) && data.playername == oldspawndata.playername
(relativepos == "prevthisplayer") ? ((data.id == oldspawndata.id) ? relativepos == "prev" : ((data.id == oldspawndata.id) ? ((relativepos == "nextthisplayer") ? lookingfornextthisplayer : data.id == oldspawndata.id) : ((relativepos == "next") ? lookingfornext : data.id == oldspawndata.id))) : data.id == desiredid
IsDefined(relativepos)
i < numotherdata
freadln(file) <= 0
i < numenemies
i < numfriends
numfriends > 32 || numenemies > 32
freadln(file) <= 0
data.minweight == data.maxweight
IsDefined(data.minweight)
j < numsightchecks
numsightchecks > 256
j < numdata
numdata > 256
i == 0 ? spawnpoint.weight < data.minweight : spawnpoint.weight > data.maxweight
freadln(file) <= 0
i < numspawns
numspawns > 256
freadln(file) <= 0
1
IsDefined(relativepos) && !IsDefined(oldspawndata)
file < 0
#/
}

//Function Number: 23
drawspawndata()
{
/#
	level notify("drawing_spawn_data");
	level endon("drawing_spawn_data");
	textoffset = VectorScale((0,0,-1));
	for(;;)
	{
		wait(0.5);
		i = 0;
		for(;;)
		{
			print3d(level.curspawndata.friends[i],"=)",(0.5,1,0.5),1,5);
			i++;
		}
		i = 0;
		for(;;)
		{
			print3d(level.curspawndata.enemies[i],"=(",(1,0.5,0.5),1,5);
			i++;
		}
		i = 0;
		for(;;)
		{
			print3d(level.curspawndata.otherdata[i].origin,level.curspawndata.otherdata[i].text,(0.5,0.75,1),1,2);
			i++;
		}
		i = 0;
		for(;;)
		{
			sp = level.curspawndata.spawnpoints[i];
			orig = sp.sighttracepoint;
			print3d(orig,level.curspawndata.playername + " spawned here",(0.5,0.5,1),1,2);
			orig = orig + textoffset;
			amnt = sp.weight - level.curspawndata.minweight / level.curspawndata.maxweight - level.curspawndata.minweight;
			print3d(orig,"Weight: " + sp.weight,(1 - amnt,amnt,0.5));
			orig = orig + textoffset;
			j = 0;
			for(;;)
			{
				print3d(orig,sp.data[j],(1,1,1));
				orig = orig + textoffset;
				j++;
			}
			j = 0;
			for(;;)
			{
				print3d(orig,"Sightchecks: -" + sp.sightchecks[j].penalty,(1,0.5,0.5));
				orig = orig + textoffset;
				j++;
			}
			i++;
		}
		wait(0.05);
	}
j < sp.sightchecks.size
j < sp.data.size
sp.winner
i < level.curspawndata.spawnpoints.size
i < level.curspawndata.otherdata.size
i < level.curspawndata.enemies.size
i < level.curspawndata.friends.size
IsDefined(level.curspawndata)
1
12
#/
}

//Function Number: 24
vectostr(vec)
{
/#
	return int(vec[0]) + "/" + int(vec[1]) + "/" + int(vec[2]);
#/
}

//Function Number: 25
strtovec(str)
{
/#
	parts = strtok(str,"/");
	return (0,0,0);
	return (int(parts[0]),int(parts[1]),int(parts[2]));
parts.size != 3
#/
}

//Function Number: 26
getspawnpoint_random(spawnpoints)
{
	if(!(IsDefined(spawnpoints)))
	{
		return undefined;
	}

	for(i = 0;i < spawnpoints.size;i++)
	{
		j = randomint(spawnpoints.size);
		spawnpoint = spawnpoints[i];
		spawnpoints[i] = spawnpoints[j];
		spawnpoints[j] = spawnpoint;
	}

	return getspawnpoint_final(spawnpoints,0);
}

//Function Number: 27
getallotherplayers()
{
	aliveplayers = [];
	for(i = 0;i < level.players.size;i++)
	{
		if(!(IsDefined(level.players[i])))
		{
		}
		else
		{
			player = level.players[i];
			if(player.sessionstate != "playing" || player == self)
			{
			}
			else if(IsDefined(level.customalivecheck))
			{
				if(!([[ level.customalivecheck ]](player)))
				{
				}
				else
				{
					aliveplayers[aliveplayers.size] = player;
				}
			}
		}
	}

	return aliveplayers;
}

//Function Number: 28
getallalliedandenemyplayers(obj)
{
	if(level.teambased)
	{
/#
		assert(IsDefined(level.teams[self.team]));
#/
		obj.allies = [];
		obj.enemies = [];
		for(i = 0;i < level.players.size;i++)
		{
			if(!(IsDefined(level.players[i])))
			{
			}
			else
			{
				player = level.players[i];
				if(player.sessionstate != "playing" || player == self)
				{
				}
				else if(IsDefined(level.customalivecheck))
				{
					if(!([[ level.customalivecheck ]](player)))
					{
					}
					else if(player.team == self.team)
					{
						obj.allies[obj.allies.size] = player;
					}
					else
					{
						obj.enemies[obj.enemies.size] = player;
					}
				}
			}
		}
	}
	else
	{
		obj.allies = [];
		obj.enemies = level.activeplayers;
	}
}

//Function Number: 29
initweights(spawnpoints)
{
	for(i = 0;i < spawnpoints.size;i++)
	{
		spawnpoints[i].weight = 0;
	}

/#
	i = 0;
	for(;;)
	{
		spawnpoints[i].spawndata = [];
		spawnpoints[i].sightchecks = [];
		i++;
	}
i < spawnpoints.size
level.storespawndata || level.debugspawning
#/
}

//Function Number: 30
spawnpointupdate_zm(spawnpoint)
{
	foreach(team in level.teams)
	{
		spawnpoint.distsum[team] = 0;
		spawnpoint.enemydistsum[team] = 0;
	}

	players = get_players();
	spawnpoint.numplayersatlastupdate = players.size;
	foreach(player in players)
	{
		if(!(IsDefined(player)))
		{
		}
		else if(player.sessionstate != "playing")
		{
		}
		else if(IsDefined(level.customalivecheck))
		{
			if(!([[ level.customalivecheck ]](player)))
			{
			}
			else
			{
				dist = distance(spawnpoint.origin,player.origin);
				spawnpoint.distsum[player.team] = spawnpoint.distsum[player.team] + dist;
				foreach(team in level.teams)
				{
					if(team != player.team)
					{
						spawnpoint.enemydistsum[team] = spawnpoint.enemydistsum[team] + dist;
					}
				}
			}
		}
	}
}

//Function Number: 31
getspawnpoint_nearteam(spawnpoints,favoredspawnpoints,forceallydistanceweight,forceenemydistanceweight)
{
	if(!(IsDefined(spawnpoints)))
	{
		return undefined;
	}

/#
	setdvar("scr_spawn_randomly","0");
	return getspawnpoint_random(spawnpoints);
GetDvar(#"6486379A") == "1"
GetDvar(#"6486379A") == ""
#/
	if(GetDvarInt(#"292A749F") > 0)
	{
		return getspawnpoint_random(spawnpoints);
	}

	spawnlogic_begin();
	k_favored_spawn_point_bonus = 25000;
	initweights(spawnpoints);
	obj = spawnstruct();
	getallalliedandenemyplayers(obj);
	numplayers = obj.allies.size + obj.enemies.size;
	allieddistanceweight = 2;
	if(IsDefined(forceallydistanceweight))
	{
		allieddistanceweight = forceallydistanceweight;
	}

	enemydistanceweight = 1;
	if(IsDefined(forceenemydistanceweight))
	{
		enemydistanceweight = forceenemydistanceweight;
	}

	myteam = self.team;
	for(i = 0;i < spawnpoints.size;i++)
	{
		spawnpoint = spawnpoints[i];
		spawnpointupdate_zm(spawnpoint);
		if(!(IsDefined(spawnpoint.numplayersatlastupdate)))
		{
			spawnpoint.numplayersatlastupdate = 0;
		}

		if(spawnpoint.numplayersatlastupdate > 0)
		{
			allydistsum = spawnpoint.distsum[myteam];
			enemydistsum = spawnpoint.enemydistsum[myteam];
			spawnpoint.weight = enemydistanceweight * enemydistsum - allieddistanceweight * allydistsum / spawnpoint.numplayersatlastupdate;
/#
			spawnpoint.spawndata[spawnpoint.spawndata.size] = "Base weight: " + int(spawnpoint.weight) + " = (" + enemydistanceweight + "*" + int(enemydistsum) + " - " + allieddistanceweight + "*" + int(allydistsum) + ") / " + spawnpoint.numplayersatlastupdate;
level.storespawndata || level.debugspawning
#/
		}
		else
		{
			spawnpoint.weight = 0;
/#
			spawnpoint.spawndata[spawnpoint.spawndata.size] = "Base weight: 0";
level.storespawndata || level.debugspawning
#/
		}
	}

	if(IsDefined(favoredspawnpoints))
	{
		for(i = 0;i < favoredspawnpoints.size;i++)
		{
			if(IsDefined(favoredspawnpoints[i].weight))
			{
				favoredspawnpoints[i].weight = favoredspawnpoints[i].weight + k_favored_spawn_point_bonus;
			}
			else
			{
				favoredspawnpoints[i].weight = k_favored_spawn_point_bonus;
			}
		}
	}

	avoidsamespawn(spawnpoints);
	avoidspawnreuse(spawnpoints,1);
	avoidweapondamage(spawnpoints);
	avoidvisibleenemies(spawnpoints,1);
	result = getspawnpoint_final(spawnpoints);
/#
	setdvar("scr_spawn_showbad","0");
	checkbad(result);
GetDvar(#"9E85FAFC") == "1"
GetDvar(#"9E85FAFC") == ""
#/
	return result;
}

//Function Number: 32
getspawnpoint_dm(spawnpoints)
{
	if(!(IsDefined(spawnpoints)))
	{
		return undefined;
	}

	spawnlogic_begin();
	initweights(spawnpoints);
	aliveplayers = getallotherplayers();
	idealdist = 1600;
	baddist = 1200;
	if(aliveplayers.size > 0)
	{
		for(i = 0;i < spawnpoints.size;i++)
		{
			totaldistfromideal = 0;
			nearbybadamount = 0;
			for(j = 0;j < aliveplayers.size;j++)
			{
				dist = distance(spawnpoints[i].origin,aliveplayers[j].origin);
				if(dist < baddist)
				{
					nearbybadamount = nearbybadamount + baddist - dist / baddist;
				}

				distfromideal = Abs(dist - idealdist);
				totaldistfromideal = totaldistfromideal + distfromideal;
			}

			avgdistfromideal = totaldistfromideal / aliveplayers.size;
			welldistancedamount = idealdist - avgdistfromideal / idealdist;
			spawnpoints[i].weight = welldistancedamount - nearbybadamount * 2 + randomfloat(0.2);
		}
	}

	avoidsamespawn(spawnpoints);
	avoidspawnreuse(spawnpoints,0);
	avoidweapondamage(spawnpoints);
	avoidvisibleenemies(spawnpoints,0);
	return getspawnpoint_final(spawnpoints);
}

//Function Number: 33
getspawnpoint_turned(spawnpoints,idealdist,baddist,idealdistteam,baddistteam)
{
	if(!(IsDefined(spawnpoints)))
	{
		return undefined;
	}

	spawnlogic_begin();
	initweights(spawnpoints);
	aliveplayers = getallotherplayers();
	if(!(IsDefined(idealdist)))
	{
		idealdist = 1600;
	}

	if(!(IsDefined(idealdistteam)))
	{
		idealdistteam = 1200;
	}

	if(!(IsDefined(baddist)))
	{
		baddist = 1200;
	}

	if(!(IsDefined(baddistteam)))
	{
		baddistteam = 600;
	}

	myteam = self.team;
	if(aliveplayers.size > 0)
	{
		for(i = 0;i < spawnpoints.size;i++)
		{
			totaldistfromideal = 0;
			nearbybadamount = 0;
			for(j = 0;j < aliveplayers.size;j++)
			{
				dist = distance(spawnpoints[i].origin,aliveplayers[j].origin);
				distfromideal = 0;
				if(aliveplayers[j].team == myteam)
				{
					if(dist < baddistteam)
					{
						nearbybadamount = nearbybadamount + baddistteam - dist / baddistteam;
					}

					distfromideal = Abs(dist - idealdistteam);
				}
				else
				{
					if(dist < baddist)
					{
						nearbybadamount = nearbybadamount + baddist - dist / baddist;
					}

					distfromideal = Abs(dist - idealdist);
				}

				totaldistfromideal = totaldistfromideal + distfromideal;
			}

			avgdistfromideal = totaldistfromideal / aliveplayers.size;
			welldistancedamount = idealdist - avgdistfromideal / idealdist;
			spawnpoints[i].weight = welldistancedamount - nearbybadamount * 2 + randomfloat(0.2);
		}
	}

	avoidsamespawn(spawnpoints);
	avoidspawnreuse(spawnpoints,0);
	avoidweapondamage(spawnpoints);
	avoidvisibleenemies(spawnpoints,0);
	return getspawnpoint_final(spawnpoints);
}

//Function Number: 34
spawnlogic_begin()
{
/#
	level.storespawndata = GetDvarInt(#"96EBB72E");
	level.debugspawning = GetDvarInt(#"632110E6") > 0;
#/
}

//Function Number: 35
init()
{
/#
	setdvar("scr_recordspawndata",0);
	level.storespawndata = GetDvarInt(#"96EBB72E");
	setdvar("scr_killbots",0);
	setdvar("scr_killbottimer",0.25);
	thread loopbotspawns();
GetDvar(#"1F9534FE") == ""
GetDvar(#"45A06390") == ""
GetDvar(#"96EBB72E") == ""
#/
	level.spawnlogic_deaths = [];
	level.spawnlogic_spawnkills = [];
	level.players = [];
	level.grenades = [];
	level.pipebombs = [];
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	level.spawnminsmaxsprimed = 0;
	if(IsDefined(level.safespawns))
	{
		for(i = 0;i < level.safespawns.size;i++)
		{
			level.safespawns[i] spawnpointinit();
		}
	}

	if(GetDvar(#"2778D919") == "")
	{
		setdvar("scr_spawn_enemyavoiddist","800");
	}

	if(GetDvar(#"1517800D") == "")
	{
		setdvar("scr_spawn_enemyavoidweight","0");
	}

/#
	setdvar("scr_spawnsimple","0");
	setdvar("scr_spawnpointdebug","0");
	thread showdeathsdebug();
	thread updatedeathinfodebug();
	thread profiledebug();
	thread allowspawndatareading();
	setdvar("scr_spawnprofile","0");
	thread watchspawnprofile();
	thread spawngraphcheck();
GetDvar(#"7CA769A6") == ""
level.storespawndata
GetDvarInt(#"632110E6") > 0
GetDvar(#"632110E6") == ""
GetDvar(#"292A749F") == ""
#/
}

//Function Number: 36
watchspawnprofile()
{
/#
	for(;;)
	{
		for(;;)
		{
			break;
			wait(0.05);
		}
		thread spawnprofile();
		for(;;)
		{
			break;
			wait(0.05);
		}
		level notify("stop_spawn_profile",GetDvarInt(#"7CA769A6") <= 0,1,GetDvarInt(#"7CA769A6") > 0,1,1);
	}
#/
}

//Function Number: 37
spawnprofile()
{
/#
	level endon("stop_spawn_profile");
	for(;;)
	{
		playernum = randomint(level.players.size);
		player = level.players[playernum];
		attempt = 1;
		for(;;)
		{
			playernum = playernum + 1 % level.players.size;
			attempt++;
			player = level.players[playernum];
		}
		player getspawnpoint_nearteam(level.spawnpoints);
		wait(0.05);
	}
!IsDefined(player) && attempt < level.players.size
level.players.size > 0 && level.spawnpoints.size > 0
1
#/
}

//Function Number: 38
spawngraphcheck()
{
/#
	for(;;)
	{
		wait(3);
		thread spawngraph();
		return;
	}
GetDvarInt(#"C25B6B47") < 1
1
#/
}

//Function Number: 39
spawngraph()
{
/#
	w = 20;
	h = 20;
	weightscale = 0.1;
	fakespawnpoints = [];
	corners = getentarray("minimap_corner","targetname");
	println("^1 can\'t spawn graph: no minimap corners");
	return;
	min = corners[0].origin;
	max = corners[0].origin;
	max = (corners[1].origin[0],max[1],max[2]);
	min = (corners[1].origin[0],min[1],min[2]);
	max = (max[0],corners[1].origin[1],max[2]);
	min = (min[0],corners[1].origin[1],min[2]);
	i = 0;
	y = 0;
	for(;;)
	{
		yamnt = y / h - 1;
		x = 0;
		for(;;)
		{
			xamnt = x / w - 1;
			fakespawnpoints[i] = spawnstruct();
			fakespawnpoints[i].origin = (min[0] * xamnt + max[0] * 1 - xamnt,min[1] * yamnt + max[1] * 1 - yamnt,min[2]);
			fakespawnpoints[i].angles = (0,0,0);
			fakespawnpoints[i].forward = AnglesToForward(fakespawnpoints[i].angles);
			fakespawnpoints[i].sighttracepoint = fakespawnpoints[i].origin;
			i++;
			x++;
		}
		y++;
	}
	didweights = 0;
	for(;;)
	{
		for(;;)
		{
			spawni = 0;
			numiters = 5;
			i = 0;
			for(;;)
			{
				break;
				endspawni = spawni + fakespawnpoints.size / numiters;
				endspawni = fakespawnpoints.size;
				for(;;)
				{
					spawnpointupdate(fakespawnpoints[spawni]);
					spawni++;
				}
				level.players[0] drawspawngraph(fakespawnpoints,w,h,weightscale);
				wait(0.05);
				i++;
			}
			wait(1);
		}
		level.players[0] getspawnpoint_nearteam(fakespawnpoints);
		i = 0;
		for(;;)
		{
			setupspawngraphpoint(fakespawnpoints[i],weightscale);
			i++;
		}
		didweights = 1;
		level.players[0] drawspawngraph(fakespawnpoints,w,h,weightscale);
		wait(0.05);
	}
i < fakespawnpoints.size
!level.players.size || !IsDefined(level.players[0].team) || level.players[0].team == "spectator" || !IsDefined(level.players[0].class)
didweights
spawni < endspawni
i == numiters - 1
!level.players.size || !IsDefined(level.players[0].team) || level.players[0].team == "spectator" || !IsDefined(level.players[0].class)
i < numiters
1
x < w
y < h
Stack-Empty ? (Stack-Empty ? corners.size != 2 : corners[1].origin[0] > max[0]) : corners[1].origin[1] > max[1]
#/
}

//Function Number: 40
drawspawngraph(fakespawnpoints,w,h,weightscale)
{
/#
	i = 0;
	y = 0;
	for(;;)
	{
		yamnt = y / h - 1;
		x = 0;
		for(;;)
		{
			xamnt = x / w - 1;
			spawngraphline(fakespawnpoints[i],fakespawnpoints[i - w],weightscale);
			spawngraphline(fakespawnpoints[i],fakespawnpoints[i - 1],weightscale);
			i++;
			x++;
		}
		y++;
	}
x > 0
y > 0
x < w
y < h
#/
}

//Function Number: 41
setupspawngraphpoint(s1,weightscale)
{
/#
	s1.visible = 1;
	s1.visible = 0;
s1.weight < -1000 / weightscale
#/
}

//Function Number: 42
spawngraphline(s1,s2,weightscale)
{
/#
	return;
	p1 = s1.origin + (0,0,s1.weight * weightscale + 100);
	p2 = s2.origin + (0,0,s2.weight * weightscale + 100);
	line(p1,p2,(1,1,1));
!s1.visible || !s2.visible
#/
}

//Function Number: 43
loopbotspawns()
{
/#
	for(;;)
	{
		for(;;)
		{
			wait(3);
			wait(0.05);
		}
		bots = [];
		i = 0;
		for(;;)
		{
			bots[bots.size] = level.players[i];
			i++;
		}
		killer = bots[randomint(bots.size)];
		victim = bots[randomint(bots.size)];
		victim thread [[ level.callbackplayerdamage ]](killer,killer,1000,0,"MOD_RIFLE_BULLET","none",(0,0,0),(0,0,0),"none",0,0);
		numkills = GetDvarInt(#"45A06390");
		lastvictim = undefined;
		index = 0;
		for(;;)
		{
			killer = bots[randomint(bots.size)];
			victim = bots[randomint(bots.size)];
			victim = bots[randomint(bots.size)];
			victim thread [[ level.callbackplayerdamage ]](killer,killer,1000,0,"MOD_RIFLE_BULLET","none",(0,0,0),(0,0,0),"none",0,0);
			lastvictim = victim;
			index++;
		}
		wait(GetDvarFloat(#"1F9534FE"));
		continue;
		wait(0.05);
	}
GetDvar(#"1F9534FE") != ""
(GetDvarInt(#"45A06390") == 1) ? index < numkills : IsDefined(lastvictim) && victim == lastvictim
bots.size > 0
(i < level.players.size) ? IsDefined(level.players[i]) : level.players[i].sessionstate == "playing" && issubstr(level.players[i].name,"bot")
IsDefined(level.players)
GetDvarInt(#"45A06390") < 1
1
#/
}

//Function Number: 44
allowspawndatareading()
{
/#
	setdvar("scr_showspawnid","");
	prevval = GetDvar(#"E0FC7E63");
	prevrelval = GetDvar(#"4058B332");
	readthistime = 0;
	for(;;)
	{
		for(;;)
		{
			val = GetDvar(#"E0FC7E63");
			relval = undefined;
			relval = GetDvar(#"4058B332");
			setdvar("scr_spawnidcycle","");
			break;
			wait(0.5);
		}
		prevval = val;
		readthistime = 0;
		readspawndata(val,relval);
		println("No spawn data to draw.");
		println("Drawing spawn ID " + level.curspawndata.id);
		thread drawspawndata();
	}
(!IsDefined(val) || val == prevval) ? IsDefined(relval) && relval != "" : IsDefined(level.curspawndata)
1
#/
}

//Function Number: 45
showdeathsdebug()
{
/#
	for(;;)
	{
		wait(3);
		time = GetTime();
		i = 0;
		for(;;)
		{
			line(level.spawnlogic_deaths[i].org,level.spawnlogic_deaths[i].killorg,(1,0,0));
			line(level.spawnlogic_deaths[i].org,level.spawnlogic_deaths[i].killorg,(1,1,1));
			killer = level.spawnlogic_deaths[i].killer;
			line(level.spawnlogic_deaths[i].killorg,killer.origin,(0.4,0.4,0.8));
			i++;
		}
		p = 0;
		for(;;)
		{
			print3d(64 + VectorScale((0,0,1)),level.players[p].origin,level.players[p].spawnlogic_killdist);
			p++;
		}
		oldspawnkills = level.spawnlogic_spawnkills;
		level.spawnlogic_spawnkills = [];
		i = 0;
		for(;;)
		{
			spawnkill = oldspawnkills[i];
			line(spawnkill.spawnpointorigin,spawnkill.dierorigin,(0.4,0.5,0.4));
			line(spawnkill.dierorigin,spawnkill.killerorigin,(0,1,1));
			print3d(32 + VectorScale((0,0,1)),spawnkill.dierorigin,"SPAWNKILLED!");
			line(spawnkill.spawnpointorigin,spawnkill.killerorigin,(0.4,0.5,0.4));
			line(spawnkill.killerorigin,spawnkill.dierorigin,(0,1,1));
			print3d(32 + VectorScale((0,0,1)),spawnkill.dierorigin,"SPAWNDIED!");
			level.spawnlogic_spawnkills[level.spawnlogic_spawnkills.size] = oldspawnkills[i];
			i++;
		}
		wait(0.05);
	}
time - spawnkill.time < 60000
(spawnkill.dierwasspawner) ? (0,1,1) : (0,1,1)
i < oldspawnkills.size
(IsDefined(level.players[p])) ? IsDefined(level.players[p].spawnlogic_killdist) : (1,1,1)
p < level.players.size
IsDefined(killer) && isalive(killer)
(GetDvar(#"632110E6") == "0") ? i < level.spawnlogic_deaths.size : IsDefined(level.spawnlogic_deaths[i].los)
1
#/
}

//Function Number: 46
updatedeathinfodebug()
{
	while(1)
	{
		if(GetDvar(#"632110E6") == "0")
		{
			wait(3);
			continue;
		}

		updatedeathinfo();
		wait(3);
	}
}

//Function Number: 47
spawnweightdebug(spawnpoints)
{
	level notify("stop_spawn_weight_debug");
	level endon("stop_spawn_weight_debug");
/#
	for(;;)
	{
		wait(3);
		textoffset = VectorScale((0,0,-1));
		i = 0;
		for(;;)
		{
			amnt = 1 * 1 - spawnpoints[i].weight / -100000;
			amnt = 0;
			amnt = 1;
			orig = 80 + VectorScale((0,0,1));
			print3d(orig,int(spawnpoints[i].weight),(1,amnt,0.5));
			orig = orig + textoffset;
			j = 0;
			for(;;)
			{
				print3d(orig,spawnpoints[i].spawndata[j],VectorScale((1,1,1)));
				orig = orig + textoffset;
				j++;
			}
			j = 0;
			for(;;)
			{
				print3d(orig,"Sight to enemy: -" + spawnpoints[i].sightchecks[j].penalty,VectorScale((1,1,1)));
				orig = orig + textoffset;
				j++;
			}
			i++;
		}
		wait(0.05);
	}
(j < spawnpoints[i].sightchecks.size) ? spawnpoints[i].sightchecks[j].penalty == 0 : 0.5
IsDefined(spawnpoints[i].sightchecks)
0.5
j < spawnpoints[i].spawndata.size
IsDefined(spawnpoints[i].spawndata)
spawnpoints[i].origin
amnt > 1
amnt < 0
i < spawnpoints.size
12
GetDvar(#"632110E6") == "0"
1
#/
}

//Function Number: 48
profiledebug()
{
	while(1)
	{
		if(GetDvar(#"6A99E750") != "1")
		{
			wait(3);
			continue;
		}

		for(i = 0;i < level.spawnpoints.size;i++)
		{
			level.spawnpoints[i].weight = randomint(10000);
		}

		if(level.players.size > 0)
		{
			level.players[randomint(level.players.size)] getspawnpoint_nearteam(level.spawnpoints);
		}

		wait(0.05);
	}
}

//Function Number: 49
debugnearbyplayers(players,origin)
{
/#
	return;
	starttime = GetTime();
	for(;;)
	{
		i = 0;
		for(;;)
		{
			line(players[i].origin,origin,(0.5,1,0.5));
			i++;
		}
		return;
		wait(0.05);
	}
GetTime() - starttime > 5000
i < players.size
1
GetDvar(#"632110E6") == "0"
#/
}

//Function Number: 50
deathoccured(dier,killer)
{
}

//Function Number: 51
checkforsimilardeaths(deathinfo)
{
	for(i = 0;i < level.spawnlogic_deaths.size;i++)
	{
		if(level.spawnlogic_deaths[i].killer == deathinfo.killer)
		{
			dist = distance(level.spawnlogic_deaths[i].org,deathinfo.org);
			if(dist > 200)
			{
			}
			else
			{
				dist = distance(level.spawnlogic_deaths[i].killorg,deathinfo.killorg);
				if(dist > 200)
				{
				}
				else
				{
					level.spawnlogic_deaths[i].remove = 1;
				}
			}
		}
	}
}

//Function Number: 52
updatedeathinfo()
{
	time = GetTime();
	for(i = 0;i < level.spawnlogic_deaths.size;i++)
	{
		deathinfo = level.spawnlogic_deaths[i];
		if(time - deathinfo.time > 90000 || !IsDefined(deathinfo.killer) || !isalive(deathinfo.killer) || !IsDefined(level.teams[deathinfo.killer.team]) || distance(deathinfo.killer.origin,deathinfo.killorg) > 400)
		{
			level.spawnlogic_deaths[i].remove = 1;
		}
	}

	oldarray = level.spawnlogic_deaths;
	level.spawnlogic_deaths = [];
	start = 0;
	if(oldarray.size - 1024 > 0)
	{
		start = oldarray.size - 1024;
	}

	for(i = start;i < oldarray.size;i++)
	{
		if(!(IsDefined(oldarray[i].remove)))
		{
			level.spawnlogic_deaths[level.spawnlogic_deaths.size] = oldarray[i];
		}
	}
}

//Function Number: 53
ispointvulnerable(playerorigin)
{
	pos = self.origin + level.bettymodelcenteroffset;
	playerpos = 32 + VectorScale((0,0,1));
	distsqrd = distancesquared(pos,playerpos);
	forward = AnglesToForward(self.angles);
	if(distsqrd < level.bettydetectionradius * level.bettydetectionradius)
	{
		playerdir = vectornormalize(playerpos - pos);
		angle = acos(vectordot(playerdir,forward));
		if(angle < level.bettydetectionconeangle)
		{
			return 1;
		}
	}
}

//Function Number: 54
avoidweapondamage(spawnpoints)
{
	if(GetDvar(#"FB71FB7") == "0")
	{
		return;
	}

	weapondamagepenalty = 100000;
	if(GetDvar(#"76B8F046") != "" && GetDvar(#"76B8F046") != "0")
	{
		weapondamagepenalty = GetDvarFloat(#"76B8F046");
	}

	mingrenadedistsquared = 62500;
	for(i = 0;i < spawnpoints.size;i++)
	{
		for(j = 0;j < level.grenades.size;j++)
		{
			if(!(IsDefined(level.grenades[j])))
			{
			}
			else if(distancesquared(spawnpoints[i].origin,level.grenades[j].origin) < mingrenadedistsquared)
			{
				spawnpoints[i].weight = spawnpoints[i].weight - weapondamagepenalty;
/#
					spawnpoints[i].spawndata[spawnpoints[i].spawndata.size] = "Was near grenade: -" + int(weapondamagepenalty);
level.storespawndata || level.debugspawning
#/
			}
		}
	}
}

//Function Number: 55
spawnperframeupdate()
{
	spawnpointindex = 0;
	while(1)
	{
		wait(0.05);
		if(!(IsDefined(level.spawnpoints)))
		{
			return;
		}

		spawnpointindex = spawnpointindex + 1 % level.spawnpoints.size;
		spawnpoint = level.spawnpoints[spawnpointindex];
		spawnpointupdate(spawnpoint);
	}
}

//Function Number: 56
getnonteamsum(skip_team,sums)
{
	value = 0;
	foreach(team in level.teams)
	{
		if(team == skip_team)
		{
		}
		else
		{
			value = value + sums[team];
		}
	}

	return value;
}

//Function Number: 57
getnonteammindist(skip_team,mindists)
{
	dist = 9999999;
	foreach(team in level.teams)
	{
		if(team == skip_team)
		{
		}
		else if(dist > mindists[team])
		{
			dist = mindists[team];
		}
	}

	return dist;
}

//Function Number: 58
spawnpointupdate(spawnpoint)
{
	if(level.teambased)
	{
		sights = [];
		foreach(team in level.teams)
		{
			spawnpoint.enemysights[team] = 0;
			sights[team] = 0;
			spawnpoint.nearbyplayers[team] = [];
		}
	}
	else
	{
		spawnpoint.enemysights = 0;
		spawnpoint.nearbyplayers["all"] = [];
	}

	spawnpointdir = spawnpoint.forward;
	debug = 0;
/#
	debug = GetDvarInt(#"632110E6") > 0;
#/
	mindist = [];
	distsum = [];
	if(!(level.teambased))
	{
		mindist["all"] = 9999999;
	}

	foreach(team in level.teams)
	{
		spawnpoint.distsum[team] = 0;
		spawnpoint.enemydistsum[team] = 0;
		spawnpoint.minenemydist[team] = 9999999;
		mindist[team] = 9999999;
	}

	spawnpoint.numplayersatlastupdate = 0;
	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		if(player.sessionstate != "playing")
		{
		}
		else
		{
			diff = player.origin - spawnpoint.origin;
			diff = (diff[0],diff[1],0);
			dist = length(diff);
			team = "all";
			if(level.teambased)
			{
				team = player.team;
			}

			if(dist < 1024)
			{
				spawnpoint.nearbyplayers[team][spawnpoint.nearbyplayers[team].size] = player;
			}

			if(dist < mindist[team])
			{
				mindist[team] = dist;
			}

			distsum[team] = distsum[team] + dist;
			spawnpoint.numplayersatlastupdate++;
			pdir = AnglesToForward(player.angles);
			if(vectordot(spawnpointdir,diff) < 0 && vectordot(pdir,diff) > 0)
			{
			}
			else
			{
				losexists = bullettracepassed(50 + VectorScale((0,0,1)),player.origin,spawnpoint.sighttracepoint,0);
				spawnpoint.lastsighttracetime = GetTime();
				if(losexists)
				{
					if(level.teambased)
					{
						sights[player.team]++;
					}
					else
					{
						spawnpoint.enemysights++;
					}

/#
					line(50 + VectorScale((0,0,1)),player.origin,spawnpoint.sighttracepoint);
(0.5,1,0.5)
debug
#/
				}
			}
		}
	}

	if(level.teambased)
	{
		foreach(team in level.teams)
		{
			spawnpoint.enemysights[team] = getnonteamsum(team,sights);
			spawnpoint.minenemydist[team] = getnonteammindist(team,mindist);
			spawnpoint.distsum[team] = distsum[team];
			spawnpoint.enemydistsum[team] = getnonteamsum(team,distsum);
		}
	}
	else
	{
		spawnpoint.distsum["all"] = distsum["all"];
		spawnpoint.enemydistsum["all"] = distsum["all"];
		spawnpoint.minenemydist["all"] = mindist["all"];
	}
}

//Function Number: 59
getlospenalty()
{
	if(GetDvar(#"CACDB8AA") != "" && GetDvar(#"CACDB8AA") != "0")
	{
		return GetDvarFloat(#"CACDB8AA");
	}

	return 100000;
}

//Function Number: 60
lastminutesighttraces(spawnpoint)
{
	if(!(IsDefined(spawnpoint.nearbyplayers)))
	{
		return 0;
	}

	closest = undefined;
	closestdistsq = undefined;
	secondclosest = undefined;
	secondclosestdistsq = undefined;
	foreach(team in spawnpoint.nearbyplayers)
	{
		if(team == self.team)
		{
		}
		else
		{
			for(i = 0;i < spawnpoint.nearbyplayers[team].size;i++)
			{
				player = spawnpoint.nearbyplayers[team][i];
				if(!(IsDefined(player)))
				{
				}
				else if(player.sessionstate != "playing")
				{
				}
				else if(player == self)
				{
				}
				else
				{
					distsq = distancesquared(spawnpoint.origin,player.origin);
					if(!IsDefined(closest) || distsq < closestdistsq)
					{
						secondclosest = closest;
						secondclosestdistsq = closestdistsq;
						closest = player;
						closestdistsq = distsq;
					}
					else if(!IsDefined(secondclosest) || distsq < secondclosestdistsq)
					{
						secondclosest = player;
						secondclosestdistsq = distsq;
					}
				}
			}
		}
	}

	if(IsDefined(closest))
	{
		if(bullettracepassed(50 + VectorScale((0,0,1)),closest.origin,spawnpoint.sighttracepoint,0))
		{
			return 1;
		}
	}

	if(IsDefined(secondclosest))
	{
		if(bullettracepassed(50 + VectorScale((0,0,1)),secondclosest.origin,spawnpoint.sighttracepoint,0))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 61
avoidvisibleenemies(spawnpoints,teambased)
{
	if(GetDvar(#"FB71FB7") == "0")
	{
		return;
	}

	lospenalty = getlospenalty();
	mindistteam = self.team;
	if(teambased)
	{
		for(i = 0;i < spawnpoints.size;i++)
		{
			if(!(IsDefined(spawnpoints[i].enemysights)))
			{
			}
			else
			{
				penalty = lospenalty * spawnpoints[i].enemysights[self.team];
				spawnpoints[i].weight = spawnpoints[i].weight - penalty;
/#
				index = spawnpoints[i].sightchecks.size;
				spawnpoints[i].sightchecks[index] = spawnstruct();
				spawnpoints[i].sightchecks[index].penalty = penalty;
level.storespawndata || level.debugspawning
#/
			}
		}
	}
	else
	{
		for(i = 0;i < spawnpoints.size;i++)
		{
			if(!(IsDefined(spawnpoints[i].enemysights)))
			{
			}
			else
			{
				penalty = lospenalty * spawnpoints[i].enemysights;
				spawnpoints[i].weight = spawnpoints[i].weight - penalty;
/#
				index = spawnpoints[i].sightchecks.size;
				spawnpoints[i].sightchecks[index] = spawnstruct();
				spawnpoints[i].sightchecks[index].penalty = penalty;
level.storespawndata || level.debugspawning
#/
			}
		}

		mindistteam = "all";
	}

	avoidweight = GetDvarFloat(#"1517800D");
	if(avoidweight != 0)
	{
		nearbyenemyouterrange = GetDvarFloat(#"2778D919");
		nearbyenemyouterrangesq = nearbyenemyouterrange * nearbyenemyouterrange;
		nearbyenemypenalty = 1500 * avoidweight;
		nearbyenemyminorpenalty = 800 * avoidweight;
		lastattackerorigin = VectorScale((-1,-1,-1));
		lastdeathpos = VectorScale((-1,-1,-1));
		if(isalive(self.lastattacker))
		{
			lastattackerorigin = self.lastattacker.origin;
		}

		if(IsDefined(self.lastdeathpos))
		{
			lastdeathpos = self.lastdeathpos;
		}

		for(i = 0;i < spawnpoints.size;i++)
		{
			mindist = spawnpoints[i].minenemydist[mindistteam];
			if(mindist < nearbyenemyouterrange * 2)
			{
				penalty = nearbyenemyminorpenalty * 1 - mindist / nearbyenemyouterrange * 2;
				if(mindist < nearbyenemyouterrange)
				{
					penalty = penalty + nearbyenemypenalty * 1 - mindist / nearbyenemyouterrange;
				}

				if(penalty > 0)
				{
					spawnpoints[i].weight = spawnpoints[i].weight - penalty;
/#
					spawnpoints[i].spawndata[spawnpoints[i].spawndata.size] = "Nearest enemy at " + int(spawnpoints[i].minenemydist[mindistteam]) + " units: -" + int(penalty);
level.storespawndata || level.debugspawning
#/
				}
			}
		}
	}
}

//Function Number: 62
avoidspawnreuse(spawnpoints,teambased)
{
	if(GetDvar(#"FB71FB7") == "0")
	{
		return;
	}

	time = GetTime();
	maxtime = 10000;
	maxdistsq = 1048576;
	for(i = 0;i < spawnpoints.size;i++)
	{
		spawnpoint = spawnpoints[i];
		if(!IsDefined(spawnpoint.lastspawnedplayer) || !IsDefined(spawnpoint.lastspawntime) || !isalive(spawnpoint.lastspawnedplayer))
		{
		}
		else if(spawnpoint.lastspawnedplayer == self)
		{
		}
		else if(teambased && spawnpoint.lastspawnedplayer.team == self.team)
		{
		}
		else
		{
			timepassed = time - spawnpoint.lastspawntime;
			if(timepassed < maxtime)
			{
				distsq = distancesquared(spawnpoint.lastspawnedplayer.origin,spawnpoint.origin);
				if(distsq < maxdistsq)
				{
					worsen = 5000 * 1 - distsq / maxdistsq * 1 - timepassed / maxtime;
					spawnpoint.weight = spawnpoint.weight - worsen;
/#
							spawnpoint.spawndata[spawnpoint.spawndata.size] = "Was recently used: -" + worsen;
level.storespawndata || level.debugspawning
#/
					continue;
				}

				spawnpoint.lastspawnedplayer = undefined;
			}
			else
			{
				spawnpoint.lastspawnedplayer = undefined;
			}
		}
	}
}

//Function Number: 63
avoidsamespawn(spawnpoints)
{
	if(GetDvar(#"FB71FB7") == "0")
	{
		return;
	}

	if(!(IsDefined(self.lastspawnpoint)))
	{
		return;
	}

	for(i = 0;i < spawnpoints.size;i++)
	{
		if(spawnpoints[i] == self.lastspawnpoint)
		{
			spawnpoints[i].weight = spawnpoints[i].weight - 50000;
/#
			spawnpoints[i].spawndata[spawnpoints[i].spawndata.size] = "Was last spawnpoint: -50000";
level.storespawndata || level.debugspawning
#/
			break;
		}
	}
}

//Function Number: 64
getrandomintermissionpoint()
{
	spawnpoints = getentarray("mp_global_intermission","classname");
	if(!(spawnpoints.size))
	{
		spawnpoints = getentarray("info_player_start","classname");
	}

/#
	assert(spawnpoints.size);
#/
	spawnpoint = maps/mp/gametypes_zm/_spawnlogic::getspawnpoint_random(spawnpoints);
	return spawnpoint;
}