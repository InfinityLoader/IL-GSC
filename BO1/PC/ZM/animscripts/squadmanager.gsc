
init_squadManager()
{
	if (IsDefined (anim.squadInitialized) && anim.squadInitialized)
	{
		return;
	}
	anim.squadCreateFuncs = [];
	anim.squadCreateStrings = [];
	anim.squads = [];
	anim.squadIndex = [];
	anim.squadRand = 0;
	anim.squadInitialized = true;
}
createSquad(squadName)
{
	assertex (!IsDefined (anim.squads[squadName]), "createSquad attempted to create a squad with the same name as an existing squad");
	anim.squads[squadName] = SpawnStruct();
	squad = anim.squads[squadName];
	squad.squadName = squadName;
	squad.sightTime = 0;
	squad.origin = undefined;
	squad.forward = undefined;
	squad.enemy = undefined;
	squad.isInCombat = false;
	squad.memberCount = 0;
	squad.members = [];
	squad.officers = [];
	squad.officerCount = 0;
	squad.squadList = [];
	squad.memberAddFuncs = [];
	squad.memberAddStrings = [];
	squad.memberRemoveFuncs = [];
	squad.memberRemoveStrings = [];
	squad.squadUpdateFuncs = [];
	squad.squadUpdateStrings = [];
	squad.squadID = anim.squadIndex.size;
	squad initState ("combat", 0.75);
	squad initState ("cover", 0.75);
	squad initState ("move", 0.75);
	squad initState ("stop", 0.75);
	squad initState ("death", 0.75);
	squad initState ("suppressed", 0.75);
	squad initState ("attacking", 0.5);
	anim.squadIndex[anim.squadIndex.size] = squad;
	squad updateSquadList();
	level notify ("squad created " + squadName);
	anim notify ("squad created " + squadName);
	for (i = 0; i < anim.squadCreateFuncs.size; i++)
	{
		squadCreateFunc = anim.squadCreateFuncs[i];
		squad thread [[squadCreateFunc]] ();
	}
	for (i = 0; i < anim.squadIndex.size; i++)
	{
		anim.squadIndex[i] updateSquadList();
	}
	squad thread updateMemberStates();
	return (squad);
}
deleteSquad(squadName)
{
	assertex (IsDefined (anim.squads[squadName]), "deleteSquad attempted to delete a squad that does not exist");
	if (squadName == "axis" || squadName == "allies")
	{
		return;
	}
	squadID = anim.squads[squadName].squadID;
	squad = anim.squads[squadName];
	while (squad.members.size)
	{
		squad.members[0] addToSquad(squad.members[0].team);
	}
	anim.squadIndex[squadID] = anim.squadIndex[anim.squadIndex.size - 1];
	anim.squadIndex[squadID].squadID = squadID;
	anim.squadIndex[anim.squadIndex.size - 1] = undefined;
	anim.squads[squadName] = undefined;
	level notify ("squad deleted " + squadName);
	anim notify ("squad deleted " + squadName);
	for (i = 0; i < anim.squadIndex.size; i++)
	{
		anim.squadIndex[i] updateSquadList();
	}
}
generateSquadName()
{
	squadName = "auto" + anim.squadRand;
	anim.squadRand++;
	return (squadName);
}
addPlayerToSquad(squadName)
{
	if (!IsDefined (squadName))
	{
		if (IsDefined (self.script_squadname))
		{
			squadName = self.script_squadname;
		}
		else
		{
			squadName = self.team;
		}
	}
	if (!IsDefined (anim.squads[squadName]))
	{
		anim createSquad (squadName);
	}
	squad = anim.squads[squadName];
	self.squad = squad;
}
squadChange()
{
	self endon ("death");
	wait (10.0);
	if (!IsDefined (self.script_squadname))
	{
		squadName = (self.team + self.script_flanker);
	}
	else
	{
		squadName = (self.script_squadname + self.script_flanker);
	}
	self addToSquad (squadName);
}
addToSquad( squadName )
{
	assertex (IsSentient (self), "addToSquad attempted to add a non-sentient member to a squad");
	if ( !IsDefined( squadName ) )
	{
		if ( IsDefined( self.script_flanker ) )
		{
			self thread squadChange();
		}
		if (IsDefined (self.script_squadname))
		{
			squadName = self.script_squadname;
		}
		else
		{
			squadName = self.team;
		}
	}
	if ( !IsDefined( anim.squads[squadName] ) )
	{
		anim createSquad( squadName );
	}
	squad = anim.squads[squadName];
	if ( IsDefined( self.squad ) )
	{
		if ( self.squad == squad )
		{
			return;
		}
		else
		{
			self removeFromSquad();
		}
	}
	self.lastEnemySightTime = 0;
	self.combatTime = 0;
	self.squad = squad;
	self.memberID = squad.members.size;
	squad.members[self.memberID] = self;
	squad.memberCount = squad.members.size;
	if ( IsDefined( level.loadoutComplete ) )
	{
		if ( self.team == "allies" && self isOfficer() )
		{
			self addOfficerToSquad();
		}
	}
	for (i = 0; i < self.squad.memberAddFuncs.size; i++)
	{
		memberAddFunc = self.squad.memberAddFuncs[i];
		self thread [[memberAddFunc]] (self.squad.squadName);
	}
	self thread memberDeathWaiter();
}
removeFromSquad()
{
	assertex (IsDefined (self.squad), "removeFromSquad attempted to remove a member who was not part of a squad (self.squad == undefined)");
	squad = self.squad;
	memberID = -1;
	if (IsDefined (self))
	{
		memberID = self.memberID;
	}
	else
	{
		for (i = 0; i < squad.members.size; i++)
		{
			if (squad.members[i] == self)
			{
				memberID = i;
			}
		}
	}
	assertex (memberID > -1, "removeFromSquad could not find memberID");
	if (memberID != squad.members.size - 1)
	{
		other = squad.members[squad.members.size - 1];
		squad.members[memberID] = other;
		if (IsDefined (other))
		{
			other.memberID = memberID;
		}
	}
	squad.members[squad.members.size - 1] = undefined;
	squad.memberCount = squad.members.size;
	if (IsDefined (self.officerID))
	{
		self removeOfficerFromSquad();
	}
	for (i = 0; i < self.squad.memberRemoveFuncs.size; i++)
	{
		memberRemoveFunc = self.squad.memberRemoveFuncs[i];
		self thread [[memberRemoveFunc]] (squad.squadName);
	}
	assert (squad.members.size == squad.memberCount);
	if (squad.memberCount == 0)
	{
		deleteSquad (squad.squadName);
	}
	if (IsDefined (self))
	{
		self.squad = undefined;
		self.memberID = undefined;
	}
	self notify ("removed from squad");
}
addOfficerToSquad()
{
	squad = self.squad;
	if (IsDefined (self.officerID))
	{
		return;
	}
	assertex (!IsDefined (self.officerID), "addOfficerToSquad attempted to add a member that is already in an officers");
	self.officerID = squad.officers.size;
	squad.officers[self.officerID] = self;
	squad.officerCount = squad.officers.size;
}
removeOfficerFromSquad()
{
	squad = self.squad;
	officerID = -1;
	if (IsDefined (self))
	{
		officerID = self.officerID;
	}
	else
	{
		for (i = 0; i < squad.officers.size; i++)
		{
			if (squad.officers[i] == self)
			{
				officerID = i;
			}
		}
	}
	assertex (officerID > -1, "removeOfficerFromSquad could not find officerID");
	if (officerID != squad.officers.size - 1)
	{
		other = squad.officers[squad.officers.size - 1];
		squad.officers[officerID] = other;
		if (IsDefined (other))
		{
			other.officerID = officerID;
		}
	}
	squad.officers[squad.officers.size - 1] = undefined;
	squad.officerCount = squad.officers.size;
	assert (squad.officers.size == squad.officerCount);
	if (IsDefined (self))
	{
		self.officerID = undefined;
	}
}
officerWaiter()
{
	if (!IsDefined (level.loadoutComplete))
	{
		anim waittill ("loadout complete");
	}
	for (i = 0; i < self.members.size; i++)
	{
		if (self.members[i] isOfficer())
		{
			self.members[i] addOfficerToSquad();
		}
	}
}
updateWaiter()
{
	while (1)
	{
		anim waittill ("squadupdate", action);
		switch (action)
		{
			case "squadlist":
			self updateSquadList();
			break;
			case "combat":
			self updateCombat();
			break;
			case "origin":
			self updateOrigin();
			break;
			case "forward":
			self updateHeading();
			break;
		}
	}
}
squadTracker()
{
	anim endon ("squad deleted " + self.squadName);
	while (1)
	{
		self updateAll();
		wait (0.1);
	}
}
memberDeathWaiter()
{
	self endon ("removed from squad");
	self waittill ("death", attacker);
	self removeFromSquad();
}
memberCombatWaiter()
{
	self endon ("removed from squad");
	while (1)
	{
		self waittill ("enemy");
		if (!IsDefined (self.enemy))
		{
			self.squad notify ("squadupdate", "combat");
		}
		else
		{
			self.squad.isInCombat = true;
		}
		wait ( 0.05 );
	}
}
updateHeading()
{
	if (IsDefined (self.enemy))
	{
		self.forward = VectorNormalize (self.enemy.origin - self.origin);
		return;
	}
	newHeading = (0, 0, 0);
	numInfluences = 0;
	for (i = 0; i < self.members.size; i++)
	{
		if (!IsAlive(self.members[i]))
		{
			continue;
		}
		newHeading += AnglesToForward (self.members[i].angles);
		numInfluences++;
	}
	if (numInfluences)
	{
		self.forward = (newHeading[0] / numInfluences, newHeading[1] / numInfluences, newHeading[2] / numInfluences);
	}
	else
	{
		self.forward = newHeading;
	}
}
updateOrigin()
{
	newOrigin = (0, 0, 0);
	numInfluences = 0;
	for (i = 0; i < self.members.size; i++)
	{
		if (!IsAlive (self.members[i]))
		{
			continue;
		}
		newOrigin += self.members[i].origin;
		numInfluences++;
	}
	if (numInfluences)
	{
		self.origin = (newOrigin[0] / numInfluences, newOrigin[1] / numInfluences, newOrigin[2] / numInfluences);
	}
	else
	{
		self.origin = newOrigin;
	}
}
updateCombat()
{
	self.isInCombat = false;
	for (i = 0; i < anim.squadIndex.size; i++)
	{
		if (IsDefined (anim.squadIndex[i].squadName) )
		{
			self.squadList[anim.squadIndex[i].squadName].isInContact = false;
		}
	}
	for (i = 0; i < self.members.size; i++)
	{
		if (IsDefined (self.members[i].enemy) &&
		IsDefined (self.members[i].enemy.squad) &&
		IsDefined(self.members[i].enemy.squad.squadName) &&
		self.members[i].combatTime > 0)
		{
			if( isdefined( self.squadList[self.members[i].enemy.squad.squadName] ) )
			{
				self.squadList[self.members[i].enemy.squad.squadName].isInContact = true;
			}
		}
	}
}
updateAll()
{
	newOrigin = (0, 0, 0);
	numInfluences = 0;
	curEnemy = undefined;
	isInCombat = false;
	self updateCombat();
	for (i = 0; i < self.members.size; i++)
	{
		if (!IsAlive (self.members[i]))
		{
			continue;
		}
		newOrigin += self.members[i].origin;
		numInfluences++;
		if (IsDefined (self.members[i].enemy) && IsDefined (self.members[i].enemy.squad))
		{
			if (!IsDefined (curEnemy))
			{
				curEnemy = self.members[i].enemy.squad;
			}
			else if (self.members[i].enemy.squad.memberCount > curEnemy.memberCount)
			{
				curEnemy = self.members[i].enemy.squad;
			}
		}
	}
	if (numInfluences)
	{
		self.origin = (newOrigin[0] / numInfluences, newOrigin[1] / numInfluences, newOrigin[2] / numInfluences);
	}
	else
	{
		self.origin = newOrigin;
	}
	self.isInCombat = isInCombat;
	self.enemy = curEnemy;
	self updateHeading();
}
updateSquadList()
{
	for (i = 0; i < anim.squadIndex.size; i++)
	{
		if (!IsDefined (self.squadList[anim.squadIndex[i].squadName]))
		{
			self.squadList[anim.squadIndex[i].squadName] = SpawnStruct();
			self.squadList[anim.squadIndex[i].squadName].isInContact = false;
		}
		for (j = 0; j < self.squadUpdateFuncs.size; j++)
		{
			squadUpdateFunc = self.squadUpdateFuncs[j];
			self thread [[squadUpdateFunc]] (anim.squadIndex[i].squadName);
		}
	}
}
isOfficer()
{
	fullRank = self animscripts\battlechatter::getRank();
	return (fullRank == "sergeant" || fullRank == "lieutenant" || fullRank == "captain" || fullRank == "sergeant");
}
aiUpdateAnimState(animscript)
{
	switch (animscript)
	{
		case "combat":
		case "move":
		case "stop":
		case "death":
		self.a.state = animscript;
		break;
		case "pain":
		case "grenadecower":
		break;
		case "cover_crouch":
		case "cover_left":
		case "cover_prone":
		case "cover_right":
		case "cover_stand":
		case "cover_wide_left":
		case "cover_wide_right":
		case "concealment_crouch":
		case "concealment_prone":
		case "concealment_stand":
		case "stalingrad_cover_crouch":
		self.a.state = "cover";
		break;
		case "aim":
		case "l33t truckride combat":
		self.a.state = "combat";
		break;
	}
}
updateStates()
{
	self resetState ("combat");
	self resetState ("cover");
	self resetState ("move");
	self resetState ("stop");
	self resetState ("death");
	self resetState ("suppressed");
	self resetState ("attacking");
	for (i = 0; i < self.members.size; i++)
	{
		if (!IsAlive (self.members[i]))
		{
			continue;
		}
		self queryMemberAnimState (self.members[i]);
		self queryMemberState (self.members[i], "suppressed");
		self queryMemberState (self.members[i], "combat");
		self queryMemberState (self.members[i], "attacking");
		self queryMemberState (self.members[i], "cover");
	}
}
updateMemberStates()
{
	anim endon ("squad deleted " + self.squadName);
	timeSlice = 0.2;
	while (1)
	{
		for (i = 0; i < self.members.size; i++)
		{
			if (!IsAlive (self.members[i]))
			{
				continue;
			}
			self.members[i] aiUpdateMessages(timeSlice);
		}
		wait (timeSlice);
	}
}
aiUpdateCombat(timeSlice)
{
	if (IsDefined (self.lastEnemySightPos))
	{
		if (self.combatTime < 0)
		{
			self.combatTime = timeSlice;
		}
		else
		{
			self.combatTime += timeSlice;
		}
		self.lastEnemySightTime = GetTime();
		return;
	}
	else if (self issuppressed())
	{
		self.combatTime += timeSlice;
		return;
	}
	if (self.combatTime > 0)
	{
		self.combatTime = (0 - timeSlice);
	}
	else
	{
		self.combatTime -= timeSlice;
	}
}
aiUpdateSuppressed(timeSlice)
{
	if (self.suppressed)
	{
		if (self.suppressedTime < 0)
		{
			self.suppressedTime = timeSlice;
		}
		else
		{
			self.suppressedTime += timeSlice;
		}
		return;
	}
	if (self.suppressedTime > 0)
	{
		self.suppressedTime = (0 - timeSlice);
	}
	else
	{
		self.suppressedTime -= timeSlice;
	}
}
initState(state, activateRatio)
{
	self.squadStates[state] = SpawnStruct();
	self.squadStates[state].activateRatio = activateRatio;
	self.squadStates[state].isActive = false;
	self.squadStates[state].numActive = 0;
}
resetState(state)
{
	self.squadStates[state].isActive = false;
	self.squadStates[state].numActive = 0;
}
queryMemberAnimState(member)
{
	self.squadStates[member.a.state].numActive++;
	if (self.squadStates[member.a.state].numActive > (self.squadStates[member.a.state].activateRatio * self.members.size))
	{
		self.squadStates[member.a.state].isActive = true;
	}
}
queryMemberState(member, state)
{
	switch (state)
	{
		case "suppressed":
		if (member.suppressedTime > 1.0)
		{
			self.squadStates[state].numActive++;
		}
		break;
		case "combat":
		if (member.combatTime > 0.0)
		{
			self.squadStates[state].numActive++;
		}
		break;
		case "attacking":
		if (GetTime() < member.a.lastShootTime + 2000)
		{
			self.squadStates[state].numActive++;
		}
		break;
		case "cover":
		if (!member animscripts\battlechatter::isExposed())
		{
			self.squadStates[state].numActive++;
		}
		break;
	}
	if (self.squadStates[state].numActive > (self.squadStates[state].activateRatio * self.members.size))
	{
		self.squadStates[state].isActive = true;
	}
}
aiUpdateMessages(timeSlice)
{
	self removeExpiredMessages();
}
constructMessage(contents, lifetime, sender)
{
	assert( IsDefined(contents) );
	if( IsDefined(contents) )
	{
		message = SpawnStruct();
		if( !IsDefined(lifetime) )
		{
			lifetime = 0.05;
		}
		message.contents	= contents;
		message.sender = sender;
		message.sendTime	= GetTime();
		message.expireTime	= GetTime() + lifetime * 1000;
		return message;
	}
	return undefined;
}
postSquadMessage(contents, lifetime)
{
	assert( IsDefined(self.squad) );
	assert( IsDefined(self.squad.members) );
	message = constructMessage( contents, lifetime, self );
	if( IsDefined(message) )
	{
		for( i=0; i < self.squad.members.size; i++ )
		{
			if( !IsAlive(self.squad.members[i]) || self == self.squad.members[i] )
			{
				continue;
			}
			self.squad.members[i] postMessage(message);
		}
	}
}
postMessage(message)
{
	assert( IsDefined(message) );
	if( IsDefined(message) )
	{
		if( !IsDefined(self.messages) )
		{
			self.messages = [];
		}
		self.messages[ self.messages.size ] = message;
	}
}
hasMessage(contents)
{
	if( IsDefined(self.messages) && self.messages.size > 0 )
	{
		for( i=0; i < self.messages.size; i++ )
		{
			message = self.messages[i];
			if( IsDefined(message) && message.contents == contents )
			{
				return true;
			}
		}
	}
	return false;
}
removeExpiredMessages()
{
	if( IsDefined(self.messages) && self.messages.size > 0 )
	{
		newArray = [];
		for( i=0; i < self.messages.size; i++ )
		{
			message = self.messages[i];
			if( !IsDefined(message) || message.expireTime < GetTime() )
			{
				continue;
			}
			newArray[newArray.size] = message;
		}
		self.messages = newArray;
	}
}

 