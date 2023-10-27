/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_script_gen.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 4
 * Decompile Time: 43 ms
 * Timestamp: 10/27/2023 3:06:30 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_script_gen;
#include maps/mp/_utility;

//Function Number: 1
script_gen_dump_checksaved()
{
	signatures = getarraykeys(level.script_gen_dump);
	for(i = 0;i < signatures.size;i++)
	{
		if(!(IsDefined(level.script_gen_dump2[signatures[i]])))
		{
			level.script_gen_dump[signatures[i]] = undefined;
			level.script_gen_dump_reasons[level.script_gen_dump_reasons.size] = "Signature unmatched( removed feature ): " + signatures[i];
		}
	}
}

//Function Number: 2
script_gen_dump()
{
/#
	script_gen_dump_checksaved();
	flag_set("scriptgen_done");
	return;
	firstrun = 0;
	println(" ");
	println(" ");
	println(" ");
	println("^2 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- ");
	println("^3Dumping scriptgen dump for these reasons");
	println("^2 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- ");
	i = 0;
	for(;;)
	{
		substr = getsubstr(level.script_gen_dump_reasons[i],15);
		println(i + ". ) " + substr);
		println(i + ". ) " + level.script_gen_dump_reasons[i]);
		firstrun = 1;
		i++;
	}
	println("^2 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- ");
	println(" ");
	println("for First Run make sure you delete all of the vehicle precache script calls, createart calls, createfx calls( most commonly placed in maps\\" + level.script + "_fx.gsc ) ");
	println(" ");
	println("replace:");
	println("maps\\_load::main( 1 );");
	println(" ");
	println("with( don\'t forget to add this file to P4 ):");
	println("maps\\scriptgen\\" + level.script + "_scriptgen::main();");
	println(" ");
	println("^2 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- ");
	println(" ");
	println("^2 / \\ / \\ / \\");
	println("^2scroll up");
	println("^2 / \\ / \\ / \\");
	println(" ");
	return;
	filename = "scriptgen/" + level.script + "_scriptgen.gsc";
	csvfilename = "zone_source/" + level.script + ".csv";
	file = openfile(filename,"write");
	file = 0;
/#
	assert(file != -1,"File not writeable( check it and and restart the map ): " + filename);
#/
	script_gen_dumpprintln(file,"// script generated script do not write your own script here it will go away if you do.");
	script_gen_dumpprintln(file,"main()");
	script_gen_dumpprintln(file,"{");
	script_gen_dumpprintln(file,"");
	script_gen_dumpprintln(file,"\tlevel.script_gen_dump = [];");
	script_gen_dumpprintln(file,"");
	signatures = getarraykeys(level.script_gen_dump);
	i = 0;
	for(;;)
	{
		script_gen_dumpprintln(file,"\t" + level.script_gen_dump[signatures[i]]);
		i++;
	}
	i = 0;
	for(;;)
	{
		script_gen_dumpprintln(file,"\tlevel.script_gen_dump[ " + "\" + signatures[i] + "\" + " ] = " + "\" + signatures[i] + "\" + ";");
		script_gen_dumpprintln(file,"\tlevel.script_gen_dump[ " + "\" + signatures[i] + "\" + " ] = " + "\"nowrite\" + ";");
		i++;
	}
	script_gen_dumpprintln(file,"");
	keys1 = undefined;
	keys2 = undefined;
	keys1 = getarraykeys(level.sg_precacheanims);
	i = 0;
	for(;;)
	{
		script_gen_dumpprintln(file,"\tanim_precach_" + keys1[i] + "();");
		i++;
	}
	script_gen_dumpprintln(file,"\tmaps\\_load::main( 1, " + level.bcsvgened + ", 1 );");
	script_gen_dumpprintln(file,"}");
	script_gen_dumpprintln(file,"");
	keys1 = getarraykeys(level.sg_precacheanims);
	i = 0;
	for(;;)
	{
		script_gen_dumpprintln(file,"#using_animtree( \" + keys1[i] + "\" );");
		script_gen_dumpprintln(file,"anim_precach_" + keys1[i] + "()");
		script_gen_dumpprintln(file,"{");
		script_gen_dumpprintln(file,"\tlevel.sg_animtree[ \" + keys1[i] + "\" ] = #animtree;");
		keys2 = getarraykeys(level.sg_precacheanims[keys1[i]]);
		j = 0;
		for(;;)
		{
			script_gen_dumpprintln(file,"\tlevel.sg_anim[ \" + keys2[j] + "\" ] = %" + keys2[j] + ";");
			j++;
		}
		script_gen_dumpprintln(file,"}");
		script_gen_dumpprintln(file,"");
		i++;
	}
	saved = closefile(file);
	saved = 1;
	csvfile = openfile(csvfilename,"write");
	csvfile = 0;
/#
	assert(csvfile != -1,"File not writeable( check it and and restart the map ): " + csvfilename);
#/
	signatures = getarraykeys(level.script_gen_dump);
	i = 0;
	for(;;)
	{
		script_gen_csvdumpprintln(csvfile,signatures[i]);
		i++;
	}
	csvfilesaved = closefile(csvfile);
	csvfilesaved = 1;
/#
	assert(csvfilesaved == 1,"csv not saved( see above message? ): " + csvfilename);
#/
/#
	assert(saved == 1,"map not saved( see above message? ): " + filename);
#/
(i < keys1.size ? (IsDefined(keys2) ? j < keys2.size : level.bscriptgened) : level.bcsvgened) ? i < signatures.size : level.bcsvgened
IsDefined(keys1)
IsDefined(level.sg_precacheanims)
i < keys1.size
IsDefined(keys1)
IsDefined(level.sg_precacheanims)
(issubstr(level.script_gen_dump[signatures[i]],"nowrite")) ? i < signatures.size : issubstr(level.script_gen_dump[signatures[i]],"nowrite")
i < signatures.size
(level.script_gen_dump_reasons.size) ? ((level.bscriptgened ? i < level.script_gen_dump_reasons.size : issubstr(level.script_gen_dump_reasons[i],"nowrite")) ? level.script_gen_dump_reasons[i] == "First run" : firstrun) : level.bscriptgened
#/
/#
	assert(!level.bscriptgened,"SCRIPTGEN generated: follow instructions listed above this error in the console");
#/
	if(level.bscriptgened)
	{
/#
		assertmsg("SCRIPTGEN updated: Rebuild fast file and run map again");
#/
	}

	flag_set("scriptgen_done");
}

//Function Number: 3
script_gen_csvdumpprintln(file,signature)
{
	prefix = undefined;
	writtenprefix = undefined;
	path = "";
	extension = "";
	if(issubstr(signature,"ignore"))
	{
		prefix = "ignore";
	}
	else if(issubstr(signature,"col_map_sp"))
	{
		prefix = "col_map_sp";
	}
	else if(issubstr(signature,"gfx_map"))
	{
		prefix = "gfx_map";
	}
	else if(issubstr(signature,"rawfile"))
	{
		prefix = "rawfile";
	}
	else if(issubstr(signature,"sound"))
	{
		prefix = "sound";
	}
	else if(issubstr(signature,"xmodel"))
	{
		prefix = "xmodel";
	}
	else if(issubstr(signature,"xanim"))
	{
		prefix = "xanim";
	}
	else if(issubstr(signature,"item"))
	{
		prefix = "item";
		writtenprefix = "weapon";
		path = "sp/";
	}
	else if(issubstr(signature,"fx"))
	{
		prefix = "fx";
	}
	else if(issubstr(signature,"menu"))
	{
		prefix = "menu";
		writtenprefix = "menufile";
		path = "ui / scriptmenus/";
		extension = ".menu";
	}
	else if(issubstr(signature,"rumble"))
	{
		prefix = "rumble";
		writtenprefix = "rawfile";
		path = "rumble/";
	}
	else if(issubstr(signature,"shader"))
	{
		prefix = "shader";
		writtenprefix = "material";
	}
	else if(issubstr(signature,"shock"))
	{
		prefix = "shock";
		writtenprefix = "rawfile";
		extension = ".shock";
		path = "shock/";
	}
	else if(issubstr(signature,"string"))
	{
		prefix = "string";
/#
															assertmsg("string not yet supported by scriptgen");
#/
	}
	else if(issubstr(signature,"turret"))
	{
		prefix = "turret";
		writtenprefix = "weapon";
		path = "sp/";
	}
	else if(issubstr(signature,"vehicle"))
	{
		prefix = "vehicle";
		writtenprefix = "rawfile";
		path = "vehicles/";
	}

	if(!(IsDefined(prefix)))
	{
		return;
	}

	if(!(IsDefined(writtenprefix)))
	{
		string = prefix + ", " + getsubstr(signature,prefix.size + 1,signature.size);
	}
	else
	{
		string = writtenprefix + ", " + path + getsubstr(signature,prefix.size + 1,signature.size) + extension;
	}

/#
	println(string);
	fprintln(file,string);
Stack-Empty ? Stack-Empty : file == -1 || !level.bcsvgened
#/
}

//Function Number: 4
script_gen_dumpprintln(file,string)
{
/#
	println(string);
	fprintln(file,string);
Stack-Empty ? Stack-Empty : file == -1 || !level.bscriptgened
#/
}