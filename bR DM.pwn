/*                                 CREDITS
 *
 *BBBBBBBBBBBBBBBBB           RRRRRRRRRRRRRR
 *BB              BB          RR           RR
 *BB             BB           RR          RR
 *BB            BB            RR         RR
 *BB           BB             RR        RR
 *BBBBBBBBBBBBB               RRRRRRRRRR
 *BB           BB             RR        RR
 *BB            BB            RR         RR
 *BB             BB           RR          RR
 *BB              BB          RR           RR
 *BBBBBBBBBBBBBBBBB           RR            RR
 *BULLET RAJA               PRESENTS bR DeathMatch [v3]
 */
/*                                    ChangeLog
 *=========> Version 1<==========
 *=> Added Login/Register System,
 *=> Added /login, /register commands
 *=> Added Offline Ban System
 *=> Added Online Ban System
 *=> Added Kicking System
 *
 *=========> Version 1.5<==========
 *=> Added Vehicle Spawning System
 *=> Added Vehicle Giving System
 *=> Added Stats System
 *=> Added Player Commands
 *=> Added Admin Commands
 *
 *=========> Version 2<==========
 *=> Added GetIP & Ban IP & Unban IP System
 *=> Added Top Killers & Top Deaths System
 *=> Added RichList
 *=> Added Spawning System
 *=> Added Credits System
 *
 *=========> Version 2.5<==========
 *=> Added Rules System
 *=> Added AutoMatic Scores Giver
 *=> Added AutoMatic HostName Changer
 *=> Added AutoMatic Tips System
 *=> Fixed Login/Register System
 *=> Added Last Active [Year, Month. Day]
 *
 *=========> Version 3<==========
 *=> Added Clan Member System
 *=> Added
 *=> Added
 *=> Added
 *=> Added
 *=> Added
 *=> Added
 */
#include <a_samp>
#include <streamer>
#include <sscanf2>
#include <zcmd>
#include <vehicles>
#include <utils>
#include <dutils>
#include <YSI/y_ini>

/* Server Information */
#define     SV_VER      "(0.3.7)"//here you can add your server version
#define     SV_GM       "bR DeathMatch ["SCRIPT_V"]"//here add your gamemode text
#define     SV_LANG     "English"//here add your server language
#define     SV_RCON     "BulletR"//here add server rcon
#define     SV_SNAME    "Check /rules, /updates"//here add your server second name
#define     SV_NAME     "BulletRaja DeathMatch "SV_VER""//here add server name
#define     SV_URL      "www.BulletRaja.Com"//here put server url
#define     SV_MAP      "San Andreas"//here server map name
#define     SCRIPT_V    "v3"

/* All Colours */
#define COLOR_PURPLE2                 0xC2A2DAFF
#define COLOR_DARKRED                 0xAA3333FF
#define COLOR_GREY                    0xAFAFAFFF
#define COLOR_ASAY                    0xFF0000FF
#define COLOR_OSAY                    0x007700FF
#define COLOR_HSAY                    0x1684CAFF
#define COLOR_MSAY                    0x1684CAFF
#define COLOR_WHITE                   0xFFFFFFFF
#define COLOR_YELLOW                  0xFFFF00FF
#define COLOR_LIGHTGREEN              0xFF0000A
#define COLOR_RED                     0xFF0000FF
#define RED                           0xFF0000FF
#define COLOR_LRED                    0xFF4747FF
#define COLOR_GREEN                   0x00FF00FF
#define COLOR_DARKMAUVE               0x623778FF
#define COLOR_MAUVE                   0x845F96FF
#define COLOR_GREENYELLOW             0xADFF2FAA
#define COLOR_BLUE                    0x0000FFFF
#define COLOR_LBLUE                   0x99FFFFFF
#define COLOR_LIGHTBLUE               0x99FFFFFF
#define COLOR_ORANGE                  0xFF9900FF
#define COLOR_PURPLE                  0xCC00DDFF
#define COLOR_PEACH                   0xFFCC66FF
#define COLOR_SILVER                  0xDDDDDDFF
#define COLOR_WANTEDBLUE              0x0055CCFF
#define COLOR_DARK_VIOLET             0x9400D3FF
#define COLOR_VIP1                    0x9400D3FF
#define COLOR_HELP                    0x00E5EEFF
#define COLOR_ADMIN                   0x0066FFFF
#define COLOR_ADMIN2                  0x008FD6FF
#define COLOR_PLAYER                  0xFFCC33FF
#define COLOR_RP                      0xFFFFFFFF
#define COLOR_ULTRAADMIN              0x993300FF
#define COLOR_EVENT                   0x00CC66FF
#define COLOR_VIP2                    0xFF33CCFF
#define COLOR_VIPCHAT                 0xCC66CCFF
#define 	COL_WHITE                 "{FFFFFF}"
#define 	COL_BLACK                 "{0E0101}"
#define 	COL_GREY                  "{C3C3C3}"
#define 	COL_GREEN                 "{6EF83C}"
#define 	COL_RED                   "{F81414}"
#define 	COL_YELLOW                "{F3FF02}"
#define 	COL_ORANGE                "{FFAF00}"
#define 	COL_LIME                  "{B7FF00}"
#define 	COL_CYAN                  "{00FFEE}"
#define 	COL_BLUE                  "{0049FF}"
#define 	COL_MAGENTA               "{F300FF}"
#define 	COL_VIOLET                "{B700FF}"
#define 	COL_PINK                  "{FF00EA}"
#define 	COL_MARONE                "{A90202}"

/* Dialogs */
#define DIALOG_REGISTER    1
#define DIALOG_LOGIN       2
#define DIALOG_STATS       3
#define DIALOG_CREDITS     4
#define DIALOG_RULES       5

/* File Path */
#define UserFiles          "/Accounts/%s.ini"

/* After Register */
#define REGISTER_MONEY 10000
#define REGISTER_SCORE 10

/* Max Entities */
#define     CLAN_TAG                "[bR]"
#define 	MAX_CLIENT_MSG_LENGTH 	144
#define     MAX_MONEY               999999999

/* New Defines */
new playerlogged[PLAYERS];
new isconnected[PLAYERS];
new pdialog[PLAYERS];
new spectat[PLAYERS] = {-1, ...};
new bool:svtd[VEHICLES + 1];
new saccstats[PLAYERS];

/* Class Selection */
#define CLASS_X 1088.1422
#define CLASS_Y 1074.0307
#define CLASS_Z 10.8382

#define M_C 0x4169E1FF
#define M_T 400
#define NOW_MSSG 100

main()
{
	print("\n|+++++++++++++++++++++++++++++++|");
	print(" [BR]DeathMatch ("SCRIPT_V") By BulletRaja");
	print("|+++++++++++++++++++++++++++++++|\n");
}

enum pInfo
{
    PlayerPass,
    PlayerName,
    PlayerMoney,
    PlayerLevel,
    PlayerScore,
    PlayerKills,
    PlayerDeaths,
    PlayerBanned,
    PlayerIP[16],
	LastActive_Y,
	LastActive_M,
	LastActive_D,
	ClanMember
}
new PlayerInfo[PLAYERS][pInfo];
			
forward LoadPlayer_data(playerid,name[],value[]);
public LoadPlayer_data(playerid,name[],value[])
{
    new year, month, day;
    getdate(year, month, day);
    INI_Int("password",PlayerInfo[playerid][PlayerPass]);
    INI_Int("Player Name",PlayerInfo[playerid][PlayerName]);
    INI_Int("money",PlayerInfo[playerid][PlayerMoney]);
    INI_Int("adminlevel",PlayerInfo[playerid][PlayerLevel]);
    INI_Int("scores",PlayerInfo[playerid][PlayerScore]);
    INI_Int("kills",PlayerInfo[playerid][PlayerKills]);
    INI_Int("deaths",PlayerInfo[playerid][PlayerDeaths]);
    INI_Int("playerbanned",PlayerInfo[playerid][PlayerBanned]);
    INI_String("playerip",PlayerInfo[playerid][PlayerIP], 16);
    INI_Int("lactive_y", PlayerInfo[playerid][LastActive_Y],year);
    INI_Int("lactive_m", PlayerInfo[playerid][LastActive_M],month);
    INI_Int("lactive_d", PlayerInfo[playerid][LastActive_D],day);
    INI_Int("ClanMember",PlayerInfo[playerid][ClanMember]);
    return 1;
}

/* Vehicles Name */
new vehName[][] =
{
	"Landstalker",
	"Bravura",
	"Buffalo",
	"Linerunner",
	"Perennial",
	"Sentinel",
	"Dumper",
	"Firetruck",
	"Trashmaster",
	"Stretch",
	"Manana",
	"Infernus",
	"Voodoo",
	"Pony",
	"Mule",
	"Cheetah",
	"Ambulance",
	"Leviathan",
	"Moonbeam",
	"Esperanto",
	"Taxi",
	"Washington",
	"Bobcat",
	"Whoopee",
	"BF Injection",
	"Hunter",
	"Premier",
	"Enforcer",
	"Securicar",
	"Banshee",
	"Predator",
	"Bus",
	"Rhino",
	"Barracks",
	"Hotknife",
	"Trailer",
	"Previon",
	"Coach",
	"Cabbie",
	"Stallion",
	"Rumpo",
	"RC Bandit",
	"Romero",
	"Packer",
	"Monster",
	"Admiral",
	"Squalo",
	"Seasparrow",
	"Pizzaboy",
	"Tram",
	"Trailer",
	"Turismo",
	"Speeder",
	"Reefer",
	"Tropic",
	"Flatbed",
	"Yankee",
	"Caddy",
	"Solair",
	"Berkley's RC Van",
	"Skimmer",
	"PCJ-600",
	"Faggio",
	"Freeway",
	"RC Baron",
	"RC Raider",
	"Glendale",
	"Oceanic",
	"Sanchez",
	"Sparrow",
	"Patriot",
	"Quad",
	"Coastguard",
	"Dinghy",
	"Hermes",
	"Sabre",
	"Rustler",
	"ZR-350",
	"Walton",
	"Regina",
	"Comet",
	"BMX",
	"Burrito",
	"Camper",
	"Marquis",
	"Baggage",
	"Dozer",
	"Maverick",
	"News Chopper",
	"Rancher",
	"FBI Rancher",
	"Virgo",
	"Greenwood",
	"Jetmax",
	"Hotring",
	"Sandking",
	"Blista Compact",
	"Police Maverick",
	"Boxville",
	"Benson",
	"Mesa",
	"RC Goblin",
	"Hotring Racer A",
	"Hotring Racer B",
	"Bloodring Banger",
	"Rancher",
	"Super GT",
	"Elegant",
	"Journey",
	"Bike",
	"Mountain Bike",
	"Beagle",
	"Cropduster",
	"Stunt",
	"Tanker",
	"Roadtrain",
	"Nebula",
	"Majestic",
	"Buccaneer",
	"Shamal",
	"Hydra",
	"FCR-900",
	"NRG-500",
	"HPV1000",
	"Cement Truck",
	"Tow Truck",
	"Fortune",
	"Cadrona",
	"FBI Truck",
	"Willard",
	"Forklift",
	"Tractor",
	"Combine",
	"Feltzer",
	"Remington",
	"Slamvan",
	"Blade",
	"Freight",
	"Streak",
	"Vortex",
	"Vincent",
	"Bullet",
	"Clover",
	"Sadler",
	"Firetruck",
	"Hustler",
	"Intruder",
	"Primo",
	"Cargobob",
	"Tampa",
	"Sunrise",
	"Merit",
	"Utility",
	"Nevada",
	"Yosemite",
	"Windsor",
	"Monster",
	"Monster",
	"Uranus",
	"Jester",
	"Sultan",
	"Stratium",
	"Elegy",
	"Raindance",
	"RC Tiger",
	"Flash",
	"Tahoma",
	"Savanna",
	"Bandito",
	"Freight Flat",
	"Streak Carriage",
	"Kart",
	"Mower",
	"Dune",
	"Sweeper",
	"Broadway",
	"Tornado",
	"AT-400",
	"DFT-30",
	"Huntley",
	"Stafford",
	"BF-400",
	"News Van",
	"Tug",
	"Trailer",
	"Emperor",
	"Wayfarer",
	"Euros",
	"Hotdog",
	"Club",
	"Freight Box",
	"Trailer",
	"Andromada",
	"Dodo",
	"RC Cam",
	"Launch",
	"Police",
	"Police",
	"Police",
	"Ranger",
	"Picador",
	"S.W.A.T",
	"Alpha",
	"Phoenix",
	"Glendale Shit",
	"Sadler Shit",
	"Luggage",
	"Luggage",
	"Stairs",
	"Boxville",
	"Tiller",
	"Utility Trailer"
};

/* Stocks */
stock AccountsPath(playerid)
{
    new string[128],playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid,playername,sizeof(playername));
    format(string,sizeof(string),UserFiles,playername);
    return string;
}

stock udb_hash(buf[]) {
    new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}
stock RPN(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}
stock PlayerNames(playerid)
{
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
	return pname;
}
stock GivePlayerScore(playerid, score)
{
    SetPlayerScore(playerid, GetPlayerScore(playerid)+score);
    return 1;
}

SendPlayerFormattedText(playerid, color, str[], define1[], define2[])
{
	new tstr[256];
	format(tstr, 256, str, define1, define2);
	SendClientMessage2(playerid, color, tstr);
	return 1;
}

SendAllFormattedText(color, str[], define1[], define2[])
{
	new tstr[256];
	format(tstr, 256, str, define1, define2);
	SendClientMessageToAll2(color, tstr);
	return 1;
}
SendClientMessage2(playerid, color, message[])
{
	if (strlen(message) <= MAX_CLIENT_MSG_LENGTH)
	{
		SendClientMessage(playerid, color, message);
	}
	else
	{
		new string[MAX_CLIENT_MSG_LENGTH + 1];
		strmid(string, message, 0, MAX_CLIENT_MSG_LENGTH);
		SendClientMessage(playerid, color, string);
	}
	return 1;
}

SendClientMessageToAll2(color, message[])
{
	for (new i = 0; i < PLAYERS; i++)
	{
		if (IsPlayerConnected2(i)) SendClientMessage2(i, color, message);
	}
	return 1;
}
ShowPlayerDialog2(playerid, dialogid, style, caption[], info[], button1[], button2[])
{
	ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);
	pdialog[playerid] = dialogid;
}

IsPlayerConnected2(playerid)
{
	return IsPlayerNPC(playerid) == 0 && playerid < sizeof(isconnected) ? isconnected[playerid] : 0;
}

stock GetPlayerIpEx(playerid)
{
    new ip[16];
	GetPlayerIp(playerid, ip, sizeof(ip));
	return ip;
}
stock GetPlayerIDbyIP(const ip[])
{
        new pip[16];
        for (new i = 0; i < GetMaxPlayers(); i ++)
        {
           if(!IsPlayerConnected(i)) continue;
           GetPlayerIp(i, pip, 16);
           if (!strcmp(ip, pip, true))
           {
               return i;
           }
        }
        return -1;
}
SendMessageToAdmins(color, message[])
{
	for (new i = 0; i < PLAYERS; i++)
	{
		if (IsPlayerConnected2(i) && PlayerInfo[i][PlayerLevel] != 0) SendClientMessage2(i, color, message);
	}
}
stock IsNumeric(const str[])
{
    for(new i, len = strlen(str); i < len; i++)
    {
        if(!('0' <= str[i] <= '9')) return false;
    }
    return true;
}

GetPlayerFacingAngleFix(playerid, &Float:ang)
{
	if (IsPlayerInAnyVehicle(playerid))
	{
		GetVehicleZAngle(GetPlayerVehicleID(playerid), ang);
	}
	else
	{
		GetPlayerFacingAngle(playerid, ang);
	}
}
SetPClassPosition(playerid, classid)
{
	new Float:angle = (360.0 / 50) * (50 - classid);
	SetPlayerInterior(playerid, 0);
	SetPlayerFacingAngle(playerid, angle);
	SetPlayerPos(playerid, CLASS_X, CLASS_Y, CLASS_Z);
	SetPlayerCameraPos(playerid, CLASS_X + floatsin(-angle, degrees) * 4.0, CLASS_Y + floatcos(-angle, degrees) * 4.0, CLASS_Z + 1.0);
	SetPlayerCameraLookAt(playerid, CLASS_X, CLASS_Y, CLASS_Z);
}

new autotips[NOW_MSSG][128];
forward SendTipM();
public SendTipM()
{
	static lm = 0;
	new rand = random(NOW_MSSG);
	while(rand == lm && NOW_MSSG != 1)	{ rand = random(NOW_MSSG);  }
	lm = rand;
	SendClientMessageToAll(M_C, autotips[lm]);
}

stock SendTip(text[])
{
	for(new m; m < NOW_MSSG; m++)
	{
	    if(!strlen(autotips[m]))
		{
			strmid(autotips[m], text, 0, 127);
			return 1;
		}
	}
	return 0;
}

//== Admins Ranks ==//
stock AdminRanks(playerid)
{
	new strings[1000];
	switch(PlayerInfo[playerid][PlayerLevel])
	{
	    case 0: strings = "Normal Player";
	    case 1: strings = "Trial Moderator";
	    case 2: strings = "Global Moderator";
	    case 3: strings = "Moderator";
 	    case 4: strings = "Head Administrator";
 	    case 5: strings = "Server Manager";
 	    case 6: strings = "Server Owner/Scripter";
	}
	return strings;
}

public OnGameModeInit()
{
    SetGameModeText(""SV_GM"");
	SendRconCommand("language "SV_LANG"");
	SendRconCommand("rcon_password "SV_RCON"");
	SendRconCommand("hostname "SV_NAME"");
	SendRconCommand("weburl "SV_URL"");
    SendRconCommand("mapname "SV_MAP"");
	//AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	for (new classsel = 1; classsel < 300; classsel++)
	{
		if (classsel == 74) continue;
		AddPlayerClass(classsel, CLASS_X, CLASS_Y, CLASS_Z, 0.0, 0, 0, 0, 0, 0, 0);
	}
	SetTimer("hostname",2000,true);
	SetTimer("GiveScores", 120000, 1);
	SetTimer("SendTipM", M_T * 1000, 1);
	
	SendTip(""COL_YELLOW"TIP"COL_WHITE": Type /cmds to see the server commands list.");
	SendTip(""COL_YELLOW"TIP"COL_WHITE": Type /rules & /credits to read rules and credits of the server");
	SendTip(""COL_YELLOW"TIP"COL_WHITE": Wanna be admin? then register on "SV_URL"");
	SendTip(""COL_YELLOW"TIP"COL_WHITE": Wanna be helper? then register on "SV_URL"");
	SendTip(""COL_YELLOW"TIP"COL_WHITE": 3");
	SendTip(""COL_YELLOW"TIP"COL_WHITE": 4");
	SendTip(""COL_YELLOW"TIP"COL_WHITE": 5");
	SendTip(""COL_YELLOW"TIP"COL_WHITE": 6");
	SendTip(""COL_YELLOW"TIP"COL_WHITE": 7");
	return 1;
}
forward hostname();
public hostname()
{
   new var = random(4);
   switch (var)
   {
     case 0: SendRconCommand("hostname "SV_NAME"");
     case 1: SendRconCommand("hostname "SV_SNAME"");
   }
}

forward GiveScores();
public GiveScores()
{
    SendClientMessageToAll(-1, "[Scores]: {00FF00}Server Developers/Admins {FFFFFF}gave you 10 scores and 1000 money, aren't they good.");
    for (new i=0; i<MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            GivePlayerScore(i, 10);
            PlayerInfo[i][PlayerScore]+=10;
            GivePlayerMoney(i, 1000);
            PlayerInfo[i][PlayerMoney]+=1000;
        }
    }
    return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if (IsPlayerNPC(playerid)) return 1;
	SetPClassPosition(playerid, classid);
	return 1;
}

public OnPlayerConnect(playerid)
{
    new playeridname[MAX_PLAYER_NAME], str[256];
    GetPlayerName(playerid, playeridname, sizeof(playeridname));
	if(strfind(playeridname,""CLAN_TAG"",true) != -1) {
		if(PlayerInfo[playerid][ClanMember]==0)  {
			format(str, sizeof(str), "You are not in the "CLAN_TAG" clan. If you want to wear the clan tag you can apply for it on "SV_URL"");
			SendClientMessage(playerid, COLOR_RED, str);
			SetTimerEx("Kicker", 50, 0, "dd", playerid, 1);
			return 1;
       	}
    }
	else if(strfind(playeridname,""CLAN_TAG"",false) != 0) {
		if(PlayerInfo[playerid][ClanMember]==1) {
			format(str, sizeof(str), "You are from "CLAN_TAG" clan. you can put "CLAN_TAG" in your name if you want.");
			SendClientMessage(playerid, COLOR_WHITE, str);
			return 1;
		}
    }
    if (isconnected[playerid] == 0)
	{
		isconnected[playerid] = 1;
		SetPlayerColor(playerid, COLOR_PLAYER);
		SetPlayerVirtualWorld(playerid, 1);
		new playername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);

		if(fexist(AccountsPath(playerid)))
		{
            INI_ParseFile(AccountsPath(playerid), "LoadPlayer_data", .bExtra = true, .extra = playerid);
		    format(str, sizeof(str), "Welcome to {00FFF3}%s.\n\n{FFFF00}Account:{FFFFFF} %s\n\nPlease enter your password below:", SV_NAME, RPN(playerid));
			ShowPlayerDialog2(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, ""COL_RED"Login", str, "Login", "Cancel");
			SendPlayerFormattedText(playerid, COLOR_LBLUE, "Welcome back %s to {FF33CC}"SV_NAME"{FFFFFF}.", playername, "");
			playerlogged[playerid] = 1;
		}
		else
		{
		    format(str, sizeof(str), "Welcome to {FFB900}%s.\n\n{FFFF00}Account:{FFFFFF} %s\n\nRegister an account to play.\n\nPlease put the password below:", SV_NAME, RPN(playerid));
			ShowPlayerDialog2(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, ""COL_GREEN"Register", str, "Continue", "Cancel");
			SendPlayerFormattedText(playerid, COLOR_WHITE, "Welcome %s to {FF33CC}"SV_NAME"{FFFFFF}.", playername, "");
			playerlogged[playerid] = 1;
		}
		return 0;
	}
	playerlogged[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new playernames[25];
    if(playerlogged[playerid] == 1)
	{
     new INI:File = INI_Open(AccountsPath(playerid));
     INI_SetTag(File,"Player Data");
     INI_WriteInt(File,"Player Name",GetPlayerName(playerid, playernames, MAX_PLAYER_NAME));
     INI_WriteInt(File,"money",GetPlayerMoney(playerid));
     INI_WriteInt(File,"adminlevel",PlayerInfo[playerid][PlayerLevel]);
     INI_WriteInt(File,"scores",GetPlayerScore(playerid));
     INI_WriteInt(File,"kills",PlayerInfo[playerid][PlayerKills]);
     INI_WriteInt(File,"deaths",PlayerInfo[playerid][PlayerDeaths]);
     INI_WriteInt(File,"playerbanned",PlayerInfo[playerid][PlayerBanned]);
     INI_WriteInt(File,"playerip",PlayerInfo[playerid][PlayerIP]);
     INI_WriteInt(File,"lactive_y", PlayerInfo[playerid][LastActive_Y]);
     INI_WriteInt(File,"lactive_m", PlayerInfo[playerid][LastActive_M]);
     INI_WriteInt(File,"lactive_d", PlayerInfo[playerid][LastActive_D]);
     INI_WriteInt(File,"ClanMember",PlayerInfo[playerid][ClanMember]);
     INI_Close(File);
	}
	playerlogged[playerid] = 0;
    return 1;
}

public OnPlayerSpawn(playerid)
{
    if(IsPlayerNPC(playerid)) return 1;
  	new name[MAX_PLAYER_NAME];
  	GetPlayerName(playerid, name, sizeof(name));
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    PlayerInfo[killerid][PlayerKills]++;
    PlayerInfo[playerid][PlayerDeaths]++;
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new str[270], playername[25], playernames[25];
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
    if(dialogid == DIALOG_REGISTER)
    {
      if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, ""COL_GREEN"Register",""COL_RED"You have entered an invalid password.\n"COL_WHITE"Type your password below to register a new account.","Register","Cancel");
      new pIP[16];
      new year, month, day;
      getdate(year, month, day);
      GetPlayerIp(playerid, pIP, sizeof(pIP));
      new INI:File = INI_Open(AccountsPath(playerid));
      INI_SetTag(File,"Player Data");
      INI_WriteInt(File,"password",udb_hash(inputtext));
      INI_WriteInt(File,"Player Name", GetPlayerName(playerid, playernames, MAX_PLAYER_NAME));
      INI_WriteInt(File,"money", REGISTER_MONEY);
      INI_WriteInt(File,"adminlevel",0);
      INI_WriteInt(File,"scores", REGISTER_SCORE);
      INI_WriteInt(File,"kills",0);
      INI_WriteInt(File,"deaths",0);
      INI_WriteInt(File,"playerbanned",0);
      INI_WriteString(File, "playerip", pIP);
      INI_WriteInt(File, "lactive_y", year);
      INI_WriteInt(File, "lactive_m", month);
      INI_WriteInt(File, "lactive_d", day);
      INI_WriteInt(File,"ClanMember",0);
      INI_Close(File);
      GivePlayerMoney(playerid, REGISTER_MONEY);
      GivePlayerScore(playerid, REGISTER_SCORE);
      playerlogged[playerid] = 1;
	  SendPlayerFormattedText(playerid, COLOR_YELLOW, "Account '%s' created, you have been logged in automatically!", playername, "");
	  SendAllFormattedText(COLOR_GREEN, "%s has registered a new account. Welcome to our server!", playername, "");
	  printf("[registered] %s (Id%d) has registered a new account.", playername, playerid);
    }
	else
	{
	 SendClientMessage(playerid, COLOR_WHITE,"You must login/register to play here.");
	}
    if(dialogid == DIALOG_LOGIN)
    {
      if(udb_hash(inputtext) == PlayerInfo[playerid][PlayerPass])
      {
       //INI_ParseFile(AccountsPath(playerid), "LoadPlayer_%s", .bExtra = true, .extra = playerid);
       SetPlayerScore(playerid,  PlayerInfo[playerid][PlayerScore]);
       GivePlayerMoney(playerid, PlayerInfo[playerid][PlayerMoney]);

       playerlogged[playerid] = 1;
       SendClientMessage(playerid, COLOR_GREEN,"Login successful, your status has been restored!");
       printf("[logged] %s (Id%d) has logged in.", playername, playerid);
		}
		else
		{
		    format(str, sizeof(str), "Welcome to {00FFF3}%s.\n\n{FFFF00}Account:{FFFFFF} %s\n\n"COL_RED"You have entered incorrrect password.\n"COL_WHITE"Please put correct password.", SV_NAME, RPN(playerid));
			ShowPlayerDialog2(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, ""COL_RED"Login", str, "Login", "Cancel");
	    }
     }
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
    new string[128], strings[128];
	format(string, sizeof(string), "%s Stats", RPN(clickedplayerid));
	format(string, sizeof(string), "*Name: %s\n*ID: %d\n*Score: %d\n*Kills: %i\n**Deaths: %i\n*Money: %d\n*Adminlevel: %d", RPN(playerid), playerid, GetPlayerScore(playerid), PlayerInfo[playerid][PlayerKills], PlayerInfo[playerid][PlayerDeaths], GetPlayerMoney(playerid), PlayerInfo[playerid][PlayerLevel]);
	ShowPlayerDialog2(playerid, DIALOG_STATS, DIALOG_STYLE_MSGBOX, strings, string, "Ok", "Cancel");
	return 1;
}

/* Server Commands */
CMD:cmds(playerid, params[])
{
 SendClientMessage(playerid, COLOR_YELLOW, ""SV_NAME"'s Commands.");
 SendClientMessage(playerid, COLOR_YELLOW, "/register, /login, /stats, /admins, /richlist, /topkills, /topdeaths");
 SendClientMessage(playerid, COLOR_YELLOW, "/credits");
 return 1;
}
CMD:admincmds(playerid, params[])
{
 if(PlayerInfo[playerid][PlayerLevel] == 1)
 {
  SendClientMessage(playerid, COLOR_YELLOW, "Admin Level 1 Commands.");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 1: /ac, /asay");
  return 1;
 }
 else if(PlayerInfo[playerid][PlayerLevel] == 2)
 {
  SendClientMessage(playerid, COLOR_YELLOW, "Admin Level 1,2 Commands.");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 1: /ac, /asay");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 2: /getip, /resetcash");
  return 1;
 }
 else if(PlayerInfo[playerid][PlayerLevel] == 3)
 {
  SendClientMessage(playerid, COLOR_YELLOW, "Admin Level 1,2,3 Commands.");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 1: /ac, /asay");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 2: /getip, /resetcash");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 3: /givemoney, /kick");
  return 1;
 }
 else if(PlayerInfo[playerid][PlayerLevel] == 4)
 {
  SendClientMessage(playerid, COLOR_YELLOW, "Admin Level 1,2,3,4 Commands.");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 1: /ac, /asay");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 2: /getip, /resetcash");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 3: /givemoney, /kick");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 4: /oban, /ounban, /banip, /unbanip, /givecar, /(v)ehicle");
  return 1;
 }
 else if(PlayerInfo[playerid][PlayerLevel] == 5)
 {
  SendClientMessage(playerid, COLOR_YELLOW, "Admin Level 1,2,3,4,5 Commands.");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 1: /ac, /asay");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 2: /getip, /resetcash");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 3: /givemoney, /kick");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 4: /oban, /ounban, /banip, /unbanip, /givecar, /(v)ehicle");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 5: /setscore, /setmoney, /ban");
  return 1;
 }
 else if(PlayerInfo[playerid][PlayerLevel] == 6)
 {
  SendClientMessage(playerid, COLOR_YELLOW, "Admin Level 1,2,3,4,5,6 Commands.");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 1: /ac, /asay");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 2: /getip, /resetcash");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 3: /givemoney, /kick");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 4: /oban, /ounban, /banip, /unbanip, /givecar, /(v)ehicle");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 5: /setscore, /setmoney, /ban");
  SendClientMessage(playerid, COLOR_YELLOW, "Level 6: /setadmin, /restart");
  return 1;
 }
 else SendClientMessage(playerid, COLOR_WHITE,"Unknown Command.");
 return 1;
}
CMD:register(playerid, params[])
{
	new playername[MAX_PLAYER_NAME];
	if (playerlogged[playerid] == 0)
	{
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
		if(fexist(AccountsPath(playerid))) ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, ""COL_GREEN"Register", "Type a password below to register an account.", "Continue", "Cancel");
		else SendClientMessage2(playerid, COLOR_WHITE, "Account already exists! Type /login to continue.");
	}
	else SendClientMessage2(playerid, COLOR_WHITE, "You are already registered!");
	return 1;
}

CMD:login(playerid, params[])
{
	new playername[MAX_PLAYER_NAME];
	if (playerlogged[playerid] == 0)
	{
		GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
        if(fexist(AccountsPath(playerid)))
		{
		  ShowPlayerDialog2(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, ""COL_RED"Login", "Type your password below to login to your account.", "Login", "Cancel");
		}
		else SendClientMessage2(playerid, COLOR_WHITE, "Account doesn't exist! Type /register to continue.");
	}
	else SendClientMessage2(playerid, COLOR_WHITE, "You are already logged in!");
	return 1;
}
CMD:admins(playerid, params[])
{
  new admins, strings[270];
  if(PlayerInfo[playerid][PlayerScore] < 100) return SendClientMessage(playerid, COLOR_WHITE,"[Server]: You must have 100 Scores to see online admins");
  SendClientMessage(playerid, COLOR_BLUE, "Online Admins");
  for(new i = 0; i < MAX_PLAYERS; i++)
  {
   if (IsPlayerConnected(i))
   {
    if(PlayerInfo[i][PlayerLevel] >= 1)
    {
       new string[128], pname[24];
       GetPlayerName(i, pname, sizeof(pname));
       admins++;
       format(string, sizeof(string), "%s {00FF00} Admin Level: {FF0000}%d [%s]", pname, PlayerInfo[i][PlayerLevel], AdminRanks(i));
       SendClientMessage(playerid, COLOR_RED, string);
    }
  }
  }
  if (admins == 0)
  {
   SendClientMessage(playerid, COLOR_RED, "[Server]: Their are no admins online.");
  }
  else
  {
   format(strings, sizeof(strings), "[Server]: There are currently %d Admins online.", admins);
   SendClientMessage(playerid, COLOR_GREEN, strings);
  }
  return 1;
}
/*CMD:admins(playerid, params[])
{
  SendClientMessage(playerid, COLOR_BLUE, "Online Admins");
  for(new i = 0; i < MAX_PLAYERS; i++)
  {
    if(PlayerInfo[i][PlayerLevel] >= 1)
    {
       new string[128], pname[24];
       GetPlayerName(i, pname, sizeof(pname));
       format(string, sizeof(string), "%s {00FF00} Admin Level: {FF0000}%d", pname, PlayerInfo[i][PlayerLevel]);
       SendClientMessage(playerid, COLOR_RED, string);
    }
  }
  return 1;
}*/

CMD:setadmin(playerid, params[])
{
	new giveplayerid, moneys1, giveplayer[25], playername[25], string[256];
	if (PlayerInfo[playerid][PlayerLevel] < 6 && !IsPlayerAdmin(playerid)) return 0;
	if (sscanf(params, "ud", giveplayerid, moneys1)) return SendClientMessage2(playerid, COLOR_WHITE, "Usage: /setadmin [playerid] [level 1-6]");
	if (!IsPlayerConnected2(giveplayerid)) return SendClientMessage2(playerid, COLOR_RED, "Error: Inactive player id!");
	if (moneys1 < 0 || moneys1 > 6) return SendClientMessage2(playerid, COLOR_RED, "Error: Invalid admin level.");
	if (playerlogged[giveplayerid] == 0) return SendClientMessage2(playerid, COLOR_WHITE, "Error: Player isn't logged in.");
	GetPlayerName(giveplayerid, giveplayer, MAX_PLAYER_NAME);
	if (PlayerInfo[giveplayerid][PlayerLevel] >= PlayerInfo[playerid][PlayerLevel] && PlayerInfo[playerid][PlayerLevel] < 6 && !IsPlayerAdmin(playerid)) return SendPlayerFormattedText(playerid, COLOR_RED, "Error: You cannot Make admin %s", giveplayer, "");
	GetPlayerName(giveplayerid, giveplayer, MAX_PLAYER_NAME);
	if (moneys1 == PlayerInfo[giveplayerid][PlayerLevel])
	{
		format(string, 64, "%s is already admin level %d.", giveplayer, moneys1);
		SendClientMessage2(playerid, COLOR_WHITE, string);
		return 1;
	}
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	PlayerInfo[giveplayerid][PlayerLevel] = moneys1;
	format(string, 64, "You have been set as admin level %d.", moneys1);
	SendClientMessage2(giveplayerid, COLOR_YELLOW, string);
	format(string, 64, "You have set %s as admin level %d.", giveplayer, moneys1);
	SendClientMessage2(playerid, COLOR_YELLOW, string);
	return 1;
}

CMD:ac(playerid, params[])
{
	new string[172];
	if(PlayerInfo[playerid][PlayerLevel] < 1) return 0;
	if(isnull(params)) return SendClientMessage(playerid, -1, "Please use /ac [Message]");
	new PName[MAX_PLAYER_NAME+1];
    GetPlayerName(playerid, PName, sizeof(PName));
	format(string, sizeof(string), "[Admin Chat][%s] %s: %s", AdminRanks(playerid),PName, params);
	SendMessageToAdmins(COLOR_RED, string);
	return 1;
}

CMD:asay(playerid, params[])
  {
  if(PlayerInfo[playerid][PlayerLevel] < 1) return 0;
  new text[128];
  if(sscanf(params, "s[128]",text)) return SendClientMessage(playerid, 0xFFFFFFFF, "Usage: /asay [text]");
  new string[128];
  new pName[128];
  GetPlayerName(playerid,pName,128);
  format(string,sizeof string,"[%s]%s: %s",AdminRanks(playerid),pName,text);
  SendClientMessageToAll(COLOR_GREEN,string);
  return 1;
}

CMD:setscore(playerid, params[])
{
	new giveplayerid, moneys1, giveplayer[25], string[256];
	if (PlayerInfo[playerid][PlayerLevel] < 5) return 0;
	if (sscanf(params, "ud", giveplayerid, moneys1)) return SendClientMessage2(playerid, COLOR_WHITE, "Usage: /setscore [playerid] [score]");
	if (!IsPlayerConnected2(giveplayerid)) return SendClientMessage2(playerid, COLOR_RED, "Error: Inactive player id!");
	if (moneys1 < 0 || moneys1 > cellmax) return SendClientMessage2(playerid, COLOR_RED, "Invalid score! Select from 0 - 2147483647.");
	if (playerlogged[giveplayerid] == 0) return SendClientMessage2(playerid, COLOR_WHITE, "Error: Player isn't logged in.");
	GetPlayerName(giveplayerid, giveplayer, MAX_PLAYER_NAME);
	if (PlayerInfo[giveplayerid][PlayerLevel] > PlayerInfo[playerid][PlayerLevel] || PlayerInfo[playerid][PlayerLevel] < 6) return SendPlayerFormattedText(playerid, COLOR_RED, "Error: You cannot Set score to %s", giveplayer, "");
	PlayerInfo[giveplayerid][PlayerScore] = moneys1;
	SetPlayerScore(giveplayerid, moneys1);
	GetPlayerName(giveplayerid, giveplayer, MAX_PLAYER_NAME);
	if (giveplayerid != playerid)
	{
		format(string, 128, "An admin has set your score to %d.", moneys1);
		SendClientMessage2(giveplayerid, COLOR_YELLOW, string);
		format(string, 128, "You have set %s's score to %d.", giveplayer, moneys1);
		SendClientMessage2(playerid, COLOR_YELLOW, string);
	}
	else
	{
		format(string, 128, "You have set your score to %d.", moneys1);
		SendClientMessage2(playerid, COLOR_YELLOW, string);
	}
	return 1;
}

CMD:setmoney(playerid, params[])
{
	new giveplayerid, moneys1, playername[25], giveplayer[25], string[256];
	if (PlayerInfo[playerid][PlayerLevel] < 5) return 0;
	if (sscanf(params, "ud", giveplayerid, moneys1)) return SendClientMessage2(playerid, COLOR_WHITE, "Usage: /setmoney [playerid] [amount]");
	if (!IsPlayerConnected2(giveplayerid)) return SendClientMessage2(playerid, COLOR_RED, "Error: Inactive player id!");
	if (moneys1 < 0 || moneys1 > MAX_MONEY) return SendClientMessage2(playerid, COLOR_RED, "Error: Invalid amount.");
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	GetPlayerName(giveplayerid, giveplayer, MAX_PLAYER_NAME);
	SetPlayerMoney(giveplayerid, 0);
	GivePlayerMoney(giveplayerid, moneys1);
	PlayerInfo[giveplayerid][PlayerMoney] = moneys1;
	if (giveplayerid != playerid)
	{
		format(string, 128, "Your money has been set to $%d by an admin.", moneys1);
		SendClientMessage2(giveplayerid, COLOR_SILVER, string);
		format(string, 128, "You have set %s's money to $%d.", giveplayer, moneys1);
		SendClientMessage2(playerid, COLOR_SILVER, string);
	}
	else
	{
		format(string, 128, "You have set your money to $%d.", moneys1);
		SendClientMessage2(playerid, COLOR_SILVER, string);
	}
	printf("[setmoney] %s has set player %s's (Id%d) money to $%d.", playername, giveplayer, giveplayerid, moneys1);
	return 1;
}

CMD:givemoney(playerid, params[])
{
	new giveplayerid, moneys1, playername[25], giveplayer[25], string[256];
	if (PlayerInfo[playerid][PlayerLevel] < 3) return 0;
	if (sscanf(params, "ud", giveplayerid, moneys1)) return SendClientMessage2(playerid, COLOR_WHITE, "Usage: /givemoney [playerid] [amount]");
	if (!IsPlayerConnected2(giveplayerid)) return SendClientMessage2(playerid, COLOR_RED, "Error: Inactive player id!");
	if (moneys1 < 1 || moneys1 > MAX_MONEY) return SendClientMessage2(playerid, COLOR_RED, "Error: Invalid amount.");
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	GetPlayerName(giveplayerid, giveplayer, MAX_PLAYER_NAME);
	GivePlayerMoney(giveplayerid, moneys1);
	if (giveplayerid != playerid)
	{
		format(string, 128, "An admin has given you $%d.", moneys1);
		SendClientMessage2(giveplayerid, COLOR_SILVER, string);
		format(string, 128, "You have given %s $%d.", giveplayer, moneys1);
		SendClientMessage2(playerid, COLOR_SILVER, string);
	}
	else
	{
		format(string, 128, "You have gave yourself $%d.", moneys1);
		SendClientMessage2(playerid, COLOR_SILVER, string);
	}
	printf("[givemoney] %s has given player %s (Id%d) $%d.", playername, giveplayer, giveplayerid, moneys1);
	return 1;
}

CMD:resetcash(playerid, params[])
{
	new giveplayerid, giveplayer[25], playername[25];
	if (PlayerInfo[playerid][PlayerLevel] < 2) return 0;
	if (sscanf(params, "u", giveplayerid)) return SendClientMessage2(playerid, COLOR_WHITE, "Usage: /resetcash [playerid]");
	if (!IsPlayerConnected2(giveplayerid)) return SendClientMessage2(playerid, COLOR_RED, "Error: Inactive player id!");
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	GetPlayerName(giveplayerid, giveplayer, MAX_PLAYER_NAME);
	SetPlayerMoney(giveplayerid, 0);
	PlayerInfo[giveplayerid][PlayerMoney] = 0;
	if (giveplayerid != playerid)
	{
		SendClientMessage2(giveplayerid, COLOR_RED, "Your cash has been reset by an admin.");
		SendPlayerFormattedText(playerid, COLOR_RED, "You have reset %s's cash.", giveplayer, "");
	}
	else SendClientMessage2(playerid, COLOR_RED, "You have reset your cash.");
	printf("[resetcash] %s has reset player %s's (Id%d) cash.", playername, giveplayer, giveplayerid);
	return 1;
}
CMD:oban(playerid, params[])
{
	new targetname[24], filestring[79];
	if (PlayerInfo[playerid][PlayerLevel] < 4 && !IsPlayerAdmin(playerid)) return 0;
	if(sscanf(params, "s[24]", targetname)) return SendClientMessage(playerid, COLOR_WHITE, "Correct Usage: /oban [Name]");
	format(filestring, sizeof(filestring), "/Accounts/%s.ini", targetname);
	if(!fexist(filestring)) return SendClientMessage(playerid, -1, "Error: Account Doesn't Exist.");
	else
	{
	    new INI:File = INI_Open(filestring);
	    INI_SetTag(File, "Player Data");
	    INI_WriteInt(File, "PlayerBanned", 1);
	    INI_Close(File);
	    new done[128];
	    format(done, sizeof(done), "You have banned %s", targetname);
	    SendClientMessage(playerid, COLOR_YELLOW, done);
	}
	return 1;
}

CMD:ounban(playerid, params[])
{
	new tname[24];
	if (PlayerInfo[playerid][PlayerLevel] < 4 && !IsPlayerAdmin(playerid)) return 0;
	if(sscanf(params, "s[24]", tname)) return SendClientMessage(playerid,-1,"Correct Usage: /ounban [Name] ");
	new filestring[79];
	format(filestring, sizeof(filestring), "/Accounts/%s.ini", tname);
	if(!fexist(filestring)) return SendClientMessage(playerid, COLOR_WHITE, "Error: Account Doesn't Exist.");
	else
	{
		new INI:File = INI_Open(filestring);
		INI_SetTag(File, "Player Data");
		INI_WriteInt(File, "PlayerBanned",0);
		INI_Close(File);
		SendRconCommand("reloadbans");
		new done[128];
		format(done, sizeof(done),"You have successfully unbanned %s", tname);
		SendClientMessage(playerid, COLOR_YELLOW,done);
	}
	return 1;
}

CMD:getip(playerid, params[])
{
	new giveplayerid, giveplayer[25], tmp2[256],options[128];
	if (PlayerInfo[playerid][PlayerLevel] < 2) return 0;
    if(sscanf(params, "s[128]u", options,giveplayerid)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /getip [playerid]");
    if (!IsPlayerConnected2(giveplayerid)) return SendClientMessage2(playerid, COLOR_RED, "Error: Inactive player id!");
    {
	 GetPlayerName(giveplayerid, giveplayer, MAX_PLAYER_NAME);
	 GetPlayerIp(giveplayerid, tmp2, 16);
	 SendPlayerFormattedText(playerid, COLOR_WHITE, "%s's ip address is %s", giveplayer, tmp2);
	}
	return 1;
}

CMD:banip(playerid, params[])
{
	new tmp[256], tmp2[256];
	if(PlayerInfo[playerid][PlayerLevel] < 4) return 0;
	if (sscanf(params, "s[128]", tmp)) return SendClientMessage2(playerid, COLOR_WHITE, "Usage: /banip [ip address]");
	format(tmp2, 32, "banip %s", tmp);
	SendRconCommand(tmp2);
	SendRconCommand("reloadbans");
	SendPlayerFormattedText(playerid, COLOR_WHITE, "You have banned IP address %s.", tmp, "");
	return 1;
}

CMD:unbanip(playerid, params[])
{
	new tmp[256], tmp2[256];
	if(PlayerInfo[playerid][PlayerLevel] < 4) return 0;
	if (sscanf(params, "s[128]", tmp)) return SendClientMessage2(playerid, COLOR_WHITE, "Usage: /unbanip [ip address]");
	format(tmp2, 32, "unbanip %s", tmp);
	SendRconCommand(tmp2);
	SendRconCommand("reloadbans");
	SendPlayerFormattedText(playerid, COLOR_WHITE, "You have unbanned IP address %s.", tmp, "");
	return 1;
}

CMD:ban(playerid, params[])
    {
        if(PlayerInfo[playerid][PlayerLevel] < 5) return 0;
        new player;
        new reason[64];
        new str[128];
        new giveplayerid, giveplayer[25];
        new Playername[MAX_PLAYER_NAME], Adminname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, Adminname, sizeof(Adminname));
        GetPlayerName(player, Playername, sizeof(Playername));
        if (PlayerInfo[giveplayerid][PlayerLevel] > PlayerInfo[playerid][PlayerLevel] && PlayerInfo[playerid][PlayerLevel] < 6 && PlayerInfo[giveplayerid][PlayerLevel] > 6) return SendPlayerFormattedText(playerid, COLOR_RED, "Error: You cannot ban %s.", giveplayer, "");
        if(sscanf(params, "us[64]", player,reason)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /kick [playerid] [reason]");
        if(!IsPlayerConnected(player))
        return SendClientMessage(playerid, COLOR_GREY, "Player is not connected!");
        format(str, sizeof(str), "'%s' has been banned by administrator '%s'. Reason: %s ", Playername, Adminname, reason);
        SendClientMessageToAll(COLOR_RED, str);
        Ban(player);
        return 1;
}

CMD:kick(playerid,params[])
{
         new player,gname[MAX_PLAYER_NAME],string[125],reason[70], giveplayerid, giveplayer[25];
         if(PlayerInfo[playerid][PlayerLevel] < 3 || (playerid)) return 0;
         if (PlayerInfo[giveplayerid][PlayerLevel] > PlayerInfo[playerid][PlayerLevel] && PlayerInfo[playerid][PlayerLevel] < 6) return SendPlayerFormattedText(playerid, COLOR_RED, "Error: You cannot kick %s.", giveplayer, "");
         if(sscanf(params,"us[70]",player,reason)) return SendClientMessage(playerid,-1," (ERROR) : /kick [playerid] [reason]");
         GetPlayerName(player,gname,sizeof(gname));
         format(string, sizeof(string), "SERVER SYSTEM: %s has been kicked from the server Reason: %s", gname,reason);
         SendClientMessageToAll( -1, string);
         Kick(player);
         return 1;
}
CMD:v(playerid, params[])
{
	return cmd_vehicle(playerid, params);
}
CMD:vehicle(playerid, params[])
{
	new tmp[256], id, string[256], giveplayerid;
	if(PlayerInfo[playerid][PlayerLevel] < 4) return 0;
    if (vehiclemodels >= MAX_VEHICLE_MODELS) return SendClientMessage2(playerid, COLOR_RED, "Error: Vehicle model limit reached.");
	if (GetMaxVehicles() == VEHICLES-PLAYERS) return SendClientMessage2(playerid, COLOR_RED, "Error: Vehicle limit reached.");
	if(sscanf(params, "s[128]", tmp)) return SendClientMessage2(playerid, COLOR_WHITE, "Usage: /v [model / name]");
	if(IsNumeric(tmp)) id = strval(tmp);
	else
	{
		new vcount = 0, ovtl[5];
		for (new d = 0; d < 212; d++)
		{
			if (strfind(vehName[d], tmp, true) != -1 || strval(tmp) == d+400)
			{
				id = d+400;
				if (vcount < 5) ovtl[vcount] = id;
				else return SendClientMessage2(playerid, COLOR_RED, "Error: More than 5 results with that name were found.");
				vcount ++;
			}
		}
		if (vcount > 1)
		{
			for (new e = 0; e < vcount; e++)
			{
				if (e == 0) SendClientMessage2(playerid, COLOR_LBLUE, "Results..");
				format(string, 64, " %s (Model - %d).", vehName[ovtl[e]-400], ovtl[e]);
				SendClientMessage2(playerid, COLOR_WHITE, string);
				if (e == vcount-1) SendClientMessage2(playerid, COLOR_WHITE, "");
			}
			return 1;
		}
	}
	if (id < 400 || id > 611) return SendClientMessage2(playerid, COLOR_ORANGE, "Usage: /changecar [model / name]");
	new Float:x, Float:y, Float:z, Float:a;
	if (spectat[playerid] != -1)
	{
		if (IsPlayerInAnyVehicle(spectat[playerid]))
		{
			GetVehiclePos(GetPlayerVehicleID(spectat[playerid]), x, y, z);
			GetVehicleZAngle(GetPlayerVehicleID(spectat[playerid]), a);
		}
		else
		{
			GetPlayerPos(spectat[playerid], x, y, z);
			GetPlayerFacingAngleFix(spectat[playerid], a);
		}
	}
	else
	{
		if (IsPlayerInAnyVehicle(playerid))
		{
			GetVehiclePos(GetPlayerVehicleID(playerid), x, y, z);
			GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
		}
		else
		{
			GetPlayerPos(playerid, x, y, z);
			GetPlayerFacingAngleFix(playerid, a);
		}
	}
	x += floatsin(-a, degrees) * 5.0;
	y += floatcos(-a, degrees) * 5.0;
	giveplayerid = CreateVehicle2(id, x, y, z, a+90.0, -1);
	LinkVehicleToInterior2(giveplayerid, GetPlayerInterior(playerid));
	SetVehicleVirtualWorld(giveplayerid, GetPlayerVirtualWorld(playerid));
	svtd[giveplayerid] = true;
	format(string, 128, "You have spawned a %s (Model - %d) (ID - %d).", vehName[id-400], id, giveplayerid);
	SendClientMessage2(playerid, COLOR_WHITE, string);
	return 1;
}
CMD:givecar(playerid, params[])
{
	new tmp[256], id, string[256], giveplayerid, uid;
	if(PlayerInfo[playerid][PlayerLevel] < 4) return 0;
	if (vehiclemodels >= MAX_VEHICLE_MODELS) return SendClientMessage2(playerid, COLOR_RED, "Error: Vehicle model limit reached.");
	if (GetMaxVehicles() == VEHICLES-PLAYERS) return SendClientMessage2(playerid, COLOR_RED, "Error: Vehicle limit reached.");
	if(sscanf(params, "us[128]", uid, tmp)) return SendClientMessage2(playerid, COLOR_WHITE, "Usage: /givecar [playerid] [model / name]");
	if(!IsPlayerConnected2(uid)) return SendClientMessage(playerid, COLOR_RED, "Inactive player id.");
	if(IsPlayerInAnyVehicle(uid)) return SendClientMessage(playerid, COLOR_RED, "That player is already in vehicle.");
	if(IsNumeric(tmp)) id = strval(tmp);
	else
	{
		new vcount = 0, ovtl[5];
		for (new d = 0; d < 212; d++)
		{
			if (strfind(vehName[d], tmp, true) != -1 || strval(tmp) == d+400)
			{
				id = d+400;
				if (vcount < 5) ovtl[vcount] = id;
				else return SendClientMessage2(playerid, COLOR_RED, "Error: More than 5 results with that name were found.");
				vcount ++;
			}
		}
		if (vcount > 1)
		{
			for (new e = 0; e < vcount; e++)
			{
				if (e == 0) SendClientMessage2(playerid, COLOR_LBLUE, "Results..");
				format(string, 64, " %s (Model - %d).", vehName[ovtl[e]-400], ovtl[e]);
				SendClientMessage2(playerid, COLOR_WHITE, string);
				if (e == vcount-1) SendClientMessage2(playerid, COLOR_WHITE, "");
			}
			return 1;
		}
	}
	if (id < 400 || id > 611) return SendClientMessage2(playerid, COLOR_ORANGE, "Usage: /changecar [model / name]");
	new Float:x, Float:y, Float:z, Float:a;
	GetPlayerPos(uid, x, y, z);
	GetPlayerFacingAngleFix(uid, a);
	x += floatsin(-a, degrees) * 5.0;
	y += floatcos(-a, degrees) * 5.0;
	giveplayerid = CreateVehicle2(id, x, y, z, a+90.0, -1);
	LinkVehicleToInterior2(giveplayerid, GetPlayerInterior(uid));
	SetVehicleVirtualWorld(giveplayerid, GetPlayerVirtualWorld(uid));
	svtd[giveplayerid] = true;
	PutPlayerInVehicle(uid, giveplayerid, 0);
	format(string, 128, "You have spawned a %s (Model - %d) (ID - %d) to %s.", vehName[id-400], id, giveplayerid, RPN(uid));
	SendClientMessage2(playerid, COLOR_WHITE, string);
	return 1;
}
CMD:stats(playerid, params[])
{
	new string[128], strings[128], player;
	if(PlayerInfo[playerid][PlayerScore] < 100)
	{
	 if(sscanf(params,"u",player)) return SendClientMessage(playerid,-1," (ERROR) : /stats [playerid]");
	 {
	  format(string, sizeof(string), "%s Stats", RPN(playerid));
	  format(string, sizeof(string), "*Name: %s\n*ID: %d\n*Score: %d\n*Kills: %i\n**Deaths: %i\n*Money: %d\n*Adminlevel: %d", RPN(playerid), playerid, GetPlayerScore(playerid), PlayerInfo[playerid][PlayerKills], PlayerInfo[playerid][PlayerDeaths], GetPlayerMoney(playerid), PlayerInfo[playerid][PlayerLevel]);
	  ShowPlayerDialog2(playerid, DIALOG_STATS, DIALOG_STYLE_MSGBOX, strings, string, "Ok", "Cancel");
	  return 1;
	 }
	 }
     else
     {
     format(string, sizeof(string), "%s Stats", RPN(playerid));
     format(string, sizeof(string), "*Name: %s\n*ID: %d\n*Score: %d\n*Kills: %i\n**Deaths: %i\n*Money: %d\n*Adminlevel: %d", RPN(playerid), playerid, GetPlayerScore(playerid), PlayerInfo[playerid][PlayerKills], PlayerInfo[playerid][PlayerDeaths], GetPlayerMoney(playerid), PlayerInfo[playerid][PlayerLevel]);
     ShowPlayerDialog2(playerid, DIALOG_STATS, DIALOG_STYLE_MSGBOX, strings, string, "Ok", "Cancel");
     return 1;
     }
}
CMD:richlist(playerid, params[])
{
    new	string[128], Slot1 = -1, Slot2 = -1, Slot3 = -1, Slot4 = -1, HighestCash = -9999;
    SendClientMessage(playerid, COLOR_YELLOW, "Server Rich List:");
    for(new x=0; x<MAX_PLAYERS; x++)
    if(IsPlayerConnected(x))
    if(GetPlayerMoney(x) >= HighestCash)
    {
        HighestCash = GetPlayerMoney(x);
        Slot1 = x;
    }
    HighestCash = -9999;
    for(new x=0; x<MAX_PLAYERS; x++)
    if(IsPlayerConnected(x) && x != Slot1)
    if(GetPlayerMoney(x) >= HighestCash)
    {
        HighestCash = GetPlayerMoney(x);
        Slot2 = x;
    }
    HighestCash = -9999;
    for(new x=0; x<MAX_PLAYERS; x++)
    if(IsPlayerConnected(x) && x != Slot1 && x != Slot2)
    if(GetPlayerMoney(x) >= HighestCash)
    {
        HighestCash = GetPlayerMoney(x);
        Slot3 = x;
    }
    HighestCash = -9999;
    for(new x=0; x<MAX_PLAYERS; x++)
    if(IsPlayerConnected(x) && x != Slot1 && x != Slot2 && x != Slot3)
    if(GetPlayerMoney(x) >= HighestCash)
    {
        HighestCash = GetPlayerMoney(x);
        Slot4 = x;
    }
    format(string, sizeof(string), "[%d]: %s - $%d", Slot1, RPN(Slot1), GetPlayerMoney(Slot1));
    SendClientMessage(playerid, COLOR_WHITE, string);
    if(Slot2 != -1)
    {
        format(string, sizeof(string), "[%d]: %s - $%d", Slot2, RPN(Slot2), GetPlayerMoney(Slot2));
        SendClientMessage(playerid, COLOR_WHITE, string);
    }
    if(Slot3 != -1)
    {
        format(string, sizeof(string), "[%d]: %s - $%d", Slot3, RPN(Slot3), GetPlayerMoney(Slot3));
        SendClientMessage(playerid, COLOR_WHITE, string);
    }
    if(Slot4 != -1)
    {
        format(string, sizeof(string), "[%d]: %s - $%d", Slot4, RPN(Slot4), GetPlayerMoney(Slot4));
        SendClientMessage(playerid, COLOR_WHITE, string);
    }
    return 1;
}
CMD:topkillers(playerid, params[])
{
    new	string[128], Slot1 = -1, Slot2 = -1, Slot3 = -1, Slot4 = -1, TopKill = -9999;
    SendClientMessage(playerid, COLOR_YELLOW, "Server Top Killers List:");
    for(new x=0; x<MAX_PLAYERS; x++)
    if(IsPlayerConnected(x))
    if(PlayerInfo[x][PlayerKills] >= TopKill)
    {
        TopKill = PlayerInfo[x][PlayerKills];
        Slot1 = x;
    }
    TopKill = -9999;
    for(new x=0; x<MAX_PLAYERS; x++)
    if(IsPlayerConnected(x) && x != Slot1)
    if(PlayerInfo[x][PlayerKills] >= TopKill)
    {
        TopKill = PlayerInfo[x][PlayerKills];
        Slot2 = x;
    }
    TopKill = -9999;
    for(new x=0; x<MAX_PLAYERS; x++)
    if(IsPlayerConnected(x) && x != Slot1 && x != Slot2)
    if(PlayerInfo[x][PlayerKills] >= TopKill)
    {
        TopKill = PlayerInfo[x][PlayerKills];
        Slot3 = x;
    }
    TopKill = -9999;
    for(new x=0; x<MAX_PLAYERS; x++)
    if(IsPlayerConnected(x) && x != Slot1 && x != Slot2 && x != Slot3)
    if(PlayerInfo[x][PlayerKills] >= TopKill)
    {
        TopKill = PlayerInfo[x][PlayerKills];
        Slot4 = x;
    }
    format(string, sizeof(string), "[%d]: %s - $%d", Slot1, RPN(Slot1), PlayerInfo[Slot1][PlayerKills]);
    SendClientMessage(playerid, COLOR_WHITE, string);
    if(Slot2 != -1)
    {
        format(string, sizeof(string), "[%d]: %s - $%d", Slot2, RPN(Slot2), PlayerInfo[Slot2][PlayerKills]);
        SendClientMessage(playerid, COLOR_WHITE, string);
    }
    if(Slot3 != -1)
    {
        format(string, sizeof(string), "[%d]: %s - $%d", Slot3, RPN(Slot3), PlayerInfo[Slot3][PlayerKills]);
        SendClientMessage(playerid, COLOR_WHITE, string);
    }
    if(Slot4 != -1)
    {
        format(string, sizeof(string), "[%d]: %s - $%d", Slot4, RPN(Slot4), PlayerInfo[Slot4][PlayerKills]);
        SendClientMessage(playerid, COLOR_WHITE, string);
    }
    return 1;
}
CMD:topdeaths(playerid, params[])
{
    new	string[128], Slot1 = -1, Slot2 = -1, Slot3 = -1, Slot4 = -1, TopDeath = -9999;
    SendClientMessage(playerid, COLOR_YELLOW, "Server Top Killers List:");
    for(new x=0; x<MAX_PLAYERS; x++)
    if(IsPlayerConnected(x))
    if(PlayerInfo[x][PlayerDeaths] >= TopDeath)
    {
        TopDeath = PlayerInfo[x][PlayerDeaths];
        Slot1 = x;
    }
    TopDeath = -9999;
    for(new x=0; x<MAX_PLAYERS; x++)
    if(IsPlayerConnected(x) && x != Slot1)
    if(PlayerInfo[x][PlayerDeaths] >= TopDeath)
    {
        TopDeath = PlayerInfo[x][PlayerDeaths];
        Slot2 = x;
    }
    TopDeath = -9999;
    for(new x=0; x<MAX_PLAYERS; x++)
    if(IsPlayerConnected(x) && x != Slot1 && x != Slot2)
    if(PlayerInfo[x][PlayerDeaths] >= TopDeath)
    {
        TopDeath = PlayerInfo[x][PlayerDeaths];
        Slot3 = x;
    }
    TopDeath = -9999;
    for(new x=0; x<MAX_PLAYERS; x++)
    if(IsPlayerConnected(x) && x != Slot1 && x != Slot2 && x != Slot3)
    if(PlayerInfo[x][PlayerDeaths] >= TopDeath)
    {
        TopDeath = PlayerInfo[x][PlayerDeaths];
        Slot4 = x;
    }
    format(string, sizeof(string), "[%d]: %s - $%d", Slot1, RPN(Slot1), PlayerInfo[Slot1][PlayerDeaths]);
    SendClientMessage(playerid, COLOR_WHITE, string);
    if(Slot2 != -1)
    {
        format(string, sizeof(string), "[%d]: %s - $%d", Slot2, RPN(Slot2), PlayerInfo[Slot2][PlayerDeaths]);
        SendClientMessage(playerid, COLOR_WHITE, string);
    }
    if(Slot3 != -1)
    {
        format(string, sizeof(string), "[%d]: %s - $%d", Slot3, RPN(Slot3), PlayerInfo[Slot3][PlayerDeaths]);
        SendClientMessage(playerid, COLOR_WHITE, string);
    }
    if(Slot4 != -1)
    {
        format(string, sizeof(string), "[%d]: %s - $%d", Slot4, RPN(Slot4), PlayerInfo[Slot4][PlayerDeaths]);
        SendClientMessage(playerid, COLOR_WHITE, string);
    }
    return 1;
}

CMD:credits(playerid, params[])
{
 new strings[1000], string[1000];
 format(strings, sizeof(strings), ""COL_RED""SV_NAME" "COL_GREY"Credits");
 format(string, sizeof(string), ""COL_YELLOW"Server Owner/Developer/Scripter/Mapper : "COL_BLUE"[bR]BulletRaja\n"COL_YELLOW"Server Manager : "COL_BLUE"[bR]Soon\n"COL_YELLOW"%s(%d) : to play in our server\n\n"COL_RED"Includes Credits\n"COL_YELLOW"Streamer : "COL_BLUE"Incognito\n"COL_YELLOW"Sscanf2 : "COL_BLUE"Emmet_\n"COL_YELLOW"Zcmd : "COL_BLUE"Zeex\n"COL_YELLOW"YSI/y_ini : "COL_BLUE"Misiur\n\n", RPN(playerid), playerid);
 ShowPlayerDialog2(playerid, DIALOG_STATS, DIALOG_STYLE_MSGBOX, strings, string, "Ok", "");
 return 1;
}
CMD:rules(playerid, params[])
{
 new string[1000], strings[1000];
 format(string, sizeof(string), ""COL_GREEN"Server Rules");
 format(string, sizeof(string), ""COL_BLUE"%s(%d)"COL_WHITE"Thanks for reading rules.\n\n\
 "COL_YELLOW"1> "COL_LIME"Soon\n\
 "COL_YELLOW"2> "COL_LIME"Soon\n\
 "COL_YELLOW"3> "COL_LIME"Soon\n\
 "COL_YELLOW"4> "COL_LIME"Soon\n\
 "COL_YELLOW"5> "COL_LIME"Soon\n\
 "COL_YELLOW"6> "COL_LIME"Soon\n\
 "COL_YELLOW"7> "COL_LIME"Soon\n\
 "COL_YELLOW"8> "COL_LIME"Soon\n\
 "COL_YELLOW"9> "COL_LIME"Soon\n\
 "COL_YELLOW"10> "COL_LIME"Soon\n\
 "COL_YELLOW"11> "COL_LIME"Soon\n\
 "COL_YELLOW"12> "COL_LIME"Soon\n\
 "COL_YELLOW"13> "COL_LIME"Soon\n\
 \n\n", RPN(playerid), playerid);
 ShowPlayerDialog2(playerid, DIALOG_RULES, DIALOG_STYLE_MSGBOX, strings, string, "Ok", "");
 return 1;
}
CMD:restart(playerid, params[])
{
	if(PlayerInfo[playerid][PlayerLevel] < 6) return 0;
	new str[256], reson[1000];
	if (sscanf(params, "s[1000]", reson)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: /restart [reason]");
	SetTimer("Restart", 500, 0);
	format(str, sizeof(str), "* The server will restart, Reason: %s.",  reson);
	SendClientMessageToAll(COLOR_OSAY, str);
	return 1;
}
CMD:setclanmember(playerid, params[])
{
   	new string[1000], giveplayerid, giveplayer[60];
    if (PlayerInfo[playerid][PlayerLevel] < 5) return 0;
 	if (!IsPlayerConnected2(giveplayerid)) return SendClientMessage2(playerid, COLOR_RED, "Error: Inactive player id!");
	if(sscanf(params,"u", giveplayerid)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /setclanmember [playerid]");
	GetPlayerName(giveplayerid, giveplayer, MAX_PLAYER_NAME);
	if(PlayerInfo[playerid][ClanMember] == 1) return SendClientMessage(playerid, COLOR_RED, "Error: He is already clan member.");
	format(string,sizeof(string), "*You Have Successfuly Set %s As An Clan Member.",giveplayer);
	SendClientMessage(playerid,COLOR_RED, string);
	format(string,sizeof(string), "An admin has made you a "CLAN_TAG" clan member. Now you are allowed to add "CLAN_TAG" tag to your name.");
	SendClientMessage(giveplayerid,COLOR_GREEN, string);
	PlayerInfo[playerid][ClanMember] = 1;
    return 1;
}
CMD:kickclanmember(playerid, params[])
{
	new giveplayerid, string[200], giveplayer[60];
    if (PlayerInfo[playerid][PlayerLevel] < 5) return 0;
 	if (!IsPlayerConnected2(giveplayerid)) return SendClientMessage2(playerid, COLOR_RED, "Error: Inactive player id!");
   	if(sscanf(params,"u",giveplayerid)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /kickclanmember [playerid]");
	GetPlayerName(giveplayerid, giveplayer, MAX_PLAYER_NAME);
	if(!PlayerInfo[playerid][ClanMember]) return SendClientMessage(playerid, COLOR_RED, "Error: He is not a clan member.");
	PlayerInfo[playerid][ClanMember] = 0;
	format(string,sizeof(string), "An admin has kicked you from "CLAN_TAG" clan. Now use /working on the cmd and remove the "CLAN_TAG" tag from your name.");
	SendClientMessage(giveplayerid,COLOR_GREEN, string);
	return 1;
}

forward Restart();
public Restart()
{
    for (new i = 0, playercount=GetPlayerPoolSize(); i <= playercount; i++)
	{
        if(IsPlayerConnected(i))
        {
            Kick(i);
        }
	}
	SendRconCommand("gmx");
	return 1;
}
