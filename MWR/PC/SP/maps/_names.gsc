/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_names.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 248 ms
 * Timestamp: 10/27/2023 2:48:24 AM
*******************************************************************/

//Function Number: 1
main()
{
}

//Function Number: 2
setup_names()
{
	if(isdefined(level.names))
	{
		return;
	}

	var_00 = [];
	var_00[var_00.size] = "american";
	var_00[var_00.size] = "british";
	var_00[var_00.size] = "arab";
	var_00[var_00.size] = "russian";
	var_00[var_00.size] = "seal";
	var_00[var_00.size] = "taskforce";
	var_00[var_00.size] = "secretservice";
	var_00[var_00.size] = "multilingual";
	var_00[var_00.size] = "portuguese";
	var_00[var_00.size] = "shadowcompany";
	var_00[var_00.size] = "delta";
	var_00[var_00.size] = "french";
	var_00[var_00.size] = "african";
	var_00[var_00.size] = "czech";
	var_00[var_00.size] = "czech_surnames";
	var_00[var_00.size] = "pmc";
	var_00[var_00.size] = "xslice";
	var_00[var_00.size] = "kva";
	var_00[var_00.size] = "atlas";
	var_00[var_00.size] = "sentinel";
	var_00[var_00.size] = "squad";
	var_00[var_00.size] = "northkorea";
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		level.names[var_00[var_01]] = [];
	}

	add_name("american","Abrahamsson");
	add_name("american","Alavi");
	add_name("american","Alderman");
	add_name("american","Allen");
	add_name("american","Arya");
	add_name("american","Baker");
	add_name("american","Barb");
	add_name("american","Bartolucci");
	add_name("american","Bell");
	add_name("american","Blumel");
	add_name("american","Boon");
	add_name("american","Bowling");
	add_name("american","Campbell");
	add_name("american","Chen");
	add_name("american","Cherubini");
	add_name("american","Collier");
	add_name("american","Cotterell");
	add_name("american","Davis");
	add_name("american","Eady");
	add_name("american","Emslie");
	add_name("american","Field");
	add_name("american","Fukuda");
	add_name("american","Gaines");
	add_name("american","Ganus");
	add_name("american","Gigliotti");
	add_name("american","Gillis");
	add_name("american","Glasco");
	add_name("american","Glenn");
	add_name("american","Gompert");
	add_name("american","Grenier");
	add_name("american","Haggerty");
	add_name("american","Hammon");
	add_name("american","Harmer");
	add_name("american","Harris");
	add_name("american","Hatch");
	add_name("american","Hawkins");
	add_name("american","Heath");
	add_name("american","James");
	add_name("american","Kar");
	add_name("american","Keating");
	add_name("american","Kriegler");
	add_name("american","Kuhn");
	add_name("american","Lastimosa");
	add_name("american","Lopez");
	add_name("american","Lor");
	add_name("american","Louie");
	add_name("american","Lowis");
	add_name("american","Luo");
	add_name("american","Massey");
	add_name("american","McCandlish");
	add_name("american","McCoy");
	add_name("american","McLeod");
	add_name("american","Messerly");
	add_name("american","Miller");
	add_name("american","Niebel");
	add_name("american","Oh");
	add_name("american","Ojeda");
	add_name("american","Onur");
	add_name("american","Peas");
	add_name("american","Pelayo");
	add_name("american","Pierce");
	add_name("american","Porter");
	add_name("american","Rieke");
	add_name("american","Rosemeier");
	add_name("american","Roycewicz");
	add_name("american","Rubin");
	add_name("american","Rule");
	add_name("american","Sharrigan");
	add_name("american","Shiring");
	add_name("american","Sue");
	add_name("american","Turner");
	add_name("american","Vinson");
	add_name("american","Volker");
	add_name("american","Wang");
	add_name("american","West");
	add_name("american","Yang");
	add_name("american","Zampella");
	add_name("american","Mejia");
	add_name("american","Becerra");
	add_name("american","Castillo");
	add_name("american","Childress");
	add_name("american","Germann");
	add_name("american","Lara");
	add_name("american","Ovando");
	add_name("american","Slanchik");
	add_name("american","Vo");
	add_name("american","Garnett");
	add_name("american","Smith");
	add_name("american","Troy");
	add_name("american","Carson");
	add_name("american","Arriaga");
	add_name("american","Beckman");
	add_name("american","Castellanos");
	add_name("american","Clopper");
	add_name("american","Crow");
	add_name("american","Demaray");
	add_name("american","Eberlein");
	add_name("american","Gallego");
	add_name("american","Gonzalez");
	add_name("american","Inman");
	add_name("american","Kelly");
	add_name("american","Kim");
	add_name("american","Li");
	add_name("american","McFerron");
	add_name("american","Mertz");
	add_name("american","Moss");
	add_name("american","Oztalay");
	add_name("american","Rude");
	add_name("american","Shiau");
	add_name("american","Slegeir");
	add_name("american","Tangtiphongkul");
	add_name("american","Torres");
	add_name("american","Uberman");
	add_name("american","Villamin");
	add_name("american","Watts");
	add_name("american","Yu");
	add_name("american","Almaguer");
	add_name("american","Bacon");
	add_name("american","Harvey");
	add_name("american","Hunter");
	add_name("american","Thomas");
	add_name("american","Wilson");
	add_name("american","Adamson");
	add_name("american","Apilado");
	add_name("american","Bayless");
	add_name("american","Beese");
	add_name("american","Berger");
	add_name("american","Biessman");
	add_name("american","Bormann");
	add_name("american","Botero");
	add_name("american","Burnett");
	add_name("american","Button");
	add_name("american","Butts");
	add_name("american","Carani");
	add_name("american","Carraher");
	add_name("american","Cervantes");
	add_name("american","Comeau");
	add_name("american","Cooper");
	add_name("american","Crump");
	add_name("american","Dahm");
	add_name("american","Davis");
	add_name("american","Degenhardt");
	add_name("american","DeVenero");
	add_name("american","Diorio");
	add_name("american","Dunkelberger");
	add_name("american","Eckstein");
	add_name("american","Edwards");
	add_name("american","Ellsbury");
	add_name("american","Fifield");
	add_name("american","Flickinger");
	add_name("american","Frame");
	add_name("american","Ganous");
	add_name("american","Garcia");
	add_name("american","Giombi");
	add_name("american","Glowacki");
	add_name("american","Gustafson");
	add_name("american","Hackbarth");
	add_name("american","Hamilton");
	add_name("american","Hartmann");
	add_name("american","Hatcher");
	add_name("american","Hauptman");
	add_name("american","Hiley");
	add_name("american","Hill");
	add_name("american","Holt");
	add_name("american","Holzapfel");
	add_name("american","Ross");
	add_name("american","Jalowitz");
	add_name("american","Karathomas");
	add_name("american","Kausak");
	add_name("american","Kelly");
	add_name("american","Kierzek");
	add_name("american","Kleiman");
	add_name("american","Koenig");
	add_name("american","Kornkven");
	add_name("american","Kraft");
	add_name("american","Kramer");
	add_name("american","Kreeger");
	add_name("american","Kurdziel");
	add_name("american","Leslie");
	add_name("american","Linn");
	add_name("american","Loane");
	add_name("american","Matejka");
	add_name("american","Maxwell");
	add_name("american","Menard");
	add_name("american","Merboth");
	add_name("american","Meyer");
	add_name("american","Miller");
	add_name("american","Moore");
	add_name("american","Negrete");
	add_name("american","Newton");
	add_name("american","Nigl");
	add_name("american","O\'leary");
	add_name("american","Olson");
	add_name("american","Paulsrud");
	add_name("american","Peeples");
	add_name("american","Pellas");
	add_name("american","Person");
	add_name("american","Petersen");
	add_name("american","Pinkston");
	add_name("american","Renner");
	add_name("american","Riddle");
	add_name("american","Ries");
	add_name("american","Schmidt");
	add_name("american","Seaman");
	add_name("american","Shorey");
	add_name("american","Skubal");
	add_name("american","Smith");
	add_name("american","Stampfli");
	add_name("american","Stephens");
	add_name("american","Styrwoll");
	add_name("american","Sumsky");
	add_name("american","Superty");
	add_name("american","Swekel");
	add_name("american","Thurler");
	add_name("american","Tiran");
	add_name("american","Tomplait");
	add_name("american","Uttech");
	add_name("american","Walker");
	add_name("american","Weiss");
	add_name("american","Willes");
	add_name("american","Williams");
	add_name("american","Ye");
	add_name("american","Yen");
	add_name("american","Yepes");
	add_name("american","Zeng");
	add_name("american","Zuehls");
	add_name("british","Abbot");
	add_name("british","Adams");
	add_name("british","Bartlett");
	add_name("british","Boyd");
	add_name("british","Boyle");
	add_name("british","Bremner");
	add_name("british","Carlyle");
	add_name("british","Carver");
	add_name("british","Cheek");
	add_name("british","Clarke");
	add_name("british","Collins");
	add_name("british","Compton");
	add_name("british","Connolly");
	add_name("british","Cook");
	add_name("british","Dowd");
	add_name("british","Field");
	add_name("british","Fleming");
	add_name("british","Fletcher");
	add_name("british","Flynn");
	add_name("british","Grant");
	add_name("british","Greaves");
	add_name("british","Griffin");
	add_name("british","Harris");
	add_name("british","Harrison");
	add_name("british","Heath");
	add_name("british","Henderson");
	add_name("british","Hopkins");
	add_name("british","Hoyt");
	add_name("british","Kent");
	add_name("british","Lewis");
	add_name("british","Lipton");
	add_name("british","Macdonald");
	add_name("british","Maxwell");
	add_name("british","McQuarrie");
	add_name("british","Miller");
	add_name("british","Mitchell");
	add_name("british","Moore");
	add_name("british","Murphy");
	add_name("british","Murray");
	add_name("british","Pearce");
	add_name("british","Plumber");
	add_name("british","Pritchard");
	add_name("british","Rankin");
	add_name("british","Reed");
	add_name("british","Ritchie");
	add_name("british","Ross");
	add_name("british","Roth");
	add_name("british","Smith");
	add_name("british","Stevenson");
	add_name("british","Stuart");
	add_name("british","Sullivan");
	add_name("british","Thompson");
	add_name("british","Veale");
	add_name("british","Wallace");
	add_name("british","Wells");
	add_name("british","Welsh");
	add_name("british","Beinke");
	add_name("british","Cable");
	add_name("british","Flora");
	add_name("british","Fox");
	add_name("british","Grubner");
	add_name("british","Knox");
	add_name("british","Kuchar");
	add_name("british","Lajoie");
	add_name("british","Lepanen");
	add_name("british","Lishman");
	add_name("british","Mates");
	add_name("british","Mauer");
	add_name("british","McCready");
	add_name("british","McInerney");
	add_name("british","Robertson");
	add_name("british","Scholten");
	add_name("british","Smith");
	add_name("british","Sutton");
	add_name("british","Teebagy");
	add_name("british","Treadwell");
	add_name("british","Wahlquist");
	add_name("british","Wallace");
	add_name("british","Welch");
	add_name("british","Whitlow");
	add_name("british","Zimmermann");
	add_name("british","Aube");
	add_name("british","Auger");
	add_name("british","Beaulieu");
	add_name("british","Bellehumeur");
	add_name("british","Bibeau");
	add_name("british","Blondeau");
	add_name("british","Boudreau");
	add_name("british","Bouffard");
	add_name("british","Boulianne");
	add_name("british","Carrier");
	add_name("british","Charette");
	add_name("british","Charron");
	add_name("british","Cormier");
	add_name("british","Cote");
	add_name("british","Demers");
	add_name("british","Dion");
	add_name("british","Dompierre");
	add_name("british","Fortin");
	add_name("british","Fournier");
	add_name("british","Fradette");
	add_name("british","Gagne");
	add_name("british","Gauthier");
	add_name("british","Giguere");
	add_name("british","Gosselin");
	add_name("british","Hebert");
	add_name("british","Laberge");
	add_name("british","Lachance");
	add_name("british","Lagrange");
	add_name("british","Larochelle");
	add_name("british","Lavigne");
	add_name("british","Lavoie");
	add_name("british","Lepage");
	add_name("british","Lesperance");
	add_name("british","Lessard");
	add_name("british","Levesque");
	add_name("british","Mahe");
	add_name("british","Martin");
	add_name("british","Meunier");
	add_name("british","Montcalm");
	add_name("british","Moreau");
	add_name("british","Morel");
	add_name("british","Ouellet");
	add_name("british","Paradis");
	add_name("british","Parent");
	add_name("british","Pinsonneault");
	add_name("british","Poirier");
	add_name("british","Polloni");
	add_name("british","Pouliot");
	add_name("british","Proulx");
	add_name("british","Rheaume");
	add_name("british","Rivard");
	add_name("british","Robidoux");
	add_name("british","Samson");
	add_name("british","Simard");
	add_name("british","St-Pierre");
	add_name("british","Taddei");
	add_name("british","Vezina");
	add_name("british","Wauthy");
	add_name("russian","Sasha Ivanov");
	add_name("russian","Aleksei Vyshinskiy");
	add_name("russian","Boris Ryzhkov");
	add_name("russian","Dima Tikhonov");
	add_name("russian","Oleg Kosygin");
	add_name("russian","Pyotr Bulganin");
	add_name("russian","Petya Malenkov");
	add_name("russian","Alyosha Tarkovsky");
	add_name("russian","Sergei Grombyo");
	add_name("russian","Viktor Kuznetsov");
	add_name("russian","Misha Podgorniy");
	add_name("russian","Borya Mikoyan");
	add_name("russian","Anatoly Voroshilov");
	add_name("russian","Kolya Shvernik");
	add_name("russian","Nikolai Kalinin");
	add_name("russian","Vladimir Brezhnev");
	add_name("russian","Pavel Chernenko");
	add_name("russian","Volodya Andropov");
	add_name("russian","Yuri Nikitin");
	add_name("russian","Dmitri Petrenko");
	add_name("russian","Vanya Gerasimov");
	add_name("russian","Mikhail Zhuravlev");
	add_name("russian","Ivan Lukin");
	add_name("russian","Kostya Golubev");
	add_name("russian","Konstantin Lebedev");
	add_name("russian","Aleksandr Vasilev");
	add_name("russian","Yakov Glushenko");
	add_name("russian","Sasha Semenov");
	add_name("russian","Aleksei Ulyanov");
	add_name("russian","Boris Yefremov");
	add_name("russian","Dima Chernyshenko");
	add_name("russian","Oleg Stepanoshvili");
	add_name("russian","Pyotr Demchenko");
	add_name("russian","Petya Avagimov");
	add_name("russian","Alyosha Murzaev");
	add_name("russian","Sergei Shkuratov");
	add_name("russian","Viktor Yakimenko");
	add_name("russian","Misha Masijashvili");
	add_name("russian","Borya Shapovalov");
	add_name("russian","Anatoly Ivashenko");
	add_name("russian","Kolya Dovzhenko");
	add_name("russian","Nikolai Turdyev");
	add_name("russian","Vladimir Sabgaida");
	add_name("russian","Pavel Svirin");
	add_name("russian","Volodya Sarayev");
	add_name("russian","Yuri Kiselev");
	add_name("russian","Dmitri Bondarenko");
	add_name("russian","Vanya Chernogolov");
	add_name("russian","Mikhail Voronov");
	add_name("russian","Ivan Afanasyev");
	add_name("russian","Kostya Gridin");
	add_name("russian","Konstantin Petrov");
	add_name("russian","Aleksandr Rykov");
	add_name("russian","Yakov Shvedov");
	add_name("arab","Abdulaziz");
	add_name("arab","Abdullah");
	add_name("arab","Ali");
	add_name("arab","Amin");
	add_name("arab","Bassam");
	add_name("arab","Fahd");
	add_name("arab","Faris");
	add_name("arab","Fouad");
	add_name("arab","Habib");
	add_name("arab","Hakem");
	add_name("arab","Hassan");
	add_name("arab","Ibrahim");
	add_name("arab","Imad");
	add_name("arab","Jabbar");
	add_name("arab","Kareem");
	add_name("arab","Khalid");
	add_name("arab","Malik");
	add_name("arab","Muhammad");
	add_name("arab","Nasir");
	add_name("arab","Omar");
	add_name("arab","Rafiq");
	add_name("arab","Rami");
	add_name("arab","Said");
	add_name("arab","Salim");
	add_name("arab","Samir");
	add_name("arab","Talib");
	add_name("arab","Tariq");
	add_name("arab","Youssef");
	add_name("arab","Ziad");
	add_name("seal","######InvalidName######");
	add_name("taskforce","######InvalidName######");
	add_name("xslice","######InvalidName######");
	add_name("delta","######InvalidName######");
	add_name("secretservice","######InvalidName######");
	add_name("portuguese","######InvalidName######");
	add_name("shadowcompany","######InvalidName######");
	add_name("multilingual","######InvalidName######");
	add_name("french","######InvalidName######");
	add_name("african","######InvalidName######");
	add_name("czech","######InvalidName######");
	add_name("czech_surnames","######InvalidName######");
	add_name("atlas","######InvalidName######");
	add_name("sentinel","######InvalidName######");
	add_name("kva","######InvalidName######");
	add_name("squad","######InvalidName######");
	add_name("northkorea","######InvalidName######");
	add_name("pmc","######InvalidName######");
	init_script_friendnames();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		remove_script_friendnames_from_list(var_00[var_01]);
		randomize_name_list(var_00[var_01]);
		level.nameindex[var_00[var_01]] = 0;
	}
}

//Function Number: 3
copy_names(param_00,param_01)
{
	level.names[param_00] = level.names[param_01];
}

//Function Number: 4
add_name(param_00,param_01)
{
	level.names[param_00][level.names[param_00].size] = param_01;
}

//Function Number: 5
remove_name(param_00,param_01)
{
	level.names[param_00] = common_scripts\utility::array_remove(level.names[param_00],param_01);
}

//Function Number: 6
init_script_friendnames()
{
	var_00 = [];
	var_01 = getspawnerarray();
	var_02 = getaiarray();
	foreach(var_04 in var_01)
	{
		if(isdefined(var_04.script_friendname) && var_04.script_friendname != "none")
		{
			var_05 = normalize_script_friendname(var_04.script_friendname);
			var_00[var_00.size] = var_05;
		}
	}

	foreach(var_08 in var_02)
	{
		if(isdefined(var_08.script_friendname) && var_08.script_friendname != "none")
		{
			var_05 = normalize_script_friendname(var_08.script_friendname);
			var_00[var_00.size] = var_05;
		}
	}

	level.script_friendnames = var_00;
}

//Function Number: 7
normalize_script_friendname(param_00)
{
	var_01 = strtok(param_00," ");
	if(var_01.size > 1)
	{
		param_00 = var_01[1];
	}

	return param_00;
}

//Function Number: 8
remove_script_friendnames_from_list(param_00)
{
	foreach(var_02 in level.script_friendnames)
	{
		foreach(var_04 in level.names[param_00])
		{
			if(var_02 == var_04)
			{
				remove_name(param_00,var_04);
			}
		}
	}
}

//Function Number: 9
randomize_name_list(param_00)
{
	var_01 = level.names[param_00].size;
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		var_03 = randomint(var_01);
		var_04 = level.names[param_00][var_02];
		level.names[param_00][var_02] = level.names[param_00][var_03];
		level.names[param_00][var_03] = var_04;
	}
}

//Function Number: 10
get_name(param_00)
{
	if(isdefined(self.team) && self.team == "neutral")
	{
		return;
	}

	if(isdefined(self.script_friendname))
	{
		if(self.script_friendname == "none")
		{
			return;
		}

		self.name = self.script_friendname;
		getrankfromname(self.name);
		self notify("set name and rank");
		return;
	}

	get_name_for_nationality(self.voice);
	self notify("set name and rank");
}

//Function Number: 11
validate_nationality(param_00)
{
	switch(param_00)
	{
		case "russian":
		case "arab":
		case "british":
		case "american":
			break;
	}
}

//Function Number: 12
get_name_for_nationality(param_00)
{
	validate_nationality(param_00);
	level.nameindex[param_00] = level.nameindex[param_00] + 1 % level.names[param_00].size;
	var_01 = level.names[param_00][level.nameindex[param_00]];
	var_02 = randomint(10);
	if(var_02 > 5)
	{
		var_03 = "Pvt. " + var_01;
		self.airank = "private";
	}
	else if(var_03 > 2)
	{
		var_03 = "Cpl. " + var_02;
		self.airank = "private";
	}
	else
	{
		var_03 = "Sgt. " + var_02;
		self.airank = "sergeant";
	}

	if(isai(self) && self isbadguy())
	{
		self.ainame = var_03;
		return;
	}

	self.name = var_03;
}

//Function Number: 13
getrankfromname(param_00)
{
	if(!isdefined(param_00))
	{
		self.airank = "private";
	}

	var_01 = strtok(param_00," ");
	var_02 = var_01[0];
	switch(var_02)
	{
		case "Pvt.":
			break;

		case "Pfc.":
			break;

		case "Agent":
			break;

		case "Cpl.":
			break;

		case "Sgt.":
			break;

		case "Lt.":
			break;

		case "Cpt.":
			break;

		default:
			break;
	}
}

//Function Number: 14
nationalityusescallsigns(param_00)
{
	switch(param_00)
	{
		case "sentinel":
		case "atlas":
		case "xslice":
		case "czech":
		case "taskforce":
		case "seal":
		case "delta":
			break;
	}
}

//Function Number: 15
nationalityusessurnames(param_00)
{
	return isdefined(level.names[param_00 + "_surnames"]);
}