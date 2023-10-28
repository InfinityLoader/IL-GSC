/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\zm_utility.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 86
 * Decompile Time: 8 ms
 * Timestamp: 10/28/2023 12:11:32 AM
*******************************************************************/

#include maps/mp/_utility;
#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/utility;
#include maps/mp/animscripts/zm_shared;

//Function Number: 1
append_missing_legs_suffix(animstate)
{
	if(IsDefined(self.has_legs) && !self.has_legs && self hasanimstatefromasd(animstate + "_crawl"))
	{
		return animstate + "_crawl";
	}
}

//Function Number: 2
initanimtree(animscript)
{
	if(animscript != "pain" && animscript != "death")
	{
		self.a.special = "none";
	}

/#
	assert(IsDefined(animscript),"Animscript not specified in initAnimTree");
#/
	self.a.script = animscript;
}

//Function Number: 3
updateanimpose()
{
/#
	assert(self.a.movement == "stop" || self.a.movement == "walk" || self.a.movement == "run","UpdateAnimPose " + self.a.pose + " " + self.a.movement);
#/
	self.desired_anim_pose = undefined;
}

//Function Number: 4
initialize(animscript)
{
	if(IsDefined(self.longdeathstarting))
	{
		if(animscript != "pain" && animscript != "death")
		{
			self dodamage(self.health + 100,self.origin);
		}

		if(animscript != "pain")
		{
			self.longdeathstarting = undefined;
			self notify("kill_long_death");
		}
	}

	if(IsDefined(self.a.mayonlydie) && animscript != "death")
	{
		self dodamage(self.health + 100,self.origin);
	}

	if(IsDefined(self.a.postscriptfunc))
	{
		scriptfunc = self.a.postscriptfunc;
		self.a.postscriptfunc = undefined;
		[[ scriptfunc ]](animscript);
	}

	if(animscript != "death")
	{
		self.a.nodeath = 0;
	}

	self.isholdinggrenade = undefined;
	self.covernode = undefined;
	self.changingcoverpos = 0;
	self.a.scriptstarttime = GetTime();
	self.a.atconcealmentnode = 0;
	if(IsDefined(self.node) && self.node.type == "Conceal Crouch" || self.node.type == "Conceal Stand")
	{
		self.a.atconcealmentnode = 1;
	}

	initanimtree(animscript);
	updateanimpose();
}

//Function Number: 5
getnodeyawtoorigin(pos)
{
	if(IsDefined(self.node))
	{
		yaw = self.node.angles[1] - getyaw(pos);
	}
	else
	{
		yaw = self.angles[1] - getyaw(pos);
	}

	yaw = AngleClamp180(yaw);
	return yaw;
}

//Function Number: 6
getnodeyawtoenemy()
{
	pos = undefined;
	if(isvalidenemy(self.enemy))
	{
		pos = self.enemy.origin;
	}
	else
	{
		if(IsDefined(self.node))
		{
			forward = AnglesToForward(self.node.angles);
		}
		else
		{
			forward = AnglesToForward(self.angles);
		}

		forward = VectorScale(forward);
		pos = self.origin + forward;
	}

	if(IsDefined(self.node))
	{
		yaw = self.node.angles[1] - getyaw(pos);
	}
	else
	{
		yaw = self.angles[1] - getyaw(pos);
	}

	yaw = AngleClamp180(yaw);
	return yaw;
}

//Function Number: 7
getcovernodeyawtoenemy()
{
	pos = undefined;
	if(isvalidenemy(self.enemy))
	{
		pos = self.enemy.origin;
	}
	else
	{
		forward = AnglesToForward(self.covernode.angles + self.animarray["angle_step_out"][self.a.cornermode]);
		forward = VectorScale(forward);
		pos = self.origin + forward;
	}

	yaw = self.covernode.angles[1] + self.animarray["angle_step_out"][self.a.cornermode] - getyaw(pos);
	yaw = AngleClamp180(yaw);
	return yaw;
}

//Function Number: 8
getyawtospot(spot)
{
	pos = spot;
	yaw = self.angles[1] - getyaw(pos);
	yaw = AngleClamp180(yaw);
	return yaw;
}

//Function Number: 9
getyawtoenemy()
{
	pos = undefined;
	if(isvalidenemy(self.enemy))
	{
		pos = self.enemy.origin;
	}
	else
	{
		forward = AnglesToForward(self.angles);
		forward = VectorScale(forward);
		pos = self.origin + forward;
	}

	yaw = self.angles[1] - getyaw(pos);
	yaw = AngleClamp180(yaw);
	return yaw;
}

//Function Number: 10
getyaw(org)
{
	angles = VectorToAngles(org - self.origin);
	return angles[1];
}

//Function Number: 11
getyaw2d(org)
{
	angles = VectorToAngles((org[0],org[1],0) - (self.origin[0],self.origin[1],0));
	return angles[1];
}

//Function Number: 12
absyawtoenemy()
{
/#
	assert(isvalidenemy(self.enemy));
#/
	yaw = self.angles[1] - getyaw(self.enemy.origin);
	yaw = AngleClamp180(yaw);
	if(yaw < 0)
	{
		yaw = -1 * yaw;
	}

	return yaw;
}

//Function Number: 13
absyawtoenemy2d()
{
/#
	assert(isvalidenemy(self.enemy));
#/
	yaw = self.angles[1] - getyaw2d(self.enemy.origin);
	yaw = AngleClamp180(yaw);
	if(yaw < 0)
	{
		yaw = -1 * yaw;
	}

	return yaw;
}

//Function Number: 14
absyawtoorigin(org)
{
	yaw = self.angles[1] - getyaw(org);
	yaw = AngleClamp180(yaw);
	if(yaw < 0)
	{
		yaw = -1 * yaw;
	}

	return yaw;
}

//Function Number: 15
absyawtoangles(angles)
{
	yaw = self.angles[1] - angles;
	yaw = AngleClamp180(yaw);
	if(yaw < 0)
	{
		yaw = -1 * yaw;
	}

	return yaw;
}

//Function Number: 16
getyawfromorigin(org,start)
{
	angles = VectorToAngles(org - start);
	return angles[1];
}

//Function Number: 17
getyawtotag(tag,org)
{
	yaw = self gettagangles(tag)[1] - getyawfromorigin(org,self gettagorigin(tag));
	yaw = AngleClamp180(yaw);
	return yaw;
}

//Function Number: 18
getyawtoorigin(org)
{
	yaw = self.angles[1] - getyaw(org);
	yaw = AngleClamp180(yaw);
	return yaw;
}

//Function Number: 19
geteyeyawtoorigin(org)
{
	yaw = self gettagangles("TAG_EYE")[1] - getyaw(org);
	yaw = AngleClamp180(yaw);
	return yaw;
}

//Function Number: 20
getcovernodeyawtoorigin(org)
{
	yaw = self.covernode.angles[1] + self.animarray["angle_step_out"][self.a.cornermode] - getyaw(org);
	yaw = AngleClamp180(yaw);
	return yaw;
}

//Function Number: 21
isstanceallowedwrapper(stance)
{
	if(IsDefined(self.covernode))
	{
		return self.covernode doesnodeallowstance(stance);
	}

	return self isstanceallowed(stance);
}

//Function Number: 22
getclaimednode()
{
	mynode = self.node;
	if(IsDefined(mynode) && self nearnode(mynode) || IsDefined(self.covernode) && mynode == self.covernode)
	{
		return mynode;
	}
}

//Function Number: 23
getnodetype()
{
	mynode = getclaimednode();
	if(IsDefined(mynode))
	{
		return mynode.type;
	}

	return "none";
}

//Function Number: 24
getnodedirection()
{
	mynode = getclaimednode();
	if(IsDefined(mynode))
	{
		return mynode.angles[1];
	}

	return self.desiredangle;
}

//Function Number: 25
getnodeforward()
{
	mynode = getclaimednode();
	if(IsDefined(mynode))
	{
		return AnglesToForward(mynode.angles);
	}

	return AnglesToForward(self.angles);
}

//Function Number: 26
getnodeorigin()
{
	mynode = getclaimednode();
	if(IsDefined(mynode))
	{
		return mynode.origin;
	}

	return self.origin;
}

//Function Number: 27
safemod(a,b)
{
	result = int(a) % b;
	result = result + b;
	return result % b;
}

//Function Number: 28
angleclamp(angle)
{
	anglefrac = angle / 360;
	angle = anglefrac - floor(anglefrac) * 360;
	return angle;
}

//Function Number: 29
quadrantanimweights(yaw)
{
	forwardweight = 90 - Abs(yaw) / 90;
	leftweight = 90 - absangleclamp180(Abs(yaw - 90)) / 90;
	result["front"] = 0;
	result["right"] = 0;
	result["back"] = 0;
	result["left"] = 0;
	if(IsDefined(self.alwaysrunforward))
	{
/#
		assert(self.alwaysrunforward);
#/
		result["front"] = 1;
		return result;
	}

	useleans = GetDvarInt(#"24833BA3");
	if(forwardweight > 0)
	{
		result["front"] = forwardweight;
		if(leftweight > 0)
		{
			result["left"] = leftweight;
		}
		else
		{
			result["right"] = -1 * leftweight;
		}
	}
	else if(useleans)
	{
		result["back"] = -1 * forwardweight;
		if(leftweight > 0)
		{
			result["left"] = leftweight;
		}
		else
		{
			result["right"] = -1 * leftweight;
		}
	}
	else
	{
		backweight = -1 * forwardweight;
		if(leftweight > backweight)
		{
			result["left"] = 1;
		}
		else if(leftweight < forwardweight)
		{
			result["right"] = 1;
		}
		else
		{
			result["back"] = 1;
		}
	}

	return result;
}

//Function Number: 30
getquadrant(angle)
{
	angle = angleclamp(angle);
	if(angle < 45 || angle > 315)
	{
		quadrant = "front";
	}
	else if(angle < 135)
	{
		quadrant = "left";
	}
	else if(angle < 225)
	{
		quadrant = "back";
	}
	else
	{
		quadrant = "right";
	}

	return quadrant;
}

//Function Number: 31
isinset(input,set)
{
	for(i = set.size - 1;i >= 0;i--)
	{
		if(input == set[i])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 32
notifyaftertime(notifystring,killmestring,time)
{
	self endon("death");
	self endon(killmestring);
	wait(time);
	self notify(notifystring);
}

//Function Number: 33
drawstringtime(msg,org,color,timer)
{
/#
	maxtime = timer * 20;
	for(i = 0;i < maxtime;i++)
	{
		print3d(org,msg,color,1,1);
		wait(0.05);
	}
#/
}

//Function Number: 34
showlastenemysightpos(string)
{
/#
	self notify("got known enemy2");
	self endon("got known enemy2");
	self endon("death");
	if(!(isvalidenemy(self.enemy)))
	{
		return;
	}

	if(self.enemy.team == "allies")
	{
		color = (0.4,0.7,1);
	}
	else
	{
		color = (1,0.7,0.4);
	}

	while(1)
	{
		wait(0.05);
		if(!(IsDefined(self.lastenemysightpos)))
		{
			continue;
		}

		print3d(self.lastenemysightpos,string,color,1,2.15);
	}
#/
}

//Function Number: 35
debugtimeout()
{
	wait(5);
	self notify("timeout");
}

//Function Number: 36
debugposinternal(org,string,size)
{
/#
	self endon("death");
	self notify("stop debug " + org);
	self endon("stop debug " + org);
	ent = spawnstruct();
	ent thread debugtimeout();
	ent endon("timeout");
	if(self.enemy.team == "allies")
	{
		color = (0.4,0.7,1);
	}
	else
	{
		color = (1,0.7,0.4);
	}

	while(1)
	{
		wait(0.05);
		print3d(org,string,color,1,size);
	}
#/
}

//Function Number: 37
debugpos(org,string)
{
	thread debugposinternal(org,string,2.15);
}

//Function Number: 38
debugpossize(org,string,size)
{
	thread debugposinternal(org,string,size);
}

//Function Number: 39
showdebugproc(frompoint,topoint,color,printtime)
{
/#
	self endon("death");
	timer = printtime * 20;
	for(i = 0;i < timer;i = i + 1)
	{
		wait(0.05);
		line(frompoint,topoint,color);
	}
#/
}

//Function Number: 40
showdebugline(frompoint,topoint,color,printtime)
{
	self thread showdebugproc(frompoint,5 + VectorScale((0,0,-1)),topoint,color);
}

//Function Number: 41
getnodeoffset(node)
{
	if(IsDefined(node.offset))
	{
		return node.offset;
	}

	cover_left_crouch_offset = (-26,0.4,36);
	cover_left_stand_offset = (-32,7,63);
	cover_right_crouch_offset = (43.5,11,36);
	cover_right_stand_offset = (36,8.3,63);
	cover_crouch_offset = (3.5,-12.5,45);
	cover_stand_offset = (-3.7,-22,63);
	cornernode = 0;
	nodeoffset = (0,0,0);
	right = AnglesToRight(node.angles);
	forward = AnglesToForward(node.angles);
	switch(node.type)
	{
		case "Cover Left":
		case "Cover Left Wide":
			nodeoffset = calculatenodeoffset(right,forward,cover_left_crouch_offset);
			continue;
			nodeoffset = calculatenodeoffset(right,forward,cover_left_stand_offset);
			break;
	node isnodedontstand() && !node isnodedontcrouch()
			break;

		case "Cover Right":
		case "Cover Right Wide":
			nodeoffset = calculatenodeoffset(right,forward,cover_right_crouch_offset);
			continue;
			nodeoffset = calculatenodeoffset(right,forward,cover_right_stand_offset);
			break;
	node isnodedontstand() && !node isnodedontcrouch()
			break;

		case "Conceal Stand":
		case "Cover Stand":
		case "Turret":
			nodeoffset = calculatenodeoffset(right,forward,cover_stand_offset);
			break;

		case "Conceal Crouch":
		case "Cover Crouch":
		case "Cover Crouch Window":
			nodeoffset = calculatenodeoffset(right,forward,cover_crouch_offset);
			break;
	}

	node.offset = nodeoffset;
	return node.offset;
}

//Function Number: 42
calculatenodeoffset(right,forward,baseoffset)
{
	return baseoffset[1] + VectorScale(forward) + (0,0,baseoffset[2]);
}

//Function Number: 43
checkpitchvisibility(frompoint,topoint,atnode)
{
	pitch = AngleClamp180(VectorToAngles(topoint - frompoint)[0]);
	if(Abs(pitch) > 45)
	{
		if(IsDefined(atnode) && atnode.type != "Cover Crouch" && atnode.type != "Conceal Crouch")
		{
			return 0;
		}

		if(pitch > 45 || pitch < anim.covercrouchleanpitch - 45)
		{
			return 0;
		}
	}
}

//Function Number: 44
showlines(start,end,end2)
{
/#
	for(;;)
	{
		line(start,end,(1,0,0),1);
		wait(0.05);
		line(start,end2,(0,0,1),1);
		wait(0.05);
	}
#/
}

//Function Number: 45
anim_array(animarray,animweights)
{
	total_anims = animarray.size;
	idleanim = randomint(total_anims);
/#
	assert(total_anims);
#/
/#
	assert(animarray.size == animweights.size);
#/
	if(total_anims == 1)
	{
		return animarray[0];
	}

	weights = 0;
	total_weight = 0;
	for(i = 0;i < total_anims;i++)
	{
		total_weight = total_weight + animweights[i];
	}

	anim_play = randomfloat(total_weight);
	current_weight = 0;
	for(i = 0;i < total_anims;i++)
	{
		current_weight = current_weight + animweights[i];
		if(anim_play >= current_weight)
		{
		}
		else
		{
			idleanim = i;
			break;
		}
	}

	return animarray[idleanim];
}

//Function Number: 46
notforcedcover()
{
	return self.a.forced_cover == "none" || self.a.forced_cover == "Show";
}

//Function Number: 47
forcedcover(msg)
{
	return IsDefined(self.a.forced_cover) && self.a.forced_cover == msg;
}

//Function Number: 48
print3dtime(timer,org,msg,color,alpha,scale)
{
/#
	newtime = timer / 0.05;
	for(i = 0;i < newtime;i++)
	{
		print3d(org,msg,color,alpha,scale);
		wait(0.05);
	}
#/
}

//Function Number: 49
print3drise(org,msg,color,alpha,scale)
{
/#
	newtime = 100;
	up = 0;
	org = org;
	for(i = 0;i < newtime;i++)
	{
		up = up + 0.5;
		print3d(org + (0,0,up),msg,color,alpha,scale);
		wait(0.05);
	}
#/
}

//Function Number: 50
crossproduct(vec1,vec2)
{
	return vec1[0] * vec2[1] - vec1[1] * vec2[0] > 0;
}

//Function Number: 51
scriptchange()
{
	self.a.current_script = "none";
	self notify(anim.scriptchange);
}

//Function Number: 52
delayedscriptchange()
{
	wait(0.05);
	scriptchange();
}

//Function Number: 53
getgrenademodel()
{
	return getweaponmodel(self.grenadeweapon);
}

//Function Number: 54
sawenemymove(timer)
{
	if(!(IsDefined(timer)))
	{
		timer = 500;
	}

	return GetTime() - self.personalsighttime < timer;
}

//Function Number: 55
canthrowgrenade()
{
	if(!(self.grenadeammo))
	{
		return 0;
	}

	if(self.script_forcegrenade)
	{
		return 1;
	}

	return isplayer(self.enemy);
}

//Function Number: 56
random_weight(array)
{
	idleanim = randomint(array.size);
	if(array.size > 1)
	{
		anim_weight = 0;
		for(i = 0;i < array.size;i++)
		{
			anim_weight = anim_weight + array[i];
		}

		anim_play = randomfloat(anim_weight);
		anim_weight = 0;
		for(i = 0;i < array.size;i++)
		{
			anim_weight = anim_weight + array[i];
			if(anim_play < anim_weight)
			{
				idleanim = i;
				break;
			}
		}
	}

	return idleanim;
}

//Function Number: 57
setfootstepeffect(name,fx)
{
/#
	assert(IsDefined(name),"Need to define the footstep surface type.");
#/
/#
	assert(IsDefined(fx),"Need to define the mud footstep effect.");
#/
	if(!(IsDefined(anim.optionalstepeffects)))
	{
		anim.optionalstepeffects = [];
	}

	anim.optionalstepeffects[anim.optionalstepeffects.size] = name;
	level._effect["step_" + name] = fx;
	anim.optionalstepeffectfunction = maps/mp/animscripts/zm_shared::playfootstepeffect;
}

//Function Number: 58
persistentdebugline(start,end)
{
/#
	self endon("death");
	level notify("newdebugline");
	level endon("newdebugline");
	for(;;)
	{
		line(start,end,(0.3,1,0),1);
		wait(0.05);
	}
#/
}

//Function Number: 59
isnodedontstand()
{
	return self.spawnflags & 4 == 4;
}

//Function Number: 60
isnodedontcrouch()
{
	return self.spawnflags & 8 == 8;
}

//Function Number: 61
doesnodeallowstance(stance)
{
	if(stance == "stand")
	{
		return !self isnodedontstand();
	}
	else
	{
/#
		assert(stance == "crouch");
#/
		return !self isnodedontcrouch();
	}
}

//Function Number: 62
animarray(animname)
{
/#
	assert(IsDefined(self.a.array));
#/
/#
	if(!(IsDefined(self.a.array[animname])))
	{
		dumpanimarray();
/#
		assert(IsDefined(self.a.array[animname]),"self.a.array[ \" + animname + "\" ] is undefined");
	}
#/
#/
	return self.a.array[animname];
}

//Function Number: 63
animarrayanyexist(animname)
{
/#
	assert(IsDefined(self.a.array));
#/
/#
	if(!(IsDefined(self.a.array[animname])))
	{
		dumpanimarray();
/#
		assert(IsDefined(self.a.array[animname]),"self.a.array[ \" + animname + "\" ] is undefined");
	}
#/
#/
	return self.a.array[animname].size > 0;
}

//Function Number: 64
animarraypickrandom(animname)
{
/#
	assert(IsDefined(self.a.array));
#/
/#
	if(!(IsDefined(self.a.array[animname])))
	{
		dumpanimarray();
/#
		assert(IsDefined(self.a.array[animname]),"self.a.array[ \" + animname + "\" ] is undefined");
	}
#/
#/
/#
	assert(self.a.array[animname].size > 0);
#/
	if(self.a.array[animname].size > 1)
	{
		index = randomint(self.a.array[animname].size);
	}
	else
	{
		index = 0;
	}

	return self.a.array[animname][index];
}

//Function Number: 65
dumpanimarray()
{
/#
	println("self.a.array:");
	keys = getarraykeys(self.a.array);
	for(i = 0;i < keys.size;i++)
	{
		if(isarray(self.a.array[keys[i]]))
		{
			println(" array[ \" + keys[i] + "\" ] = {array of size " + self.a.array[keys[i]].size + "}");
		}
		else
		{
			println(" array[ \" + keys[i] + "\" ] = ",self.a.array[keys[i]]);
		}
	}
#/
}

//Function Number: 66
getanimendpos(theanim)
{
	movedelta = getmovedelta(theanim,0,1);
	return self localtoworldcoords(movedelta);
}

//Function Number: 67
isvalidenemy(enemy)
{
	if(!(IsDefined(enemy)))
	{
		return 0;
	}
}

//Function Number: 68
damagelocationisany(a,b,c,d,e,f,g,h,i,j,k,ovr)
{
	if(!(IsDefined(a)))
	{
		return 0;
	}

	if(self.damagelocation == a)
	{
		return 1;
	}

	if(!(IsDefined(b)))
	{
		return 0;
	}

	if(self.damagelocation == b)
	{
		return 1;
	}

	if(!(IsDefined(c)))
	{
		return 0;
	}

	if(self.damagelocation == c)
	{
		return 1;
	}

	if(!(IsDefined(d)))
	{
		return 0;
	}

	if(self.damagelocation == d)
	{
		return 1;
	}

	if(!(IsDefined(e)))
	{
		return 0;
	}

	if(self.damagelocation == e)
	{
		return 1;
	}

	if(!(IsDefined(f)))
	{
		return 0;
	}

	if(self.damagelocation == f)
	{
		return 1;
	}

	if(!(IsDefined(g)))
	{
		return 0;
	}

	if(self.damagelocation == g)
	{
		return 1;
	}

	if(!(IsDefined(h)))
	{
		return 0;
	}

	if(self.damagelocation == h)
	{
		return 1;
	}

	if(!(IsDefined(i)))
	{
		return 0;
	}

	if(self.damagelocation == i)
	{
		return 1;
	}

	if(!(IsDefined(j)))
	{
		return 0;
	}

	if(self.damagelocation == j)
	{
		return 1;
	}

	if(!(IsDefined(k)))
	{
		return 0;
	}

	if(self.damagelocation == k)
	{
		return 1;
	}

/#
	assert(!IsDefined(ovr));
#/
	return 0;
}

//Function Number: 69
ragdolldeath(moveanim)
{
	self endon("killanimscript");
	lastorg = self.origin;
	movevec = (0,0,0);
	for(;;)
	{
		wait(0.05);
		force = distance(self.origin,lastorg);
		lastorg = self.origin;
		if(self.health == 1)
		{
			self.a.nodeath = 1;
			self startragdoll();
			wait(0.05);
			physicsexplosionsphere(lastorg,600,0,force * 0.1);
			self notify("killanimscript");
			return;
		}
	}
}

//Function Number: 70
iscqbwalking()
{
	return IsDefined(self.cqbwalking) && self.cqbwalking;
}

//Function Number: 71
squared(value)
{
	return value * value;
}

//Function Number: 72
randomizeidleset()
{
	self.a.idleset = randomint(2);
}

//Function Number: 73
getrandomintfromseed(intseed,intmax)
{
/#
	assert(intmax > 0);
#/
	index = intseed % anim.randominttablesize;
	return anim.randominttable[index] % intmax;
}

//Function Number: 74
is_banzai()
{
	return IsDefined(self.banzai) && self.banzai;
}

//Function Number: 75
is_heavy_machine_gun()
{
	return IsDefined(self.heavy_machine_gunner) && self.heavy_machine_gunner;
}

//Function Number: 76
is_zombie()
{
	if(IsDefined(self.is_zombie) && self.is_zombie)
	{
		return 1;
	}
}

//Function Number: 77
is_civilian()
{
	if(IsDefined(self.is_civilian) && self.is_civilian)
	{
		return 1;
	}
}

//Function Number: 78
is_zombie_gibbed()
{
	return self is_zombie() && self.gibbed;
}

//Function Number: 79
set_zombie_gibbed()
{
	if(self is_zombie())
	{
		self.gibbed = 1;
	}
}

//Function Number: 80
is_skeleton(skeleton)
{
	if(skeleton == "base" && issubstr(get_skeleton(),"scaled"))
	{
		return 1;
	}

	return get_skeleton() == skeleton;
}

//Function Number: 81
get_skeleton()
{
	if(IsDefined(self.skeleton))
	{
		return self.skeleton;
	}
	else
	{
		return "base";
	}
}

//Function Number: 82
debug_anim_print(text)
{
/#
	if(IsDefined(level.dog_debug_anims) && level.dog_debug_anims)
	{
		println(text + " " + GetTime());
	}

	if(IsDefined(level.dog_debug_anims_ent) && level.dog_debug_anims_ent == self getentnum())
	{
		println(text + " " + GetTime());
	}
#/
}

//Function Number: 83
debug_turn_print(text,line)
{
/#
	if(IsDefined(level.dog_debug_turns) && level.dog_debug_turns == self getentnum())
	{
		duration = 200;
		currentyawcolor = (1,1,1);
		lookaheadyawcolor = (1,0,0);
		desiredyawcolor = (1,1,0);
		currentyaw = AngleClamp180(self.angles[1]);
		desiredyaw = AngleClamp180(self.desiredangle);
		lookaheaddir = self.lookaheaddir;
		lookaheadangles = VectorToAngles(lookaheaddir);
		lookaheadyaw = AngleClamp180(lookaheadangles[1]);
		println(text + " " + GetTime() + " cur: " + currentyaw + " look: " + lookaheadyaw + " desired: " + desiredyaw);
	}
#/
}

//Function Number: 84
play_sound_on_tag_endon_death(alias,tag)
{
	maps/mp/_utility::play_sound_on_tag(alias,tag);
}

//Function Number: 85
play_sound_in_space(alias,origin,master)
{
	org = spawn("script_origin",(0,0,1));
	if(!(IsDefined(origin)))
	{
		origin = self.origin;
	}

	org.origin = origin;
	if(IsDefined(master) && master)
	{
		org playsoundasmaster(alias);
	}
	else
	{
		org playsound(alias);
	}

	if(IsDefined(org))
	{
		org delete();
	}
}

//Function Number: 86
wait_network_frame()
{
	if(numremoteclients())
	{
		snapshot_ids = getsnapshotindexarray();
		for(acked = undefined;!(IsDefined(acked));acked = snapshotacknowledged(snapshot_ids))
		{
			level waittill("snapacknowledged");
		}
	}
	else
	{
		wait(0.1);
	}
}