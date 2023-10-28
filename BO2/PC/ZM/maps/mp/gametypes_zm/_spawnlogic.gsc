/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes_zm\_spawnlogic.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 64
 * Decompile Time: 31 ms
 * Timestamp: 10/28/2023 12:11:39 AM
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
	if(!(IsDefined(level.extraspawnpointsused)))
	{
		level.extraspawnpointsused = [];
	}
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
		if(level.storespawndata || level.debugspawning)
		{
			bestspawnpoint.spawndata[bestspawnpoint.spawndata.size] = "Last minute sight trace: -" + penalty;
		}
#/
		bestspawnpoint.weight = bestspawnpoint.weight - penalty;
		bestspawnpoint.lastsighttracetime = GetTime();
	}
}

//Function Number: 19
checkbad(spawnpoint)
{
/#
	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		if(!isalive(player) || player.sessionstate != "playing")
		{
		}
		else if(level.teambased && player.team == self.team)
		{
		}
		else
		{
			losexists = bullettracepassed(50 + VectorScale((0,0,1)),player.origin,spawnpoint.sighttracepoint,0);
			if(losexists)
			{
				thread badspawnline(spawnpoint.sighttracepoint,50 + VectorScale((0,0,1)),player.origin,self.name);
			}
		}
	}
#/
}

//Function Number: 20
badspawnline(start,end,name1,name2)
{
/#
	dist = distance(start,end);
	for(i = 0;i < 200;i++)
	{
		line(start,end,(1,0,0));
		print3d(start,"Bad spawn! " + name1 + ", dist = " + dist);
		print3d(end,name2);
		wait(0.05);
	}
#/
}

//Function Number: 21
storespawndata(spawnpoints,useweights,bestspawnpoint)
{
/#
	if(!IsDefined(level.storespawndata) || !level.storespawndata)
	{
		return;
	}

	level.storespawndata = GetDvarInt(#"96EBB72E");
	if(!(level.storespawndata))
	{
		return;
	}

	if(!(IsDefined(level.spawnid)))
	{
		level.spawngameid = randomint(100);
		level.spawnid = 0;
	}

	if(bestspawnpoint.classname == "mp_global_intermission")
	{
		return;
	}

	level.spawnid++;
	file = openfile("spawndata.txt","append");
	fprintfields(file,level.spawngameid + "." + level.spawnid + "," + spawnpoints.size + "," + self.name);
	for(i = 0;i < spawnpoints.size;i++)
	{
		str = vectostr(spawnpoints[i].origin) + ",";
		if(spawnpoints[i] == bestspawnpoint)
		{
			str = str + "1,";
		}
		else
		{
			str = str + "0,";
		}

		if(!(useweights))
		{
			str = str + "0,";
		}
		else
		{
			str = str + spawnpoints[i].weight + ",";
		}

		if(!(IsDefined(spawnpoints[i].spawndata)))
		{
			spawnpoints[i].spawndata = [];
		}

		if(!(IsDefined(spawnpoints[i].sightchecks)))
		{
			spawnpoints[i].sightchecks = [];
		}

		str = str + spawnpoints[i].spawndata.size + ",";
		for(j = 0;j < spawnpoints[i].spawndata.size;j++)
		{
			str = str + spawnpoints[i].spawndata[j] + ",";
		}

		str = str + spawnpoints[i].sightchecks.size + ",";
		for(j = 0;j < spawnpoints[i].sightchecks.size;j++)
		{
			str = str + spawnpoints[i].sightchecks[j].penalty + "," + vectostr(spawnpoints[i].origin) + ",";
		}

		fprintfields(file,str);
	}

	obj = spawnstruct();
	getallalliedandenemyplayers(obj);
	numallies = 0;
	numenemies = 0;
	str = "";
	for(i = 0;i < obj.allies.size;i++)
	{
		if(obj.allies[i] == self)
		{
		}
		else
		{
			numallies++;
			str = str + vectostr(obj.allies[i].origin) + ",";
		}
	}

	for(i = 0;i < obj.enemies.size;i++)
	{
		numenemies++;
		str = str + vectostr(obj.enemies[i].origin) + ",";
	}

	str = numallies + "," + numenemies + "," + str;
	fprintfields(file,str);
	otherdata = [];
	if(IsDefined(level.bombguy))
	{
		index = otherdata.size;
		otherdata[index] = spawnstruct();
		otherdata[index].origin = 20 + VectorScale((0,0,1));
		otherdata[index].text = "Bomb holder";
	}
	else if(IsDefined(level.bombpos))
	{
		index = otherdata.size;
		otherdata[index] = spawnstruct();
		otherdata[index].origin = level.bombpos;
		otherdata[index].text = "Bomb";
	}

	if(IsDefined(level.flags))
	{
		for(i = 0;i < level.flags.size;i++)
		{
			index = otherdata.size;
			otherdata[index] = spawnstruct();
			otherdata[index].origin = level.flags[i].origin;
			otherdata[index].text = level.flags[i].useobj maps/mp/gametypes_zm/_gameobjects::getownerteam() + " flag";
		}
	}

	str = otherdata.size + ",";
	for(i = 0;i < otherdata.size;i++)
	{
		str = str + vectostr(otherdata[i].origin) + "," + otherdata[i].text + ",";
	}

	fprintfields(file,str);
	closefile(file);
	thisspawnid = level.spawngameid + "." + level.spawnid;
	if(IsDefined(self.thisspawnid))
	{
	}

	self.thisspawnid = thisspawnid;
#/
}

//Function Number: 22
readspawndata(desiredid,relativepos)
{
/#
	file = openfile("spawndata.txt","read");
	if(file < 0)
	{
		return;
	}

	oldspawndata = level.curspawndata;
	level.curspawndata = undefined;
	prev = undefined;
	prevthisplayer = undefined;
	lookingfornextthisplayer = 0;
	lookingfornext = 0;
	if(IsDefined(relativepos) && !IsDefined(oldspawndata))
	{
		return;
	}

	while(1)
	{
		if(freadln(file) <= 0)
		{
			break;
		}

		data = spawnstruct();
		data.id = fgetarg(file,0);
		numspawns = int(fgetarg(file,1));
		if(numspawns > 256)
		{
			break;
		}

		data.playername = fgetarg(file,2);
		data.spawnpoints = [];
		data.friends = [];
		data.enemies = [];
		data.otherdata = [];
		for(i = 0;i < numspawns;i++)
		{
			if(freadln(file) <= 0)
			{
				break;
			}

			spawnpoint = spawnstruct();
			spawnpoint.origin = strtovec(fgetarg(file,0));
			spawnpoint.winner = int(fgetarg(file,1));
			spawnpoint.weight = int(fgetarg(file,2));
			spawnpoint.data = [];
			spawnpoint.sightchecks = [];
			if(i == 0)
			{
				data.minweight = spawnpoint.weight;
				data.maxweight = spawnpoint.weight;
			}
			else
			{
				if(spawnpoint.weight < data.minweight)
				{
					data.minweight = spawnpoint.weight;
				}

				if(spawnpoint.weight > data.maxweight)
				{
					data.maxweight = spawnpoint.weight;
				}
			}

			argnum = 4;
			numdata = int(fgetarg(file,3));
			if(numdata > 256)
			{
				break;
			}

			for(j = 0;j < numdata;j++)
			{
				spawnpoint.data[spawnpoint.data.size] = fgetarg(file,argnum);
				argnum++;
			}

			numsightchecks = int(fgetarg(file,argnum));
			argnum++;
			if(numsightchecks > 256)
			{
				break;
			}

			for(j = 0;j < numsightchecks;j++)
			{
				index = spawnpoint.sightchecks.size;
				spawnpoint.sightchecks[index] = spawnstruct();
				spawnpoint.sightchecks[index].penalty = int(fgetarg(file,argnum));
				argnum++;
				spawnpoint.sightchecks[index].origin = strtovec(fgetarg(file,argnum));
				argnum++;
			}

			data.spawnpoints[data.spawnpoints.size] = spawnpoint;
		}

		if(!(IsDefined(data.minweight)))
		{
			data.minweight = -1;
			data.maxweight = 0;
		}

		if(data.minweight == data.maxweight)
		{
			data.minweight = data.minweight - 1;
		}

		if(freadln(file) <= 0)
		{
			break;
		}

		numfriends = int(fgetarg(file,0));
		numenemies = int(fgetarg(file,1));
		if(numfriends > 32 || numenemies > 32)
		{
			break;
		}

		argnum = 2;
		for(i = 0;i < numfriends;i++)
		{
			data.friends[data.friends.size] = strtovec(fgetarg(file,argnum));
			argnum++;
		}

		for(i = 0;i < numenemies;i++)
		{
			data.enemies[data.enemies.size] = strtovec(fgetarg(file,argnum));
			argnum++;
		}

		if(freadln(file) <= 0)
		{
			break;
		}

		numotherdata = int(fgetarg(file,0));
		argnum = 1;
		for(i = 0;i < numotherdata;i++)
		{
			otherdata = spawnstruct();
			otherdata.origin = strtovec(fgetarg(file,argnum));
			argnum++;
			otherdata.text = fgetarg(file,argnum);
			argnum++;
			data.otherdata[data.otherdata.size] = otherdata;
		}

		if(IsDefined(relativepos))
		{
			if(relativepos == "prevthisplayer")
			{
				if(data.id == oldspawndata.id)
				{
					level.curspawndata = prevthisplayer;
					break;
				}

				continue;
			}

			if(relativepos == "prev")
			{
				if(data.id == oldspawndata.id)
				{
					level.curspawndata = prev;
					break;
				}

				continue;
			}

			if(relativepos == "nextthisplayer")
			{
				if(lookingfornextthisplayer)
				{
					level.curspawndata = data;
					break;
				}
				else if(data.id == oldspawndata.id)
				{
					lookingfornextthisplayer = 1;
				}

				continue;
			}

			if(relativepos == "next")
			{
				if(lookingfornext)
				{
					level.curspawndata = data;
					break;
				}
				else if(data.id == oldspawndata.id)
				{
					lookingfornext = 1;
				}
			}
		}
		else if(data.id == desiredid)
		{
			level.curspawndata = data;
			break;
		}

		prev = data;
		if(IsDefined(oldspawndata) && data.playername == oldspawndata.playername)
		{
			prevthisplayer = data;
		}
	}

	closefile(file);
#/
}

//Function Number: 23
drawspawndata()
{
/#
	level notify("drawing_spawn_data");
	level endon("drawing_spawn_data");
	textoffset = VectorScale((0,0,-1));
	while(1)
	{
		if(!(IsDefined(level.curspawndata)))
		{
			wait(0.5);
			continue;
		}

		for(i = 0;i < level.curspawndata.friends.size;i++)
		{
			print3d(level.curspawndata.friends[i],"=)",(0.5,1,0.5),1,5);
		}

		for(i = 0;i < level.curspawndata.enemies.size;i++)
		{
			print3d(level.curspawndata.enemies[i],"=(",(1,0.5,0.5),1,5);
		}

		for(i = 0;i < level.curspawndata.otherdata.size;i++)
		{
			print3d(level.curspawndata.otherdata[i].origin,level.curspawndata.otherdata[i].text,(0.5,0.75,1),1,2);
		}

		for(i = 0;i < level.curspawndata.spawnpoints.size;i++)
		{
			sp = level.curspawndata.spawnpoints[i];
			orig = sp.sighttracepoint;
			if(sp.winner)
			{
				print3d(orig,level.curspawndata.playername + " spawned here",(0.5,0.5,1),1,2);
				orig = orig + textoffset;
			}

			amnt = sp.weight - level.curspawndata.minweight / level.curspawndata.maxweight - level.curspawndata.minweight;
			print3d(orig,"Weight: " + sp.weight,(1 - amnt,amnt,0.5));
			orig = orig + textoffset;
			for(j = 0;j < sp.data.size;j++)
			{
				print3d(orig,sp.data[j],(1,1,1));
				orig = orig + textoffset;
			}

			for(j = 0;j < sp.sightchecks.size;j++)
			{
				print3d(orig,"Sightchecks: -" + sp.sightchecks[j].penalty,(1,0.5,0.5));
				orig = orig + textoffset;
			}
		}

		wait(0.05);
	}
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
	if(parts.size != 3)
	{
		return (0,0,0);
	}

	return (int(parts[0]),int(parts[1]),int(parts[2]));
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
	if(level.storespawndata || level.debugspawning)
	{
		for(i = 0;i < spawnpoints.size;i++)
		{
			spawnpoints[i].spawndata = [];
			spawnpoints[i].sightchecks = [];
		}
	}
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
	if(GetDvar(#"6486379A") == "")
	{
		setdvar("scr_spawn_randomly","0");
	}

	if(GetDvar(#"6486379A") == "1")
	{
		return getspawnpoint_random(spawnpoints);
	}
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
			if(level.storespawndata || level.debugspawning)
			{
				spawnpoint.spawndata[spawnpoint.spawndata.size] = "Base weight: " + int(spawnpoint.weight) + " = (" + enemydistanceweight + "*" + int(enemydistsum) + " - " + allieddistanceweight + "*" + int(allydistsum) + ") / " + spawnpoint.numplayersatlastupdate;
			}
#/
		}
		else
		{
			spawnpoint.weight = 0;
/#
			if(level.storespawndata || level.debugspawning)
			{
				spawnpoint.spawndata[spawnpoint.spawndata.size] = "Base weight: 0";
			}
		}
#/
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
	if(GetDvar(#"9E85FAFC") == "")
	{
		setdvar("scr_spawn_showbad","0");
	}

	if(GetDvar(#"9E85FAFC") == "1")
	{
		checkbad(result);
	}
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
	if(GetDvar(#"96EBB72E") == "")
	{
		setdvar("scr_recordspawndata",0);
	}

	level.storespawndata = GetDvarInt(#"96EBB72E");
	if(GetDvar(#"45A06390") == "")
	{
		setdvar("scr_killbots",0);
	}

	if(GetDvar(#"1F9534FE") == "")
	{
		setdvar("scr_killbottimer",0.25);
	}

	thread loopbotspawns();
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
	if(GetDvar(#"292A749F") == "")
	{
		setdvar("scr_spawnsimple","0");
	}

	if(GetDvar(#"632110E6") == "")
	{
		setdvar("scr_spawnpointdebug","0");
	}

	if(GetDvarInt(#"632110E6") > 0)
	{
		thread showdeathsdebug();
		thread updatedeathinfodebug();
		thread profiledebug();
	}

	if(level.storespawndata)
	{
		thread allowspawndatareading();
	}

	if(GetDvar(#"7CA769A6") == "")
	{
		setdvar("scr_spawnprofile","0");
	}

	thread watchspawnprofile();
	thread spawngraphcheck();
#/
}

//Function Number: 36
watchspawnprofile()
{
/#
	while(1)
	{
		while(1)
		{
			if(GetDvarInt(#"7CA769A6") > 0)
			{
				break;
			}

			wait(0.05);
		}

		thread spawnprofile();
		while(1)
		{
			if(GetDvarInt(#"7CA769A6") <= 0)
			{
				break;
			}

			wait(0.05);
		}

		level notify("stop_spawn_profile");
	}
#/
}

//Function Number: 37
spawnprofile()
{
/#
	level endon("stop_spawn_profile");
	while(1)
	{
		if(level.players.size > 0 && level.spawnpoints.size > 0)
		{
			playernum = randomint(level.players.size);
			player = level.players[playernum];
			attempt = 1;
			while(!IsDefined(player) && attempt < level.players.size)
			{
				playernum = playernum + 1 % level.players.size;
				attempt++;
				player = level.players[playernum];
			}

			player getspawnpoint_nearteam(level.spawnpoints);
		}

		wait(0.05);
	}
#/
}

//Function Number: 38
spawngraphcheck()
{
/#
	while(1)
	{
		if(GetDvarInt(#"C25B6B47") < 1)
		{
			wait(3);
			continue;
		}

		thread spawngraph();
		return;
	}
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
	if(corners.size != 2)
	{
		println("^1 can\'t spawn graph: no minimap corners");
		return;
	}

	min = corners[0].origin;
	max = corners[0].origin;
	if(corners[1].origin[0] > max[0])
	{
		max = (corners[1].origin[0],max[1],max[2]);
	}
	else
	{
		min = (corners[1].origin[0],min[1],min[2]);
	}

	if(corners[1].origin[1] > max[1])
	{
		max = (max[0],corners[1].origin[1],max[2]);
	}
	else
	{
		min = (min[0],corners[1].origin[1],min[2]);
	}

	i = 0;
	for(y = 0;y < h;y++)
	{
		yamnt = y / h - 1;
		for(x = 0;x < w;x++)
		{
			xamnt = x / w - 1;
			fakespawnpoints[i] = spawnstruct();
			fakespawnpoints[i].origin = (min[0] * xamnt + max[0] * 1 - xamnt,min[1] * yamnt + max[1] * 1 - yamnt,min[2]);
			fakespawnpoints[i].angles = (0,0,0);
			fakespawnpoints[i].forward = AnglesToForward(fakespawnpoints[i].angles);
			fakespawnpoints[i].sighttracepoint = fakespawnpoints[i].origin;
			i++;
		}
	}

	didweights = 0;
	while(1)
	{
		spawni = 0;
		numiters = 5;
		for(i = 0;i < numiters;i++)
		{
			if(!level.players.size || !IsDefined(level.players[0].team) || level.players[0].team == "spectator" || !IsDefined(level.players[0].class))
			{
				break;
			}

			endspawni = spawni + fakespawnpoints.size / numiters;
			if(i == numiters - 1)
			{
				endspawni = fakespawnpoints.size;
			}

			while(spawni < endspawni)
			{
				spawnpointupdate(fakespawnpoints[spawni]);
				spawni++;
			}

			if(didweights)
			{
				level.players[0] drawspawngraph(fakespawnpoints,w,h,weightscale);
			}

			wait(0.05);
		}

		if(!level.players.size || !IsDefined(level.players[0].team) || level.players[0].team == "spectator" || !IsDefined(level.players[0].class))
		{
			wait(1);
			continue;
		}

		level.players[0] getspawnpoint_nearteam(fakespawnpoints);
		for(i = 0;i < fakespawnpoints.size;i++)
		{
			setupspawngraphpoint(fakespawnpoints[i],weightscale);
		}

		didweights = 1;
		level.players[0] drawspawngraph(fakespawnpoints,w,h,weightscale);
		wait(0.05);
	}
#/
}

//Function Number: 40
drawspawngraph(fakespawnpoints,w,h,weightscale)
{
/#
	i = 0;
	for(y = 0;y < h;y++)
	{
		yamnt = y / h - 1;
		for(x = 0;x < w;x++)
		{
			xamnt = x / w - 1;
			if(y > 0)
			{
				spawngraphline(fakespawnpoints[i],fakespawnpoints[i - w],weightscale);
			}

			if(x > 0)
			{
				spawngraphline(fakespawnpoints[i],fakespawnpoints[i - 1],weightscale);
			}

			i++;
		}
	}
#/
}

//Function Number: 41
setupspawngraphpoint(s1,weightscale)
{
/#
	s1.visible = 1;
	if(s1.weight < -1000 / weightscale)
	{
		s1.visible = 0;
	}
#/
}

//Function Number: 42
spawngraphline(s1,s2,weightscale)
{
/#
	if(!s1.visible || !s2.visible)
	{
		return;
	}

	p1 = s1.origin + (0,0,s1.weight * weightscale + 100);
	p2 = s2.origin + (0,0,s2.weight * weightscale + 100);
	line(p1,p2,(1,1,1));
#/
}

//Function Number: 43
loopbotspawns()
{
/#
	while(1)
	{
		if(GetDvarInt(#"45A06390") < 1)
		{
			wait(3);
			continue;
		}

		if(!(IsDefined(level.players)))
		{
			wait(0.05);
			continue;
		}

		bots = [];
		for(i = 0;i < level.players.size;i++)
		{
			if(!(IsDefined(level.players[i])))
			{
			}
			else if(level.players[i].sessionstate == "playing" && issubstr(level.players[i].name,"bot"))
			{
				bots[bots.size] = level.players[i];
			}
		}

		if(bots.size > 0)
		{
			if(GetDvarInt(#"45A06390") == 1)
			{
				killer = bots[randomint(bots.size)];
				victim = bots[randomint(bots.size)];
				victim thread [[ level.callbackplayerdamage ]](killer,killer,1000,0,"MOD_RIFLE_BULLET","none",(0,0,0),(0,0,0),"none",0,0);
			}
			else
			{
				numkills = GetDvarInt(#"45A06390");
				lastvictim = undefined;
				for(index = 0;index < numkills;index++)
				{
					killer = bots[randomint(bots.size)];
					victim = bots[randomint(bots.size)];
					while(IsDefined(lastvictim) && victim == lastvictim)
					{
						victim = bots[randomint(bots.size)];
					}

					victim thread [[ level.callbackplayerdamage ]](killer,killer,1000,0,"MOD_RIFLE_BULLET","none",(0,0,0),(0,0,0),"none",0,0);
					lastvictim = victim;
				}
			}
		}

		if(GetDvar(#"1F9534FE") != "")
		{
			wait(GetDvarFloat(#"1F9534FE"));
			continue;
		}

		wait(0.05);
	}
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
	while(1)
	{
		val = GetDvar(#"E0FC7E63");
		relval = undefined;
		if(!IsDefined(val) || val == prevval)
		{
			relval = GetDvar(#"4058B332");
			if(IsDefined(relval) && relval != "")
			{
				setdvar("scr_spawnidcycle","");
				break;
			}

			wait(0.5);
			continue;
		}

		prevval = val;
		readthistime = 0;
		readspawndata(val,relval);
		if(!(IsDefined(level.curspawndata)))
		{
			println("No spawn data to draw.");
		}
		else
		{
			println("Drawing spawn ID " + level.curspawndata.id);
		}

		thread drawspawndata();
	}
#/
}

//Function Number: 45
showdeathsdebug()
{
/#
	while(1)
	{
		if(GetDvar(#"632110E6") == "0")
		{
			wait(3);
			continue;
		}

		time = GetTime();
		for(i = 0;i < level.spawnlogic_deaths.size;i++)
		{
			if(IsDefined(level.spawnlogic_deaths[i].los))
			{
				line(level.spawnlogic_deaths[i].org,level.spawnlogic_deaths[i].killorg,(1,0,0));
			}
			else
			{
				line(level.spawnlogic_deaths[i].org,level.spawnlogic_deaths[i].killorg,(1,1,1));
			}

			killer = level.spawnlogic_deaths[i].killer;
			if(IsDefined(killer) && isalive(killer))
			{
				line(level.spawnlogic_deaths[i].killorg,killer.origin,(0.4,0.4,0.8));
			}
		}

		for(p = 0;p < level.players.size;p++)
		{
			if(!(IsDefined(level.players[p])))
			{
			}
			else if(IsDefined(level.players[p].spawnlogic_killdist))
			{
				print3d(64 + VectorScale((0,0,1)),level.players[p].origin,level.players[p].spawnlogic_killdist);
			}
		}

		oldspawnkills = level.spawnlogic_spawnkills;
		level.spawnlogic_spawnkills = [];
		for(i = 0;i < oldspawnkills.size;i++)
		{
			spawnkill = oldspawnkills[i];
			if(spawnkill.dierwasspawner)
			{
				line(spawnkill.spawnpointorigin,spawnkill.dierorigin,(0.4,0.5,0.4));
				line(spawnkill.dierorigin,spawnkill.killerorigin,(0,1,1));
				print3d(32 + VectorScale((0,0,1)),spawnkill.dierorigin,"SPAWNKILLED!");
			}
			else
			{
				line(spawnkill.spawnpointorigin,spawnkill.killerorigin,(0.4,0.5,0.4));
				line(spawnkill.killerorigin,spawnkill.dierorigin,(0,1,1));
				print3d(32 + VectorScale((0,0,1)),spawnkill.dierorigin,"SPAWNDIED!");
			}

			if(time - spawnkill.time < 60000)
			{
				level.spawnlogic_spawnkills[level.spawnlogic_spawnkills.size] = oldspawnkills[i];
			}
		}

		wait(0.05);
	}
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
	while(1)
	{
		if(GetDvar(#"632110E6") == "0")
		{
			wait(3);
			continue;
		}

		textoffset = VectorScale((0,0,-1));
		for(i = 0;i < spawnpoints.size;i++)
		{
			amnt = 1 * 1 - spawnpoints[i].weight / -100000;
			if(amnt < 0)
			{
				amnt = 0;
			}

			if(amnt > 1)
			{
				amnt = 1;
			}

			orig = 80 + VectorScale((0,0,1));
			print3d(orig,int(spawnpoints[i].weight),(1,amnt,0.5));
			orig = orig + textoffset;
			if(IsDefined(spawnpoints[i].spawndata))
			{
				for(j = 0;j < spawnpoints[i].spawndata.size;j++)
				{
					print3d(orig,spawnpoints[i].spawndata[j],VectorScale((1,1,1)));
					orig = orig + textoffset;
				}
			}

			if(IsDefined(spawnpoints[i].sightchecks))
			{
				for(j = 0;j < spawnpoints[i].sightchecks.size;j++)
				{
					if(spawnpoints[i].sightchecks[j].penalty == 0)
					{
					}
					else
					{
						print3d(orig,"Sight to enemy: -" + spawnpoints[i].sightchecks[j].penalty,VectorScale((1,1,1)));
						orig = orig + textoffset;
					}
				}
			}
		}

		wait(0.05);
	}
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
	if(GetDvar(#"632110E6") == "0")
	{
		return;
	}

	starttime = GetTime();
	while(1)
	{
		for(i = 0;i < players.size;i++)
		{
			line(players[i].origin,origin,(0.5,1,0.5));
		}

		if(GetTime() - starttime > 5000)
		{
			return;
		}

		wait(0.05);
	}
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
				if(level.storespawndata || level.debugspawning)
				{
					spawnpoints[i].spawndata[spawnpoints[i].spawndata.size] = "Was near grenade: -" + int(weapondamagepenalty);
				}
			}
#/
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
					if(debug)
					{
						line(50 + VectorScale((0,0,1)),player.origin,spawnpoint.sighttracepoint);
					}
				}
			}
		}
#/
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
				if(level.storespawndata || level.debugspawning)
				{
					index = spawnpoints[i].sightchecks.size;
					spawnpoints[i].sightchecks[index] = spawnstruct();
					spawnpoints[i].sightchecks[index].penalty = penalty;
				}
			}
#/
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
				if(level.storespawndata || level.debugspawning)
				{
					index = spawnpoints[i].sightchecks.size;
					spawnpoints[i].sightchecks[index] = spawnstruct();
					spawnpoints[i].sightchecks[index].penalty = penalty;
				}
			}
#/
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
					if(level.storespawndata || level.debugspawning)
					{
						spawnpoints[i].spawndata[spawnpoints[i].spawndata.size] = "Nearest enemy at " + int(spawnpoints[i].minenemydist[mindistteam]) + " units: -" + int(penalty);
					}
				}
			}
#/
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
					if(level.storespawndata || level.debugspawning)
					{
						spawnpoint.spawndata[spawnpoint.spawndata.size] = "Was recently used: -" + worsen;
					}
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
			if(level.storespawndata || level.debugspawning)
			{
				spawnpoints[i].spawndata[spawnpoints[i].spawndata.size] = "Was last spawnpoint: -50000";
			}
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