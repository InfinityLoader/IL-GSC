/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_copter.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 18 ms
 * Timestamp: 10/28/2023 12:10:28 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.coptermodel = "vehicle_cobra_helicopter_fly";
	precachemodel(level.coptermodel);
	level.copter_maxaccel = 200;
	level.copter_maxvel = 700;
	level.copter_rotspeed = 90;
	level.copter_accellookahead = 2;
	level.coptercenteroffset = VectorScale((0,0,1));
	level.coptertargetoffset = VectorScale((0,0,1));
	level.copterexplosion = loadfx("explosions/fx_default_explosion");
	level.copterfinalexplosion = loadfx("explosions/fx_large_vehicle_explosion");
}

//Function Number: 2
getabovebuildingslocation(location)
{
	trace = bullettrace(10000 + VectorScale((0,0,1)),location,location,0);
	startorigin = 514 + VectorScale((0,0,-1));
	zpos = 0;
	maxxpos = 13;
	maxypos = 13;
	for(xpos = 0;xpos < maxxpos;xpos++)
	{
		for(ypos = 0;ypos < maxypos;ypos++)
		{
			thisstartorigin = startorigin + (xpos / maxxpos - 1 - 0.5 * 1024,ypos / maxypos - 1 - 0.5 * 1024,0);
			thisorigin = bullettrace(thisstartorigin,10000 + VectorScale((0,0,-1)),thisstartorigin,0);
			zpos = zpos + thisorigin["position"][2];
		}
	}

	zpos = zpos / maxxpos * maxypos;
	zpos = zpos + 850;
	return (location[0],location[1],zpos);
}

//Function Number: 3
vectorangle(v1,v2)
{
	dot = vectordot(v1,v2);
	if(dot >= 1)
	{
		return 0;
	}
	else if(dot <= -1)
	{
		return 180;
	}

	return acos(dot);
}

//Function Number: 4
vectortowardsothervector(v1,v2,angle)
{
	dot = vectordot(v1,v2);
	if(dot <= -1)
	{
		return v1;
	}

	v3 = vectornormalize(dot - VectorScale(v1));
	return sin(angle) + VectorScale(v3);
}

//Function Number: 5
veclength(v)
{
	return distance((0,0,0),v);
}

//Function Number: 6
createcopter(location,team,damagetrig)
{
	location = getabovebuildingslocation(location);
	scriptorigin = spawn("script_origin",location);
	scriptorigin.angles = VectorToAngles((1,0,0));
	copter = spawn("script_model",location);
	copter.angles = VectorToAngles((0,1,0));
	copter linkto(scriptorigin);
	scriptorigin.copter = copter;
	copter setmodel(level.coptermodel);
	copter playloopsound("mp_copter_ambience");
	damagetrig.origin = scriptorigin.origin;
	damagetrig thread mylinkto(scriptorigin);
	scriptorigin.damagetrig = damagetrig;
	scriptorigin.finaldest = location;
	scriptorigin.finalzdest = location[2];
	scriptorigin.desireddir = (1,0,0);
	scriptorigin.desireddirentity = undefined;
	scriptorigin.desireddirentityoffset = (0,0,0);
	scriptorigin.vel = (0,0,0);
	scriptorigin.dontascend = 0;
	scriptorigin.health = 2000;
	if(GetDvar(#"A8262D2E") != "")
	{
		scriptorigin.health = GetDvarFloat(#"A8262D2E");
	}

	scriptorigin.team = team;
	scriptorigin thread copterai();
	scriptorigin thread copterdamage(damagetrig);
	return scriptorigin;
}

//Function Number: 7
makecopterpassive()
{
	self.damagetrig notify("unlink");
	self.damagetrig = undefined;
	self notify("passive");
	self.desireddirentity = undefined;
	self.desireddir = undefined;
}

//Function Number: 8
makecopteractive(damagetrig)
{
	damagetrig.origin = self.origin;
	damagetrig thread mylinkto(self);
	self.damagetrig = damagetrig;
	self thread copterai();
	self thread copterdamage(damagetrig);
}

//Function Number: 9
mylinkto(obj)
{
	self endon("unlink");
	while(1)
	{
		self.angles = obj.angles;
		self.origin = obj.origin;
		wait(0.1);
	}
}

//Function Number: 10
setcopterdefensearea(areaent)
{
	self.areaent = areaent;
	self.areadescentpoints = [];
	if(IsDefined(areaent.target))
	{
		self.areadescentpoints = getentarray(areaent.target,"targetname");
	}

	for(i = 0;i < self.areadescentpoints.size;i++)
	{
		self.areadescentpoints[i].targetent = getent(self.areadescentpoints[i].target,"targetname");
	}
}

//Function Number: 11
copterai()
{
	self thread coptermove();
	self thread coptershoot();
	self endon("death");
	self endon("passive");
	flying = 1;
	descendingent = undefined;
	reacheddescendingent = 0;
	returningtoarea = 0;
	while(1)
	{
		if(!(IsDefined(self.areaent)))
		{
			wait(1);
			continue;
		}

		players = level.players;
		enemytargets = [];
		if(self.team != "neutral")
		{
			for(i = 0;i < players.size;i++)
			{
				if(isalive(players[i]) && IsDefined(players[i].pers["team"]) && players[i].pers["team"] != self.team && !IsDefined(players[i].usingobj))
				{
					playerorigin = players[i].origin;
					playerorigin = (playerorigin[0],playerorigin[1],self.areaent.origin[2]);
					if(distance(playerorigin,self.areaent.origin) < self.areaent.radius)
					{
						enemytargets[enemytargets.size] = players[i];
					}
				}
			}
		}

		insidetargets = [];
		outsidetargets = [];
		skyheight = bullettrace(self.origin,10000 + VectorScale((0,0,1)),self.origin,0)[undefined]["position"] - 10;
		besttarget = undefined;
		bestweight = 0;
		for(i = 0;i < enemytargets.size;i++)
		{
			inside = 0;
			trace = bullettrace(10 + VectorScale((0,0,1)),enemytargets[i].origin,10000 + VectorScale((0,0,1)),enemytargets[i].origin);
			if(trace["position"][2] >= skyheight)
			{
				outsidetargets[outsidetargets.size] = enemytargets[i];
			}
			else
			{
				insidetargets[insidetargets.size] = enemytargets[i];
			}
		}

		gotopos = undefined;
		calcedgotopos = 0;
		olddescendingent = undefined;
		if(flying)
		{
			if(outsidetargets.size == 0 && insidetargets.size > 0 && self.areadescentpoints.size > 0)
			{
				flying = 0;
				result = determinebestent(insidetargets,self.areadescentpoints,self.origin);
				descendingent = result["descendEnt"];
				if(IsDefined(descendingent))
				{
					gotopos = result["position"];
					continue;
				}

				flying = 1;
			}
		}
		else
		{
			olddescendingent = descendingent;
			if(insidetargets.size == 0)
			{
				flying = 1;
			}
			else
			{
				if(outsidetargets.size > 0)
				{
					if(!(IsDefined(descendingent)))
					{
						flying = 1;
					}
					else
					{
						calcedgotopos = 1;
						gotopos = determinebestpos(insidetargets,descendingent,self.origin);
						if(!(IsDefined(gotopos)))
						{
							flying = 1;
						}
					}
				}

				if(IsDefined(descendingent))
				{
					if(!(calcedgotopos))
					{
						gotopos = determinebestpos(insidetargets,descendingent,self.origin);
					}
				}

				if(!(IsDefined(gotopos)))
				{
					result = determinebestent(insidetargets,self.areadescentpoints,self.origin);
					if(IsDefined(result["descendEnt"]))
					{
						descendingent = result["descendEnt"];
						gotopos = result["position"];
						reacheddescendingent = 0;
					}
					else if(IsDefined(descendingent))
					{
						if(IsDefined(self.finaldest))
						{
							gotopos = self.finaldest;
							continue;
						}

						gotopos = descendingent.origin;
					}
					else
					{
						gotopos = undefined;
					}
				}

				if(!(IsDefined(gotopos)))
				{
					flying = 1;
				}
			}
		}

		if(flying)
		{
			desireddist = 2560;
			disttoarea = distance((self.origin[0],self.origin[1],self.areaent.origin[2]),self.areaent.origin);
			if(outsidetargets.size == 0 && disttoarea > self.areaent.radius + desireddist * 0.25)
			{
				returningtoarea = 1;
			}
			else if(disttoarea < self.areaent.radius * 0.5)
			{
				returningtoarea = 0;
			}

			if(outsidetargets.size == 0 && !returningtoarea)
			{
				if(self.team != "neutral")
				{
					for(i = 0;i < players.size;i++)
					{
						if(isalive(players[i]) && IsDefined(players[i].pers["team"]) && players[i].pers["team"] != self.team && !IsDefined(players[i].usingobj))
						{
							playerorigin = players[i].origin;
							playerorigin = (playerorigin[0],playerorigin[1],self.areaent.origin[2]);
							if(distance(players[i].origin,self.areaent.origin) > self.areaent.radius)
							{
								outsidetargets[outsidetargets.size] = players[i];
							}
						}
					}
				}
			}

			best = undefined;
			bestdist = 0;
			for(i = 0;i < outsidetargets.size;i++)
			{
				dist = Abs(distance(outsidetargets[i].origin,self.origin) - desireddist);
				if(!IsDefined(best) || dist < bestdist)
				{
					best = outsidetargets[i];
					bestdist = dist;
				}
			}

			if(IsDefined(best))
			{
				attackpos = best.origin + level.coptertargetoffset;
				gotopos = determinebestattackpos(attackpos,self.origin,desireddist);
				self setcopterdest(gotopos,0);
				self.desireddir = vectornormalize(attackpos - gotopos);
				self.desireddirentity = best;
				self.desireddirentityoffset = level.coptertargetoffset;
				wait(1);
				continue;
			}

			gotopos = getrandompos(self.areaent.origin,self.areaent.radius);
			self setcopterdest(gotopos,0);
			self.desireddir = undefined;
			self.desireddirentity = undefined;
			wait(1);
			continue;
		}

		if(distance(self.origin,descendingent.origin) < descendingent.radius)
		{
			reacheddescendingent = 1;
		}

		godirectly = IsDefined(olddescendingent) && olddescendingent == descendingent;
		godirectly = godirectly && reacheddescendingent;
		self.desireddir = vectornormalize(descendingent.targetent.origin - gotopos - level.coptercenteroffset);
		self.desireddirentity = descendingent.targetent;
		self.desireddirentityoffset = (0,0,0);
		if(gotopos != self.origin)
		{
			self setcopterdest(gotopos - level.coptercenteroffset,1,godirectly);
			wait(0.3);
			continue;
		}

		wait(0.3);
	}
}

//Function Number: 12
determinebestpos(targets,descendent,startorigin)
{
	targetpos = descendent.targetent.origin;
	circleradius = distance(targetpos,descendent.origin);
	bestpoint = undefined;
	bestdist = 0;
	for(i = 0;i < targets.size;i++)
	{
		enemypos = targets[i].origin + level.coptertargetoffset;
		passed = bullettracepassed(enemypos,targetpos,0,undefined);
		if(passed)
		{
			dir = targetpos - enemypos;
			dir = (dir[0],dir[1],0);
			isect = VectorScale(vectornormalize(dir)) + targetpos;
			isect = (isect[0],isect[1],descendent.origin[2]);
			dist = distance(isect,descendent.origin);
			if(dist <= descendent.radius)
			{
				dist = distance(isect,startorigin);
				if(!IsDefined(bestpoint) || dist < bestdist)
				{
					bestdist = dist;
					bestpoint = isect;
				}
			}
		}
	}

	return bestpoint;
}

//Function Number: 13
determinebestent(targets,descendents,startorigin)
{
	result = [];
	bestpos = undefined;
	bestent = 0;
	bestdist = 0;
	for(i = 0;i < descendents.size;i++)
	{
		thispos = determinebestpos(targets,descendents[i],startorigin);
		if(IsDefined(thispos))
		{
			thisdist = distance(thispos,startorigin);
			if(!IsDefined(bestpos) || thisdist < bestdist)
			{
				bestpos = thispos;
				bestent = i;
				bestdist = thisdist;
			}
		}
	}

	if(IsDefined(bestpos))
	{
		result["descendEnt"] = descendents[bestent];
		result["position"] = bestpos;
		return result;
	}

	result["descendEnt"] = undefined;
	return result;
}

//Function Number: 14
determinebestattackpos(targetpos,curpos,desireddist)
{
	targetposcopterheight = (targetpos[0],targetpos[1],curpos[2]);
	attackdirx = curpos - targetposcopterheight;
	attackdirx = vectornormalize(attackdirx);
	attackdiry = (0 - attackdirx[1],attackdirx[0],0);
	bestpos = undefined;
	bestdist = 0;
	for(i = 0;i < 8;i++)
	{
		theta = i / 8 * 360;
		thisdir = sin(theta) + VectorScale(attackdiry);
		traceend = desireddist + VectorScale(thisdir);
		losexists = bullettracepassed(targetpos,traceend,0,undefined);
		if(losexists)
		{
			thisdist = distance(traceend,curpos);
			if(!IsDefined(bestpos) || thisdist < bestdist)
			{
				bestpos = traceend;
				bestdist = thisdist;
			}
		}
	}

	gotopos = undefined;
	if(IsDefined(bestpos))
	{
		gotopos = bestpos;
	}
	else
	{
		dist = distance(targetposcopterheight,curpos);
		if(dist > desireddist)
		{
			gotopos = 0 - dist - desireddist + VectorScale(vectornormalize(attackdirx));
		}
		else
		{
			gotopos = self.origin;
		}
	}

	return gotopos;
}

//Function Number: 15
getrandompos(origin,radius)
{
	for(pos = origin + (randomfloat(2) - 1 * radius,randomfloat(2) - 1 * radius,0);distancesquared(pos,origin) > radius * radius;pos = origin + (randomfloat(2) - 1 * radius,randomfloat(2) - 1 * radius,0))
	{
	}

	return pos;
}

//Function Number: 16
coptershoot()
{
	self endon("death");
	self endon("passive");
	costhreshold = cos(10);
	while(1)
	{
		if(IsDefined(self.desireddirentity) && IsDefined(self.desireddirentity.origin))
		{
			mypos = self.origin + level.coptercenteroffset;
			enemypos = self.desireddirentity.origin + self.desireddirentityoffset;
			curdir = AnglesToForward(self.angles);
			enemydirraw = enemypos - mypos;
			enemydir = vectornormalize(enemydirraw);
			if(vectordot(curdir,enemydir) > costhreshold)
			{
				canseetarget = bullettracepassed(mypos,enemypos,0,undefined);
				if(!canseetarget && isplayer(self.desireddirentity) && isalive(self.desireddirentity))
				{
					canseetarget = bullettracepassed(mypos,self.desireddirentity geteye(),0,undefined);
				}

				if(canseetarget)
				{
					self playsound("mp_copter_shoot");
					numshots = 20;
					for(i = 0;i < numshots;i++)
					{
						mypos = self.origin + level.coptercenteroffset;
						dir = AnglesToForward(self.angles);
						dir = dir + (randomfloat(2) - 1 * 0.015,randomfloat(2) - 1 * 0.015,randomfloat(2) - 1 * 0.015);
						dir = vectornormalize(dir);
						self mymagicbullet(mypos,dir);
						wait(0.075);
					}

					wait(0.25);
				}
			}
		}

		wait(0.25);
	}
}

//Function Number: 17
mymagicbullet(pos,dir)
{
	damage = 20;
	if(GetDvar(#"9E8F8CB7") != "")
	{
		damage = GetDvarInt(#"9E8F8CB7");
	}

	trace = bullettrace(pos,10000 + VectorScale(dir),pos,1);
	if(IsDefined(trace["entity"]) && isplayer(trace["entity"]) && isalive(trace["entity"]))
	{
		trace["entity"] thread [[ level.callbackplayerdamage ]](self,self,damage,0,"MOD_RIFLE_BULLET","copter",self.origin,dir,"none",0,0);
	}
}

//Function Number: 18
setcopterdest(newlocation,descend,dontascend)
{
	self.finaldest = getabovebuildingslocation(newlocation);
	if(IsDefined(descend) && descend)
	{
		self.finalzdest = newlocation[2];
	}
	else
	{
		self.finalzdest = self.finaldest[2];
	}

	self.intransit = 1;
	self.dontascend = 0;
	if(IsDefined(dontascend))
	{
		self.dontascend = dontascend;
	}
}

//Function Number: 19
notifyarrived()
{
	wait(0.05);
	self notify("arrived");
}

//Function Number: 20
coptermove()
{
	self endon("death");
	if(IsDefined(self.coptermoverunning))
	{
		return;
	}

	self.coptermoverunning = 1;
	self.intransit = 0;
	interval = 0.15;
	zinterp = 0.1;
	tiltamnt = 0;
	while(1)
	{
		horizdistsquared = distancesquared((self.origin[0],self.origin[1],0),(self.finaldest[0],self.finaldest[1],0));
		donemoving = horizdistsquared < 100;
		neardest = horizdistsquared < 65536;
		self.intransit = 1;
		desiredz = 0;
		movinghorizontally = 1;
		movingvertically = 0;
		if(self.dontascend)
		{
			movingvertically = 1;
		}
		else if(!(neardest))
		{
			desiredz = getabovebuildingslocation(self.origin)[2];
			movinghorizontally = Abs(self.origin[2] - desiredz) <= 256;
			movingvertically = !movinghorizontally;
		}
		else
		{
			movingvertically = 1;
		}

		if(movinghorizontally)
		{
			if(movingvertically)
			{
				thisdest = (self.finaldest[0],self.finaldest[1],self.finalzdest);
				continue;
			}

			thisdest = self.finaldest;
		}
		else
		{
/#
			assert(movingvertically);
#/
			thisdest = (self.origin[0],self.origin[1],desiredz);
		}

		movevec = thisdest - self.origin;
		idealaccel = VectorScale(self.origin - level.copter_accellookahead + VectorScale(self.vel));
		vlen = veclength(idealaccel);
		if(vlen > level.copter_maxaccel)
		{
			idealaccel = VectorScale(idealaccel);
		}

		self.vel = self.vel + idealaccel;
		vlen = veclength(self.vel);
		if(vlen > level.copter_maxvel)
		{
			self.vel = VectorScale(self.vel);
		}

		thisdest = interval + VectorScale(self.vel);
		self moveto(thisdest,interval * 0.999);
		speed = veclength(self.vel);
		if(IsDefined(self.desireddirentity) && IsDefined(self.desireddirentity.origin))
		{
			self.destdir = vectornormalize(self.desireddirentity.origin + self.desireddirentityoffset - self.origin + level.coptercenteroffset);
		}
		else if(IsDefined(self.desireddir))
		{
			self.destdir = self.desireddir;
		}
		else if(movingvertically)
		{
			self.destdir = AnglesToForward(self.angles);
			self.destdir = vectornormalize((self.destdir[0],self.destdir[1],0));
		}
		else
		{
			tiltamnt = speed / level.copter_maxvel;
			tiltamnt = tiltamnt - 0.1 / 0.9;
			if(tiltamnt < 0)
			{
				tiltamnt = 0;
			}

			self.destdir = movevec;
			self.destdir = vectornormalize((self.destdir[0],self.destdir[1],0));
			tiltamnt = tiltamnt * 1 - vectorangle(AnglesToForward(self.angles),self.destdir) / 180;
			self.destdir = vectornormalize((self.destdir[0],self.destdir[1],tiltamnt * -0.4));
		}

		newdir = self.destdir;
		if(newdir[2] < -0.4)
		{
			newdir = vectornormalize((newdir[0],newdir[1],-0.4));
		}

		copterangles = self.angles;
		copterangles = combineangles(copterangles,VectorScale((0,1,0)));
		olddir = AnglesToForward(copterangles);
		thisrotspeed = level.copter_rotspeed;
		olddir2d = vectornormalize((olddir[0],olddir[1],0));
		newdir2d = vectornormalize((newdir[0],newdir[1],0));
		angle = vectorangle(olddir2d,newdir2d);
		angle3d = vectorangle(olddir,newdir);
		if(angle > 0.001 && thisrotspeed > 0.001)
		{
			thisangle = thisrotspeed * interval;
			if(thisangle > angle)
			{
				thisangle = angle;
			}

			newdir2d = vectortowardsothervector(olddir2d,newdir2d,thisangle);
			oldz = olddir[2] / veclength((olddir[0],olddir[1],0));
			newz = newdir[2] / veclength((newdir[0],newdir[1],0));
			interpz = oldz + newz - oldz * thisangle / angle;
			newdir = vectornormalize((newdir2d[0],newdir2d[1],interpz));
			copterangles = VectorToAngles(newdir);
			copterangles = combineangles(copterangles,VectorScale((0,-1,0)));
			self rotateto(copterangles,interval * 0.999);
		}
		else if(angle3d > 0.001 && thisrotspeed > 0.001)
		{
			thisangle = thisrotspeed * interval;
			if(thisangle > angle3d)
			{
				thisangle = angle3d;
			}

			newdir = vectortowardsothervector(olddir,newdir,thisangle);
			newdir = vectornormalize(newdir);
			copterangles = VectorToAngles(newdir);
			copterangles = combineangles(copterangles,VectorScale((0,-1,0)));
			self rotateto(copterangles,interval * 0.999);
		}

		wait(interval);
	}
}

//Function Number: 21
copterdamage(damagetrig)
{
	self endon("passive");
	while(1)
	{
		damagetrig waittill("damage",amount,attacker);
		if(IsDefined(attacker) && isplayer(attacker) && IsDefined(attacker.pers["team"]) && attacker.pers["team"] == self.team)
		{
			continue;
		}

		self.health = self.health - amount;
		if(self.health <= 0)
		{
			self thread copterdie();
			return;
		}
	}
}

//Function Number: 22
copterdie()
{
	self endon("passive");
	self death_notify_wrapper();
	self.dead = 1;
	self thread copterexplodefx();
	interval = 0.2;
	rottime = 15;
	self rotateyaw(360 + randomfloat(360),rottime);
	self rotatepitch(360 + randomfloat(360),rottime);
	self rotateroll(360 + randomfloat(360),rottime);
	while(1)
	{
		self.vel = 200 + VectorScale(VectorScale((0,0,-1)));
		newpos = interval + VectorScale(self.vel);
		pathclear = bullettracepassed(self.origin,newpos,0,undefined);
		if(!(pathclear))
		{
			break;
		}

		self moveto(newpos,interval * 0.999);
		wait(interval);
	}

	playfx(level.copterfinalexplosion,self.origin);
	fakeself = spawn("script_origin",self.origin);
	fakeself playsound("mp_copter_explosion");
	self notify("finaldeath",self.origin,interval,self.vel);
	deletecopter();
	wait(2);
	fakeself delete();
}

//Function Number: 23
deletecopter()
{
	if(IsDefined(self.damagetrig))
	{
		self.damagetrig notify("unlink");
		self.damagetrig = undefined;
	}

	self.copter delete();
	self delete();
}

//Function Number: 24
copterexplodefx()
{
	self endon("finaldeath");
	while(1)
	{
		playfx(level.copterexplosion,self.origin);
		self playsound("mp_copter_explosion");
		wait(0.5 + randomfloat(1));
	}
}