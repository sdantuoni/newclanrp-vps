/*
				eXtreme RolePlay
				        En proceso de creación.
				        
				        
				        
				        

							SQLite Server

	adri1, Ner0x, Jeff, Martin, inuckles, raul.lg98, Sirgio, Angelyto



							    includes

						YSI			- Y_Less
						ZCMD		- Zeex
						SSCANF		- Y_Less
						STREANER	- Incognito
*/

// ----------> Includes
#include <a_samp>
#include <YSI\y_iterate>
#include <YSI\y_va>
#include <zcmd>
#include <sscanf2>
#include <streamer>

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
	
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

// ----------> Archivos
#define PATX "/eXtremeROL/conocidos/%s.ini"

// ----------> Dialogs
#define DIALOG_REGISTER 20
#define DIALOG_LOGIN    21
#define DIALOG_EMAIL    22
#define DIALOG_KNOW     23
#define DIALOG_HOUSE    24 // (+2 = 26, próximo dialog será 27)
#define DIALOG_COMPRA   27
#define DIALOG_RETIRAR  28
#define DIALOG_DEPOSIT  29
#define DIALOG_BANCO    30
#define DIALOG_RETIRAR2 31
#define DIALOG_DEPOSIT2 32
#define DIALOG_AYUNTA   33
#define DIALOG_BIKE     34
#define DIALOG_DUDAS	35
#define DIALOG_EMAIL2   36
#define DIALOG_CONFIRME 37
#define DIALOG_GROTTI	40
// ----------> Límites
#define MAX_NPC         35
#define MAX_EVENTS      20

// ----------> Colores
#define ROJO     			"{FF0000}"
#define VERDE   			"{00FF00}"
#define AZUL    			"{0000FF}"
#define AMARILLO  			"{FFFF00}"
#define BLANCO              "{FFFFFF}"
#define AZULCLARO           "{27BCFF}"
#define GRIS                "{ACACAC}"
#define RED     			"{FF0000}"
#define GREEN   			"{00FF00}"
#define BLUE    			"{0000FF}"
#define YELLOW  			"{FFFF00}"
#define WHITE               "{FFFFFF}"
#define LIGHTBLUE           "{27BCFF}"

// ----------> Otros
#define DeleteChatForPlayer(%0,%1,%2) for(new %2 = 0; %2 != %1; %2++) SendClientMessage(%0, -1, " ")
#define loop(%0,%1,%2) for(new %2 = %0; %2 < %1; %2++)
#define DELAY 100
#define RGBToHex(%0,%1,%2,%3) %0 << 24 | %1 << 16 | %2 << 8 | %3
#define funcion:%0(%1) forward %0(%1); public %0(%1)
#define GiveBagForPlayer(%0,%1) SetPlayerAttachedObject(%0,9,1310,1,-0.132999,-0.114999,-0.023000,0.000000,90.0,0.000000,0.731000,0.862999,0.889000, %1, 0x00FFFFFF)

// ----------> Bots
#define SHOP_UNITY  0
#define BITCH_BJ    1
#define SHOP_AYUNT  2
#define SHOP_VINE   3
#define BANK_1      4
#define BANK_2      5
#define BANK_3      6
#define BAR_GROOVE  7
#define BINCO       8
#define BURGERSHOT  9
#define BELLS       10
#define DANCER1     11
#define DANCER2     12
#define BARBER      13
#define PIZZASTACK  14
#define PROLAPS     15
#define SUBURBAN    16
#define VICTIM      17
#define ZIP         18

#define INT_NONE    0
#define INT_GROTTI  1
#define INT_BANCO   2
#define INT_CNN     3
#define INT_VIP     4
#define INT_BITCH   5
#define INT_247U    6
#define INT_ALHAM   7
#define INT_247VIN  8
#define INT_247AYU  9
#define INT_BINCO   10
#define INT_ZIP     11
#define INT_PROLAPS 12
#define INT_SUBURBA 13
#define INT_VICTIM  14
#define INT_BURGER  15
#define INT_PIZZA   16
#define INT_PELU    17
#define INT_TATTO   18
#define INT_PELU2   19
#define INT_BELL    20
#define INT_PIGPEN  21
#define INT_BARGR   22
#define INT_GYMLS   23
#define INT_LSPD    24
#define INT_AYUNT   25
native IsValidVehicle(vehicleid);
// ----------> Variables
enum PInfo
{
	Float:posx,
	Float:posy,
	Float:posz,
	Float:angle,
	interiorid,
	bikerent,
	passtext[33],
	email[64],
	pass,
	dinero,
	dinerobank,
	sexo,
	edad,
	skin,
	Float:vida,
	Float:chaleco,
	admlvl,
  	phonenumber,
 	Interior,
 	BankA,
 	Work,
 	VBank,
 	VGrotti,
 	V247,
 	VRopa,
 	VComida,
 	DudeChannel,
 	Plevel,
	PlayerVehicle[4],
	PlayerVehicleKey[4]
};
new PlayerInfo[MAX_PLAYERS][PInfo];
new DestroyVehiclesTimer[MAX_VEHICLES];
enum VInfo
{
	VD[24],
	VKEY,
	Float:vposx,
	Float:vposy,
	Float:vposz,
	Float:vangle,
	vmodelid,
	vcolor1,
	vcolor2,
	vpaintjob,
	mod1,
	mod2,
	mod3,
	mod4,
	mod5,
	mod6,
	mod7,
	mod8,
	mod9,
	mod10,
	mod11,
	mod12,
	mod13,
	mod14,
	mod15,
	mod16,
	mod17,
	slot
};
new VehicleInfo[MAX_VEHICLES][VInfo];
new spoiler[20][0] = {
	{1000},
	{1001},
	{1002},
	{1003},
	{1014},
	{1015},
	{1016},
	{1023},
	{1058},
	{1060},
	{1049},
	{1050},
	{1138},
	{1139},
	{1146},
	{1147},
	{1158},
	{1162},
	{1163},
	{1164}
};

new nitro[3][0] = {
    {1008},
    {1009},
    {1010}
};

new fbumper[23][0] = {
    {1117},
    {1152},
    {1153},
    {1155},
    {1157},
    {1160},
    {1165},
    {1167},
    {1169},
    {1170},
    {1171},
    {1172},
    {1173},
    {1174},
    {1175},
    {1179},
    {1181},
    {1182},
    {1185},
    {1188},
    {1189},
    {1192},
    {1193}
};

new rbumper[22][0] = {
    {1140},
    {1141},
    {1148},
    {1149},
    {1150},
    {1151},
    {1154},
    {1156},
    {1159},
    {1161},
    {1166},
    {1168},
    {1176},
    {1177},
    {1178},
    {1180},
    {1183},
    {1184},
    {1186},
    {1187},
    {1190},
    {1191}
};

new exhaust[28][0] = {
    {1018},
    {1019},
    {1020},
    {1021},
    {1022},
    {1028},
    {1029},
    {1037},
    {1043},
    {1044},
    {1045},
    {1046},
    {1059},
    {1064},
    {1065},
    {1066},
    {1089},
    {1092},
    {1104},
    {1105},
    {1113},
    {1114},
    {1126},
    {1127},
    {1129},
    {1132},
    {1135},
    {1136}
};

new bventr[2][0] = {
    {1142},
    {1144}
};

new bventl[2][0] = {
    {1143},
    {1145}
};

new bscoop[4][0] = {
	{1004},
	{1005},
	{1011},
	{1012}
};

new rscoop[17][0] = {
    {1006},
    {1032},
    {1033},
    {1035},
    {1038},
    {1053},
    {1054},
    {1055},
    {1061},
    {1067},
    {1068},
    {1088},
    {1091},
    {1103},
    {1128},
    {1130},
    {1131}
};

new lskirt[21][0] = {
    {1007},
    {1026},
    {1031},
    {1036},
    {1039},
    {1042},
    {1047},
    {1048},
    {1056},
    {1057},
    {1069},
    {1070},
    {1090},
    {1093},
    {1106},
    {1108},
    {1118},
    {1119},
    {1133},
    {1122},
    {1134}
};

new rskirt[21][0] = {
    {1017},
    {1027},
    {1030},
    {1040},
    {1041},
    {1051},
    {1052},
    {1062},
    {1063},
    {1071},
    {1072},
    {1094},
    {1095},
    {1099},
    {1101},
    {1102},
    {1107},
    {1120},
    {1121},
    {1124},
    {1137}
};

new hydraulics[1][0] = {
    {1087}
};

new vbase[1][0] = {
    {1086}
};

new rbbars[4][0] = {
    {1109},
    {1110},
    {1123},
    {1125}
};

new fbbars[2][0] = {
    {1115},
    {1116}
};

new wheels[17][0] = {
    {1025},
    {1073},
    {1074},
    {1075},
    {1076},
    {1077},
    {1078},
    {1079},
    {1080},
    {1081},
    {1082},
    {1083},
    {1084},
    {1085},
    {1096},
    {1097},
    {1098}
};

new lights[2][0] = {
	{1013},
	{1024}
};
forward OnPlayerWeaponChange(playerid, newweaponid, oldweaponid);

new Float:VehicleGrottiSpawns[][] =
{
    {204.9464, -1444.2706, 12.9216, -40.0},
    {202.4313, -1442.4076, 12.9216, -40.0},
    {200.1760, -1440.2938, 12.9216, -40.0},
    {198.0144, -1438.4742, 12.9216, -40.0},
    {195.8165, -1436.5382, 12.9216, -40.0},
    {209.6814, -1421.4117, 12.9216, -227.0},
    {211.7771, -1423.5690, 12.9216, -227.0},
    {213.8425, -1425.6744, 12.9216, -227.0},
    {216.0536, -1427.9497, 12.9216, -227.0},
    {218.0803, -1430.1473, 12.9216, -227.0}
};

new
    DB:Database,
	Text:TD_NN,
	PlayerText:TD_IO[MAX_PLAYERS],
	Text:TD_EY[3],
	Text:TD_BX[2],
	Dude_Object[3],
	ServerTime = 12,
	ServerMinute = 0,
	PlayerText:Background[MAX_PLAYERS],
	PlayerText:Conceptos[7][MAX_PLAYERS],
	ChatLogDisabled[MAX_PLAYERS],
	PlayerText:ErrorCommand[MAX_PLAYERS],
	BancoLS[6],
	PlayerKnownPlayer[MAX_PLAYERS][MAX_PLAYERS],
	Text3D:IDlabel[MAX_PLAYERS],
	NPCS[MAX_NPC],
	NPC_USED[MAX_NPC],
	PlayerEvent[MAX_PLAYERS][MAX_EVENTS],
    UsingPhone[MAX_PLAYERS],
    NumeroMarcado[MAX_PLAYERS],
    Text:CircularMenu[12],
    Text:UserBox[4],
    PlayerText:PlayerUserBox[MAX_PLAYERS][2],
	gArma[MAX_PLAYERS],
	Text:Bank[20],
	PlayerText:PlayerBank[MAX_PLAYERS][2],
	Text:TD_Phone[10],
	PlayerText:PTD_PhoneString1[MAX_PLAYERS],
	PlayerText:PTD_PhoneString2[MAX_PLAYERS],
	PlayerText:BankCash[MAX_PLAYERS],
	PlayerText:CosasPorHacer[MAX_PLAYERS][4],
	LSPD_Doors[4],
	P_newuser[MAX_PLAYERS]=-1,
	P_No_Message_Atraco[MAX_PLAYERS]=-1,
	P_bank_state[MAX_PLAYERS]=-1,
	P_circularmenu_active[MAX_PLAYERS]=-1,
	P_player_tutorial[MAX_PLAYERS]=-1,
	P_conocerid[MAX_PLAYERS]=-1,
	P_register_step[MAX_PLAYERS]=-1,
	P_catalogogrotti[MAX_PLAYERS]=-1,
	VBikeRent[2],
	LSPD_OBJECT[27],
	VVehicleGrotti[2],
	AyuntNoBug,
	CarWash[5],
	CarWashUsed,
	CarWashUsedBy[MAX_PLAYERS],
	DudeTime[MAX_PLAYERS],
	DudeMsg[MAX_PLAYERS],
	CoachBus,
	//Text:InventarioTD[5],
	//PlayerText:PlayerInventarioTD[MAX_PLAYERS][10],
	PoliciaAvisada[MAX_PLAYERS],
	Area_CarWash,
	Text:DeadTD[8],
	Text:WelcomeTD[4],
	Text:TD_ST[10],
	PlayerText:PTD_ST[MAX_PLAYERS][2],
	Text:TD_PLAYERDATA[6],
	PlayerText:PTD_PD[MAX_PLAYERS],
	Alhambra,
	Alhambra_Bar,
	Menu:AlhambraMenu,
	Alhambra_Pick,
	Conce_Pick1,
	Conce_Pick2,
	Text:TD_GrottiCatalogo[9],
	PlayerText:PTD_GrottiCatalogo[MAX_PLAYERS][4]
;

new RandomMen[] =
{
    60,
    7,
    48,
    59,
	299
};

new RandomWoman[] =
{
    298,
    12,
    55,
    93,
	148
};

new unwashable[89][0] = {
{403},{406},{408},{414},{417},
{423},{424},{425},{430},{431},
{432},{433},{435},{437},{441},
{443},{444},{446},{447},{448},
{452},{453},{454},{455},{456},
{457},{460},{461},{462},{463},
{464},{465},{468},{469},{471},
{472},{473},{476},{481},{484},
{485},{486},{487},{488},{493},
{497},{498},{501},{508},{509},
{510},{511},{512},{513},{514},
{515},{519},{520},{521},{522},
{523},{524},{530},{531},{532},
{539},{544},{548},{553},{556},
{557},{563},{564},{568},{571},
{572},{573},{574},{577},{578},
{581},{583},{586},{588},{592},
{593},{594},{595},{609}
};

new RandMusic[][] =
{
	"https://dl.dropboxusercontent.com/s/6qshzzdvbrqrxyo/blackandyellow.mp3",
	"https://dl.dropboxusercontent.com/s/95zai6kygp58bw0/survival.mp3",
	"https://dl.dropboxusercontent.com/s/0r4rz08onquoqyf/song3.mp3",
	"https://dl.dropboxusercontent.com/s/hlgkora62wpwhhv/hood.mp3"
};

new MyTimers[MAX_PLAYERS][50];

new Float:CameraPositions[][] =
{
    {1408.857299, -1632.013916, 135.030731, 1430.333129, -1623.923461, 137.190429, 1410.314453, -1627.295898, 135.816528, 1431.559448, -1619.127685, 137.895111},
    {1423.960693, -790.761047, 97.296607, 1422.713745, -802.571594, 93.713417, 1423.505004, -795.559020, 95.965515, 1422.459472, -807.558715, 93.459938},
    {1468.1969, -1714.5869, 21.8133, 1465.1074, -1716.8134, 21.8133, 1468.7809, -1715.3973, 21.9533, 1465.6914, -1717.6238, 21.9533},
    {1691.775024, -1760.483520, 51.646430, 1685.613769, -1750.009033, 49.212718, 1689.289428, -1756.257690, 50.664569, 1683.128173, -1745.783203, 48.230857},
    {1239.9844, -1312.6952, 61.7067, 1236.2928, -1306.7589, 61.7067, 1239.1367, -1313.2223, 61.2017, 1235.4452, -1307.2860, 61.2017},
    {1694.733764, -2286.287353, 48.846031, 1696.801757, -2286.243408, 72.494438, 1689.767822, -2286.203613, 48.269191, 1691.805175, -2286.213867, 72.678306},
    {1141.516235, -2006.309936, 89.270088, 1150.323608, -1998.296875, 92.549591, 1137.950683, -2009.554077, 87.942459, 1146.758056, -2001.541015, 91.221961},
    {1163.4066, -1651.3649, 61.6941, 1164.8997, -1657.4850, 60.0530, 1163.6432, -1652.3344, 61.4342, 1165.1362, -1658.4545, 59.7930},
    {1501.1635, -1735.7188, 52.0382, 1500.5176, -1731.0140, 51.2951, 1501.9237, -1735.0713, 51.7482, 1501.2778, -1730.3666, 51.0051},
    {1818.463012, -1669.808837, 22.066495, 1820.971435, -1673.945068, 21.014766, 1820.996582, -1673.986450, 21.004339, 1823.505004, -1678.122680, 19.952610},
    {1605.174072, -2106.205566, 58.206455, 1605.174072, -2106.205566, 58.206455, 1609.583740, -2104.772460, 56.335178, 1609.632568, -2104.453857, 56.773700}
};

new Float:Exteriors[][] =
{
	{0.0, 0.0, 0.0, 0.0},
	{542.3840,-1293.5125,17.2422,350.0}, //Grotti 1
	{1462.3038,-1010.2267,26.8462,180.0}, //Banco 2
	{648.8630,-1360.6012,13.5863,70.0}, //CNN 3
	{1654.2700,-1654.8944,22.5156,180.0}, //VIP 4
	{1203.6499, 8.7910, 1001.6718, 0.0}, //BITCH 5
	{1833.149780, -1842.485717, 13.578125, 0.0}, //24/7 Unity 6
	{1836.4471,-1682.3042,13.3476,90.0}, //Alhambra 7
	{1315.4854,-897.6839,39.5781,180.0}, //24/7 Vinewood 8
	{1352.3815,-1759.2286,13.5078,0.0}, //24/7 Ayuntamiento 9
	{2244.3567,-1665.5562,15.4766,360.0}, //Binco Grove 10
	{1456.4344,-1137.6427,23.9484,220.0}, //ZIP 11
	{499.5753,-1360.6145,16.3664,360.0}, //ProLaps 12
	{2112.7739,-1211.6287,23.9631,180.0}, //SubUrban 13
	{597.2778,-1249.4883,18.3021,30.0}, //Victim 14
	{810.6630,-1616.1554,13.5469,270.0}, //BurgerShot 15
	{2105.4858,-1806.5336,13.5547,90.0}, //PizzaStacked 16
	{2070.6365,-1793.7847,13.5469,260.0}, //Peluquería 1 17
	{2068.5840,-1779.7758,13.5596, 280.0}, //Tatto 18
	{823.9835,-1588.2754,13.5545, 140.0}, //Peluquería 2 19
	{928.7275,-1352.9547,13.3438, 90.0}, //Cluckin Bells 20
	{2421.3159,-1219.6179,25.5382, 180.0}, //PigPen 21
	{2310.0977,-1643.5522,14.8270, 150.0}, //Bar grove 22
	{2229.8601,-1721.4545,13.5633, 125.0}, //GymLS 23
	{1555.142822, -1675.475341, 16.195312, 90.0}, //LSPD
	{1481.037597, -1771.786376, 18.795755, 0.0} //Ayuntamiento
};

new Float:Cajeros[][] =
{
	{1410.21143, -1228.69971, 13.16360},
	{1224.61646, -1428.50427, 13.07948},
	{1222.61646, -1428.50427, 13.07950},
	{1220.61646, -1428.50427, 13.07950},
	{1218.61646, -1428.50427, 13.07950},
	{1161.02258, -1497.45313, 15.41748},
	{1498.90039, -1847.78955, 13.16123},
	{1380.03198, -1642.76318, 13.17232},
	{538.80273, -1740.98254, 11.93303},
	{1007.77338, -1295.86072, 13.14124},
	{1312.18127, -897.83740, 39.17719},
	{1734.48511, -1907.68274, 13.18131},
	{1763.64221, -2204.38379, 13.15179},
	{1585.76953, -2286.25854, 13.12480},
	{1831.72632, -1308.21704, 13.11254},
	{2043.84473, -1414.96716, 16.76000},
	{1452.96997, -1008.29999, 26.48000},
	{1452.96997, -1005.71002, 26.48000},
	{818.16, -1360.63, 1992.27},
	{819.09, -1360.63, 1992.27},
	{820.03, -1360.63, 1992.27},
	{821.08, -1360.63, 1992.27}
};
// ----------> Callbacks

main() {}

public OnGameModeInit()
{
    Database = db_open("ServerDatabase.db");
    db_query(Database, "CREATE TABLE IF NOT EXISTS `USERS` (`NAME`, `PASSWORD`, `IP`, `POSX`, `POSY`, `POSZ`, `ANGLE`, `INTERIORID`, `BR`, `EMAIL`, `DINERO`, `DINEROBANK`, `SEXO`, `EDAD`, `SKIN`, `VIDA`, `CHALECO`, `ADMLVL`, `PHONENUMBER`, `INTERIOR`, `BANKA`, `VBANK`, `VGROTTI`, `V247`, `VROPA`, `VFOOD`, `DUDE`, `WORK`, `LVL`, `VEH0`, `VEH1`, `VEH2`, `VEH3`, `VKEY0`, `VKEY1`, `VKEY2`, `VKEY3`)");
    db_query(Database, "CREATE TABLE IF NOT EXISTS `VEHS` (`VKEY`, `VD`, `VPOSX`, `VPOSY`, `VPOSZ`, `VANGLE`, `VMODELID`, `VCOLOR1`, `VCOLOR2`, `VPAINTJOB`, `VM1`, `VM2`, `VM3`, `VM4`, `VM5`, `VM6`, `VM7`, `VM8`, `VM9`, `VM10`, `VM11`, `VM12`, `VM13`, `VM14`, `VM15`, `VM16`, `VM17`)");
	SetGameModeText("eXtreme Roleplay español");
    ShowPlayerMarkers(0);
   	ShowNameTags(0);
    DisableInteriorEnterExits();
    EnableStuntBonusForAll(0);
	ManualVehicleEngineAndLights();
	UsePlayerPedAnims();
	AllowInteriorWeapons(1);
    SetTimer("UpdateServerTime", 15000, true);
    ConnectNPC("NPC_001", "atraco1_1");
    ConnectNPC("NPC_002", "bitch");
    ConnectNPC("NPC_003", "247ayunta");
    ConnectNPC("NPC_004", "247vinewood");
    ConnectNPC("NPC_005", "banco1");
    ConnectNPC("NPC_006", "banco2");
    ConnectNPC("NPC_007", "banco3");
    ConnectNPC("NPC_008", "bargrove");
    ConnectNPC("NPC_009", "binco1");
    ConnectNPC("NPC_010", "burgershot");
    ConnectNPC("NPC_011", "chuckinbells");
    ConnectNPC("NPC_012", "dancer2");
    ConnectNPC("NPC_013", "dancer3");
    ConnectNPC("NPC_014", "peluqueria");
    ConnectNPC("NPC_015", "pizzastack");
    ConnectNPC("NPC_016", "prolaps");
    ConnectNPC("NPC_017", "suburban");
    ConnectNPC("NPC_018", "victim");
    ConnectNPC("NPC_019", "zip");
    ConnectNPC("NPC_020", "ayunta");
	ConnectNPC("NPC_021", "lspd1");
	ConnectNPC("NPC_022", "lspd2");
	ConnectNPC("NPC_023", "lspd3");
	ConnectNPC("NPC_024", "grotti1");
	ConnectNPC("NPC_025", "grotti2");
	ConnectNPC("NPC_026", "guarda1");
	ConnectNPC("NPC_027", "guarda2");
	ConnectNPC("NPC_028", "guarda3");
	ConnectNPC("NPC_029", "lineaA");
	ConnectNPC("NPC_030", "dj");
	ConnectNPC("NPC_031", "bar1");
	
	AlhambraMenu = CreateMenu("Bar", 2, 10.0, 160.0, 50.0, 0.0);
	AddMenuItem(AlhambraMenu, 0, "Sprunk");
	AddMenuItem(AlhambraMenu, 0, "Cerveza");
	AddMenuItem(AlhambraMenu, 0, "Vodka");
	AddMenuItem(AlhambraMenu, 0, "Whisky");
	//VehiclesTD
	TD_GrottiCatalogo[0] = TextDrawCreate(610.608764, 340.416931, "usebox");
	TextDrawLetterSize(TD_GrottiCatalogo[0], 0.000000, 7.921101);
	TextDrawTextSize(TD_GrottiCatalogo[0], 496.975219, 0.000000);
	TextDrawAlignment(TD_GrottiCatalogo[0], 1);
	TextDrawColor(TD_GrottiCatalogo[0], 0);
	TextDrawUseBox(TD_GrottiCatalogo[0], true);
	TextDrawBoxColor(TD_GrottiCatalogo[0], 102);
	TextDrawSetShadow(TD_GrottiCatalogo[0], 0);
	TextDrawSetOutline(TD_GrottiCatalogo[0], 0);
	TextDrawFont(TD_GrottiCatalogo[0], 0);

	TD_GrottiCatalogo[1] = TextDrawCreate(504.254547, 349.934082, simbolos("Vel.Máxima~n~~n~Aceleración"));
	TextDrawLetterSize(TD_GrottiCatalogo[1], 0.298667, 1.232499);
	TextDrawAlignment(TD_GrottiCatalogo[1], 1);
	TextDrawColor(TD_GrottiCatalogo[1], -1);
	TextDrawSetShadow(TD_GrottiCatalogo[1], 0);
	TextDrawSetOutline(TD_GrottiCatalogo[1], 0);
	TextDrawBackgroundColor(TD_GrottiCatalogo[1], 51);
	TextDrawFont(TD_GrottiCatalogo[1], 1);
	TextDrawSetProportional(TD_GrottiCatalogo[1], 1);

	TD_GrottiCatalogo[2] = TextDrawCreate(603.112792, 364.916656, "maximocaja");
	TextDrawLetterSize(TD_GrottiCatalogo[2], 0.000000, 0.349445);
	TextDrawTextSize(TD_GrottiCatalogo[2], 502.597320, 0.000000);
	TextDrawAlignment(TD_GrottiCatalogo[2], 1);
	TextDrawColor(TD_GrottiCatalogo[2], 0);
	TextDrawUseBox(TD_GrottiCatalogo[2], true);
	TextDrawBoxColor(TD_GrottiCatalogo[2], 255);
	TextDrawSetShadow(TD_GrottiCatalogo[2], 0);
	TextDrawSetOutline(TD_GrottiCatalogo[2], 0);
	TextDrawFont(TD_GrottiCatalogo[2], 0);

	TD_GrottiCatalogo[3] = TextDrawCreate(601.770141, 367.083343, "maximobarraatras");
	TextDrawLetterSize(TD_GrottiCatalogo[3], 0.000000, -0.165925);
	TextDrawTextSize(TD_GrottiCatalogo[3], 504.002929, 0.000000);
	TextDrawAlignment(TD_GrottiCatalogo[3], 1);
	TextDrawColor(TD_GrottiCatalogo[3], 0);
	TextDrawUseBox(TD_GrottiCatalogo[3], true);
	TextDrawBoxColor(TD_GrottiCatalogo[3], -1061109505);
	TextDrawSetShadow(TD_GrottiCatalogo[3], 0);
	TextDrawSetOutline(TD_GrottiCatalogo[3], 0);
	TextDrawFont(TD_GrottiCatalogo[3], 0);

	TD_GrottiCatalogo[4] = TextDrawCreate(604.112915, 386.916839, "acelecaja");
	TextDrawLetterSize(TD_GrottiCatalogo[4], 0.000000, 0.349445);
	TextDrawTextSize(TD_GrottiCatalogo[4], 502.597259, 0.000000);
	TextDrawAlignment(TD_GrottiCatalogo[4], 1);
	TextDrawColor(TD_GrottiCatalogo[4], 0);
	TextDrawUseBox(TD_GrottiCatalogo[4], true);
	TextDrawBoxColor(TD_GrottiCatalogo[4], 255);
	TextDrawSetShadow(TD_GrottiCatalogo[4], 0);
	TextDrawSetOutline(TD_GrottiCatalogo[4], 0);
	TextDrawFont(TD_GrottiCatalogo[4], 0);

	TD_GrottiCatalogo[5] = TextDrawCreate(601.770141, 389.666687, "acelebarraatras");
	TextDrawLetterSize(TD_GrottiCatalogo[5], 0.000000, -0.165925);
	TextDrawTextSize(TD_GrottiCatalogo[5], 504.002929, 0.000000);
	TextDrawAlignment(TD_GrottiCatalogo[5], 1);
	TextDrawColor(TD_GrottiCatalogo[5], 0);
	TextDrawUseBox(TD_GrottiCatalogo[5], true);
	TextDrawBoxColor(TD_GrottiCatalogo[5], -1061109505);
	TextDrawSetShadow(TD_GrottiCatalogo[5], 0);
	TextDrawSetOutline(TD_GrottiCatalogo[5], 0);
	TextDrawFont(TD_GrottiCatalogo[5], 0);

	TD_GrottiCatalogo[6] = TextDrawCreate(315.657257, 399.583374, "COMPRAR");
	TextDrawLetterSize(TD_GrottiCatalogo[6], 0.449999, 1.600000);
	TextDrawAlignment(TD_GrottiCatalogo[6], 2);
	TextDrawColor(TD_GrottiCatalogo[6], -5963521);
	TextDrawSetShadow(TD_GrottiCatalogo[6], 0);
	TextDrawSetOutline(TD_GrottiCatalogo[6], 1);
	TextDrawBackgroundColor(TD_GrottiCatalogo[6], 255);
	TextDrawFont(TD_GrottiCatalogo[6], 3);
	TextDrawSetProportional(TD_GrottiCatalogo[6], 1);
	TextDrawTextSize(TD_GrottiCatalogo[6], 20.0, 70.0);
	TextDrawSetSelectable(TD_GrottiCatalogo[6], true);

	TD_GrottiCatalogo[7] = TextDrawCreate(354.670501, 396.466552, "~>~");
	TextDrawLetterSize(TD_GrottiCatalogo[7], 0.465929, 2.049168);
	TextDrawAlignment(TD_GrottiCatalogo[7], 2);
	TextDrawColor(TD_GrottiCatalogo[7], -1);
	TextDrawSetShadow(TD_GrottiCatalogo[7], 0);
	TextDrawSetOutline(TD_GrottiCatalogo[7], 1);
	TextDrawBackgroundColor(TD_GrottiCatalogo[7], 51);
	TextDrawFont(TD_GrottiCatalogo[7], 1);
	TextDrawSetProportional(TD_GrottiCatalogo[7], 1);
    TextDrawTextSize(TD_GrottiCatalogo[7], 40.0, 40.0);
	TextDrawSetSelectable(TD_GrottiCatalogo[7], true);

	TD_GrottiCatalogo[8] = TextDrawCreate(262.333953, 396.466552, "~<~");
	TextDrawLetterSize(TD_GrottiCatalogo[8], 0.465929, 2.049168);
	TextDrawAlignment(TD_GrottiCatalogo[8], 2);
	TextDrawColor(TD_GrottiCatalogo[8], -1);
	TextDrawSetShadow(TD_GrottiCatalogo[8], 0);
	TextDrawSetOutline(TD_GrottiCatalogo[8], 1);
	TextDrawBackgroundColor(TD_GrottiCatalogo[8], 51);
	TextDrawFont(TD_GrottiCatalogo[8], 1);
	TextDrawSetProportional(TD_GrottiCatalogo[8], 1);
	TextDrawTextSize(TD_GrottiCatalogo[8], 40.0, 40.0);
	TextDrawSetSelectable(TD_GrottiCatalogo[8], true);

	WelcomeTD[0] = TextDrawCreate(1153.555419, -37.326667, "usebox");
	TextDrawLetterSize(WelcomeTD[0], 0.000000, 82.072463);
	TextDrawTextSize(WelcomeTD[0], -55.333335, 0.000000);
	TextDrawAlignment(WelcomeTD[0], 1);
	TextDrawColor(WelcomeTD[0], 0);
	TextDrawUseBox(WelcomeTD[0], true);
	TextDrawBoxColor(WelcomeTD[0], 255);
	TextDrawSetShadow(WelcomeTD[0], 0);
	TextDrawSetOutline(WelcomeTD[0], 0);
	TextDrawFont(WelcomeTD[0], 0);
	
	WelcomeTD[1] = TextDrawCreate(108.000000, 102.044509, "bienvenido");
	TextDrawLetterSize(WelcomeTD[1], 0.792666, 4.721067);
	TextDrawAlignment(WelcomeTD[1], 1);
	TextDrawColor(WelcomeTD[1], -1);
	TextDrawSetShadow(WelcomeTD[1], 0);
	TextDrawSetOutline(WelcomeTD[1], 1);
	TextDrawBackgroundColor(WelcomeTD[1], 51);
	TextDrawFont(WelcomeTD[1], 2);
	TextDrawSetProportional(WelcomeTD[1], 1);

	WelcomeTD[2] = TextDrawCreate(109.444427, 138.884536, "Cargando...");
	TextDrawLetterSize(WelcomeTD[2], 0.242889, 1.346132);
	TextDrawAlignment(WelcomeTD[2], 1);
	TextDrawColor(WelcomeTD[2], -1);
	TextDrawSetShadow(WelcomeTD[2], 0);
	TextDrawSetOutline(WelcomeTD[2], 1);
	TextDrawBackgroundColor(WelcomeTD[2], 51);
	TextDrawFont(WelcomeTD[2], 2);
	TextDrawSetProportional(WelcomeTD[2], 1);

	WelcomeTD[3] = TextDrawCreate(222.222274, 416.142211, "eXtreme RolePlay 1.01");
	TextDrawLetterSize(WelcomeTD[3], 0.449999, 1.600000);
	TextDrawAlignment(WelcomeTD[3], 1);
	TextDrawColor(WelcomeTD[3], -2621185);
	TextDrawSetShadow(WelcomeTD[3], 0);
	TextDrawSetOutline(WelcomeTD[3], 1);
	TextDrawBackgroundColor(WelcomeTD[3], 51);
	TextDrawFont(WelcomeTD[3], 3);
	TextDrawSetProportional(WelcomeTD[3], 1);
	
	TD_Phone[0] = TextDrawCreate(507.409515, 183.166580, "ld_poke:cd1d");
	TextDrawLetterSize(TD_Phone[0], 0.000000, 0.000000);
	TextDrawTextSize(TD_Phone[0], 93.235671, 242.666717);
	TextDrawAlignment(TD_Phone[0], 1);
	TextDrawColor(TD_Phone[0], -2139062017);
	TextDrawSetShadow(TD_Phone[0], 0);
	TextDrawSetOutline(TD_Phone[0], 0);
	TextDrawFont(TD_Phone[0], 4);

	TD_Phone[1] = TextDrawCreate(508.409515, 184.366592, "ld_poke:cd1d");
	TextDrawLetterSize(TD_Phone[1], 0.000000, 0.000000);
	TextDrawTextSize(TD_Phone[1], 91.361587, 239.166748);
	TextDrawAlignment(TD_Phone[1], 1);
	TextDrawColor(TD_Phone[1], 255);
	TextDrawSetShadow(TD_Phone[1], 0);
	TextDrawSetOutline(TD_Phone[1], 0);
	TextDrawFont(TD_Phone[1], 4);

	TD_Phone[2] = TextDrawCreate(553.323669, 195.416656, "ld_pool:ball");
	TextDrawLetterSize(TD_Phone[2], 0.000000, 0.000000);
	TextDrawTextSize(TD_Phone[2], 3.279647, 3.500000);
	TextDrawAlignment(TD_Phone[2], 1);
	TextDrawColor(TD_Phone[2], -2139062202);
	TextDrawSetShadow(TD_Phone[2], 0);
	TextDrawSetOutline(TD_Phone[2], 0);
	TextDrawFont(TD_Phone[2], 4);

	TD_Phone[3] = TextDrawCreate(548.638427, 203.000015, "LD_SPAC:white");
	TextDrawLetterSize(TD_Phone[3], 0.000000, 0.000000);
	TextDrawTextSize(TD_Phone[3], 13.118604, 1.749999);
	TextDrawAlignment(TD_Phone[3], 1);
	TextDrawColor(TD_Phone[3], -2139062202);
	TextDrawSetShadow(TD_Phone[3], 0);
	TextDrawSetOutline(TD_Phone[3], 0);
	TextDrawFont(TD_Phone[3], 4);

	TD_Phone[4] = TextDrawCreate(546.764160, 398.416656, "ld_pool:ball");
	TextDrawLetterSize(TD_Phone[4], 0.000000, 0.000000);
	TextDrawTextSize(TD_Phone[4], 16.398239, 19.249977);
	TextDrawAlignment(TD_Phone[4], 1);
	TextDrawColor(TD_Phone[4], -2139062202);
	TextDrawSetShadow(TD_Phone[4], 0);
	TextDrawSetOutline(TD_Phone[4], 0);
	TextDrawFont(TD_Phone[4], 4);

	TD_Phone[5] = TextDrawCreate(512.562194, 215.250015, "ld_otb:blue");
	TextDrawLetterSize(TD_Phone[5], 0.000000, 0.000000);
	TextDrawTextSize(TD_Phone[5], 82.928268, 177.916564);
	TextDrawAlignment(TD_Phone[5], 1);
	TextDrawColor(TD_Phone[5], -1);
	TextDrawSetShadow(TD_Phone[5], 0);
	TextDrawSetOutline(TD_Phone[5], 0);
	TextDrawFont(TD_Phone[5], 4);

	TD_Phone[6] = TextDrawCreate(512.562194, 215.250030, "ld_plan:tvbase");
	TextDrawLetterSize(TD_Phone[6], 0.000000, 0.000000);
	TextDrawTextSize(TD_Phone[6], 82.928253, 31.499998);
	TextDrawAlignment(TD_Phone[6], 1);
	TextDrawColor(TD_Phone[6], -1);
	TextDrawSetShadow(TD_Phone[6], 0);
	TextDrawSetOutline(TD_Phone[6], 0);
	TextDrawFont(TD_Phone[6], 4);

	TD_Phone[7] = TextDrawCreate(512.156738, 362.083343, "ld_plan:tvbase");
	TextDrawLetterSize(TD_Phone[7], 0.000000, 0.000000);
	TextDrawTextSize(TD_Phone[7], 82.928253, 31.499998);
	TextDrawAlignment(TD_Phone[7], 1);
	TextDrawColor(TD_Phone[7], -1);
	TextDrawSetShadow(TD_Phone[7], 0);
	TextDrawSetOutline(TD_Phone[7], 0);
	TextDrawFont(TD_Phone[7], 4);

	TD_Phone[8] = TextDrawCreate(575.812683, 372.749969, "(Y)");
	TextDrawLetterSize(TD_Phone[8], 0.305695, 1.191666);
	TextDrawTextSize(TD_Phone[8], -17.803804, 25.083328);
	TextDrawAlignment(TD_Phone[8], 2);
	TextDrawColor(TD_Phone[8], -1);
	TextDrawUseBox(TD_Phone[8], true);
	TextDrawBoxColor(TD_Phone[8], 16711844);
	TextDrawSetShadow(TD_Phone[8], 0);
	TextDrawSetOutline(TD_Phone[8], 0);
	TextDrawBackgroundColor(TD_Phone[8], 51);
	TextDrawFont(TD_Phone[8], 1);
	TextDrawSetProportional(TD_Phone[8], 1);

	TD_Phone[9] = TextDrawCreate(531.835021, 371.999938, "(N)");
	TextDrawLetterSize(TD_Phone[9], 0.305695, 1.191666);
	TextDrawTextSize(TD_Phone[9], -17.803804, 25.083328);
	TextDrawAlignment(TD_Phone[9], 2);
	TextDrawColor(TD_Phone[9], -1);
	TextDrawUseBox(TD_Phone[9], true);
	TextDrawBoxColor(TD_Phone[9], -16777036);
	TextDrawSetShadow(TD_Phone[9], 0);
	TextDrawSetOutline(TD_Phone[9], 0);
	TextDrawBackgroundColor(TD_Phone[9], 51);
	TextDrawFont(TD_Phone[9], 1);
	TextDrawSetProportional(TD_Phone[9], 1);
	
	TD_ST[0] = TextDrawCreate(1359.333496, -57.735557, "usebox");
	TextDrawLetterSize(TD_ST[0], 0.000000, 87.983581);
	TextDrawTextSize(TD_ST[0], -97.111129, 0.000000);
	TextDrawAlignment(TD_ST[0], 1);
	TextDrawColor(TD_ST[0], 0);
	TextDrawUseBox(TD_ST[0], true);
	TextDrawBoxColor(TD_ST[0], 102);
	TextDrawSetShadow(TD_ST[0], 0);
	TextDrawSetOutline(TD_ST[0], 0);
	TextDrawFont(TD_ST[0], 0);

	TD_ST[1] = TextDrawCreate(637.666442, 5.486647, "usebox");
	TextDrawLetterSize(TD_ST[1], 0.000000, 48.472476);
	TextDrawTextSize(TD_ST[1], 0.666631, 0.000000);
	TextDrawAlignment(TD_ST[1], 1);
	TextDrawColor(TD_ST[1], 0);
	TextDrawUseBox(TD_ST[1], true);
	TextDrawBoxColor(TD_ST[1], 102);
	TextDrawSetShadow(TD_ST[1], 0);
	TextDrawSetOutline(TD_ST[1], 0);
	TextDrawFont(TD_ST[1], 0);

	TD_ST[2] = TextDrawCreate(216.444549, 41.315570, "e__treme~n~__roleplay");
	TextDrawLetterSize(TD_ST[2], 0.882889, 3.033599);
	TextDrawAlignment(TD_ST[2], 1);
	TextDrawColor(TD_ST[2], -1);
	TextDrawSetShadow(TD_ST[2], 0);
	TextDrawSetOutline(TD_ST[2], 8);
	TextDrawBackgroundColor(TD_ST[2], 51);
	TextDrawFont(TD_ST[2], 3);
	TextDrawSetProportional(TD_ST[2], 1);

	TD_ST[3] = TextDrawCreate(243.000137, 16.265243, "X");
	TextDrawLetterSize(TD_ST[3], 1.772222, 6.124797);
	TextDrawAlignment(TD_ST[3], 1);
	TextDrawColor(TD_ST[3], -1);
	TextDrawSetShadow(TD_ST[3], 0);
	TextDrawSetOutline(TD_ST[3], 8);
	TextDrawBackgroundColor(TD_ST[3], 51);
	TextDrawFont(TD_ST[3], 3);
	TextDrawSetProportional(TD_ST[3], 1);

	TD_ST[4] = TextDrawCreate(448.666717, 171.740020, "usebox");
	TextDrawLetterSize(TD_ST[4], 0.000000, 11.741603);
	TextDrawTextSize(TD_ST[4], 191.777908, 0.000000);
	TextDrawAlignment(TD_ST[4], 1);
	TextDrawColor(TD_ST[4], 0);
	TextDrawUseBox(TD_ST[4], true);
	TextDrawBoxColor(TD_ST[4], 102);
	TextDrawSetShadow(TD_ST[4], 0);
	TextDrawSetOutline(TD_ST[4], 0);
	TextDrawFont(TD_ST[4], 0);

	TD_ST[5] = TextDrawCreate(197.333511, 184.675552, "~<~");
	TextDrawLetterSize(TD_ST[5], 0.039778, 2.077867);
	TextDrawAlignment(TD_ST[5], 2);
	TextDrawColor(TD_ST[5], -1);
	TextDrawSetShadow(TD_ST[5], 0);
	TextDrawSetOutline(TD_ST[5], 1);
	TextDrawBackgroundColor(TD_ST[5], 51);
	TextDrawFont(TD_ST[5], 1);
	TextDrawSetProportional(TD_ST[5], 1);
	TextDrawTextSize(TD_ST[5], 50, 50);
	TextDrawSetSelectable(TD_ST[5], true);

	TD_ST[6] = TextDrawCreate(197.333511, 240.435302, "~<~");
	TextDrawLetterSize(TD_ST[6], 0.039778, 2.077867);
	TextDrawAlignment(TD_ST[6], 2);
	TextDrawColor(TD_ST[6], -1);
	TextDrawSetShadow(TD_ST[6], 0);
	TextDrawSetOutline(TD_ST[6], 1);
	TextDrawBackgroundColor(TD_ST[6], 51);
	TextDrawFont(TD_ST[6], 1);
	TextDrawSetProportional(TD_ST[6], 1);
	TextDrawTextSize(TD_ST[6], 50, 50);
	TextDrawSetSelectable(TD_ST[6], true);

	TD_ST[7] = TextDrawCreate(425.555999, 240.435302, "~>~");
	TextDrawLetterSize(TD_ST[7], 0.039778, 2.077867);
	TextDrawAlignment(TD_ST[7], 2);
	TextDrawColor(TD_ST[7], -1);
	TextDrawSetShadow(TD_ST[7], 0);
	TextDrawSetOutline(TD_ST[7], 1);
	TextDrawBackgroundColor(TD_ST[7], 51);
	TextDrawFont(TD_ST[7], 1);
	TextDrawSetProportional(TD_ST[7], 1);
	TextDrawTextSize(TD_ST[7], 50, 50);
	TextDrawSetSelectable(TD_ST[7], true);

	TD_ST[8] = TextDrawCreate(425.555999, 184.675552, "~>~");
	TextDrawLetterSize(TD_ST[8], 0.039778, 2.077867);
	TextDrawAlignment(TD_ST[8], 2);
	TextDrawColor(TD_ST[8], -1);
	TextDrawSetShadow(TD_ST[8], 0);
	TextDrawSetOutline(TD_ST[8], 1);
	TextDrawBackgroundColor(TD_ST[8], 51);
	TextDrawFont(TD_ST[8], 1);
	TextDrawSetProportional(TD_ST[8], 1);
	TextDrawTextSize(TD_ST[8], 50, 50);
	TextDrawSetSelectable(TD_ST[8], true);

	TD_ST[9] = TextDrawCreate(319.111389, 372.835571, "continuar");
	TextDrawLetterSize(TD_ST[9], 0.564222, 2.067912);
	TextDrawTextSize(TD_ST[9], 21.333337, 125.440010);
	TextDrawAlignment(TD_ST[9], 2);
	TextDrawColor(TD_ST[9], -1);
	TextDrawUseBox(TD_ST[9], true);
	TextDrawBoxColor(TD_ST[9], -1061109760);
	TextDrawSetShadow(TD_ST[9], 0);
	TextDrawSetOutline(TD_ST[9], 1);
	TextDrawBackgroundColor(TD_ST[9], 51);
	TextDrawFont(TD_ST[9], 3);
	TextDrawSetProportional(TD_ST[9], 1);
	TextDrawSetSelectable(TD_ST[9], true);
	
	TD_PLAYERDATA[0] = TextDrawCreate(316.889038, 319.075714, simbolos("¿Son correctos?"));
	TextDrawLetterSize(TD_PLAYERDATA[0], 0.449999, 1.600000);
	TextDrawAlignment(TD_PLAYERDATA[0], 2);
	TextDrawColor(TD_PLAYERDATA[0], -1);
	TextDrawSetShadow(TD_PLAYERDATA[0], 0);
	TextDrawSetOutline(TD_PLAYERDATA[0], 1);
	TextDrawBackgroundColor(TD_PLAYERDATA[0], 51);
	TextDrawFont(TD_PLAYERDATA[0], 1);
	TextDrawSetProportional(TD_PLAYERDATA[0], 1);

	TD_PLAYERDATA[1] = TextDrawCreate(319.111480, 153.813400, "tus datos");
	TextDrawLetterSize(TD_PLAYERDATA[1], 0.449999, 1.600000);
	TextDrawTextSize(TD_PLAYERDATA[1], 48.888877, 252.373260);
	TextDrawAlignment(TD_PLAYERDATA[1], 2);
	TextDrawColor(TD_PLAYERDATA[1], -1507073);
	TextDrawUseBox(TD_PLAYERDATA[1], true);
	TextDrawBoxColor(TD_PLAYERDATA[1], 1162697215);
	TextDrawSetShadow(TD_PLAYERDATA[1], 0);
	TextDrawSetOutline(TD_PLAYERDATA[1], 0);
	TextDrawBackgroundColor(TD_PLAYERDATA[1], 51);
	TextDrawFont(TD_PLAYERDATA[1], 3);
	TextDrawSetProportional(TD_PLAYERDATA[1], 1);

	TD_PLAYERDATA[2] = TextDrawCreate(388.111968, 367.862304, "no");
	TextDrawLetterSize(TD_PLAYERDATA[2], 0.564221, 2.067912);
	TextDrawTextSize(TD_PLAYERDATA[2], 51.111133, 23.893312);
	TextDrawAlignment(TD_PLAYERDATA[2], 2);
	TextDrawColor(TD_PLAYERDATA[2], -1);
	TextDrawUseBox(TD_PLAYERDATA[2], true);
	TextDrawBoxColor(TD_PLAYERDATA[2], 1);
	TextDrawSetShadow(TD_PLAYERDATA[2], 0);
	TextDrawSetOutline(TD_PLAYERDATA[2], 1);
	TextDrawBackgroundColor(TD_PLAYERDATA[2], 51);
	TextDrawFont(TD_PLAYERDATA[2], 3);
	TextDrawSetProportional(TD_PLAYERDATA[2], 1);
	TextDrawSetSelectable(TD_PLAYERDATA[2], true);

	TD_PLAYERDATA[3] = TextDrawCreate(255.555541, 367.857849, simbolos("sí"));
	TextDrawLetterSize(TD_PLAYERDATA[3], 0.564221, 2.067912);
	TextDrawTextSize(TD_PLAYERDATA[3], 51.111133, 23.893312);
	TextDrawAlignment(TD_PLAYERDATA[3], 2);
	TextDrawColor(TD_PLAYERDATA[3], -1);
	TextDrawUseBox(TD_PLAYERDATA[3], true);
	TextDrawBoxColor(TD_PLAYERDATA[3], 16711680);
	TextDrawSetShadow(TD_PLAYERDATA[3], 0);
	TextDrawSetOutline(TD_PLAYERDATA[3], 1);
	TextDrawBackgroundColor(TD_PLAYERDATA[3], 51);
	TextDrawFont(TD_PLAYERDATA[3], 3);
	TextDrawSetProportional(TD_PLAYERDATA[3], 1);
	TextDrawSetSelectable(TD_PLAYERDATA[3], true);

	TD_PLAYERDATA[4] = TextDrawCreate(449.111145, 172.237686, "usebox");
	TextDrawLetterSize(TD_PLAYERDATA[4], 0.000000, 11.902604);
	TextDrawTextSize(TD_PLAYERDATA[4], 189.555603, 0.000000);
	TextDrawAlignment(TD_PLAYERDATA[4], 1);
	TextDrawColor(TD_PLAYERDATA[4], 0);
	TextDrawUseBox(TD_PLAYERDATA[4], true);
	TextDrawBoxColor(TD_PLAYERDATA[4], 102);
	TextDrawSetShadow(TD_PLAYERDATA[4], 0);
	TextDrawSetOutline(TD_PLAYERDATA[4], 0);
	TextDrawFont(TD_PLAYERDATA[4], 0);

	TD_PLAYERDATA[5] = TextDrawCreate(204.000045, 187.662200, "Nombre~n~~n~Edad~n~~n~Genero");
	TextDrawLetterSize(TD_PLAYERDATA[5], 0.449999, 1.600000);
	TextDrawAlignment(TD_PLAYERDATA[5], 1);
	TextDrawColor(TD_PLAYERDATA[5], -1);
	TextDrawSetShadow(TD_PLAYERDATA[5], 0);
	TextDrawSetOutline(TD_PLAYERDATA[5], 1);
	TextDrawBackgroundColor(TD_PLAYERDATA[5], 51);
	TextDrawFont(TD_PLAYERDATA[5], 1);
	TextDrawSetProportional(TD_PLAYERDATA[5], 1);
	//Areas
	Area_CarWash = CreateDynamicRectangle(1909.005737, -1781.180664, 1913.502319, -1784.899291, 0);
	//

	LSPD_Doors[0] = CreateDynamicObject(3055, 1588.5118, -1637.83386, 14.59201,   0.00000, 0.00000, 0.00000);
    LSPD_Doors[1] = CreateDynamicObject(1495, 1582.61719, -1637.90515, 12.32990,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19435, 1583.34888, -1637.91528, 16.58720,   0.00000, 0.00000, 90.00000);
	//Ayunt bot no bug
	AyuntNoBug = CreateDynamicObject(8356, 360.0919, 176.36160, 918.97968,   90.00000, 90.00000, 180.00000);
	SetDynamicObjectMaterial(AyuntNoBug, 0, 0, "none", "none");
	SetDynamicObjectMaterial(AyuntNoBug, 1, 0, "none", "none");
	SetDynamicObjectMaterial(AyuntNoBug, 2, 0, "none", "none");
	
	//Pizzería LS decoración
	CreateDynamicObject(869, 2101.31055, -1764.80432, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2097.70898, -1826.98950, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2096.70190, -1781.71997, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2097.55249, -1778.33838, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2098.18286, -1775.02026, 12.92670,   0.00000, 0.00000, -14.76000);
	CreateDynamicObject(869, 2098.74561, -1771.57117, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2099.96265, -1768.30505, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2103.37500, -1765.97290, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2096.99243, -1780.81067, 12.92670,   0.00000, 0.00000, 79.55999);
	CreateDynamicObject(700, 2123.48169, -1828.98572, 12.00450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2096.00928, -1787.91956, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 2122.64453, -1782.45398, 12.37966,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 2115.13062, -1782.50110, 12.37966,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2097.57544, -1788.09973, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2096.89063, -1824.18262, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2094.34717, -1827.91101, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2094.25586, -1830.05859, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2122.58569, -1829.02393, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2094.08984, -1824.42468, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2098.21240, -1829.72461, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2102.02222, -1829.56689, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2105.62354, -1829.61755, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2109.76929, -1829.51746, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2113.96924, -1829.33948, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2118.25342, -1829.11938, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(700, 2092.58203, -1824.44373, 12.00450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(700, 2092.52148, -1830.33594, 12.00450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(700, 2099.11304, -1829.10107, 12.00450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(700, 2107.78442, -1829.10132, 12.00450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(700, 2115.78784, -1829.38757, 12.00450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2099.73438, -1766.86438, 13.91170,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2096.64575, -1823.47363, 13.91170,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2095.21826, -1789.43591, 13.91170,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2095.93286, -1781.89307, 13.91170,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2098.19312, -1773.90625, 13.91170,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2098.82520, -1806.94543, 13.91170,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2092.53174, -1828.09692, 13.91170,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2099.69482, -1810.59326, 13.81640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2093.46069, -1806.86072, 13.81640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2097.12598, -1806.86072, 13.81640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2099.65747, -1802.55261, 13.81640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2091.78467, -1806.89758, 13.91170,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 2118.83643, -1782.63538, 12.37966,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 2111.60962, -1782.56494, 12.37966,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 2108.03735, -1782.74146, 12.37966,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 2104.51367, -1782.84546, 12.37966,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2096.99243, -1789.20215, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2095.60620, -1786.21753, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2096.24512, -1783.67529, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2094.87695, -1789.08691, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2095.10840, -1788.19604, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2095.79004, -1785.64526, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2095.79004, -1785.64526, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2096.59985, -1783.00708, 12.92670,   0.00000, 0.00000, 79.55999);
	CreateDynamicObject(869, 2096.59985, -1783.00708, 12.92670,   0.00000, 0.00000, 79.55999);
	CreateDynamicObject(869, 2095.88721, -1785.81958, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2097.89819, -1776.62878, 12.92670,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2098.47852, -1774.17212, 12.92670,   0.00000, 0.00000, -114.42003);
	CreateDynamicObject(869, 2099.40063, -1770.19751, 12.92670,   0.00000, 0.00000, -114.42003);
	CreateDynamicObject(1408, 2096.74609, -1802.67493, 13.10160,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1408, 2094.34155, -1802.67493, 13.10160,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1408, 2096.54346, -1810.54773, 13.11720,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1408, 2094.56226, -1810.54773, 13.11720,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3666, 2095.36597, -1806.96765, 13.00000,   0.00000, 0.00000, 0.00000);
	//HOUSE
	CreateDynamicObjectEx(4586, 1405.11719, -1191.40625, 85.03130,   0.00000, 0.00000, 0.00000, 20000.0, 20000.0);
	new rojoescalera1 = CreateDynamicObject(18766, 1421.38794, -1184.1919, 137.13000,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(rojoescalera1, 0, 18787, "matramps", "redrailing");
	new rojoescalera2 = CreateDynamicObject(18766, 1416.39001, -1184.1939, 137.13000,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(rojoescalera2, 0, 18787, "matramps", "redrailing");
	new pared1 = CreateDynamicObject(18766, 1410.70862, -1186.18945, 131.62529,   0.00000, 90.00000, 90.00000);
	SetDynamicObjectMaterial(pared1, 0, 19325, "lsmall_shops", "ws_stationfloor");
	CreateDynamicObject(18762, 1404.71997, -1184.18994, 136.32080,   90.00000, 0.00000, 90.00000);
	new pared2 = CreateDynamicObject(18766, 1403.18005, -1203.66003, 141.75999,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(pared2, 0, 19325, "lsmall_shops", "ws_stationfloor");
	new pared3 = CreateDynamicObject(18766, 1396.11011, -1203.66003, 141.69000,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(pared3, 0, 19325, "lsmall_shops", "ws_stationfloor");
	new pared4 = CreateDynamicObject(18766, 1414.80273, -1197.03748, 141.56000,   0.00000, 90.00000, 90.00000);
	SetDynamicObjectMaterial(pared4, 0, 19325, "lsmall_shops", "ws_stationfloor");
	new pared5 = CreateDynamicObject(18766, 1412.75000, -1195.09998, 141.56000,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(pared5, 0, 19325, "lsmall_shops", "ws_stationfloor");
	new pared6 = CreateDynamicObject(18766, 1412.59998, -1203.55005, 141.75999,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(pared6, 0, 19325, "lsmall_shops", "ws_stationfloor");
	new pared7 = CreateDynamicObject(18766, 1394.10999, -1195.58997, 141.81400,   0.00000, 90.00000, 90.00000);
	SetDynamicObjectMaterial(pared7, 0, 19325, "lsmall_shops", "ws_stationfloor");
	CreateDynamicObject(18762, 1394.10999, -1185.96997, 136.32080,   90.00000, 0.00000, 0.00000);
	new pared8 = CreateDynamicObject(18766, 1399.93994, -1184.18994, 141.78999,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(pared8, 0, 19325, "lsmall_shops", "ws_stationfloor");
	new pared9 = CreateDynamicObject(18766, 1396.11011, -1184.18591, 141.78999,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(pared9, 0, 19325, "lsmall_shops", "ws_stationfloor");
	//CreateDynamicObject(6959, 1423.80005, -1203.28003, 142.14000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19448, 1423.81177, -1188.43274, 138.35391,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19448, 1423.81177, -1188.43274, 134.85530,   0.00000, 0.00000, 0.00000);

	new pared10 = CreateDynamicObject(18766, 1421.30627, -1192.77112, 133.61000,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(pared10, 0, 19325, "lsmall_shops", "ws_stationfloor");
	CreateDynamicObject(18762, 1411.39404, -1184.18787, 131.04401,   90.00000, 0.00000, 90.00000);
	new escaleras1 = CreateDynamicObject(14407, 1415.90833, -1186.45776, 133.62801,   0.00000, 0.00000, 270.00000);
	SetDynamicObjectMaterial(escaleras1, 0, 19379, "all_walls", "mp_shop_floor2");
	new escaleras2 = CreateDynamicObject(14407, 1415.79004, -1190.38000, 130.91000,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(escaleras2, 0, 19379, "all_walls", "mp_shop_floor2");
	new techo1 = CreateDynamicObject(6959, 1414.28162, -1203.70239, 142.12000,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(techo1, 0, 19325, "lsmall_shops", "ws_stationfloor");
	CreateDynamicObject(6959, 1411.56006, -1205.18005, 131.57001,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19356, 1415.59998, -1188.48999, 130.38000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19356, 1417.82007, -1188.50000, 136.89450,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19448, 1423.15002, -1189.20996, 140.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19448, 1413.98608, -1186.82996, 131.99001,   90.00000, 90.00000, 90.00000);
	CreateDynamicObject(19448, 1413.98206, -1186.34204, 131.89000,   90.00000, 90.00000, 90.00000);
	CreateDynamicObject(19448, 1407.46191, -1203.42871, 138.52368,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19448, 1407.46936, -1203.43762, 141.91000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19448, 1419.33997, -1202.18005, 140.39000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19448, 1423.13000, -1198.71997, 140.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19356, 1410.51001, -1199.28394, 133.28000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19429, 1407.27197, -1194.55188, 137.07069,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19448, 1401.80005, -1193.17004, 133.28000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19448, 1405.54004, -1199.17004, 133.28000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19429, 1406.56995, -1193.97998, 133.28000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19429, 1406.56995, -1198.31995, 133.28000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19429, 1410.51001, -1193.68005, 133.28000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(6959, 1411.56006, -1205.18005, 131.57001,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19443, 1417.20996, -1190.26001, 138.21001,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1416.65002, -1190.26001, 137.89999,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1415.95996, -1190.26001, 137.62399,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1415.39001, -1190.26001, 137.28000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1414.81995, -1190.26001, 136.92999,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1417.48999, -1190.26001, 138.39000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1416.32996, -1190.26001, 137.74001,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1415.64001, -1190.26001, 137.45200,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1415.06995, -1190.26001, 137.11000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1416.89001, -1190.26001, 138.05000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(1723, 1398.88000, -1190.77002, 136.81000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1723, 1400.78003, -1187.40002, 136.81000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2315, 1397.78003, -1188.88000, 136.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1828, 1397.89001, -1187.96997, 136.85001,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2315, 1406.62842, -1187.72229, 136.81000,   0.00000, 0.00000, 120.00000);
	CreateDynamicObject(1724, 1404.50000, -1185.44312, 136.81000,   0.00000, 0.00000, 30.00000);
	CreateDynamicObject(1724, 1405.07593, -1188.31006, 136.81000,   0.00000, 0.00000, 120.00000);
	CreateDynamicObject(1724, 1407.74451, -1188.60120, 136.81000,   0.00000, 0.00000, 211.96001);
	CreateDynamicObject(19379, 1422.23889, -1189.66589, 138.56000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1420.44995, -1199.30005, 138.56000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1423.06995, -1189.26001, 134.03999,   0.08000, 90.00000, 0.00000);
	CreateDynamicObject(3850, 1417.08667, -1186.58887, 139.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19448, 1415.22998, -1194.55396, 141.39000,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19448, 1411.96997, -1194.55005, 141.39999,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19379, 1399.85132, -1198.48987, 136.73000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(2774, 1400.21997, -1203.77002, 148.05330,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19448, 1399.95996, -1188.52002, 133.28000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19448, 1401.84998, -1193.14001, 133.28000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19448, 1400.66003, -1197.87000, 133.28000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19386, 1410.51001, -1196.07996, 133.28000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19448, 1415.17395, -1199.17004, 133.28000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19448, 1415.30005, -1197.91003, 133.28000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19448, 1415.30005, -1194.17004, 133.28000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1649, 1399.40710, -1183.32092, 139.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2123, 1397.74146, -1195.92322, 137.47000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2123, 1397.74146, -1200.32886, 137.47000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2123, 1399.10364, -1199.06995, 137.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2123, 1399.10364, -1197.45239, 137.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2123, 1396.34265, -1197.45239, 137.47000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2123, 1396.34265, -1199.06995, 137.47000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2315, 1408.25000, -1195.01196, 137.36800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2315, 1406.05005, -1195.01196, 137.36600,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2315, 1406.04004, -1195.01196, 137.39790,   0.00000, 90.00000, 180.00000);
	CreateDynamicObject(1668, 1406.07092, -1195.00854, 138.02998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2125, 1409.38757, -1193.72559, 137.16190,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2014, 1413.85510, -1197.97595, 136.64999,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2014, 1413.85620, -1196.98792, 136.64999,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2016, 1413.85791, -1196.02539, 136.64999,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2011, 1409.84998, -1202.97998, 136.82001,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2013, 1411.79065, -1196.07324, 136.66000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2016, 1410.79285, -1196.07336, 136.66000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2011, 1405.76001, -1202.84998, 136.82001,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2315, 1402.65601, -1202.68994, 136.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2011, 1401.06006, -1202.59998, 136.82001,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2256, 1403.40002, -1203.14001, 138.75000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19386, 1421.46997, -1195.21997, 140.38000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2774, 1401.29834, -1194.15466, 148.05330,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1502, 1410.46997, -1195.29004, 131.52000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1502, 1422.20996, -1195.19995, 138.64000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2125, 1407.88757, -1193.72559, 137.16190,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2125, 1406.38757, -1193.72559, 137.16190,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2014, 1413.85510, -1198.97595, 136.64999,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2014, 1413.85510, -1199.97595, 136.64999,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18762, 1409.71997, -1184.18994, 136.32080,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(18762, 1414.71997, -1184.18994, 136.32080,   90.00000, 0.00000, 90.00000);
	new pared11 = CreateDynamicObject(18766, 1400.61011, -1203.67004, 141.69000,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(pared11, 0, 19325, "lsmall_shops", "ws_stationfloor");
	CreateDynamicObject(18762, 1394.10999, -1190.96997, 136.32080,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(18762, 1394.10999, -1195.96997, 136.32080,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(18762, 1394.10999, -1200.96997, 136.32080,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(18762, 1399.71997, -1184.18994, 136.32080,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(18762, 1396.21997, -1184.18994, 136.32080,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19325, 1393.61548, -1199.80566, 139.43159,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(19325, 1393.61548, -1186.05566, 139.43159,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(19325, 1393.61548, -1190.18164, 139.43159,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(19325, 1404.26306, -1183.70117, 139.43159,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19325, 1408.38916, -1183.70117, 139.43159,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19325, 1412.51123, -1183.70117, 139.43159,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19379, 1410.35132, -1198.48987, 136.73000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1399.85132, -1188.85986, 136.73000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1408.79932, -1188.85986, 136.72600,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19356, 1415.62012, -1188.50195, 136.89450,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19356, 1417.82007, -1188.50000, 133.39529,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2232, 1396.24255, -1184.82117, 140.15836,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19356, 1418.26404, -1195.21997, 140.38000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19443, 1417.48999, -1193.75842, 138.39000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1417.20996, -1193.75842, 138.21001,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1416.89001, -1193.75842, 138.05000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1416.65002, -1193.75842, 137.89999,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1416.32996, -1193.75842, 137.74001,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1415.95996, -1193.75842, 137.62399,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1415.64001, -1193.75842, 137.45200,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1415.39001, -1193.75842, 137.28000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1415.06995, -1193.75842, 137.11000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1414.81995, -1193.75842, 136.92999,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1414.81995, -1190.26001, 136.75600,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1414.81995, -1193.75842, 136.75600,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1422.23889, -1187.66589, 138.39999,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19356, 1415.61450, -1188.48279, 133.39529,   0.00000, 0.00000, 90.00000);
	new pared12 = CreateDynamicObject(18766, 1416.39001, -1184.18787, 127.13210,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(pared12, 0, 19325, "lsmall_shops", "ws_stationfloor");
	CreateDynamicObject(18762, 1406.39404, -1184.18787, 131.04401,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(18762, 1401.39404, -1184.18787, 131.04401,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(18762, 1396.39404, -1184.18787, 131.04401,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19379, 1408.64148, -1188.50696, 134.77431,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18762, 1417.83948, -1190.92175, 137.87553,   -30.00000, 90.00000, 90.00000);
	CreateDynamicObject(18762, 1416.99548, -1190.92175, 137.38750,   -30.00000, 90.00000, 90.00000);
	CreateDynamicObject(18762, 1416.13745, -1190.92175, 136.88750,   -30.00000, 90.00000, 90.00000);
	CreateDynamicObject(18762, 1415.27747, -1190.92175, 136.39149,   -30.00000, 90.00000, 90.00000);
	CreateDynamicObject(18762, 1414.44751, -1190.92175, 135.91150,   -30.00000, 90.00000, 90.00000);
	CreateDynamicObject(18762, 1413.94751, -1190.92175, 135.19470,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(18762, 1418.05945, -1190.92175, 137.87550,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1398.14148, -1188.50696, 134.77431,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1408.64148, -1198.13904, 134.77431,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1398.14148, -1198.13904, 134.77431,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1419.14148, -1198.13904, 134.77431,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19325, 1403.26306, -1183.70117, 132.82410,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19325, 1409.90515, -1183.70117, 132.82410,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19325, 1416.54321, -1183.70117, 132.82410,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(11665, 1418.77820, -1196.85010, 139.31570,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2267, 1418.74512, -1195.34534, 140.79210,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2071, 1399.78162, -1190.26172, 138.25261,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2563, 1402.49927, -1190.41687, 131.60580,   0.00000, 0.00000, 90.00000);
	new pared13 = CreateDynamicObject(18766, 1414.80273, -1202.03552, 141.56000,   0.00000, 90.00000, 90.00000);
	SetDynamicObjectMaterial(pared13, 0, 19325, "lsmall_shops", "ws_stationfloor");
	CreateDynamicObject(2014, 1413.85510, -1200.97595, 136.64999,   0.00000, 0.00000, 270.00000);
	new pared14 = CreateDynamicObject(18766, 1415.80957, -1202.63525, 141.75999,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(pared14, 0, 19325, "lsmall_shops", "ws_stationfloor");
	CreateDynamicObject(19325, 1393.61548, -1194.30554, 139.43159,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(2014, 1413.85510, -1201.97595, 136.64999,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19429, 1416.89099, -1195.44666, 140.34230,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19325, 1393.61511, -1203.93152, 139.43159,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(2016, 1413.70264, -1196.07935, 136.64999,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19379, 1422.23889, -1187.66589, 138.55460,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19448, 1416.89771, -1200.06506, 140.39000,   0.00000, 0.00000, 0.00000);
	new pared15 = CreateDynamicObject(18766, 1419.80627, -1192.77307, 133.61000,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(pared15, 0, 19325, "lsmall_shops", "ws_stationfloor");
	new pared16 = CreateDynamicObject(18766, 1416.80225, -1192.76709, 132.11000,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(pared16, 0, 19325, "lsmall_shops", "ws_stationfloor");
	new pared17 = CreateDynamicObject(18766, 1412.92224, -1192.77112, 129.84010,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(pared17, 0, 19325, "lsmall_shops", "ws_stationfloor");
	CreateDynamicObject(19429, 1408.46997, -1194.54785, 137.06870,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19429, 1408.46997, -1195.50793, 137.06870,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19429, 1407.27197, -1195.50391, 137.07069,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(1535, 1423.09009, -1187.31958, 138.60612,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19435, 1398.38806, -1184.61963, 139.35889,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19435, 1398.38806, -1184.61755, 139.73390,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(2232, 1396.24255, -1184.82117, 138.96207,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2232, 1400.48865, -1184.82117, 140.15840,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2232, 1400.48865, -1184.82117, 138.96210,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2370, 1397.39221, -1199.39282, 136.77913,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2370, 1397.39221, -1197.68677, 136.77910,   0.00000, 0.00000, 0.00000);
	new pared = CreateDynamicObject(18766, 1409.56055, -1186.20813, 141.56000,   0.00000, 90.00000, 90.00000);
    SetDynamicObjectMaterial(pared, 0, 19325, "lsmall_shops", "ws_stationfloor");
	/*CreateDynamicObject(18766, 1421.38794, -1184.18994, 162.13000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18766, 1410.70862, -1186.18945, 156.62529,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(18762, 1404.71997, -1184.18994, 161.32080,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(18766, 1403.18005, -1203.66003, 166.75999,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18766, 1396.11011, -1203.66003, 166.69000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18766, 1414.80273, -1197.03748, 166.56000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(18766, 1412.75000, -1195.09998, 166.56000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18766, 1412.59998, -1203.55005, 166.75999,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18766, 1394.10999, -1195.58997, 166.81400,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(18762, 1394.10999, -1185.96997, 161.32080,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, 1399.93994, -1184.18994, 166.78999,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18766, 1396.11011, -1184.18591, 166.78999,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(6959, 1423.80005, -1203.28003, 167.14000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18766, 1421.30627, -1192.77112, 158.61000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18762, 1411.39404, -1184.18787, 156.04401,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(14407, 1415.90833, -1186.45776, 158.62801,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(14407, 1415.79004, -1190.38000, 155.91000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(6959, 1414.28162, -1203.70239, 167.12000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(6959, 1411.56006, -1205.18005, 156.57001,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19357, 1415.59998, -1188.48999, 155.38000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19357, 1417.82007, -1188.50000, 161.89450,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19449, 1423.15002, -1189.20996, 165.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19449, 1413.98608, -1186.82996, 156.99001,   90.00000, 90.00000, 90.00000);
	CreateDynamicObject(19449, 1413.98206, -1186.34204, 156.89000,   90.00000, 90.00000, 90.00000);
	CreateDynamicObject(19449, 1407.46191, -1203.42871, 163.52368,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19449, 1407.46936, -1203.43762, 166.91000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19449, 1419.33997, -1202.18005, 165.39000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19449, 1423.13000, -1198.71997, 165.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19357, 1410.51001, -1199.28394, 158.28000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19430, 1407.27197, -1194.55188, 162.07069,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19449, 1401.80005, -1193.17004, 158.28000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19449, 1405.54004, -1199.17004, 158.28000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19430, 1406.56995, -1193.97998, 158.28000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19430, 1406.56995, -1198.31995, 158.28000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19430, 1410.51001, -1193.68005, 158.28000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(6959, 1411.56006, -1205.18005, 156.57001,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19443, 1417.20996, -1190.26001, 163.21001,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1416.65002, -1190.26001, 162.89999,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1415.95996, -1190.26001, 162.62399,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1415.39001, -1190.26001, 162.28000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1414.81995, -1190.26001, 161.92999,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1417.48999, -1190.26001, 163.39000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1416.32996, -1190.26001, 162.74001,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1415.64001, -1190.26001, 162.45200,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1415.06995, -1190.26001, 162.11000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1416.89001, -1190.26001, 163.05000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(1723, 1398.88000, -1190.77002, 161.81000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1723, 1400.78003, -1187.40002, 161.81000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2315, 1397.78003, -1188.88000, 161.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1828, 1397.89001, -1187.96997, 161.85001,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2315, 1406.62842, -1187.72229, 161.81000,   0.00000, 0.00000, 120.00000);
	CreateDynamicObject(1724, 1404.50000, -1185.44312, 161.81000,   0.00000, 0.00000, 30.00000);
	CreateDynamicObject(1724, 1405.07593, -1188.31006, 161.81000,   0.00000, 0.00000, 120.00000);
	CreateDynamicObject(1724, 1407.74451, -1188.60120, 161.81000,   0.00000, 0.00000, 211.96001);
	CreateDynamicObject(2314, 1397.60999, -1197.59998, 161.85001,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19379, 1422.23889, -1189.66589, 163.56000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1420.44995, -1199.30005, 163.56000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1423.06995, -1189.26001, 159.03999,   0.08000, 90.00000, 0.00000);
	CreateDynamicObject(3850, 1417.08667, -1186.58887, 164.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19448, 1415.22998, -1194.55396, 166.39000,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19448, 1411.96997, -1194.55005, 166.39999,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19379, 1399.85132, -1198.48987, 161.73000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(2774, 1400.21997, -1203.77002, 173.05330,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19448, 1399.95996, -1188.52002, 158.28000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19448, 1401.84998, -1193.14001, 158.28000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19448, 1400.66003, -1197.87000, 158.28000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19387, 1410.51001, -1196.07996, 158.28000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19449, 1415.17395, -1199.17004, 158.28000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19449, 1415.30005, -1197.91003, 158.28000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19449, 1415.30005, -1194.17004, 158.28000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1649, 1398.47998, -1184.79004, 164.39000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1649, 1398.43994, -1184.80005, 164.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2232, 1396.06995, -1184.60999, 163.22473,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2314, 1397.61121, -1199.31006, 161.87000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2123, 1397.60779, -1195.18384, 162.47000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2123, 1397.61243, -1200.29028, 162.47000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2123, 1398.71545, -1199.33789, 162.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2123, 1398.68958, -1197.89661, 162.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2123, 1398.74988, -1196.43811, 162.47000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2123, 1396.62036, -1196.24463, 162.47000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2123, 1396.63867, -1197.77661, 162.47000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2123, 1396.64111, -1199.30981, 162.47000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2315, 1408.25000, -1195.01196, 162.36800,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2315, 1406.05005, -1195.01196, 162.36600,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2315, 1406.04004, -1195.01196, 162.39790,   0.00000, 90.00000, 180.00000);
	CreateDynamicObject(1668, 1406.07092, -1195.00854, 163.02998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2125, 1409.38757, -1193.72559, 162.16190,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2014, 1413.85510, -1197.97595, 161.64999,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2014, 1413.85620, -1196.98792, 161.64999,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2016, 1413.85791, -1196.02539, 161.64999,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2011, 1409.84998, -1202.97998, 161.82001,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2013, 1411.79065, -1196.07324, 161.66000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2016, 1410.79285, -1196.07336, 161.66000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2011, 1405.76001, -1202.84998, 161.82001,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2315, 1402.65601, -1202.68994, 161.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2011, 1401.06006, -1202.59998, 161.82001,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2256, 1403.40002, -1203.14001, 163.75000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19386, 1421.46997, -1195.21997, 165.38000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2774, 1401.29834, -1194.15466, 173.05330,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1502, 1410.46997, -1195.29004, 156.52000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1502, 1422.20996, -1195.19995, 163.64000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2125, 1407.88757, -1193.72559, 162.16190,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2125, 1406.38757, -1193.72559, 162.16190,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2014, 1413.85510, -1198.97595, 161.64999,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2014, 1413.85510, -1199.97595, 161.64999,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18762, 1409.71997, -1184.18994, 161.32080,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(18762, 1414.71997, -1184.18994, 161.32080,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(18766, 1400.61011, -1203.67004, 166.69000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18762, 1394.10999, -1190.96997, 161.32080,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(18762, 1394.10999, -1195.96997, 161.32080,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(18762, 1394.10999, -1200.96997, 161.32080,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(18762, 1399.71997, -1184.18994, 161.32080,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(18762, 1396.21997, -1184.18994, 161.32080,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19325, 1393.61548, -1199.80566, 164.43159,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(19325, 1393.61548, -1186.05566, 164.43159,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(19325, 1393.61548, -1190.18164, 164.43159,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(19325, 1404.26306, -1183.70117, 164.43159,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19325, 1408.38916, -1183.70117, 164.43159,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19325, 1412.38916, -1183.70117, 164.43159,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19379, 1410.35132, -1198.48987, 161.73000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1399.85132, -1188.85986, 161.73000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1408.79932, -1188.85986, 161.72600,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19357, 1415.62012, -1188.50195, 161.89450,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19357, 1417.82007, -1188.50000, 158.39529,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2232, 1396.06995, -1184.60999, 164.42844,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2232, 1396.06995, -1184.60999, 165.60600,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2232, 1400.66016, -1184.60999, 163.22470,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2232, 1400.66016, -1184.60999, 164.42841,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2232, 1400.66016, -1184.60999, 165.60605,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19356, 1418.26404, -1195.21997, 165.38000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19443, 1417.48999, -1193.75842, 163.39000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1417.20996, -1193.75842, 163.21001,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1416.89001, -1193.75842, 163.05000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1416.65002, -1193.75842, 162.89999,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1416.32996, -1193.75842, 162.74001,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1415.95996, -1193.75842, 162.62399,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1415.64001, -1193.75842, 162.45200,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1415.39001, -1193.75842, 162.28000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1415.06995, -1193.75842, 162.11000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1414.81995, -1193.75842, 161.92999,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1414.81995, -1190.26001, 161.75600,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19443, 1414.81995, -1193.75842, 161.75600,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1422.23889, -1187.66589, 163.39999,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19357, 1415.61450, -1188.48279, 158.39529,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18766, 1416.39001, -1184.18787, 152.13210,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18762, 1406.39404, -1184.18787, 156.04401,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(18762, 1401.39404, -1184.18787, 156.04401,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(18762, 1396.39404, -1184.18787, 156.04401,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(18766, 1416.39001, -1184.18787, 162.13000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1408.64148, -1188.50696, 159.77431,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18762, 1417.83948, -1190.92175, 162.87553,   -30.00000, 90.00000, 90.00000);
	CreateDynamicObject(18762, 1416.99548, -1190.92175, 162.38750,   -30.00000, 90.00000, 90.00000);
	CreateDynamicObject(18762, 1416.13745, -1190.92175, 161.88750,   -30.00000, 90.00000, 90.00000);
	CreateDynamicObject(18762, 1415.27747, -1190.92175, 161.39149,   -30.00000, 90.00000, 90.00000);
	CreateDynamicObject(18762, 1414.44751, -1190.92175, 160.91150,   -30.00000, 90.00000, 90.00000);
	CreateDynamicObject(18762, 1413.94751, -1190.92175, 160.19470,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(18762, 1418.05945, -1190.92175, 162.87550,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1398.14148, -1188.50696, 159.77431,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1408.64148, -1198.13904, 159.77431,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1398.14148, -1198.13904, 159.77431,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1419.14148, -1198.13904, 159.77431,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19325, 1403.26306, -1183.70117, 157.82410,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19325, 1409.90515, -1183.70117, 157.82410,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19325, 1416.54321, -1183.70117, 157.82410,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(11665, 1418.77820, -1196.85010, 164.31570,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2267, 1418.74512, -1195.34534, 165.79210,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2071, 1399.78162, -1190.26172, 163.25261,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2563, 1402.49927, -1190.41687, 156.60580,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2774, 1409.76965, -1184.53894, 173.05331,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2774, 1409.76965, -1186.18494, 173.05330,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2774, 1409.77368, -1187.68494, 173.05330,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, 1414.80273, -1202.03552, 166.56000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(2014, 1413.85510, -1200.97595, 161.64999,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(18766, 1415.80957, -1202.63525, 166.75999,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19325, 1393.61548, -1194.30554, 164.43159,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(2014, 1413.85510, -1201.97595, 161.64999,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19429, 1416.89099, -1195.44666, 165.34230,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19325, 1393.60706, -1203.93152, 164.43159,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(2016, 1413.70264, -1196.07935, 161.64999,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19379, 1422.23889, -1187.66589, 163.55460,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19449, 1416.89771, -1200.06506, 165.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18766, 1419.80627, -1192.77307, 158.61000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18766, 1416.80225, -1192.76709, 157.11000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18766, 1412.92224, -1192.77112, 154.84010,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19430, 1408.46997, -1194.54785, 162.06870,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19430, 1408.46997, -1195.50793, 162.06870,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19430, 1407.27197, -1195.50391, 162.07069,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(1535, 1423.09009, -1187.31958, 163.60612,   0.00000, 0.00000, 90.00000);
*/

	//Taller LS y Groove decoración
	CreateDynamicObject(9220, 2365.60010, -1711.68994, 15.20000,   0.00000, 0.00000, -180.02000);
	CreateDynamicObject(641, 2352.32007, -1702.01001, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2373.59009, -1721.73999, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2360.35010, -1722.26001, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2352.91992, -1722.28003, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2352.04004, -1716.44995, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2352.16992, -1711.70996, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2352.27002, -1707.14001, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2368.00000, -1722.21997, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2395.55005, -1742.58997, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2401.55005, -1742.33997, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2382.16992, -1742.39001, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2375.31006, -1742.22998, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2363.54004, -1742.27002, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2357.05005, -1742.31995, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2342.33008, -1742.64001, 9.80000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2323.25000, -1742.03003, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1280, 2388.82080, -1742.07813, 12.83000,   0.00000, 0.00000, 990.00000);
	CreateDynamicObject(1280, 2267.32397, -1742.09094, 12.83000,   0.00000, 0.00000, 990.00000);
	CreateDynamicObject(1280, 2348.63892, -1742.02771, 12.83000,   0.00000, 0.00000, 990.00000);
	CreateDynamicObject(1280, 2388.74731, -1742.72925, 12.84000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1280, 2267.36011, -1742.79004, 12.84000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1280, 2348.60376, -1742.68481, 12.84000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1215, 2321.93335, -1737.93994, 13.04000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2322.01050, -1746.76306, 13.04000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2319.34082, -1740.57251, 13.04000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2305.48438, -1746.77234, 13.04000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2318.95581, -1742.29907, 13.04000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2319.31250, -1744.09253, 13.04000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2320.39917, -1745.70642, 13.04000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2298.51001, -1742.31995, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2333.58008, -1746.05969, 14.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2236.06689, -1738.06897, 14.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2353.04004, -1738.06848, 14.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2393.92822, -1738.06848, 14.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2380.96997, -1738.06848, 14.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2393.94189, -1746.05969, 14.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2380.36011, -1746.05969, 14.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2352.79004, -1746.05969, 14.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(997, 2367.59009, -1739.15002, 12.82000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(997, 2367.59009, -1745.63000, 12.76000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3660, 2333.55005, -1738.06848, 14.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2293.89795, -1738.06848, 14.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2262.98999, -1738.06897, 14.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2236.08984, -1746.05969, 14.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2293.63354, -1746.05969, 14.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2263.02979, -1746.05969, 14.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2320.39502, -1738.99023, 13.04000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2305.52002, -1737.84998, 13.04000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2307.09888, -1739.01074, 13.04000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2308.14258, -1740.46606, 13.04000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2308.54077, -1742.22876, 13.04000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2308.14673, -1744.07068, 13.04000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2307.06763, -1745.69690, 13.04000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2335.78003, -1742.37000, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2227.92114, -1742.34351, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2304.46997, -1742.29004, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2289.95996, -1742.26001, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2283.90991, -1742.12000, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2276.30005, -1742.25000, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2270.82007, -1742.38000, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2264.37012, -1742.31995, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1280, 2328.96973, -1742.06641, 12.83000,   0.00000, 0.00000, 990.00000);
	CreateDynamicObject(1280, 2328.90454, -1742.71094, 12.84000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1280, 2294.10010, -1741.65002, 12.83000,   0.00000, 0.00000, 990.00000);
	CreateDynamicObject(1280, 2279.38989, -1741.83997, 12.83000,   0.00000, 0.00000, 990.00000);
	CreateDynamicObject(1280, 2294.18994, -1742.31995, 12.84000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1280, 2279.46997, -1742.43005, 12.84000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(641, 2258.70996, -1742.31995, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2243.40991, -1742.34998, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2235.19067, -1742.52759, 9.90000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1238, 1181.29004, -1311.82996, 12.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1238, 1182.60999, -1311.82996, 12.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1238, 1184.15002, -1311.82996, 12.87000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2274.37036, -1746.05969, 14.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2281.49219, -1738.06897, 14.35000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1280, 2231.30933, -1741.93433, 12.83000,   0.00000, 0.00000, 990.00000);
	CreateDynamicObject(1280, 2231.34009, -1742.61340, 12.83000,   0.00000, 0.00000, 810.60004);
	CreateDynamicObject(3578, 2624.75220, -2116.95654, 13.18084,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(11614, 2505.28564, -2137.85767, 15.56080,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(12943, 2482.54126, -2136.05933, 12.59000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(12943, 2456.37036, -2136.05127, 12.59000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(12943, 2465.04663, -2136.01270, 12.59000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(12943, 2473.71851, -2135.93262, 12.59000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(5409, 2501.01270, -2091.28589, 16.99000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11614, 2526.99170, -2137.89551, 15.56080,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3660, 2483.10815, -2078.45264, 14.80410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2514.24585, -2091.36621, 14.80410,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3660, 2433.84277, -2095.10718, 14.80410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2433.84277, -2082.53613, 14.80410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2502.47363, -2078.43237, 14.80410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2533.72168, -2075.71484, 14.80410,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3660, 2506.03149, -2067.26660, 14.80410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2483.10815, -2067.18726, 14.80410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2486.81445, -2067.25977, 14.80410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2514.58789, -2081.16235, 12.88180,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2514.19800, -2079.47168, 12.88180,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2512.76807, -2078.63037, 12.88180,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2523.72388, -2078.87598, 12.88180,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1676, 2523.75830, -2082.87354, 14.14350,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1676, 2523.75830, -2085.77344, 14.14350,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1676, 2523.75830, -2090.31348, 14.14350,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1676, 2523.73828, -2092.81348, 14.12350,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3660, 2525.53882, -2067.26538, 14.80410,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2533.73291, -2091.78418, 14.80410,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(9193, 2421.36499, -2101.70337, 16.13080,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(9193, 2421.03882, -2076.53760, 16.13080,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 2429.10547, -2128.63550, 12.66580,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1251, 2429.12549, -2124.51538, 12.66580,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1251, 2429.12549, -2120.65552, 12.66580,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1251, 2429.12549, -2117.05542, 12.66580,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1251, 2429.10547, -2133.09546, 12.66580,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1251, 2434.96582, -2108.64453, 12.66580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 2439.95264, -2140.21802, 12.66580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 2444.47266, -2140.21802, 12.66580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 2448.17261, -2140.21802, 12.66580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 2435.51270, -2140.21802, 12.66580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 2435.45264, -2140.21802, 12.66580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 2440.08594, -2108.64453, 12.66580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 2444.74585, -2108.64453, 12.66580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1251, 2448.82568, -2108.64453, 12.66580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1361, 2523.75610, -2095.86450, 13.28520,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1361, 2523.81250, -2079.88672, 13.16930,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2523.79272, -2096.99390, 12.93860,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2523.79272, -2098.17383, 12.93860,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2523.79272, -2099.35400, 12.93860,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2523.79272, -2100.51392, 12.93860,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 2424.10010, -2071.73462, 12.24770,   0.00000, 0.00000, 9990.00000);
	CreateDynamicObject(1215, 2419.38354, -2098.26367, 12.98260,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2422.73511, -2084.01953, 12.98260,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2421.39355, -2083.32813, 12.98260,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2420.04980, -2082.44580, 12.98260,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2418.95581, -2079.96753, 12.98260,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2423.54834, -2094.86816, 12.98260,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2421.93262, -2095.15259, 12.98260,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2420.59277, -2095.92358, 12.98260,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2419.85620, -2097.08179, 12.98260,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2419.28442, -2081.31543, 12.98260,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 2424.16333, -2095.07495, 12.02775,   0.00000, 0.00000, 9990.00000);
	CreateDynamicObject(3096, 2423.76514, -2081.70776, 14.79720,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3096, 2423.74487, -2097.25024, 14.79720,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3096, 2482.56323, -2143.87231, 14.97630,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3096, 2456.38916, -2143.85400, 15.08540,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3096, 2473.83154, -2143.65234, 15.08540,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3096, 2465.04492, -2143.86353, 15.08540,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(994, 2427.97559, -2104.39038, 13.24080,   -0.04000, 0.00000, 0.00000);
	CreateDynamicObject(994, 2434.27441, -2104.39038, 13.24080,   -0.04000, 0.00000, 0.00000);
	CreateDynamicObject(994, 2440.51294, -2104.39038, 13.24080,   -0.04000, 0.00000, 0.00000);
	CreateDynamicObject(994, 2450.59570, -2141.11792, 13.24080,   -0.04000, 0.00000, 90.00000);
	CreateDynamicObject(994, 2446.67285, -2104.39038, 13.24080,   -0.04000, 0.00000, 0.00000);
	CreateDynamicObject(994, 2450.32910, -2113.13574, 13.24080,   -0.04000, 0.00000, 90.00000);
	CreateDynamicObject(994, 2450.32910, -2106.99585, 13.24080,   -0.04000, 0.00000, 90.00000);
	CreateDynamicObject(994, 2450.57666, -2128.63403, 13.24080,   -0.04000, 0.00000, 90.00000);
	CreateDynamicObject(994, 2450.56201, -2134.84497, 13.24080,   -0.04000, 0.00000, 90.00000);
	CreateDynamicObject(638, 2447.83228, -2121.08838, 13.12100,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(638, 2450.33984, -2121.10547, 13.12100,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1215, 2452.09644, -2125.54834, 13.10100,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2450.07153, -2116.11084, 13.10100,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2451.64014, -2116.20068, 13.10100,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2450.48218, -2125.61768, 13.10100,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2431.18579, -2136.04956, 12.96380,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2429.71411, -2105.83545, 12.96380,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2426.31348, -2109.49438, 12.96380,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2426.30908, -2106.46655, 12.96380,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2429.87915, -2109.17188, 12.96380,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2426.89624, -2112.03711, 12.96380,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2427.57593, -2136.08423, 12.96380,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2427.91968, -2138.54956, 12.96380,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2428.17773, -2141.78052, 12.96380,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2431.92407, -2141.79321, 12.96380,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2431.41895, -2138.71167, 12.96380,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3515, 2428.36963, -2108.85815, 11.73580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3515, 2429.91431, -2139.33447, 11.73580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3462, 2433.29834, -2136.21362, 13.69980,   0.00000, 0.00000, -150.02000);
	CreateDynamicObject(3462, 2432.49316, -2113.36841, 13.69980,   0.00000, 0.00000, 150.00000);
	CreateDynamicObject(869, 2430.54517, -2111.94653, 12.96380,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3242, 2452.97729, -2070.22900, 14.55020,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3242, 2438.86816, -2070.22900, 14.55020,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(638, 2439.31030, -2073.88281, 13.17420,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(638, 2453.49536, -2073.88281, 13.17420,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(638, 2457.57788, -2073.88281, 13.17420,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(638, 2443.27075, -2073.88281, 13.17420,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3761, 2453.26245, -2135.68750, 14.54412,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3761, 2479.32495, -2137.00342, 14.57097,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3761, 2470.62744, -2136.08838, 14.57561,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3761, 2461.80908, -2135.56543, 14.61491,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2523.72388, -2077.87598, 12.88180,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2523.72388, -2076.87598, 12.88180,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2523.72388, -2075.87598, 12.88180,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2523.72388, -2074.87598, 12.88180,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2522.72388, -2074.87598, 12.88180,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2521.72388, -2074.87598, 12.88180,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2520.72388, -2074.87598, 12.88180,   0.00000, 0.00000, 0.00000);

	//prisión fortcarson exterior
	CreateDynamicObject(3749, 288.14139, 1411.57861, 14.56882,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(8149, 110.56751, 1406.39197, 12.48510,   0.00000, 0.00000, 0.50000);
	CreateDynamicObject(8148, 191.81569, 1485.24390, 12.48510,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(8152, 208.32149, 1455.58911, 12.48510,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 160.86678, 1432.89941, 9.42527,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(987, 288.85178, 1401.91943, 9.42530,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(8155, 268.55685, 1363.50305, 12.48510,   0.00000, 0.00000, 179.50000);
	CreateDynamicObject(8148, 192.69859, 1336.32190, 12.48510,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(8150, 225.65190, 1403.21338, 11.76890,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(8150, 225.65190, 1419.87341, 11.76890,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3749, 245.64140, 1411.57861, 14.56880,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3749, 203.48140, 1411.57861, 14.56880,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3749, 162.68140, 1411.57861, 14.56880,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 288.29187, 1431.50024, 9.42527,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(987, 150.32680, 1420.99939, 9.42530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 150.32680, 1409.09937, 9.42530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 150.32680, 1397.19934, 9.42530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 150.41547, 1403.17761, 9.42530,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(987, 150.32680, 1385.29932, 9.42530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 150.32680, 1373.39929, 9.42530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 150.32680, 1361.49927, 9.42530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3749, 150.64270, 1353.89209, 14.56880,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 150.32680, 1335.99927, 9.42530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3749, 150.64270, 1464.39209, 14.56880,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 150.32680, 1432.89941, 9.42530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 150.32680, 1444.79944, 9.42530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 150.32680, 1473.01941, 9.42530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(4079, 253.94090, 1453.85669, 21.73030,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(4079, 204.54510, 1448.91235, 21.73030,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(16480, 260.32025, 1447.58826, 20.49623,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16482, 199.95773, 1455.19604, 20.49620,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(16480, 260.32025, 1447.58826, 20.49623,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(16480, 199.95770, 1455.19604, 20.49620,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(980, 288.65009, 1411.56982, 11.88040,   0.00000, 0.00000, 90.00000);//p1
	CreateDynamicObject(980, 246.15010, 1411.56982, 11.88040,   0.00000, 0.00000, 90.00000);//p2
	CreateDynamicObject(980, 204.33009, 1411.56982, 11.88040,   0.00000, 0.00000, 90.00000);//p3
	CreateDynamicObject(980, 162.85010, 1411.56982, 11.88040,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 160.86681, 1444.79944, 9.42530,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(987, 160.86681, 1456.69934, 9.42530,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(987, 219.34413, 1484.93176, 9.42530,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(13367, 114.36054, 1480.31946, 20.24940,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(13367, 114.36050, 1340.57947, 20.24940,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(13367, 284.36050, 1340.57947, 20.24940,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(13367, 284.36050, 1428.29956, 20.24940,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2627, 117.79669, 1456.40564, 9.58588,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2627, 119.09175, 1448.58215, 9.58590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2627, 116.25794, 1443.84302, 9.58590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2627, 116.25909, 1435.36230, 9.58590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2627, 116.12229, 1439.01270, 9.58590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2628, 131.76711, 1451.42712, 9.63530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2628, 131.76711, 1448.36707, 9.63530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2629, 131.76711, 1443.94714, 9.63530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2630, 131.76711, 1439.86707, 9.63530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2630, 131.76711, 1436.12708, 9.63530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2630, 131.76711, 1433.06702, 9.63530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2630, 131.76711, 1425.58716, 9.63530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2631, 126.86128, 1418.94861, 9.62230,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2631, 118.70130, 1418.94861, 9.62230,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2631, 118.70130, 1413.16858, 9.62230,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2632, 118.70130, 1407.04858, 9.62230,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2632, 126.86130, 1408.40857, 9.62230,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(6959, 196.19568, 1368.28088, 9.66584,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(6960, 196.19569, 1368.28088, 11.79846,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3496, 216.22052, 1378.06055, 9.68207,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3496, 216.22050, 1358.00049, 9.68210,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3496, 177.80051, 1358.00049, 9.68210,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(3496, 177.80051, 1378.40051, 9.68210,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(987, 225.46680, 1335.99927, 9.42530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 225.46680, 1347.89929, 9.42530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 225.46680, 1359.79932, 9.42530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3749, 226.07671, 1381.25085, 14.58370,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(987, 225.46680, 1391.07935, 9.42530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(980, 225.66748, 1381.26550, 11.88040,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3268, 267.43716, 1386.58337, 9.24311,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3268, 267.43719, 1353.60339, 9.24310,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3050, 177.98509, 1423.18958, 12.73825,   0.00000, 0.00000, 315.58606);
	CreateDynamicObject(3050, 180.19136, 1420.97217, 12.73820,   0.00000, 0.00000, 315.58609);
	CreateDynamicObject(3050, 180.19136, 1420.97217, 9.70918,   0.00000, 0.00000, 315.58609);
	CreateDynamicObject(3050, 177.98511, 1423.18958, 9.70920,   0.00000, 0.00000, 315.58609);
	CreateDynamicObject(691, 298.16101, 1398.69861, 8.32853,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(691, 299.57538, 1425.55774, 8.32853,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(691, 310.41223, 1399.06860, 6.89011,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(691, 321.60385, 1398.19263, 5.50702,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(691, 311.19989, 1425.66565, 7.20362,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(691, 321.44418, 1425.23682, 6.55817,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(13367, 284.36050, 1397.35962, 20.24940,   0.00000, 0.00000, 0.00000);
	//Spraycans
	/*CreateDynamicObject(5422, 2071.47656, -1831.42188, 14.56250,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(6400, 488.28131, -1734.69531, 12.39060,   0.00000, 0.00000, 81.00000);
	CreateDynamicObject(5856, 1024.98438, -1029.35156, 33.19530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(5779, 1041.35156, -1025.92969, 32.67190,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(5340, 2644.85938, -2039.23438, 14.03910,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(13028, 720.01563, -462.52341, 16.85940,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(11313, -1935.85938, 239.53130, 35.35160,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(11319, -1904.53125, 277.89841, 42.95310,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(10575, -2716.35156, 217.47659, 5.38280,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(9625, -2425.72656, 1027.99219, 52.28130,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(10182, -1786.81250, 1209.42188, 25.83590,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3294, -1420.54688, 2591.15625, 57.74220,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3294, -100.00000, 1111.41406, 21.64060,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(9093, 2386.65625, 1043.60156, 11.59380,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(7891, 1968.74219, 2162.49219, 12.09380,   0.00000, 0.00000, 0.00000);*/
	//Alhambra
	Alhambra = CreateDynamicObject(18018, 493.35941, -14.89840, 999.67188-7.403,   0.00000, 0.00000, 180.00000);
	SetDynamicObjectMaterial(Alhambra, 0, 19449, "all_walls", "cj_white_wall2");
	SetDynamicObjectMaterial(Alhambra, 1, 19128, "dancefloors", "DanceFloor1");
	SetDynamicObjectMaterial(Alhambra, 2, 4724, "skyscr1_lan2", "sl_librarywall1");
	SetDynamicObjectMaterial(Alhambra, 3, 4724, "skyscr1_lan2", "sl_librarywall1");
	SetDynamicObjectMaterial(Alhambra, 4, 4724, "skyscr1_lan2", "sl_librarywall1");
	CreateDynamicObject(19128, 489.82819, -12.15030, 999.64099-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19128, 489.82819, -16.12030, 999.64099-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19128, 485.82819, -16.12030, 999.64099-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19128, 485.82819, -12.15030, 999.64099-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19128, 485.91699, -1.67260, 1001.33350-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19128, 489.12100, -1.67260, 1001.32953-7.403,   0.00000, 0.00000, 0.00000);
		//Arriba
	CreateDynamicObject(19128, 487.16385, -23.14099, 1002.06549-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19128, 487.16379, -27.14100, 1002.06549-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19128, 483.16379, -23.14100, 1002.06549-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19128, 481.27979, -23.14100, 1002.06152-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19128, 483.16379, -27.14100, 1002.06549-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19128, 481.27979, -27.14100, 1002.06152-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19370, 478.95279, -24.52480, 1002.02753-7.403,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19370, 478.95279, -27.73480, 1002.02753-7.403,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19370, 475.45221, -22.81710, 1002.02753-7.403,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19370, 475.45221, -26.01710, 1002.02753-7.403,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19370, 471.95221, -26.01710, 1002.02753-7.403,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19370, 471.95221, -22.81710, 1002.02753-7.403,   0.00000, 90.00000, 0.00000);
		//Humo
    CreateDynamicObject(2780, 487.92630, -14.27980, 992.67328-7.403,   0.00000, 0.00000, 0.00000);
    //Flashh
    CreateDynamicObject(345, 487.8518, -13.6801, 1003.5559-7.403,   0.00000, 0.00000, 0.00000);
    
	new rp1 = CreateDynamicObject(19464, 487.4775, -0.2203, 1003.0283-7.403, 0.0000, 0.0000, 90.0);
	SetDynamicObjectMaterialText(rp1, 0, "eXtreme RolePlay", 140, "Arial", 60, 1, -16776961, 0, 1);
	//new ex2 = CreateDynamicObject(19353, 485.4350, -20.9671, 1001.5, 0.0000, 0.0000, 90.0);
	//SetDynamicObjectMaterialText(ex2, 0, "Alhambra - MUSIC", 140, "Franklin Gothic Medium", 70, 1, -16776961, 0, 1);
	CreateDynamicObject(2773, 479.60956, -22.44417, 1002.62671-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1723, 501.08069, -13.54530, 999.67578-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1723, 503.03867, -16.51109, 999.67578-7.403,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1723, 501.11157, -19.83668, 999.67578-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1723, 503.13370, -23.22323, 999.67578-7.403,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2315, 501.36566, -15.07765, 999.67773-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2315, 501.36569, -21.57760, 999.67767-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1723, 488.93503, -20.37638, 999.67578-7.403,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1723, 485.43500, -20.37640, 999.67578-7.403,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1723, 481.93500, -20.37640, 999.67578-7.403,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1723, 496.58069, -13.54530, 999.67578-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1723, 498.53870, -16.51110, 999.67578-7.403,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2315, 496.86569, -15.07760, 999.67767-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1723, 496.61160, -19.83670, 999.67578-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2315, 496.86569, -21.57760, 999.67767-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1723, 498.63370, -23.22320, 999.67578-7.403,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1670, 497.55798, -14.99923, 1000.18555-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1670, 502.25339, -14.97345, 1000.18555-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1670, 497.54715, -21.48342, 1000.18555-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1670, 502.03802, -21.51635, 1000.18555-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2321, 488.43237, -5.16120, 1001.33154-7.403,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(14820, 487.70255, -5.20942, 1001.92041-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2321, 488.43237, -5.16120, 1000.85852-7.403,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19172, 478.74191, -6.43730, 1000.32568-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19174, 481.43591, -6.43730, 1000.32568-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19175, 484.13190, -6.43730, 1000.32568-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19172, 486.82990, -6.43730, 1000.32568-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19174, 489.52991, -6.43730, 1000.32568-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19175, 492.22391, -6.43730, 1000.32568-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19172, 494.92191, -6.43730, 1000.32568-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19174, 496.02789, -6.43330, 1000.32568-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2232, 478.03122, -2.58967, 1004.73108-7.403,   30.00000, 0.00000, 45.00000);
	CreateDynamicObject(2232, 483.35071, -0.98835, 1004.73108-7.403,   30.00000, 0.00000, 45.00000);
	CreateDynamicObject(2232, 491.81039, -0.61982, 1004.73108-7.403,   30.00000, 0.00000, -45.00000);
	CreateDynamicObject(2232, 499.01279, -2.34857, 1004.73108-7.403,   30.00000, 0.00000, -45.00000);
	CreateDynamicObject(2232, 488.23129, -5.52460, 1001.45367-7.403,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(2232, 487.06329, -5.52460, 1001.43768-7.403,   0.00000, -90.00000, 0.00000);
	CreateDynamicObject(957, 503.62030, -10.18162, 1004.71277-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 503.62030, -12.68160, 1004.71283-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 503.62030, -15.18160, 1004.71283-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 503.62030, -17.68160, 1004.71283-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 503.62030, -20.18160, 1004.71283-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 503.62030, -22.68160, 1004.71283-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 503.62030, -24.68160, 1004.71283-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 501.12030, -10.18160, 1004.71283-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 498.62030, -10.18160, 1005.45880-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 496.12030, -10.18160, 1005.45880-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 503.62030, -10.18160, 1004.71283-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 501.12030, -12.68160, 1004.71283-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 501.12030, -15.18160, 1004.71283-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 501.12030, -17.68160, 1004.71283-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 501.12030, -20.18160, 1004.71283-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 501.12030, -22.68160, 1004.71283-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 501.12030, -24.68160, 1004.71283-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 498.62030, -12.68160, 1005.45880-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 498.62030, -15.18160, 1005.45880-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 498.62030, -17.68160, 1005.45880-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 498.62030, -20.18160, 1005.45880-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 498.62030, -22.68160, 1005.45880-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 498.62030, -24.68160, 1005.45880-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 496.12030, -12.68160, 1005.45880-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 496.12030, -15.18160, 1005.45880-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 496.12030, -17.68160, 1005.45880-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 496.12030, -20.18160, 1005.45880-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 496.12030, -22.68160, 1005.45880-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 496.12030, -24.68160, 1005.45880-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18643, 477.21643, -6.47648, 1001.08051-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18646, 488.74466, -5.53492, 1001.90936-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18646, 486.60504, -5.55718, 1001.90942-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18655, 483.64883, -5.88202, 998.61652-7.403,   0.00000, 0.00000, 117.50000);
	CreateDynamicObject(18655, 491.31070, -5.97206, 998.61652-7.403,   0.00000, 0.00000, 55.00000);
	Alhambra_Bar = CreateDynamicObject(18090, 479.13095, -11.04733, 1002.23102-7.403,   0.00000, 0.00000, 180.00000);
	//SetDynamicObjectMaterial(Alhambra_Bar, 0, 19449, "all_walls", "cj_white_wall2");
	SetDynamicObjectMaterial(Alhambra_Bar, 2, 19449, "all_walls", "cj_white_wall2");
	SetDynamicObjectMaterial(Alhambra_Bar, 3, 18646, "matcolours", "white");
	SetDynamicObjectMaterial(Alhambra_Bar, 5, 0, "null", "null");
	SetDynamicObjectMaterial(Alhambra_Bar, 6, 0, "null", "null");
	CreateDynamicObject(19464, 478.13184, -6.29586, 1002.12537-7.403,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2125, 481.15588, -14.08824, 999.97687-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2125, 481.15591, -12.08820, 999.97693-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2125, 481.15591, -10.08820, 999.97693-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2125, 481.15591, -8.08820, 999.97693-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2125, 477.87485, -15.80164, 999.97687-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 477.23871, -13.92360, 1002.50391-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2176, 503.71820, -4.64323, 1002.47101-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1537, 473.82312, -21.31648, 1002.68042-7.403,   0.00000, 0.00000, 180.00000);
	//CreateDynamicObject(18708, 484.26685, -0.59231, 1004.37402,   0.00000, 0.00000, 0.00000);//pompas
	CreateDynamicObject(18708, 485.2, -0.54790, 1001.7-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18708, 487.69751, -0.54790, 1001.7-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18708, 489.69751, -0.54790, 1001.7-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18728, 484.36285, -6.07611, 999.42529-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18728, 490.86292, -6.07610, 999.42529-7.403,   0.00000, 0.00000, 0.00000);
	//CreateDynamicObject(19289, 483.20093, -0.33785, 1004.10431,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19289, 483.20093, -0.33785, 1004.10431-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19289, 484.70090, -0.33790, 1004.10431-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19289, 486.20090, -0.33790, 1004.10431-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19289, 487.70090, -0.33790, 1004.10431-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19289, 489.20090, -0.33790, 1004.10431-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19289, 490.70090, -0.33790, 1004.10431-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19289, 492.20090, -0.33790, 1004.10431-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19289, 483.20090, -0.33790, 1002.1043-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19289, 484.70090, -0.33790, 1002.1043-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19289, 486.20090, -0.33790, 1002.1043-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19289, 487.70090, -0.33790, 1002.1043-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19289, 489.20090, -0.33790, 1002.1043-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19289, 490.70090, -0.33790, 1002.1043-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19289, 492.20090, -0.33790, 1002.1043-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19289, 483.20090, -0.33790, 1003.2107-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19289, 492.20090, -0.33790, 1003.2107-7.403,   0.00000, 0.00000, 0.00000);
	//Regalos
	CreateDynamicObject(19056, 483.66119, -17.14150, 1003.61047-7.403,   0.00000, 0.00000, 33.00000);
	CreateDynamicObject(19087, 483.64963, -17.18654, 1005.60065-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19057, 490.95050, -15.96320, 1003.47723-7.403,   0.00000, 0.00000, -30.00000);
	CreateDynamicObject(19087, 490.95117, -15.97180, 1005.60065-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19055, 490.54459, -11.29980, 1003.75708-7.403,   0.00000, 0.00000, -130.00000);
	CreateDynamicObject(19087, 490.49725, -11.27329, 1005.60065-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19054, 484.24710, -11.21110, 1003.11462-7.403,   0.00000, 0.00000, -26.00000);
	CreateDynamicObject(19087, 484.24438, -11.20873, 1005.60065-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1541, 478.12482, -12.86644, 1001.46960-7.403,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1543, 477.75262, -13.73249, 1001.32068-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1544, 477.73889, -13.53200, 1001.32068-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1543, 477.73889, -12.03200, 1001.32068-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1544, 477.73889, -11.53200, 1001.32068-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1544, 477.73889, -11.03200, 1001.32068-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1543, 477.73889, -10.53200, 1001.32068-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1543, 477.73889, -10.03200, 1001.32068-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1543, 477.73889, -12.03200, 1001.82068-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1543, 477.73889, -11.53200, 1001.82068-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1544, 477.73889, -10.53200, 1001.82068-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1543, 477.73889, -10.03200, 1001.82068-7.403,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1546, 480.73688, -13.44233, 1000.78174-7.403,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1546, 480.61685, -13.08849, 1000.78174-7.403,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1549, 477.72546, -17.58126, 999.64783-7.403,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(18102, 477.26559, -18.17190, 1001.64838-7.403,   90.00000, 90.00000, 180.00000);
    CreateDynamicObject(1533, 489.39911, -22.86130, 992.23749,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1533, 489.39911, -24.35130, 992.23749,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18755, 493.45871, -26.90600, 994.21472,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(18756, 493.45871, -26.90600, 994.21472,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(18757, 493.45871, -26.90600, 994.21472,   0.00000, 0.00000, -90.00000);


    /* ----> Pickups
    CreatePickup(19133, 1, 1654.2700, -1654.8944, 22.5156, 0); // Vip
    CreatePickup(19133, 1, 648.8630, -1360.6012, 13.5863, 0); // CNN
    CreatePickup(19133, 1, 1464.851318, -1010.793090, 26.843750, 0); // Banco
    CreatePickup(19133, 1, 542.3840, -1293.5125, 17.2422, 0); // Grotti
    
    CreatePickup(19133, 1, 1833.149780, -1842.485717, 13.578125, 0); // 24/7 Unity
    CreatePickup(19133, 1, 1836.4471, -1682.3042, 13.3476, 0); // Alhambra
    CreatePickup(19133, 1, 1315.4854, -897.6839, 39.5781, 0); // 24/7 Vinewood
    CreatePickup(19133, 1, 1352.3815, -1759.2286, 13.5078, 0); // 24/7 Ayuntamiento
    CreatePickup(19133, 1, 2244.3567, -1665.5562, 15.4766, 0); // Binco
    CreatePickup(19133, 1, 1456.4344, -1137.6427, 23.9484, 0); // Zip
    CreatePickup(19133, 1, 499.5753, -1360.6145, 16.3664, 0); // ProLaps
    CreatePickup(19133, 1, 2112.7739, -1211.6287, 23.9631, 0); // SubUrban
    CreatePickup(19133, 1, 597.2778, -1249.4883, 18.3021, 0); // Victim
    CreatePickup(19133, 1, 810.6630, -1616.1554, 13.5469, 0); // Burger Shot
    CreatePickup(19133, 1, 2105.4858, -1806.5336, 13.5547, 0); // Pizzeria
    CreatePickup(19133, 1, 2070.6365, -1793.7847, 13.5469, 0); // Peluquería
    CreatePickup(19133, 1, 2068.5840, -1779.7758, 13.5596, 0); // Tattoo studio
    CreatePickup(19133, 1, 823.9835, -1588.2754, 13.5545, 0); // Peluquería 2
    CreatePickup(19133, 1, 928.7275, -1352.9547, 13.3438, 0); // Clukin' Bells
    CreatePickup(19133, 1, 2421.3159, -1219.6179, 25.5382, 0); // Pig Pen (Prostíbulo)
    CreatePickup(19133, 1, 2310.0977, -1643.5522, 14.8270, 0); // Groove Bar
    CreatePickup(19133, 1, 2229.8601, -1721.4545, 13.5633, 0); // Cantos Gym

    CreatePickup(19133, 1, 1555.142822, -1675.475341, 16.195312, 0); // LSPD
    CreatePickup(19133, 1, 1481.037597, -1771.786376, 18.795755, 0); //Ayuntamiento
     //Alhambra*/
	CreatePickup(19133, 1, 1204.8596, 12.2682, 1000.9991, 0); // Bitch
 	CreatePickup(1212, 1, 1471.842773, -1002.820617, 26.815937, 0); // Banco 1
    CreatePickup(1212, 1, 1463.410522, -1002.820617, 26.815937, 0); // Banco 2
    CreatePickup(1212, 1, 1457.344238, -1002.820617, 26.815937, 0); // Banco 3
    Alhambra_Pick = CreatePickup(0, 1, 481.611053, -10.849586, 1000.679687-7.403, 0);//Alahambra
    CreatePickup(1239, 1, 361.829895, 173.562728, 1008.0, 0);//InfoAyunta
    Conce_Pick1 = CreatePickup(0, 1, 560.660095, -1310.996093, 1996.575927, 0); //Concesionario 1
    Conce_Pick2 = CreatePickup(0, 1, 560.660095, -1313.875244, 1996.575927, 0); //Concesionario 2
    CarWash[0] = CreateDynamicObject(18747, 0, 0, -100, 0, 0, 90);
    CarWash[1] = CreateDynamicObject(18747, 0, 0, -100, 0, 0, 90);
	CarWash[2] = CreateDynamicObject(18687, 0, 0, -100, 0, 0, -90);
    CarWash[3] = CreateDynamicObject(18687, 0, 0, -100, 0, 0, 90);
    CarWash[4] = CreateObject(18707, 0, 0, -100, 0, 0, 0);
    CreateDynamicObject(1250, 1908.84998, -1783.68945, 13.40625,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1239, 1909.45374, -1783.84558, 13.91913,   0.00000, 0.00000, 90.00000);

    
	// ----> Labels
	Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}Victim", 0xFFFFFFFF, 597.2778, -1249.4883, 18.3021, 5.0, 0, 0); // Victim
	Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}Burger Shot", 0xFFFFFFFF, 810.6630, -1616.1554, 13.5469, 5.0, 0, 0); // Burger Shot
	Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}Pizzeria", 0xFFFFFFFF, 2105.4858, -1806.5336, 13.5547, 5.0, 0, 0); // Pizzeria
	Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}Peluquería", 0xFFFFFFFF, 2070.6365, -1793.7847, 13.5469, 5.0, 0, 0); // Peluquería
	Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}Tattoo studio", 0xFFFFFFFF, 2068.5840, -1779.7758, 13.5596, 5.0, 0, 0); // Tattoo studio
	Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}Peluquería 2", 0xFFFFFFFF, 823.9835, -1588.2754, 13.5545, 5.0, 0, 0); // Peluquería 2
	Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}Clukin' Bells", 0xFFFFFFFF, 928.7275, -1352.9547, 13.3438, 5.0, 0, 0); // Clukin' Bells
	Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}Pig Pen (Prostíbulo)", 0xFFFFFFFF, 2421.3159, -1219.6179, 25.5382, 5.0, 0, 0); // Pig Pen (Prostíbulo)
	Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}Groove Bar", 0xFFFFFFFF, 2310.0977, -1643.5522, 14.8270, 5.0, 0, 0); // Groove Bar
	Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}Cantos Gym", 0xFFFFFFFF, 2229.8601, -1721.4545, 13.5633, 5.0, 0, 0); // Cantos Gym
	Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}Lugar V.I.P", 0xFFFFFFFF, 1654.2700, -1654.8944, 22.5156, 5.0, 0, 0); // Vip
    Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}Dept. Noticias", 0xFFFFFFFF, 648.8630, -1360.6012, 13.5863, 5.0, 0, 0); // CNN
    Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}Banco de Los Santos", 0xFFFFFFFF, 1464.851318, -1010.793090, 26.843750, 5.0, 0, 0); // Banco
    Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}Grotti", 0xFFFFFFFF, 542.3840, -1293.5125, 17.2422, 5.0, 0, 0); // Grotti
    Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}Prostitución", 0xFFFFFFFF, 1204.8596, 12.2682, 1000.9991, 5.0, 0, 0); // Bitch
    Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}12/7 Unity", 0xFFFFFFFF, 1833.149780, -1842.485717, 13.578125, 5.0, 0, 0); // 24/7 Unity
    Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}Alhambra", 0xFFFFFFFF, 1836.4471, -1682.3042, 13.3476, 5.0, 0, 0); // Alhambra
    Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}12/7 Vinewood", 0xFFFFFFFF, 1315.4854, -897.6839, 39.5781, 5.0, 0, 0); // 24/7 Vinewood
    Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}12/7 Ayuntamiento", 0xFFFFFFFF, 1352.3815, -1759.2286, 13.5078, 5.0, 0, 0); // 24/7 Ayuntamiento
    Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}Binco", 0xFFFFFFFF, 2244.3567, -1665.5562, 15.4766, 5.0, 0, 0); // Binco
    Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}Zip", 0xFFFFFFFF, 1456.4344, -1137.6427, 23.9484, 5.0, 0, 0); // Zip
    Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}ProLaps", 0xFFFFFFFF, 499.5753, -1360.6145, 16.3664, 5.0, 0, 0); // ProLaps
    Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}SubUrban", 0xFFFFFFFF, 2112.7739, -1211.6287, 23.9631, 5.0, 0, 0); // SubUrban
    Create3DTextLabel("Presiona '{5EFF00}F/INTRO{FFFFFF}' para ser atendido.", 0xFFFFFFFF, 1471.842773, -1002.820617, 26.815937, 1.5, 0, 0); // Banco1
    Create3DTextLabel("Presiona '{5EFF00}F/INTRO{FFFFFF}' para ser atendido.", 0xFFFFFFFF, 1463.410522, -1002.820617, 26.815937, 1.5, 0, 0); // Banco2
    Create3DTextLabel("Presiona '{5EFF00}F/INTRO{FFFFFF}' para ser atendido.", 0xFFFFFFFF, 1457.344238, -1002.820617, 26.815937, 1.5, 0, 0); // Banco3
    Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}LSPD", 0xFFFFFFFF, 1555.142822, -1675.475341, 16.195312, 5.0, 0, 0); // LSPD
    Create3DTextLabel("Presiona '{5EFF00}~k~~VEHICLE_ENTER_EXIT~{FFFFFF}' para entrar.\n{5EFF00}Ayuntamiento", 0xFFFFFFFF, 1481.037597, -1771.786376, 18.795755, 5.0, 0, 0); //Ayuntamiento
    Create3DTextLabel("Presiona '{5EFF00}F/INTRO{FFFFFF}' para ser atendido.", 0xFFFFFFFF, 361.829895, 173.562728, 1008.382812, 1.5, 0, 0); // Info ayunta
    
/*    InventarioTD[0] = TextDrawCreate(486.888549, 109.517761, "usebox");
	TextDrawLetterSize(InventarioTD[0], 0.000000, 22.857652);
	TextDrawTextSize(InventarioTD[0], 162.000076, 0.000000);
	TextDrawAlignment(InventarioTD[0], 1);
	TextDrawColor(InventarioTD[0], 0);
	TextDrawUseBox(InventarioTD[0], true);
	TextDrawBoxColor(InventarioTD[0], 255);
	TextDrawSetShadow(InventarioTD[0], 0);
	TextDrawSetOutline(InventarioTD[0], 0);
	TextDrawFont(InventarioTD[0], 0);

	InventarioTD[1] = TextDrawCreate(483.888458, 112.508880, "usebox");
	TextDrawLetterSize(InventarioTD[1], 0.000000, 22.102088);
	TextDrawTextSize(InventarioTD[1], 164.222290, 0.000000);
	TextDrawAlignment(InventarioTD[1], 1);
	TextDrawColor(InventarioTD[1], 0);
	TextDrawUseBox(InventarioTD[1], true);
	TextDrawBoxColor(InventarioTD[1], -2139062017);
	TextDrawSetShadow(InventarioTD[1], 0);
	TextDrawSetOutline(InventarioTD[1], 0);
	TextDrawFont(InventarioTD[1], 0);

	InventarioTD[2] = TextDrawCreate(179.111099, 121.457748, "Inventario");
	TextDrawLetterSize(InventarioTD[2], 0.449999, 1.600000);
	TextDrawAlignment(InventarioTD[2], 1);
	TextDrawColor(InventarioTD[2], -1);
	TextDrawSetShadow(InventarioTD[2], 0);
	TextDrawSetOutline(InventarioTD[2], 1);
	TextDrawBackgroundColor(InventarioTD[2], 51);
	TextDrawFont(InventarioTD[2], 3);
	TextDrawSetProportional(InventarioTD[2], 1);

	InventarioTD[3] = TextDrawCreate(485.111206, 146.353332, "usebox");
	TextDrawLetterSize(InventarioTD[3], 0.000000, -0.064813);
	TextDrawTextSize(InventarioTD[3], 163.333343, 0.000000);
	TextDrawAlignment(InventarioTD[3], 1);
	TextDrawColor(InventarioTD[3], 0);
	TextDrawUseBox(InventarioTD[3], true);
	TextDrawBoxColor(InventarioTD[3], 255);
	TextDrawSetShadow(InventarioTD[3], 0);
	TextDrawSetOutline(InventarioTD[3], 0);
	TextDrawFont(InventarioTD[3], 0);

	InventarioTD[4] = TextDrawCreate(280.778076, 146.855529, "usebox");
	TextDrawLetterSize(InventarioTD[4], 0.000000, 18.512973);
	TextDrawTextSize(InventarioTD[4], 274.889129, 0.000000);
	TextDrawAlignment(InventarioTD[4], 1);
	TextDrawColor(InventarioTD[4], 0);
	TextDrawUseBox(InventarioTD[4], true);
	TextDrawBoxColor(InventarioTD[4], 255);
	TextDrawSetShadow(InventarioTD[4], 0);
	TextDrawSetOutline(InventarioTD[4], 0);
	TextDrawFont(InventarioTD[4], 0);*/

    //Bank LS
 	Bank[0] = TextDrawCreate(1033.555541, -37.326667, "usebox");
	TextDrawLetterSize(Bank[0], 0.000000, 80.116912);
	TextDrawTextSize(Bank[0], -57.555557, 0.000000);
	TextDrawAlignment(Bank[0], 1);
	TextDrawColor(Bank[0], 0);
	TextDrawUseBox(Bank[0], true);
	TextDrawBoxColor(Bank[0], -1061109505);
	TextDrawSetShadow(Bank[0], 0);
	TextDrawSetOutline(Bank[0], 0);
	TextDrawFont(Bank[0], 0);

	Bank[1] = TextDrawCreate(139.555541, 26.880022, "ld_spac:dark");
	TextDrawLetterSize(Bank[1], 0.000000, 0.000000);
	TextDrawTextSize(Bank[1], 17.333339, 19.413330);
	TextDrawAlignment(Bank[1], 1);
	TextDrawColor(Bank[1], -1);
	TextDrawSetShadow(Bank[1], 0);
	TextDrawSetOutline(Bank[1], 0);
	TextDrawBackgroundColor(Bank[1], -16776961);
	TextDrawFont(Bank[1], 4);

	Bank[2] = TextDrawCreate(160.888946, 24.391101, "BANCO");
	TextDrawLetterSize(Bank[2], 0.459777, 1.659733);
	TextDrawAlignment(Bank[2], 1);
	TextDrawColor(Bank[2], 255);
	TextDrawSetShadow(Bank[2], 0);
	TextDrawSetOutline(Bank[2], 0);
	TextDrawBackgroundColor(Bank[2], 255);
	TextDrawFont(Bank[2], 1);
	TextDrawSetProportional(Bank[2], 1);

	Bank[3] = TextDrawCreate(161.333312, 37.831119, "Los Santos");
	TextDrawLetterSize(Bank[3], 0.281555, 1.127111);
	TextDrawAlignment(Bank[3], 1);
	TextDrawColor(Bank[3], 255);
	TextDrawSetShadow(Bank[3], 0);
	TextDrawSetOutline(Bank[3], 0);
	TextDrawBackgroundColor(Bank[3], 51);
	TextDrawFont(Bank[3], 1);
	TextDrawSetProportional(Bank[3], 1);

	Bank[4] = TextDrawCreate(886.444396, 69.695564, "usebox");
	TextDrawLetterSize(Bank[4], 0.000000, 2.908025);
	TextDrawTextSize(Bank[4], -46.000007, 0.000000);
	TextDrawAlignment(Bank[4], 1);
	TextDrawColor(Bank[4], 0);
	TextDrawUseBox(Bank[4], true);
	TextDrawBoxColor(Bank[4], 255);
	TextDrawSetShadow(Bank[4], 0);
	TextDrawSetOutline(Bank[4], 0);
	TextDrawFont(Bank[4], 0);

	Bank[5] = TextDrawCreate(888.777770, 70.197784, "usebox");
	TextDrawLetterSize(Bank[5], 0.000000, 2.596913);
	TextDrawTextSize(Bank[5], -46.444450, 0.000000);
	TextDrawAlignment(Bank[5], 1);
	TextDrawColor(Bank[5], 0);
	TextDrawUseBox(Bank[5], true);
	TextDrawBoxColor(Bank[5], -1088603905);
	TextDrawSetShadow(Bank[5], 0);
	TextDrawSetOutline(Bank[5], 0);
	TextDrawFont(Bank[5], 0);

	Bank[6] = TextDrawCreate(1236.222045, 99.064437, "usebox");
	TextDrawLetterSize(Bank[6], 0.000000, 70.465545);
	TextDrawTextSize(Bank[6], -47.777774, 0.000000);
	TextDrawAlignment(Bank[6], 1);
	TextDrawColor(Bank[6], 0);
	TextDrawUseBox(Bank[6], true);
	TextDrawBoxColor(Bank[6], 102);
	TextDrawSetShadow(Bank[6], 0);
	TextDrawSetOutline(Bank[6], 0);
	TextDrawFont(Bank[6], 0);

	Bank[7] = TextDrawCreate(518.888793, 100.059989, "usebox");
	TextDrawLetterSize(Bank[7], 0.000000, 49.272464);
	TextDrawTextSize(Bank[7], 121.555618, 0.000000);
	TextDrawAlignment(Bank[7], 1);
	TextDrawColor(Bank[7], 0);
	TextDrawUseBox(Bank[7], true);
	TextDrawBoxColor(Bank[7], -1);
	TextDrawSetShadow(Bank[7], 0);
	TextDrawSetOutline(Bank[7], 0);
	TextDrawFont(Bank[7], 0);

	Bank[8] = TextDrawCreate(506.666778, 115.002258, "usebox");
	TextDrawLetterSize(Bank[8], 0.000000, 22.552461);
	TextDrawTextSize(Bank[8], 134.000091, 0.000000);
	TextDrawAlignment(Bank[8], 1);
	TextDrawColor(Bank[8], 0);
	TextDrawUseBox(Bank[8], true);
	TextDrawBoxColor(Bank[8], -1088603905);
	TextDrawSetShadow(Bank[8], 0);
	TextDrawSetOutline(Bank[8], 0);
	TextDrawFont(Bank[8], 0);

	Bank[9] = TextDrawCreate(409.999664, 190.157760, "usebox");
	TextDrawLetterSize(Bank[9], 0.000000, 8.200865);
	TextDrawTextSize(Bank[9], 227.333374, 0.000000);
	TextDrawAlignment(Bank[9], 1);
	TextDrawColor(Bank[9], 0);
	TextDrawUseBox(Bank[9], true);
	TextDrawBoxColor(Bank[9], -1);
	TextDrawSetShadow(Bank[9], 0);
	TextDrawSetOutline(Bank[9], 0);
	TextDrawFont(Bank[9], 0);

	Bank[10] = TextDrawCreate(163.111129, 139.377822, "Por favor, introduzca su numero de identificacion personal");
	TextDrawLetterSize(Bank[10], 0.317111, 1.286398);
	TextDrawAlignment(Bank[10], 1);
	TextDrawColor(Bank[10], -1);
	TextDrawSetShadow(Bank[10], 0);
	TextDrawSetOutline(Bank[10], 0);
	TextDrawBackgroundColor(Bank[10], 51);
	TextDrawFont(Bank[10], 1);
	TextDrawSetProportional(Bank[10], 1);

	Bank[11] = TextDrawCreate(238.777770, 212.057785, "ld_spac:dark");
	TextDrawLetterSize(Bank[11], 0.000000, 0.000000);
	TextDrawTextSize(Bank[11], 26.222229, 31.857786);
	TextDrawAlignment(Bank[11], 1);
	TextDrawColor(Bank[11], -1);
	TextDrawSetShadow(Bank[11], 0);
	TextDrawSetOutline(Bank[11], 0);
	TextDrawBackgroundColor(Bank[11], -16776961);
	TextDrawFont(Bank[11], 4);

	Bank[12] = TextDrawCreate(278.889068, 212.062240, "ld_spac:dark");
	TextDrawLetterSize(Bank[12], 0.000000, 0.000000);
	TextDrawTextSize(Bank[12], 26.222229, 31.857786);
	TextDrawAlignment(Bank[12], 1);
	TextDrawColor(Bank[12], -1);
	TextDrawSetShadow(Bank[12], 0);
	TextDrawSetOutline(Bank[12], 0);
	TextDrawBackgroundColor(Bank[12], -16776961);
	TextDrawFont(Bank[12], 4);

	Bank[13] = TextDrawCreate(321.666809, 213.062240, "ld_spac:dark");
	TextDrawLetterSize(Bank[13], 0.000000, 0.000000);
	TextDrawTextSize(Bank[13], 26.222229, 31.857786);
	TextDrawAlignment(Bank[13], 1);
	TextDrawColor(Bank[13], -1);
	TextDrawSetShadow(Bank[13], 0);
	TextDrawSetOutline(Bank[13], 0);
	TextDrawBackgroundColor(Bank[13], -16776961);
	TextDrawFont(Bank[13], 4);

	Bank[14] = TextDrawCreate(364.000122, 212.568908, "ld_spac:dark");
	TextDrawLetterSize(Bank[14], 0.000000, 0.000000);
	TextDrawTextSize(Bank[14], 26.222229, 31.857786);
	TextDrawAlignment(Bank[14], 1);
	TextDrawColor(Bank[14], -1);
	TextDrawSetShadow(Bank[14], 0);
	TextDrawSetOutline(Bank[14], 0);
	TextDrawBackgroundColor(Bank[14], -16776961);
	TextDrawFont(Bank[14], 4);

	Bank[15] = TextDrawCreate(259.111083, 117.475532, "Elija un servicio");
	TextDrawLetterSize(Bank[15], 0.449999, 1.600000);
	TextDrawAlignment(Bank[15], 1);
	TextDrawColor(Bank[15], 255);
	TextDrawSetShadow(Bank[15], 0);
	TextDrawSetOutline(Bank[15], 0);
	TextDrawBackgroundColor(Bank[15], 51);
	TextDrawFont(Bank[15], 1);
	TextDrawSetProportional(Bank[15], 1);

	Bank[16] = TextDrawCreate(315.0, 145.357772, "usebox");
	TextDrawLetterSize(Bank[16], 0.000000, 4.381600);
	TextDrawTextSize(Bank[16], 50.0, 175.0);
	TextDrawAlignment(Bank[16], 2);
	TextDrawColor(Bank[16], 0);
	TextDrawUseBox(Bank[16], true);
	TextDrawBoxColor(Bank[16], -1205847297);
	TextDrawSetShadow(Bank[16], 0);
	TextDrawSetOutline(Bank[16], 0);
	TextDrawFont(Bank[16], 0);
	TextDrawSetSelectable(Bank[16], true);

	Bank[17] = TextDrawCreate(315.0, 201.113067, "usebox");
	TextDrawLetterSize(Bank[17], 0.000000, 4.381600);
	TextDrawTextSize(Bank[17], 50.0, 175.0);
	TextDrawAlignment(Bank[17], 2);
	TextDrawColor(Bank[17], 0);
	TextDrawUseBox(Bank[17], true);
	TextDrawBoxColor(Bank[17], -1205847297);
	TextDrawSetShadow(Bank[17], 0);
	TextDrawSetOutline(Bank[17], 0);
	TextDrawFont(Bank[17], 0);
	TextDrawSetSelectable(Bank[17], true);

	Bank[18] = TextDrawCreate(315.0, 257.863952, "usebox");
	TextDrawLetterSize(Bank[18], 0.000000, 4.381600);
	TextDrawTextSize(Bank[18], 50.0, 175.0);
	TextDrawAlignment(Bank[18], 2);
	TextDrawColor(Bank[18], 0);
	TextDrawUseBox(Bank[18], true);
	TextDrawBoxColor(Bank[18], -1205847297);
	TextDrawSetShadow(Bank[18], 0);
	TextDrawSetOutline(Bank[18], 0);
	TextDrawFont(Bank[18], 0);
	TextDrawSetSelectable(Bank[18], true);

	Bank[19] = TextDrawCreate(314.666900, 155.306671, "Retirar~n~~n~~n~~n~Depositar~n~~n~~n~~n~Salir");
	TextDrawLetterSize(Bank[19], 0.449999, 1.600000);
	TextDrawAlignment(Bank[19], 2);
	TextDrawColor(Bank[19], -1);
	TextDrawSetShadow(Bank[19], 0);
	TextDrawSetOutline(Bank[19], 0);
	TextDrawBackgroundColor(Bank[19], 51);
	TextDrawFont(Bank[19], 1);
	TextDrawSetProportional(Bank[19], 1);
    //UserBox
	UserBox[0] = TextDrawCreate(513.999816, 118.975563, "usebox");
	TextDrawLetterSize(UserBox[0], 0.000000, 23.797899);
	TextDrawTextSize(UserBox[0], 125.111122, 0.000000);
	TextDrawAlignment(UserBox[0], 1);
	TextDrawColor(UserBox[0], 0);
	TextDrawUseBox(UserBox[0], true);
	TextDrawBoxColor(UserBox[0], -2139062142);
	TextDrawSetShadow(UserBox[0], 0);
	TextDrawSetOutline(UserBox[0], 0);
	TextDrawFont(UserBox[0], 0);

	UserBox[1] = TextDrawCreate(508.777557, 124.953330, "usebox");
	TextDrawLetterSize(UserBox[1], 0.000000, 22.420114);
	TextDrawTextSize(UserBox[1], 130.000015, 0.000000);
	TextDrawAlignment(UserBox[1], 1);
	TextDrawColor(UserBox[1], 0);
	TextDrawUseBox(UserBox[1], true);
	TextDrawBoxColor(UserBox[1], 20223);
	TextDrawSetShadow(UserBox[1], 0);
	TextDrawSetOutline(UserBox[1], 0);
	TextDrawFont(UserBox[1], 0);

	UserBox[2] = TextDrawCreate(507.777770, 160.291107, "usebox");
	TextDrawLetterSize(UserBox[2], 0.000000, 18.333211);
	TextDrawTextSize(UserBox[2], 130.888885, 0.000000);
	TextDrawAlignment(UserBox[2], 1);
	TextDrawColor(UserBox[2], 0);
	TextDrawUseBox(UserBox[2], true);
	TextDrawBoxColor(UserBox[2], -1378294167);
	TextDrawSetShadow(UserBox[2], 0);
	TextDrawSetOutline(UserBox[2], 0);
	TextDrawFont(UserBox[2], 0);

	UserBox[3] = TextDrawCreate(276.000030, 297.671142, "eXtreme Roleplay");
	TextDrawLetterSize(UserBox[3], 0.449999, 1.600000);
	TextDrawAlignment(UserBox[3], 1);
	TextDrawColor(UserBox[3], -1);
	TextDrawSetShadow(UserBox[3], 0);
	TextDrawSetOutline(UserBox[3], 1);
	TextDrawBackgroundColor(UserBox[3], 51);
	TextDrawFont(UserBox[3], 0);
	TextDrawSetProportional(UserBox[3], 1);
    //Circular menu
 	CircularMenu[0] = TextDrawCreate(241.888824, 121.872619, "hud:radardisc");
	TextDrawLetterSize(CircularMenu[0], 0.000000, 0.000000);
	TextDrawTextSize(CircularMenu[0], 80.000000, 80.000000);
	TextDrawAlignment(CircularMenu[0], 1);
	TextDrawFont(CircularMenu[0], 4);

	CircularMenu[1] = TextDrawCreate(401.111236, 121.872619, "hud:radardisc");
	TextDrawLetterSize(CircularMenu[1], 0.000000, 0.000000);
	TextDrawAlignment(CircularMenu[1], 1);
	TextDrawTextSize(CircularMenu[1], -80.000000, 80.000000);
	TextDrawFont(CircularMenu[1], 4);

	CircularMenu[2] = TextDrawCreate(401.111236, 281.668060, "hud:radardisc");
	TextDrawLetterSize(CircularMenu[2], 0.000000, 0.000000);
	TextDrawTextSize(CircularMenu[2], -80.000000, -80.000000);
	TextDrawAlignment(CircularMenu[2], 1);
	TextDrawFont(CircularMenu[2], 4);

	CircularMenu[3] = TextDrawCreate(241.888824, 281.668060, "hud:radardisc");
	TextDrawLetterSize(CircularMenu[3], 0.000000, 0.000000);
	TextDrawAlignment(CircularMenu[3], 1);
	TextDrawTextSize(CircularMenu[3], 80.000000, -80.000000);
	TextDrawFont(CircularMenu[3], 4);

	CircularMenu[4] = TextDrawCreate(305.777832, 110.008880, "hud:radar_gangB");
	TextDrawLetterSize(CircularMenu[4], 0.000000, 0.000000);
	TextDrawTextSize(CircularMenu[4], 31.555561, 27.377786);
	TextDrawAlignment(CircularMenu[4], 2);
	TextDrawColor(CircularMenu[4], -1);
	TextDrawSetShadow(CircularMenu[4], 0);
	TextDrawSetOutline(CircularMenu[4], 0);
	TextDrawFont(CircularMenu[4], 4);

	CircularMenu[5] = TextDrawCreate(380.555694, 191.648803, "hud:radar_qmark");
	TextDrawLetterSize(CircularMenu[5], 0.000000, 0.000000);
	TextDrawTextSize(CircularMenu[5], 31.555561, 27.377786);
	TextDrawAlignment(CircularMenu[5], 2);
	TextDrawColor(CircularMenu[5], -1);
	TextDrawSetShadow(CircularMenu[5], 0);
	TextDrawSetOutline(CircularMenu[5], 0);
	TextDrawFont(CircularMenu[5], 4);

	CircularMenu[6] = TextDrawCreate(305.777832, 262.337768, "hud:radar_truck");
	TextDrawLetterSize(CircularMenu[6], 0.000000, 0.000000);
	TextDrawTextSize(CircularMenu[6], 31.555561, 27.377786);
	TextDrawAlignment(CircularMenu[6], 2);
	TextDrawColor(CircularMenu[6], -1);
	TextDrawSetShadow(CircularMenu[6], 0);
	TextDrawSetOutline(CircularMenu[6], 0);
	TextDrawFont(CircularMenu[6], 4);

	CircularMenu[7] = TextDrawCreate(232.777938, 191.648803, "hud:radar_catalinapink");
	TextDrawLetterSize(CircularMenu[7], 0.000000, 0.000000);
	TextDrawTextSize(CircularMenu[7], 31.555561, 27.377786);
	TextDrawAlignment(CircularMenu[7], 2);
	TextDrawColor(CircularMenu[7], -1);
	TextDrawSetShadow(CircularMenu[7], 0);
	TextDrawSetOutline(CircularMenu[7], 0);
	TextDrawFont(CircularMenu[7], 4);

	CircularMenu[8] = TextDrawCreate(322.666900, 115.982307, "_~n~Cuenta");
	TextDrawLetterSize(CircularMenu[8], 0.449999, 1.600000);
	TextDrawAlignment(CircularMenu[8], 2);
	TextDrawColor(CircularMenu[8], -256);
	TextDrawSetShadow(CircularMenu[8], 0);
	TextDrawFont(CircularMenu[8], 1);
	TextDrawSetProportional(CircularMenu[8], 1);
	TextDrawTextSize(CircularMenu[8], 40, 40);
	TextDrawSetSelectable(CircularMenu[8], true);

	CircularMenu[9] = TextDrawCreate(395.222534, 197.124511, "_~n~Info");
	TextDrawLetterSize(CircularMenu[9], 0.449999, 1.600000);
	TextDrawAlignment(CircularMenu[9], 2);
	TextDrawColor(CircularMenu[9], -256);
	TextDrawSetShadow(CircularMenu[9], 0);
	TextDrawFont(CircularMenu[9], 1);
	TextDrawSetProportional(CircularMenu[9], 1);
	TextDrawTextSize(CircularMenu[9], 40, 40);
	TextDrawSetSelectable(CircularMenu[9], true);

	CircularMenu[10] = TextDrawCreate(322.666900, 267.315643, "_~n~Trabajo");
	TextDrawLetterSize(CircularMenu[10], 0.449999, 1.600000);
	TextDrawAlignment(CircularMenu[10], 2);
	TextDrawColor(CircularMenu[10], -256);
	TextDrawSetShadow(CircularMenu[10], 0);
	TextDrawFont(CircularMenu[10], 1);
	TextDrawSetProportional(CircularMenu[10], 1);
	TextDrawTextSize(CircularMenu[10], 40, 40);
	TextDrawSetSelectable(CircularMenu[10], true);

	CircularMenu[11] = TextDrawCreate(248.778030, 197.124511, "_~n~Comandos");
	TextDrawLetterSize(CircularMenu[11], 0.449999, 1.600000);
	TextDrawAlignment(CircularMenu[11], 2);
	TextDrawColor(CircularMenu[11], -256);
	TextDrawSetShadow(CircularMenu[11], 0);
	TextDrawFont(CircularMenu[11], 1);
	TextDrawSetProportional(CircularMenu[11], 1);
	TextDrawTextSize(CircularMenu[11], 40, 40);
	TextDrawSetSelectable(CircularMenu[11], true);
	
	//big logo
	TD_EY[0] = TextDrawCreate(129.333374, 80.142257, "e__treme~n~___Roleplay");
	TextDrawLetterSize(TD_EY[0], 1.964222, 7.279643);
	TextDrawAlignment(TD_EY[0], 1);
	TextDrawColor(TD_EY[0], -1);
	TextDrawSetShadow(TD_EY[0], 0);
	TextDrawSetOutline(TD_EY[0], 3);
	TextDrawBackgroundColor(TD_EY[0], 255);
	TextDrawFont(TD_EY[0], 3);
	TextDrawSetProportional(TD_EY[0], 1);

	TD_EY[1] = TextDrawCreate(173.000076, 25.888900, "X");
	TextDrawLetterSize(TD_EY[1], 3.931333, 13.850309);
	TextDrawAlignment(TD_EY[1], 1);
	TextDrawColor(TD_EY[1], -1);
	TextDrawSetShadow(TD_EY[1], 0);
	TextDrawSetOutline(TD_EY[1], 3);
	TextDrawBackgroundColor(TD_EY[1], 255);
	TextDrawFont(TD_EY[1], 3);
	TextDrawSetProportional(TD_EY[1], 1);
	
	TD_EY[2] = TextDrawCreate(173.000076, 25.888900, "_");
	TextDrawLetterSize(TD_EY[2], 3.931333, 13.850309);
	TextDrawAlignment(TD_EY[2], 1);
	TextDrawColor(TD_EY[2], -1);
	TextDrawSetShadow(TD_EY[2], 0);
	TextDrawSetOutline(TD_EY[2], 3);
	TextDrawBackgroundColor(TD_EY[2], 255);
	TextDrawFont(TD_EY[2], 3);
	TextDrawSetProportional(TD_EY[2], 1);
	
	//NotificationTD
	TD_NN = TextDrawCreate(158.444503, 36.344409, "usebox");
	TextDrawLetterSize(TD_NN, 0.000000, 7.737652);
	TextDrawTextSize(TD_NN, 9.999992, 0.000000);
	TextDrawAlignment(TD_NN, 1);
	TextDrawColor(TD_NN, 0);
	TextDrawUseBox(TD_NN, true);
	TextDrawBoxColor(TD_NN, 160);
	TextDrawSetShadow(TD_NN, 0);
	TextDrawSetOutline(TD_NN, 0);
	TextDrawFont(TD_NN, 0);
	
	/*RegistroTD
	TD_RO[0] = TextDrawCreate(399.5, 83.139968, "usebox");
	TextDrawLetterSize(TD_RO[0], 0.000000, 32.4);
	TextDrawTextSize(TD_RO[0], 230.888916, 0.000000);
	TextDrawAlignment(TD_RO[0], 1);
	TextDrawColor(TD_RO[0], 0);
	TextDrawUseBox(TD_RO[0], true);
	TextDrawBoxColor(TD_RO[0], -2139062017);
	TextDrawSetShadow(TD_RO[0], 0);
	TextDrawSetOutline(TD_RO[0], 0);
	TextDrawFont(TD_RO[0], 0);

	TD_RO[1] = TextDrawCreate(396.666717, 85.624435, "usebox");
	TextDrawLetterSize(TD_RO[1], 0.000000, 31.817655);
	TextDrawTextSize(TD_RO[1], 233.555572, 0.000000);
	TextDrawAlignment(TD_RO[1], 1);
	TextDrawColor(TD_RO[1], 0);
	TextDrawUseBox(TD_RO[1], true);
	TextDrawBoxColor(TD_RO[1], 255);
	TextDrawSetShadow(TD_RO[1], 0);
	TextDrawSetOutline(TD_RO[1], 0);
	TextDrawFont(TD_RO[1], 0);

	TD_RO[2] = TextDrawCreate(248.000015, 104.035499, "nombre y apellido");
	TextDrawLetterSize(TD_RO[2], 0.344666, 1.331199);
	TextDrawAlignment(TD_RO[2], 1);
	TextDrawColor(TD_RO[2], -5963521);
	TextDrawSetShadow(TD_RO[2], 0);
	TextDrawSetOutline(TD_RO[2], 1);
	TextDrawBackgroundColor(TD_RO[2], 51);
	TextDrawFont(TD_RO[2], 3);
	TextDrawSetProportional(TD_RO[2], 1);

	TD_RO[3] = TextDrawCreate(248.111129, 160.786544, "correo electronico");
	TextDrawLetterSize(TD_RO[3], 0.344666, 1.331199);
	TextDrawAlignment(TD_RO[3], 1);
	TextDrawColor(TD_RO[3], -5963521);
	TextDrawSetShadow(TD_RO[3], 0);
	TextDrawSetOutline(TD_RO[3], 1);
	TextDrawBackgroundColor(TD_RO[3], 51);
	TextDrawFont(TD_RO[3], 3);
	TextDrawSetProportional(TD_RO[3], 1);

	TD_RO[4] = TextDrawCreate(248.222244, 216.541976, "genero");
	TextDrawLetterSize(TD_RO[4], 0.344666, 1.331199);
	TextDrawAlignment(TD_RO[4], 1);
	TextDrawColor(TD_RO[4], -5963521);
	TextDrawSetShadow(TD_RO[4], 0);
	TextDrawSetOutline(TD_RO[4], 1);
	TextDrawBackgroundColor(TD_RO[4], 51);
	TextDrawFont(TD_RO[4], 3);
	TextDrawSetProportional(TD_RO[4], 1);

	TD_RO[5] = TextDrawCreate(248.777801, 273.293090, "edad");
	TextDrawLetterSize(TD_RO[5], 0.344666, 1.331199);
	TextDrawAlignment(TD_RO[5], 1);
	TextDrawColor(TD_RO[5], -5963521);
	TextDrawSetShadow(TD_RO[5], 0);
	TextDrawSetOutline(TD_RO[5], 1);
	TextDrawBackgroundColor(TD_RO[5], 51);
	TextDrawFont(TD_RO[5], 3);
	TextDrawSetProportional(TD_RO[5], 1);

	TD_RO[6] = TextDrawCreate(368.0, 332.024444, "usebox");
	TextDrawLetterSize(TD_RO[6], 0.000000, 2.2);
	TextDrawTextSize(TD_RO[6], 261.555511, 0.000000);
	TextDrawAlignment(TD_RO[6], 1);
	TextDrawColor(TD_RO[6], 0);
	TextDrawUseBox(TD_RO[6], true);
	TextDrawBoxColor(TD_RO[6], -2139062017);
	TextDrawSetShadow(TD_RO[6], 0);
	TextDrawSetOutline(TD_RO[6], 0);
	TextDrawFont(TD_RO[6], 0);

	TD_RO[7] = TextDrawCreate(315.000061, 333.026641, "continuar");
	TextDrawLetterSize(TD_RO[7], 0.576663, 1.968353);
	TextDrawTextSize(TD_RO[7], 20.0, 97.0);
	TextDrawAlignment(TD_RO[7], 2);
	TextDrawColor(TD_RO[7], -5963521);
	TextDrawUseBox(TD_RO[7], true);
	TextDrawBoxColor(TD_RO[7], 255);
	TextDrawSetShadow(TD_RO[7], 0);
	TextDrawSetOutline(TD_RO[7], 0);
	TextDrawBackgroundColor(TD_RO[7], -65281);
	TextDrawFont(TD_RO[7], 3);
	TextDrawSetProportional(TD_RO[7], 1);
	TextDrawSetSelectable(TD_RO[7], true);
	
	TD_RO[8] = TextDrawCreate(292.888397, 271.289093, "+");
	TextDrawLetterSize(TD_RO[8], 0.449999, 1.600000);
	TextDrawAlignment(TD_RO[8], 2);
	TextDrawColor(TD_RO[8], -1);
	TextDrawSetShadow(TD_RO[8], 0);
	TextDrawSetOutline(TD_RO[8], 1);
	TextDrawBackgroundColor(TD_RO[8], 51);
	TextDrawFont(TD_RO[8], 1);
	TextDrawSetProportional(TD_RO[8], 1);
	TextDrawTextSize(TD_RO[8], 15, 15);
	TextDrawSetSelectable(TD_RO[8], true);

	TD_RO[12] = TextDrawCreate(280.999633, 269.800170, "-");
	TextDrawLetterSize(TD_RO[12], 0.449999, 1.600000);
	TextDrawAlignment(TD_RO[12], 2);
	TextDrawColor(TD_RO[12], -1);
	TextDrawSetShadow(TD_RO[12], 0);
	TextDrawSetOutline(TD_RO[12], 1);
	TextDrawBackgroundColor(TD_RO[12], 51);
	TextDrawFont(TD_RO[12], 1);
	TextDrawSetProportional(TD_RO[12], 1);
	TextDrawTextSize(TD_RO[12], 15, 15);
	TextDrawSetSelectable(TD_RO[12], true);


	TD_RO[9] = TextDrawCreate(314.777770, 174.226654, "_");
	TextDrawLetterSize(TD_RO[9], 0.458888, 3.128177);
	TextDrawTextSize(TD_RO[9], 19.111114, 142.862075);
	TextDrawAlignment(TD_RO[9], 2);
	TextDrawColor(TD_RO[9], -1);
	TextDrawUseBox(TD_RO[9], true);
	TextDrawBoxColor(TD_RO[9], 255);
	TextDrawSetShadow(TD_RO[9], 0);
	TextDrawSetOutline(TD_RO[9], 1);
	TextDrawBackgroundColor(TD_RO[9], 51);
	TextDrawFont(TD_RO[9], 1);
	TextDrawSetProportional(TD_RO[9], 1);
	TextDrawSetSelectable(TD_RO[9], true);

	TD_RO[10] = TextDrawCreate(313.555572, 230.977691, "_");
	TextDrawLetterSize(TD_RO[10], 0.458888, 3.128177);
	TextDrawTextSize(TD_RO[10], 19.111114, 142.862075);
	TextDrawAlignment(TD_RO[10], 2);
	TextDrawColor(TD_RO[10], -1);
	TextDrawUseBox(TD_RO[10], true);
	TextDrawBoxColor(TD_RO[10], 255);
	TextDrawSetShadow(TD_RO[10], 0);
	TextDrawSetOutline(TD_RO[10], 1);
	TextDrawBackgroundColor(TD_RO[10], 51);
	TextDrawFont(TD_RO[10], 1);
	TextDrawSetProportional(TD_RO[10], 1);
	TextDrawSetSelectable(TD_RO[10], true);

	TD_RO[11] = TextDrawCreate(314.111053, 288.724304, "_");
	TextDrawLetterSize(TD_RO[11], 0.458888, 3.128177);
	TextDrawTextSize(TD_RO[11], 19.111114, 142.862075);
	TextDrawAlignment(TD_RO[11], 2);
	TextDrawColor(TD_RO[11], -1);
	TextDrawUseBox(TD_RO[11], true);
	TextDrawBoxColor(TD_RO[11], 255);
	TextDrawSetShadow(TD_RO[11], 0);
	TextDrawSetOutline(TD_RO[11], 1);
	TextDrawBackgroundColor(TD_RO[11], 51);
	TextDrawFont(TD_RO[11], 1);
	TextDrawSetProportional(TD_RO[11], 1);
	TextDrawSetSelectable(TD_RO[11], true);*/
	
	// Box
	TD_BX[0] = TextDrawCreate(1086.000488, -26.375560, "usebox");
	TextDrawLetterSize(TD_BX[0], 0.000000, 15.096668);
	TextDrawTextSize(TD_BX[0], -69.555564, 0.000000);
	TextDrawAlignment(TD_BX[0], 1);
	TextDrawColor(TD_BX[0], 0);
	TextDrawUseBox(TD_BX[0], true);
	TextDrawBoxColor(TD_BX[0], 255);
	TextDrawSetShadow(TD_BX[0], 0);
	TextDrawSetOutline(TD_BX[0], 0);
	TextDrawFont(TD_BX[0], 0);

	TD_BX[1] = TextDrawCreate(1076.778076, 336.508941, "usebox");
	TextDrawLetterSize(TD_BX[1], 0.000000, 15.096668);
	TextDrawTextSize(TD_BX[1], -79.777755, 0.000000);
	TextDrawAlignment(TD_BX[1], 1);
	TextDrawColor(TD_BX[1], 0);
	TextDrawUseBox(TD_BX[1], true);
	TextDrawBoxColor(TD_BX[1], 255);
	TextDrawSetShadow(TD_BX[1], 0);
	TextDrawSetOutline(TD_BX[1], 0);
	TextDrawFont(TD_BX[1], 0);
	
	
	DeadTD[0] = TextDrawCreate(-2.000000, -1.000000, "ld_dual:tvcorn");
	TextDrawBackgroundColor(DeadTD[0], 255);
	TextDrawFont(DeadTD[0], 4);
	TextDrawLetterSize(DeadTD[0], 0.500000, 1.000000);
	TextDrawColor(DeadTD[0], -16776961);
	TextDrawSetOutline(DeadTD[0], 0);
	TextDrawSetProportional(DeadTD[0], 1);
	TextDrawSetShadow(DeadTD[0], 1);
	TextDrawUseBox(DeadTD[0], 1);
	TextDrawBoxColor(DeadTD[0], 255);
	TextDrawTextSize(DeadTD[0], 50.000000, 50.000000);
	TextDrawSetSelectable(DeadTD[0], 0);

	DeadTD[1] = TextDrawCreate(-2.000000, 449.000000, "ld_dual:tvcorn");
	TextDrawBackgroundColor(DeadTD[1], 255);
	TextDrawFont(DeadTD[1], 1);
	TextDrawLetterSize(DeadTD[1], 0.500000, 1.000000);
	TextDrawColor(DeadTD[1], -1);
	TextDrawSetOutline(DeadTD[1], 0);
	TextDrawSetProportional(DeadTD[1], 1);
	TextDrawSetShadow(DeadTD[1], 1);
	TextDrawUseBox(DeadTD[1], 1);
	TextDrawBoxColor(DeadTD[1], 255);
	TextDrawTextSize(DeadTD[1], 50.000000, -50.000000);
	TextDrawSetSelectable(DeadTD[1], 0);

	DeadTD[2] = TextDrawCreate(643.000000, 450.000000, "ld_dual:tvcorn");
	TextDrawBackgroundColor(DeadTD[2], 255);
	TextDrawFont(DeadTD[2], 4);
	TextDrawLetterSize(DeadTD[2], 0.500000, 1.000000);
	TextDrawColor(DeadTD[2], -16776961);
	TextDrawSetOutline(DeadTD[2], 0);
	TextDrawSetProportional(DeadTD[2], 1);
	TextDrawSetShadow(DeadTD[2], 1);
	TextDrawUseBox(DeadTD[2], 1);
	TextDrawBoxColor(DeadTD[2], 255);
	TextDrawTextSize(DeadTD[2], -50.000000, -50.000000);
	TextDrawSetSelectable(DeadTD[2], 0);

	DeadTD[3] = TextDrawCreate(641.000000, -2.000000, "ld_dual:tvcorn");
	TextDrawBackgroundColor(DeadTD[3], 255);
	TextDrawFont(DeadTD[3], 4);
	TextDrawLetterSize(DeadTD[3], 0.500000, 1.000000);
	TextDrawColor(DeadTD[3], -16776961);
	TextDrawSetOutline(DeadTD[3], 0);
	TextDrawSetProportional(DeadTD[3], 1);
	TextDrawSetShadow(DeadTD[3], 1);
	TextDrawUseBox(DeadTD[3], 1);
	TextDrawBoxColor(DeadTD[3], 255);
	TextDrawTextSize(DeadTD[3], -50.000000, 50.000000);
	TextDrawSetSelectable(DeadTD[3], 0);

	DeadTD[4] = TextDrawCreate(-48.000000, 39.000000, "ld_dual:health");
	TextDrawBackgroundColor(DeadTD[4], 255);
	TextDrawFont(DeadTD[4], 4);
	TextDrawLetterSize(DeadTD[4], 0.500000, 1.000000);
	TextDrawColor(DeadTD[4], 1259936255);
	TextDrawSetOutline(DeadTD[4], 0);
	TextDrawSetProportional(DeadTD[4], 1);
	TextDrawSetShadow(DeadTD[4], 1);
	TextDrawUseBox(DeadTD[4], 1);
	TextDrawBoxColor(DeadTD[4], 255);
	TextDrawTextSize(DeadTD[4], 50.000000, 460.000000);
	TextDrawSetSelectable(DeadTD[4], 0);

	DeadTD[5] = TextDrawCreate(44.000000, -21.000000, "ld_dual:health");
	TextDrawBackgroundColor(DeadTD[5], 255);
	TextDrawFont(DeadTD[5], 4);
	TextDrawLetterSize(DeadTD[5], 0.500000, 1.000000);
	TextDrawColor(DeadTD[5], 1259936255);
	TextDrawSetOutline(DeadTD[5], 0);
	TextDrawSetProportional(DeadTD[5], 1);
	TextDrawSetShadow(DeadTD[5], 1);
	TextDrawUseBox(DeadTD[5], 1);
	TextDrawBoxColor(DeadTD[5], 255);
	TextDrawTextSize(DeadTD[5], 578.000000, 24.000000);
	TextDrawSetSelectable(DeadTD[5], 0);

	DeadTD[6] = TextDrawCreate(44.000000, 445.000000, "ld_dual:health");
	TextDrawBackgroundColor(DeadTD[6], 255);
	TextDrawFont(DeadTD[6], 4);
	TextDrawLetterSize(DeadTD[6], 0.500000, 1.000000);
	TextDrawColor(DeadTD[6], 1259936255);
	TextDrawSetOutline(DeadTD[6], 0);
	TextDrawSetProportional(DeadTD[6], 1);
	TextDrawSetShadow(DeadTD[6], 1);
	TextDrawUseBox(DeadTD[6], 1);
	TextDrawBoxColor(DeadTD[6], 255);
	TextDrawTextSize(DeadTD[6], 578.000000, 24.000000);
	TextDrawSetSelectable(DeadTD[6], 0);

	DeadTD[7] = TextDrawCreate(637.000000, 39.000000, "ld_dual:health");
	TextDrawBackgroundColor(DeadTD[7], 255);
	TextDrawFont(DeadTD[7], 4);
	TextDrawLetterSize(DeadTD[7], 0.500000, 1.000000);
	TextDrawColor(DeadTD[7], 1259936255);
	TextDrawSetOutline(DeadTD[7], 0);
	TextDrawSetProportional(DeadTD[7], 1);
	TextDrawSetShadow(DeadTD[7], 1);
	TextDrawUseBox(DeadTD[7], 1);
	TextDrawBoxColor(DeadTD[7], 255);
	TextDrawTextSize(DeadTD[7], 50.000000, 460.000000);
	TextDrawSetSelectable(DeadTD[7], 0);
	
	// ------------> Objetos
	Dude_Object[0] = CreateObject(1378, -1723.57813, 188.92191, 27.03130,   0.00000, 0.00000, -90.00000);
	Dude_Object[1] = CreateObject(1376, -1728.91406, 188.90630, 22.51560,   0.00000, 0.00000, -90.00000);
	Dude_Object[2] = CreateObject(1386, -1728.91406, 188.90630, 35.74220,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2932, -1730.94312, 173.99323, 5.21877,   0.00000, 0.00000, 0.00000);

	//SAPD
	LSPD_OBJECT[26] = CreateObject(19370, 1576.6994, -1677.4489, 1995.7229, 0.0000, 0.0000, 180.0);
	SetObjectMaterialText(LSPD_OBJECT[26], "LSPD", 0, 140, "Verdana", 215, 1, -1, 0, 1);
	
	LSPD_OBJECT[0] = CreateObject(18981, 1556.44995, -1663.09998, 2000.00000,   0.00000, 0.00000, 0.00000);
	LSPD_OBJECT[1] = CreateObject(18981, 1556.46997, -1688.09998, 2000.00000,   0.00000, 0.00000, 0.00000);
	LSPD_OBJECT[2] = CreateObject(18981, 1577.12000, -1701.88000, 2000.00000,   0.00000, 0.00000, 0.00000);
	LSPD_OBJECT[3] = CreateObject(18981, 1577.12000, -1676.88000, 2000.00000,   0.00000, 0.00000, 0.00000);
	LSPD_OBJECT[4] = CreateObject(18981, 1576.95996, -1651.87000, 2000.00000,   0.00000, 0.00000, 0.00000);
	LSPD_OBJECT[5] = CreateObject(18981, 1565.05005, -1637.39001, 2000.00000,   0.00000, 0.00000, 90.00000);
	LSPD_OBJECT[6] = CreateObject(18981, 1543.07996, -1642.81006, 2000.00000,   0.00000, 0.00000, 0.00000);
	LSPD_OBJECT[7] = CreateObject(18981, 1544.05005, -1651.09998, 2000.00000,   0.00000, 0.00000, 90.00000);
	LSPD_OBJECT[8] = CreateObject(18981, 1543.98999, -1700.06006, 2000.00000,   0.00000, 0.00000, 90.00000);
	LSPD_OBJECT[9] = CreateObject(18981, 1564.21997, -1713.90002, 2000.00000,   0.00000, 0.00000, 90.00000);
	LSPD_OBJECT[10] = CreateObject(18981, 1539.21997, -1713.90002, 2000.00000,   0.00000, 0.00000, 90.00000);
	LSPD_OBJECT[11] = CreateObject(18981, 1576.95996, -1626.88000, 2000.00000,   0.00000, 0.00000, 0.00000);
	LSPD_OBJECT[12] = CreateObject(18981, 1540.05005, -1637.39001, 2000.00000,   0.00000, 0.00000, 90.00000);
	LSPD_OBJECT[13] = CreateObject(18981, 1544.54004, -1708.34998, 2000.00000,   0.00000, 0.00000, 0.00000);

	LSPD_OBJECT[14] = CreateObject(18981, 1567.47998, -1696.09998, 1989.04004,   0.00000, 90.00000, 0.00000);
	LSPD_OBJECT[15] = CreateObject(18981, 1567.50000, -1671.16003, 1989.04004,   0.00000, 90.00000, 0.00000);

	LSPD_OBJECT[16] = CreateObject(18981, 1569.22998, -1701.79004, 1993.90002,   0.00000, 90.00000, 0.00000);
	LSPD_OBJECT[17] = CreateObject(18981, 1569.22998, -1715.64001, 1993.92004,   0.00000, 90.00000, 0.00000);
	LSPD_OBJECT[18] = CreateObject(18981, 1569.35999, -1651.18994, 1993.90002,   0.00000, 90.00000, 0.00000);
	LSPD_OBJECT[19] = CreateObject(18981, 1569.35999, -1626.18994, 1993.90002,   0.00000, 90.00000, 0.00000);
	CreateObject(18981, 1569.35999, -1651.19995, 1983.71997,   0.00000, 90.00000, 0.00000);
	CreateObject(18981, 1569.35999, -1651.19995, 1988.20996,   0.00000, 90.00000, 0.00000);

	LSPD_OBJECT[20] = CreateObject(18981, 1569.31006, -1701.75000, 1999.97998,   0.00000, 90.00000, 0.00000);
	LSPD_OBJECT[21] = CreateObject(18981, 1544.40002, -1702.84998, 1999.97998,   0.00000, 90.00000, 0.00000);
	LSPD_OBJECT[22] = CreateObject(18981, 1568.62000, -1676.88000, 1999.97998,   0.00000, 90.00000, 0.00000);
	LSPD_OBJECT[23] = CreateObject(18981, 1568.02002, -1627.33997, 1999.97998,   0.00000, 90.00000, 0.00000);
	LSPD_OBJECT[24] = CreateObject(18981, 1544.33997, -1643.18005, 1999.97998,   0.00000, 90.00000, 0.00000);
	LSPD_OBJECT[25] = CreateObject(18981, 1569.41003, -1651.93005, 1999.97998,   0.00000, 90.00000, 0.00000);

	/*SAPD Map Interior por Raul Lara*/
	//Piso segundas plantas
	SetObjectMaterial(LSPD_OBJECT[16], 0, 10941, "silicon2_sfse", "ws_stationfloor", 0);
	SetObjectMaterial(LSPD_OBJECT[17], 0, 10941, "silicon2_sfse", "ws_stationfloor", 0);
	SetObjectMaterial(LSPD_OBJECT[18], 0, 10941, "silicon2_sfse", "ws_stationfloor", 0);
	SetObjectMaterial(LSPD_OBJECT[19], 0, 10941, "silicon2_sfse", "ws_stationfloor", 0);
	//Paredes
	SetObjectMaterial(LSPD_OBJECT[0], 0, 14853, "gen_pol_vegas", "office_wallnu1", 0);
	SetObjectMaterial(LSPD_OBJECT[1], 0, 14853, "gen_pol_vegas", "office_wallnu1", 0);
	SetObjectMaterial(LSPD_OBJECT[2], 0, 14853, "gen_pol_vegas", "office_wallnu1", 0);
	SetObjectMaterial(LSPD_OBJECT[3], 0, 14853, "gen_pol_vegas", "office_wallnu1", 0);
	SetObjectMaterial(LSPD_OBJECT[4], 0, 14853, "gen_pol_vegas", "office_wallnu1", 0);
	SetObjectMaterial(LSPD_OBJECT[5], 0, 14853, "gen_pol_vegas", "office_wallnu1", 0);
	SetObjectMaterial(LSPD_OBJECT[6], 0, 14853, "gen_pol_vegas", "office_wallnu1", 0);
	SetObjectMaterial(LSPD_OBJECT[7], 0, 14853, "gen_pol_vegas", "office_wallnu1", 0);
	SetObjectMaterial(LSPD_OBJECT[8], 0, 14853, "gen_pol_vegas", "office_wallnu1", 0);
	SetObjectMaterial(LSPD_OBJECT[9], 0, 14853, "gen_pol_vegas", "office_wallnu1", 0);
	SetObjectMaterial(LSPD_OBJECT[10], 0, 14853, "gen_pol_vegas", "office_wallnu1", 0);
	SetObjectMaterial(LSPD_OBJECT[11], 0, 14853, "gen_pol_vegas", "office_wallnu1", 0);
	SetObjectMaterial(LSPD_OBJECT[12], 0, 14853, "gen_pol_vegas", "office_wallnu1", 0);
	SetObjectMaterial(LSPD_OBJECT[13], 0, 14853, "gen_pol_vegas", "office_wallnu1", 0);
	//Techo
	SetObjectMaterial(LSPD_OBJECT[20], 0, 14853, "gen_pol_vegas", "mp_police_win", 0);
	SetObjectMaterial(LSPD_OBJECT[21], 0, 14853, "gen_pol_vegas", "mp_police_win", 0);
	SetObjectMaterial(LSPD_OBJECT[22], 0, 14853, "gen_pol_vegas", "mp_police_win", 0);
	SetObjectMaterial(LSPD_OBJECT[23], 0, 14853, "gen_pol_vegas", "mp_police_win", 0);
	SetObjectMaterial(LSPD_OBJECT[24], 0, 14853, "gen_pol_vegas", "mp_police_win", 0);
	SetObjectMaterial(LSPD_OBJECT[25], 0, 14853, "gen_pol_vegas", "mp_police_win", 0);
	//Piso Lobby
	SetObjectMaterial(LSPD_OBJECT[14], 0, 14853, "gen_pol_vegas", "blue_carpet_256", 0);
	SetObjectMaterial(LSPD_OBJECT[15], 0, 14853, "gen_pol_vegas", "blue_carpet_256", 0);

	CreateDynamicObject(1536, 1557.04004, -1678.10999, 1989.57996,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1536, 1557.04004, -1675.10999, 1989.57996,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19375, 1560.00000, -1689.21997, 1994.31006,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19375, 1560.00000, -1663.72998, 1994.31006,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19375, 1574.04004, -1689.33997, 1994.31006,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19375, 1573.97998, -1663.75000, 1994.31006,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2191, 1576.10999, -1665.15002, 1989.52002,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2191, 1576.10999, -1667.15002, 1989.52002,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19379, 1571.97998, -1694.51001, 1989.50000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(6099, 1512.85999, -1670.81006, 1990.56006,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(19379, 1562.34998, -1694.51001, 1989.50000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1571.81006, -1705.01001, 1989.50000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1562.18994, -1705.01001, 1989.50000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1552.71997, -1694.52002, 1989.50000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1552.56006, -1705.01001, 1989.50000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1542.97998, -1705.75000, 1989.47998,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1571.81006, -1715.51001, 1989.50000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1562.18994, -1715.50000, 1989.50000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1552.58997, -1715.50000, 1989.52002,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1542.97998, -1716.21997, 1989.50000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(18755, 1554.70996, -1709.53003, 1991.56006,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19464, 1553.75000, -1703.18994, 1991.87695,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18758, 1554.68005, -1709.51001, 1991.29004,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19464, 1548.01001, -1705.67004, 1996.94995,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(14407, 1554.01001, -1705.10999, 1991.21997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1547.92004, -1705.67004, 1992.13000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1553.78003, -1705.67004, 1996.94995,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18758, 1554.68005, -1709.55005, 1996.34998,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19464, 1553.69995, -1705.68994, 1992.13000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18758, 1554.68005, -1701.52002, 1991.29004,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19464, 1559.80005, -1700.45996, 1996.94995,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19465, 1565.70996, -1700.45996, 1996.94995,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1571.64001, -1700.45996, 1996.94995,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1577.48999, -1700.45996, 1996.94995,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1568.53003, -1703.48999, 1996.94995,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19465, 1568.53003, -1709.40002, 1996.94995,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1568.53003, -1715.26001, 1996.94995,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1569.67004, -1692.27002, 1991.81006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19465, 1569.67004, -1698.02002, 1991.81006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1569.67004, -1709.77002, 1991.81006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1569.67004, -1715.62000, 1991.81006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19379, 1571.81995, -1658.44995, 1989.50000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1562.18994, -1658.45996, 1989.50000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1552.56995, -1658.43994, 1989.50000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1562.18005, -1647.96997, 1989.50000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1571.81006, -1647.94995, 1989.50000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1571.81995, -1637.45996, 1989.50000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1562.18994, -1637.46997, 1989.50000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1552.54004, -1640.68994, 1989.50000,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19379, 1561.78003, -1651.16003, 1989.47998,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19464, 1570.55005, -1654.77002, 1991.81006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19465, 1570.54004, -1660.70996, 1991.81006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1573.63000, -1651.92004, 1988.16003,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19465, 1570.55005, -1648.87000, 1991.81006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1573.56995, -1646.04004, 1991.81006,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19465, 1570.54004, -1643.02002, 1991.81006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1570.55005, -1637.21997, 1991.81006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19465, 1562.70996, -1660.68005, 1991.81006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1562.70996, -1654.79004, 1991.81006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1559.88000, -1650.69995, 1991.81006,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1562.72998, -1653.55005, 1991.81006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18758, 1554.80005, -1648.23999, 1991.29004,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19464, 1553.83997, -1641.69995, 1991.81006,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1550.72998, -1641.70996, 1991.81006,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(14407, 1553.98999, -1643.82996, 1991.16003,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(18758, 1554.80005, -1640.27002, 1991.29004,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(18755, 1554.90002, -1648.12000, 1991.50000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19464, 1550.72998, -1644.35999, 1991.81006,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1553.87000, -1644.35999, 1991.81006,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1544.89001, -1644.35999, 1991.81006,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19379, 1543.08997, -1641.81995, 1989.52002,   0.00000, 90.00000, 90.00000);
	CreateDynamicObject(19464, 1553.91003, -1644.35999, 1996.91003,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1550.72998, -1644.35999, 1996.91003,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1544.89001, -1644.35999, 1996.91003,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1559.68005, -1651.77002, 1996.91003,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19465, 1562.50000, -1654.83997, 1996.91003,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1562.50000, -1660.78003, 1996.91003,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19465, 1570.42004, -1642.96997, 1996.91003,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19465, 1570.42004, -1654.81006, 1996.91003,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1570.43005, -1637.05005, 1996.91003,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1573.50000, -1651.72998, 1996.91003,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2357, 1560.67004, -1691.62000, 1994.79004,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1671, 1558.80005, -1690.81995, 1994.84998,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2357, 1560.67004, -1697.69995, 1994.79004,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2357, 1564.19995, -1697.69995, 1994.79004,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2357, 1564.19995, -1691.62000, 1994.79004,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2357, 1568.92004, -1691.62000, 1994.79004,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2357, 1568.92004, -1697.69995, 1994.79004,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2607, 1572.90002, -1695.53003, 1994.81006,   0.00000, 0.00000, 9270.00000);
	CreateDynamicObject(1671, 1558.76001, -1692.56995, 1994.84998,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1671, 1562.27002, -1690.78003, 1994.84998,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1671, 1562.26001, -1692.40002, 1994.84998,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1671, 1566.91003, -1690.92004, 1994.84998,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1671, 1566.89001, -1692.53003, 1994.84998,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1671, 1567.07996, -1696.87000, 1994.84998,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1671, 1567.05005, -1698.78003, 1994.84998,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1671, 1562.31006, -1698.78003, 1994.84998,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1671, 1562.26001, -1696.45996, 1994.84998,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1671, 1558.70996, -1698.84998, 1994.84998,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1671, 1558.62000, -1696.63000, 1994.84998,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1714, 1574.44995, -1695.26001, 1994.40002,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2611, 1576.53003, -1695.51001, 1995.93005,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2611, 1576.54004, -1692.85999, 1995.93005,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2607, 1572.89001, -1693.60999, 1994.81006,   0.00000, 0.00000, 9270.00000);
	CreateDynamicObject(1714, 1574.34998, -1693.31995, 1994.40002,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2166, 1573.27002, -1705.13000, 1994.42004,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2165, 1573.28003, -1707.08997, 1994.42004,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2186, 1573.38000, -1709.03003, 1994.48999,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1704, 1571.07996, -1704.94995, 1994.42004,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1704, 1571.07996, -1707.14001, 1994.42004,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2611, 1576.51001, -1708.02002, 1996.34998,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1714, 1574.76001, -1706.39001, 1994.42004,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19464, 1569.67004, -1703.94995, 1991.81006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2357, 1574.04004, -1698.39001, 1989.98999,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2357, 1572.72998, -1698.40002, 1989.98999,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2357, 1572.70996, -1702.64001, 1989.98999,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2357, 1574.03003, -1702.64001, 1989.98999,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2357, 1572.71997, -1706.90002, 1989.98999,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2357, 1574.02002, -1706.90002, 1989.98999,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1714, 1573.45996, -1710.59998, 1989.58997,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1714, 1573.37000, -1694.38000, 1989.58997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1671, 1571.06995, -1706.92004, 1990.06006,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1671, 1571.06006, -1704.85999, 1990.06006,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1671, 1571.05005, -1702.57996, 1990.06006,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1671, 1571.09998, -1700.43005, 1990.06006,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1671, 1575.76001, -1697.82996, 1990.06006,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1671, 1575.79004, -1700.42004, 1990.06006,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1671, 1575.81006, -1703.03003, 1990.06006,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1671, 1575.77002, -1705.69995, 1990.06006,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1671, 1575.70996, -1708.01001, 1990.06006,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(14532, 1571.56995, -1692.39001, 1990.56995,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(14532, 1577.10999, -1695.20996, 1990.56995,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(14532, 1574.92004, -1712.08997, 1990.56995,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2172, 1560.04004, -1697.93994, 1989.57996,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1714, 1558.21997, -1698.53003, 1989.57996,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2172, 1560.04004, -1694.29004, 1989.57996,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1714, 1558.27002, -1694.56006, 1989.57996,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2172, 1560.04004, -1690.70996, 1989.57996,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2172, 1563.18994, -1690.70996, 1989.57996,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2172, 1563.18994, -1694.29004, 1989.57996,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2172, 1563.18994, -1697.93994, 1989.57996,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1714, 1558.21997, -1691.18994, 1989.57996,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1714, 1561.34998, -1691.26001, 1989.57996,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1714, 1561.37000, -1694.85999, 1989.57996,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1714, 1561.43005, -1698.08997, 1989.57996,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2172, 1572.98999, -1684.84998, 1989.57996,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2357, 1565.44995, -1669.54004, 1989.93994,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2357, 1565.45996, -1673.81995, 1989.93994,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2357, 1565.46997, -1678.06995, 1989.93994,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2357, 1565.47998, -1682.32996, 1989.93994,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19375, 1564.77002, -1681.10999, 1985.19995,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2357, 1565.45996, -1683.76001, 1989.95996,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3857, 1564.73999, -1685.17004, 1990.84985,   0.00000, 0.00000, 135.00000);
	CreateDynamicObject(2172, 1572.97998, -1682.94995, 1989.57996,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2172, 1572.95996, -1678.90002, 1989.57996,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2172, 1572.96997, -1677.01001, 1989.57996,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2172, 1573.03003, -1672.89001, 1989.57996,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2172, 1573.03003, -1670.98999, 1989.57996,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2172, 1573.07996, -1667.18994, 1989.57996,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2172, 1572.05005, -1683.82996, 1989.57996,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2172, 1572.04004, -1681.93005, 1989.57996,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2172, 1572.06995, -1677.90002, 1989.57996,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2172, 1572.06995, -1675.98999, 1989.57996,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2172, 1572.10999, -1671.89001, 1989.57996,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2172, 1572.12000, -1669.95996, 1989.57996,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2172, 1572.17004, -1666.18005, 1989.57996,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19375, 1566.05005, -1681.06006, 1985.07996,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19375, 1566.08997, -1672.21997, 1985.07996,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19375, 1564.76001, -1671.78003, 1985.19995,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19356, 1564.73999, -1687.53003, 1991.29004,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3857, 1564.73999, -1670.25195, 1990.84985,   0.00000, 0.00000, 135.00000);
	CreateDynamicObject(3857, 1566.97998, -1663.76001, 1995.37000,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(3857, 1566.97998, -1663.68994, 2001.18005,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(3857, 1567.32996, -1689.26001, 1995.37000,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(3857, 1567.32996, -1689.26001, 2001.17004,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(3850, 1556.72998, -1701.34998, 1994.92004,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3850, 1556.88000, -1640.09998, 1994.94995,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3850, 1556.88000, -1636.67004, 1994.94995,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1570.41003, -1648.89001, 1996.91003,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1570.42004, -1660.72998, 1996.91003,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18758, 1554.81995, -1640.03003, 1991.29004,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(18758, 1554.80005, -1648.23999, 1996.30005,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(18755, 1554.90002, -1648.12000, 1986.14001,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(18758, 1554.90002, -1648.22998, 1986.15002,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19385, 1558.55005, -1652.27002, 1985.96997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19385, 1561.72998, -1652.26001, 1985.96997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19385, 1564.93005, -1652.27002, 1985.96997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19385, 1568.12000, -1652.26001, 1985.96997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19385, 1558.56995, -1644.17004, 1985.96997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19385, 1561.75000, -1644.16003, 1985.96997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19385, 1564.94995, -1644.17004, 1985.96997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19385, 1568.16003, -1644.17004, 1985.96997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19385, 1569.78003, -1650.60999, 1985.96997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19385, 1569.79004, -1645.88000, 1985.96997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, 1569.80005, -1648.20996, 1985.96997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, 1556.90002, -1642.48999, 1985.96997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, 1560.13000, -1642.46997, 1985.96997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, 1563.33997, -1642.46997, 1985.96997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, 1566.60999, -1642.46997, 1985.96997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, 1569.71997, -1642.50000, 1985.96997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, 1571.48999, -1644.23999, 1985.96997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, 1571.48999, -1648.33997, 1985.96997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, 1571.44995, -1651.85999, 1985.96997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, 1569.73999, -1653.96997, 1985.96997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, 1566.28003, -1653.96997, 1985.96997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, 1563.31006, -1653.94995, 1985.96997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, 1560.00000, -1653.95996, 1985.96997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, 1556.91003, -1653.94995, 1985.96997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, 1558.42004, -1655.47998, 1985.96997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, 1561.68005, -1655.54004, 1985.96997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, 1564.83997, -1655.56995, 1985.96997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, 1568.06995, -1655.54004, 1985.96997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, 1572.98999, -1650.34998, 1985.96997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, 1573.02002, -1647.22998, 1985.96997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, 1573.02002, -1644.07996, 1985.96997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19355, 1568.18994, -1640.96997, 1985.96997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, 1564.94995, -1640.93994, 1985.96997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, 1561.72998, -1640.95996, 1985.96997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19355, 1558.58997, -1640.96997, 1985.96997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1811, 1570.77002, -1672.39001, 1990.13000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1811, 1570.82996, -1670.39001, 1990.13000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1811, 1570.83997, -1676.12000, 1990.13000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1811, 1570.68005, -1678.58997, 1990.13000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1811, 1574.30005, -1676.31995, 1990.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1811, 1574.34998, -1678.42004, 1990.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1811, 1574.54004, -1682.63000, 1990.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1811, 1574.51001, -1684.89001, 1990.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1811, 1570.51001, -1682.45996, 1990.13000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1811, 1570.41003, -1684.81006, 1990.13000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1811, 1570.56995, -1666.48999, 1990.13000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1811, 1574.31006, -1666.66003, 1990.13000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2356, 1567.30005, -1669.58997, 1989.54004,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2356, 1567.37000, -1673.48999, 1989.54004,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2356, 1567.30005, -1677.37000, 1989.54004,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2356, 1567.43005, -1680.33997, 1989.54004,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2356, 1567.42004, -1683.97998, 1989.54004,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1703, 1558.77002, -1664.20996, 1989.53003,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1703, 1557.47998, -1667.57996, 1989.53003,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1703, 1557.43005, -1672.27002, 1989.53003,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1703, 1560.94995, -1688.63000, 1989.53003,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1703, 1557.47998, -1687.56006, 1989.53003,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1703, 1557.47998, -1682.52002, 1989.53003,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19302, 1558.45996, -1644.19995, 1985.45996,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19302, 1561.62000, -1644.17004, 1985.45996,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19302, 1564.82996, -1644.20996, 1985.45996,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19302, 1567.98999, -1644.18994, 1985.45996,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19302, 1569.73999, -1645.71997, 1985.45996,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19302, 1569.73999, -1650.47998, 1985.45996,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(19302, 1568.22998, -1652.22998, 1985.45996,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19302, 1565.01001, -1652.23999, 1985.45996,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19302, 1561.81995, -1652.22998, 1985.45996,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19302, 1558.63000, -1652.23999, 1985.45996,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1771, 1557.66003, -1642.34998, 1984.83997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1771, 1560.87000, -1642.35999, 1984.83997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1771, 1564.07996, -1642.31995, 1984.83997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1771, 1567.38000, -1642.38000, 1984.83997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1771, 1571.65002, -1647.59998, 1984.83997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1771, 1571.60999, -1649.14001, 1984.83997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1771, 1568.96997, -1654.18005, 1984.83997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1771, 1565.48999, -1654.18994, 1984.83997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1771, 1562.51001, -1654.16003, 1984.83997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1771, 1559.13000, -1654.09998, 1984.83997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8169, 1575.33997, -1652.01001, 1990.58997,   15.00000, 90.00000, 270.00000);
	CreateDynamicObject(8169, 1572.81995, -1652.02002, 1990.58997,   15.00000, 90.00000, 270.00000);
	CreateDynamicObject(3857, 1574.18994, -1651.80005, 1990.58997,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(14782, 1562.18994, -1655.39001, 1990.56006,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(14782, 1557.32996, -1654.44995, 1990.56006,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(14782, 1557.35999, -1660.54004, 1990.56006,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2063, 1560.20996, -1651.18005, 1990.47998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2063, 1560.03003, -1663.33997, 1990.47998,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1703, 1573.29004, -1663.18005, 1989.53003,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1703, 1575.75000, -1663.15002, 1989.53003,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1703, 1571.19995, -1656.72998, 1989.53003,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1703, 1575.97998, -1654.71997, 1989.53003,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1502, 1570.52002, -1661.46997, 1989.43005,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1502, 1570.52002, -1649.65002, 1989.43005,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1502, 1570.53003, -1643.78003, 1989.43005,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1502, 1562.76001, -1661.45996, 1989.43005,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2606, 1576.68005, -1643.09998, 1991.30005,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2606, 1576.68005, -1641.13000, 1991.30005,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2606, 1576.68005, -1641.13000, 1990.65002,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2606, 1576.68005, -1643.13000, 1990.65002,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1715, 1572.92004, -1641.02002, 1989.56995,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1715, 1572.93994, -1642.68005, 1989.56995,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2206, 1574.68005, -1642.76001, 1989.58997,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1703, 1569.87000, -1639.39001, 1989.53003,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1703, 1566.98999, -1638.39001, 1989.53003,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1703, 1563.21997, -1638.39001, 1989.53003,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2206, 1574.35999, -1643.02002, 1994.39001,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1714, 1576.12000, -1641.70996, 1994.40002,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(2204, 1575.13000, -1647.16003, 1994.38000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19464, 1573.50000, -1647.42004, 1996.91003,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2206, 1572.93994, -1659.52002, 1994.39001,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1714, 1573.76001, -1661.31995, 1994.40002,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1703, 1571.41003, -1652.35999, 1994.40002,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1703, 1573.93005, -1652.33997, 1994.40002,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1811, 1572.89001, -1657.65002, 1995.00000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1811, 1574.46997, -1657.59998, 1995.00000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1703, 1571.06006, -1641.37000, 1994.40002,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(16662, 1558.93005, -1662.60999, 2004.23999,   63.00000, 90.00000, 90.00000);
	CreateDynamicObject(1722, 1561.58997, -1656.70996, 1994.40002,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1722, 1560.76001, -1656.67004, 1994.40002,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1722, 1557.57996, -1656.67004, 1994.40002,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1722, 1558.18005, -1656.66003, 1994.40002,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1722, 1558.82996, -1656.65002, 1994.40002,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1722, 1558.82996, -1654.88000, 1994.40002,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1722, 1558.18005, -1654.87000, 1994.40002,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1722, 1557.56006, -1654.87000, 1994.40002,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1722, 1557.56995, -1653.22998, 1994.40002,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1722, 1558.18994, -1653.21997, 1994.40002,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1722, 1558.85999, -1653.20996, 1994.40002,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1722, 1560.72998, -1653.14001, 1994.40002,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1722, 1561.48999, -1653.10999, 1994.40002,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1502, 1570.41003, -1655.56995, 1994.37000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1502, 1570.40002, -1643.73999, 1994.37000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1502, 1562.50000, -1654.06006, 1994.37000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1703, 1566.22998, -1638.44995, 1994.40002,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1703, 1569.78003, -1639.25000, 1994.40002,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1703, 1562.79004, -1638.41003, 1994.40002,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1703, 1559.28003, -1638.37000, 1994.40002,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1703, 1557.44995, -1641.52002, 1994.40002,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(630, 1557.93005, -1638.51001, 1995.43005,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(630, 1562.23999, -1638.34998, 1995.43005,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(630, 1565.64001, -1638.34998, 1995.43005,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(630, 1569.47998, -1638.46997, 1995.43005,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2357, 1561.73999, -1640.66003, 1994.79004,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2357, 1565.93994, -1640.66003, 1994.77002,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(630, 1569.90002, -1638.56995, 1990.59998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(630, 1566.27002, -1638.35999, 1990.59998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2030, 1567.10999, -1640.51001, 1989.96997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2030, 1564.05005, -1640.33997, 1989.96997,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1703, 1569.05005, -1705.68994, 1989.53003,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1703, 1569.03003, -1709.23999, 1989.53003,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1703, 1568.07996, -1712.85999, 1989.53003,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1703, 1564.62000, -1712.84998, 1989.53003,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(630, 1569.06006, -1712.75000, 1990.59998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(630, 1569.23999, -1708.54004, 1990.59998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(630, 1565.45996, -1712.81006, 1990.59998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2030, 1566.81006, -1710.39001, 1989.97998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1703, 1561.32996, -1712.85999, 1994.42004,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1703, 1565.56995, -1712.90002, 1994.42004,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(630, 1562.39001, -1712.80005, 1995.43005,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(630, 1566.70996, -1713.05005, 1995.43005,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19370, 1560.66003, -1662.05005, 1994.40002,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19370, 1557.16003, -1662.04004, 1994.40002,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19370, 1559.54004, -1660.43994, 1994.33997,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(18755, 1554.90002, -1648.12000, 1996.34998,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(18755, 1554.70996, -1709.53003, 1996.31995,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2198, 1566.43994, -1705.90002, 1994.40002,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1806, 1567.98999, -1704.96997, 1994.42004,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(630, 1557.67004, -1669.32996, 1990.59998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(630, 1557.50000, -1664.46997, 1990.59998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(630, 1557.68994, -1684.01001, 1990.59998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(630, 1557.91003, -1688.57996, 1990.59998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2357, 1559.82996, -1668.50000, 1989.92004,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2357, 1559.77002, -1684.43994, 1989.92004,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1502, 1569.64001, -1698.79004, 1989.43005,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1502, 1568.54004, -1710.15002, 1994.37000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1502, 1566.47998, -1700.46997, 1994.37000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1715, 1572.43994, -1648.60999, 1989.56995,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1715, 1574.06995, -1648.53003, 1989.56995,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2206, 1574.25000, -1650.35999, 1989.58997,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19356, 1564.74402, -1687.53003, 1992.01855,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19356, 1564.73999, -1665.43005, 1991.29004,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19356, 1564.74402, -1665.43005, 1992.01855,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3857, 1564.73999, -1677.70996, 1990.84985,   0.00000, 0.00000, 135.00000);
	CreateDynamicObject(19464, 1552.07996, -1703.18994, 1991.87695,   0.00000, 0.00000, 90.00000);

    //Banco Los Santos Mapeo Raul Lara edited by adri1
	BancoLS[1] = CreateDynamicObject(8172, 1455.19556, -1009.48761, -51.14740,   90.00000, 0.00000, 180.00000);
	BancoLS[5] = CreateDynamicObject(8172, 1455.19556, -1009.4968, -51.14740,   90.00000, 0.00000, 0.00000);
	BancoLS[2] = CreateDynamicObject(14576, 1440.16003, -979.08002, 30.73000,   0.00000, 0.00000, 0.00000);
	BancoLS[3] = CreateDynamicObject(18766, 1434.71997, -971.25000, 38.76000,   0.00000, 0.00000, 81.34000);
	BancoLS[4] = CreateDynamicObject(18766, 1388.29004, -1015.71002, 29.00000,   0.00000, 90.00000, 89.51000);
	CreateDynamicObject(19464, 1474.56995, -1009.41998, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1477.28003, -999.21997, 28.31000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1469.19995, -998.76001, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1469.07996, -995.59003, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1475.07495, -993.69861, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1463.31006, -998.76001, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1452.47998, -1000.67999, 28.31000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1452.47998, -1006.59003, 28.31000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1457.48999, -998.76001, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1452.78003, -998.76001, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(14411, 1466.72998, -996.73999, 27.71000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1466.26001, -995.59003, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19376, 1457.07996, -1004.73999, 25.73000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1470.17004, -1003.71997, 30.83000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1480.64001, -1003.70001, 30.83000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1477.39001, -994.10999, 30.83000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1472.04004, -1004.78003, 30.85000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1461.55005, -1004.78003, 30.85000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1451.06006, -1003.45001, 30.85000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1451.22998, -1004.77002, 30.87000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1459.67004, -1000.56000, 30.83000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1467.56006, -1004.73999, 25.73000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1478.03003, -1004.73999, 25.73000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1472.40002, -995.31000, 25.69000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1461.93994, -995.44000, 25.69000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1451.51001, -996.50000, 25.69000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19464, 1455.47998, -1009.41998, 32.33000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1461.41003, -1009.41998, 32.33000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1467.22998, -1009.41998, 32.33000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1473.08997, -1009.41998, 32.33000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1472.13000, -998.40997, 33.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1472.10999, -1004.33002, 33.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1469.14001, -1007.21002, 33.39000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1463.19995, -1007.20001, 33.39000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1460.50000, -998.51001, 33.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1460.50000, -1001.65997, 33.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1463.22998, -995.59003, 33.39000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1469.03003, -995.58002, 33.39000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19376, 1467.28003, -1002.42999, 35.70000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1467.34998, -992.81000, 35.68000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1456.89001, -1000.25000, 35.68000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1456.81995, -1002.25000, 35.72000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19450, 1459.30005, -1002.10999, 24.98000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19450, 1459.31006, -1001.21002, 24.88000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2165, 1457.94995, -1001.53998, 25.82000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2165, 1463.81006, -1001.67999, 25.82000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19450, 1468.90002, -1001.21997, 24.88000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19450, 1468.93005, -1002.10999, 24.98000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2165, 1467.41003, -1001.70001, 25.82000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2206, 1454.98999, -1001.66998, 25.66000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2206, 1460.66003, -1001.72998, 25.66000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2206, 1464.34998, -1001.70001, 25.66000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2206, 1468.33997, -1001.70001, 25.66000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2165, 1472.14001, -1001.65002, 25.82000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2206, 1473.06006, -1001.67999, 25.66000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19450, 1472.32092, -1002.10999, 24.98000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19450, 1472.32092, -1001.21997, 24.88000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2165, 1476.66003, -1001.59998, 25.82000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19388, 1453.77002, -1002.13000, 27.57000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2165, 1459.84998, -1001.71002, 25.82000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19388, 1455.29004, -1000.51001, 27.57000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19376, 1457.13000, -1004.73999, 29.42000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1451.56006, -995.40002, 29.54000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1478.05005, -1004.72998, 29.42000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1467.56006, -1004.75000, 29.42000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1466.90002, -1003.63000, 29.40000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1457.22998, -1003.52002, 29.56000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1477.39001, -996.26001, 29.40000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(736, 1539.18005, -1033.53003, 33.97000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(736, 1544.81006, -1036.18005, 33.97000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(736, 1560.62000, -1046.98999, 33.97000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(736, 1570.75000, -1059.63000, 33.97000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(729, 1554.16003, -1046.18005, 23.18000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(729, 1547.68994, -1040.83997, 23.18000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(729, 1567.84998, -1061.93994, 23.18000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(736, 1563.79004, -1054.16003, 33.97000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19376, 1472.19995, -993.78998, 34.08000,   90.00000, 90.00000, 90.00000);
	CreateDynamicObject(19464, 1457.79004, -1004.14001, 33.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1457.35999, -1007.20001, 33.39000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19376, 1451.05005, -995.59003, 30.89000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19464, 1457.65002, -998.40002, 33.39000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1451.80005, -998.39001, 33.39000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1454.93005, -1001.31000, 33.39000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1449.03003, -1001.29999, 33.39000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1445.93994, -999.35999, 33.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1448.95996, -995.53003, 33.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1448.46997, -993.78003, 33.39000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19376, 1451.08997, -997.73999, 35.70000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19464, 1445.27002, -990.40002, 32.49000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1445.28003, -984.72998, 32.49000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1442.17004, -994.09998, 32.49000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1442.23999, -981.67999, 32.49000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1439.31006, -991.25000, 32.49000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1438.66003, -988.47998, 32.49000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1438.63147, -982.57849, 32.49000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19376, 1439.89001, -988.88000, 29.88000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1440.07996, -979.25000, 29.86000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1439.89001, -988.88000, 34.21000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1439.84998, -979.27002, 34.21000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(2204, 1438.87000, -988.56000, 29.95000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2206, 1443.60999, -985.29999, 29.97000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1714, 1442.55103, -983.92529, 29.95000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1715, 1441.80444, -986.93939, 29.97000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1715, 1443.41833, -986.98999, 29.97000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2199, 1440.64001, -981.84003, 29.95000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2199, 1443.00000, -981.85999, 29.95000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2029, 1467.92004, -1005.26001, 30.94000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2029, 1465.93005, -1005.27002, 30.94000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1715, 1470.51001, -1005.17999, 30.94000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1715, 1468.69995, -1003.76001, 30.94000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1715, 1467.15002, -1003.73999, 30.94000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1715, 1466.04004, -1003.78003, 30.94000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1715, 1468.57996, -1006.82001, 30.94000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1715, 1467.14001, -1006.77002, 30.94000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1715, 1466.03003, -1006.76001, 30.94000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1715, 1464.38000, -1005.29999, 30.94000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2165, 1470.23999, -1001.14001, 30.93000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2165, 1467.23999, -1001.09998, 30.93000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1715, 1466.65002, -999.66998, 30.94000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1715, 1469.73999, -999.65997, 30.94000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1999, 1487.93994, -1007.63000, 25.81000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1671, 1488.48816, -1008.47192, 26.28130,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1721, 1487.86401, -1006.56049, 25.82000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2356, 1475.64001, -1000.13000, 25.82000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2356, 1472.72998, -1000.16998, 25.82000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2356, 1467.37000, -1000.08002, 25.82000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2356, 1463.29004, -999.95001, 25.82000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2356, 1459.42004, -999.90002, 25.82000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2356, 1457.41003, -999.88000, 25.82000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(3850, 1466.58997, -998.94000, 31.42000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, 1470.00000, -998.95001, 31.42000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3850, 1473.43994, -998.95001, 31.42000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3857, 1458.97998, -1002.14001, 26.75000,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(3857, 1466.38000, -1002.15002, 26.75000,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(3857, 1473.57996, -1002.15002, 26.75000,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(3857, 1466.38000, -1002.15002, 26.75000,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(3857, 1466.38000, -1002.15002, 26.75000,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(3857, 1458.97998, -1002.14001, 26.75000,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(3857, 1458.97998, -1002.14001, 26.75000,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(2198, 1461.17004, -997.28003, 30.94000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2198, 1461.17004, -999.20001, 30.94000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2198, 1461.16003, -1003.03998, 30.94000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2198, 1461.16003, -1001.13000, 30.94000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1715, 1462.81995, -1002.46997, 30.94000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1715, 1462.69995, -1000.65002, 30.94000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1715, 1462.70996, -998.72998, 30.94000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1715, 1462.76001, -996.58002, 30.94000,   0.00000, 0.00000, 270.00000);
	CreateDynamicObject(1502, 1454.53003, -1002.14001, 25.81000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1502, 1445.01001, -993.77002, 30.92000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(3857, 1473.57996, -1002.15002, 26.75000,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(3857, 1473.57996, -1002.15002, 26.75000,   0.00000, 0.00000, 45.00000);
	CreateDynamicObject(3850, 1452.62000, -1007.06000, 25.85000,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(1703, 1457.16003, -1008.8808, 25.81000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1703, 1459.68005, -1008.8808, 25.81000,   0.00000, 0.00000, 180.00000);

	CreateDynamicObject(1569, 1466.48743, -1009.55627, 25.80000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1569, 1463.46777, -1009.56000, 25.80000,   0.00000, 0.00000, 0.00000);

	CreateDynamicObject(2773, 1455.58997, -1003.46002, 26.33000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1442.32996, -993.77002, 35.97000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1445.91003, -991.91998, 33.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1445.92004, -993.59998, 37.50000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19376, 1488.53003, -1004.73999, 25.73000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(1999, 1483.43994, -1007.63000, 25.81000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1671, 1483.98816, -1008.47192, 26.28130,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1721, 1483.86401, -1006.56049, 25.82000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1999, 1478.93994, -1007.63000, 25.81000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1671, 1478.98816, -1008.47192, 26.28130,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1721, 1479.36401, -1006.56049, 25.82000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1999, 1488.95642, -1003.13000, 25.81000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1999, 1484.40381, -1003.13000, 25.81000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1999, 1479.93970, -1003.13000, 25.81000,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1671, 1488.22839, -1002.51599, 26.28130,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1671, 1483.72839, -1002.51599, 26.28130,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1671, 1479.22839, -1002.51599, 26.28130,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1721, 1488.97632, -1004.06195, 25.82000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1721, 1484.18225, -1004.07123, 25.82000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1721, 1479.63379, -1004.09277, 25.82000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1480.27051, -999.83838, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1486.18933, -999.83838, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19465, 1492.10510, -999.82788, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1493.64941, -1002.74835, 28.31000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1493.64941, -1008.62842, 28.31000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1480.27051, -1009.41998, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1486.18933, -1009.41998, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1492.10510, -1009.41998, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19376, 1488.55005, -1004.72998, 29.42000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19465, 1475.12036, -998.76617, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1472.12036, -992.74640, 28.31000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19376, 1482.90002, -995.31000, 25.69000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1493.40002, -995.31000, 25.69000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19464, 1480.97217, -993.69861, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1480.36340, -996.35339, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1486.22717, -996.35339, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19465, 1492.10510, -996.35339, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1486.85925, -993.69861, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19465, 1492.10510, -993.69861, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19464, 1494.88062, -997.00488, 28.31000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1494.88062, -991.06952, 28.31000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19449, 1488.72327, -998.11798, 28.25570,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(19376, 1498.34705, -995.71210, 29.42000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1487.86450, -996.27448, 29.40000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1493.40002, -985.81000, 25.69000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19464, 1494.93359, -985.17145, 28.31000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1494.91602, -979.23688, 28.31000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(14455, 1494.60278, -992.40027, 27.39466,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(14455, 1494.60278, -984.40033, 27.39470,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19376, 1493.40002, -976.31000, 25.69000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19464, 1492.14514, -978.09680, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19376, 1482.94775, -985.72314, 25.69000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1482.94775, -976.31000, 25.69000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19464, 1486.23755, -978.09326, 28.31000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2184, 1487.76917, -987.21783, 25.81075,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1714, 1486.65588, -986.19922, 25.76041,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1671, 1488.41943, -985.16565, 26.22420,   0.00000, 0.00000, -70.00000);
	CreateDynamicObject(1671, 1488.41943, -987.16559, 26.22420,   0.00000, 0.00000, -110.00000);
	CreateDynamicObject(19464, 1483.20837, -990.64746, 28.31000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1483.23779, -984.79523, 28.31000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19464, 1483.23389, -978.93530, 28.31000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(14455, 1483.60278, -987.90033, 27.39470,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(14455, 1483.60278, -980.40033, 27.39470,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1704, 1492.93701, -984.61780, 25.73987,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1704, 1492.93701, -986.61780, 25.73990,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2267, 1483.42480, -986.33032, 28.23058,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2191, 1489.73267, -993.04474, 25.75012,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2191, 1488.21313, -993.04468, 25.75010,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2191, 1486.71313, -993.04468, 25.75010,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1491, 1491.34167, -993.74774, 25.76862,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 1491.35315, -999.85278, 25.76860,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19376, 1487.86450, -986.77448, 29.40000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1498.34705, -986.77448, 29.42000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1487.86450, -977.27448, 29.40000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19376, 1498.34705, -977.27448, 29.42000,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19464, 1436.38342, -981.66968, 32.49000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2258, 1460.32678, -1001.38647, 32.62560,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2262, 1455.29114, -999.00885, 32.62560,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1491, 1474.34033, -998.80811, 25.75650,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2773, 1476.58997, -1003.46002, 26.33000,   0.00000, 0.00000, 0.00000);

	//Cajeros
	CreateDynamicObject(2942, 1410.21143, -1228.69971, 13.16360,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2942, 1224.61646, -1428.50427, 13.07948,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2942, 1222.61646, -1428.50427, 13.07950,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2942, 1220.61646, -1428.50427, 13.07950,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2942, 1218.61646, -1428.50427, 13.07950,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2942, 1161.02258, -1497.45313, 15.41748,   0.00000, 0.00000, 247.50285);
	CreateDynamicObject(2942, 1498.90039, -1847.78955, 13.16123,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2942, 1380.03198, -1642.76318, 13.17232,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2942, 538.80273, -1740.98254, 11.93303,   0.00000, 0.00000, 172.75285);
	CreateDynamicObject(2942, 1007.77338, -1295.86072, 13.14124,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2942, 1312.18127, -897.83740, 39.17719,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2942, 1734.48511, -1907.68274, 13.18131,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2942, 1763.64221, -2204.38379, 13.15179,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2942, 1585.76953, -2286.25854, 13.12480,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2942, 1831.72632, -1308.21704, 13.11254,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2942, 2043.84473, -1414.96716, 16.76000,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2942, 1452.96997, -1008.29999, 26.48000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2942, 1452.96997, -1005.71002, 26.48000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2942, 818.16, -1360.63, 1992.27,   0.00, 0.00, 0.00);
	CreateDynamicObject(2942, 819.09, -1360.63, 1992.27,   0.00, 0.00, 0.00);
	CreateDynamicObject(2942, 820.03, -1360.63, 1992.27,   0.00, 0.00, 0.00);
	CreateDynamicObject(2942, 821.08, -1360.63, 1992.27,   0.00, 0.00, 0.00);
	
    //Lounge Vip, Creditos: Raul Lara.
	CreateDynamicObject(5709, 873.51, -1370.82, 2000.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(5709, 871.51, -1355.40, 2000.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(5709, 833.14, -1332.32, 2000.00,   0.00, 0.00, 90.00);
	CreateDynamicObject(5709, 864.38, -1385.89, 2000.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(5709, 871.48, -1371.95, 2000.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(5709, 848.56, -1342.05, 2000.00,   0.00, 0.00, 90.00);
	CreateDynamicObject(5709, 791.15, -1348.77, 2000.00,   0.00, 0.00, 180.00);
	CreateDynamicObject(5709, 798.71, -1350.63, 2000.00,   0.00, 0.00, 180.00);
	CreateDynamicObject(5709, 798.23, -1361.08, 2000.00,   0.00, 0.00, 180.00);
	CreateDynamicObject(5709, 798.22, -1382.40, 2000.00,   0.00, 0.00, 180.00);
	CreateDynamicObject(5709, 844.33, -1410.77, 2000.00,   0.00, 0.00, 270.00);
	CreateDynamicObject(5709, 827.91, -1410.70, 2000.00,   0.00, 0.00, 270.00);
	CreateDynamicObject(5709, 828.47, -1403.72, 2000.00,   0.00, 0.00, 300.67);
	CreateDynamicObject(5709, 820.38, -1401.41, 2000.00,   0.00, 0.00, 270.00);
	CreateDynamicObject(5709, 839.23, -1339.63, 2000.00,   0.00, 0.00, 126.68);
	CreateDynamicObject(5709, 821.55, -1332.29, 2000.00,   0.00, 0.00, 90.00);
	CreateDynamicObject(5709, 805.14, -1357.55, 2000.00,   0.00, 0.00, 180.00);
	CreateDynamicObject(3851, 843.02, -1383.25, 1992.19,   0.00, 0.00, 90.00);
	CreateDynamicObject(3851, 828.73, -1383.22, 1992.19,   0.00, 0.00, 90.00);
	CreateDynamicObject(1536, 837.29, -1383.32, 1991.67,   0.00, 0.00, 35.02);
	CreateDynamicObject(1536, 834.38, -1383.24, 1991.61,   0.00, 0.00, 131.09);
	CreateDynamicObject(3851, 843.05, -1383.25, 1995.99,   0.00, 0.00, 90.00);
	CreateDynamicObject(3851, 831.75, -1383.24, 1995.99,   0.00, 0.00, 90.00);
	CreateDynamicObject(3851, 820.45, -1383.23, 1995.99,   0.00, 0.00, 90.00);
	CreateDynamicObject(3851, 843.05, -1383.25, 1999.96,   0.00, 0.00, 90.00);
	CreateDynamicObject(19379, 851.44, -1378.41, 1991.56,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 819.94, -1378.44, 1991.56,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 828.34, -1388.02, 1991.56,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 838.79, -1387.77, 1991.54,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 849.25, -1387.71, 1991.56,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 848.07, -1368.81, 1991.56,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 848.08, -1359.17, 1991.56,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 848.08, -1349.56, 1991.56,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 837.60, -1359.17, 1991.56,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 837.59, -1349.55, 1991.56,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 827.09, -1349.59, 1991.56,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 827.13, -1359.21, 1991.56,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 821.54, -1359.33, 1991.54,   0.00, 90.00, 0.00);
	CreateDynamicObject(3851, 831.75, -1383.24, 1999.96,   0.00, 0.00, 90.00);
	CreateDynamicObject(3851, 820.45, -1383.23, 1999.96,   0.00, 0.00, 90.00);
	CreateDynamicObject(3851, 831.75, -1383.24, 2003.95,   0.00, 0.00, 90.00);
	CreateDynamicObject(3851, 820.45, -1383.23, 2003.95,   0.00, 0.00, 90.00);
	CreateDynamicObject(3851, 843.05, -1383.25, 2003.95,   0.00, 0.00, 90.00);
	CreateDynamicObject(3851, 840.35, -1360.17, 1992.19,   0.00, 0.00, 90.00);
	CreateDynamicObject(1536, 834.63, -1360.14, 1991.67,   0.00, 0.00, 327.75);
	CreateDynamicObject(1536, 831.69, -1360.11, 1991.67,   0.00, 0.00, 207.82);
	CreateDynamicObject(3851, 826.04, -1360.17, 1992.19,   0.00, 0.00, 90.00);
	CreateDynamicObject(3851, 828.86, -1360.17, 1996.16,   0.00, 0.00, 90.00);
	CreateDynamicObject(3851, 840.15, -1360.17, 1996.16,   0.00, 0.00, 90.00);
	CreateDynamicObject(3851, 828.86, -1360.17, 2000.15,   0.00, 0.00, 90.00);
	CreateDynamicObject(3851, 840.15, -1360.17, 2000.15,   0.00, 0.00, 90.00);
	CreateDynamicObject(3851, 840.15, -1360.17, 2004.15,   0.00, 0.00, 90.00);
	CreateDynamicObject(3851, 828.86, -1360.17, 2004.15,   0.00, 0.00, 90.00);
	CreateDynamicObject(18762, 815.96, -1368.74, 1994.19,   0.00, 0.00, 0.00);
	CreateDynamicObject(18762, 815.96, -1368.68, 1999.18,   0.00, 0.00, 0.00);
	CreateDynamicObject(18762, 815.96, -1368.68, 2004.17,   0.00, 0.00, 0.00);
	CreateDynamicObject(18762, 816.00, -1363.33, 1994.19,   0.00, 0.00, 0.00);
	CreateDynamicObject(18762, 815.99, -1363.33, 1999.21,   0.00, 0.00, 0.00);
	CreateDynamicObject(18762, 815.99, -1363.33, 2004.11,   0.00, 0.00, 0.00);
	CreateDynamicObject(3851, 816.43, -1365.55, 1996.52,   0.00, 0.00, 0.00);
	CreateDynamicObject(3851, 816.37, -1365.54, 1999.28,   0.00, 0.00, 0.00);
	CreateDynamicObject(18755, 814.31, -1366.05, 2010.88,   0.00, 0.00, 180.00);
	CreateDynamicObject(3851, 816.41, -1365.55, 2006.41,   0.00, 0.00, 0.00);
	CreateDynamicObject(5709, 793.93, -1366.57, 2000.00,   0.00, 0.00, 180.00);
	CreateDynamicObject(5709, 801.78, -1363.90, 2000.00,   0.00, 0.00, 270.00);
	CreateDynamicObject(18981, 847.75, -1354.69, 1979.58,   0.00, 0.00, 0.00);
	CreateDynamicObject(18981, 853.46, -1371.47, 1979.58,   0.00, 0.00, 0.00);
	CreateDynamicObject(19379, 853.29, -1372.00, 1992.00,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 852.29, -1372.00, 1991.82,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 851.81, -1372.00, 1991.71,   0.00, 90.00, 0.00);
	CreateDynamicObject(10444, 854.80, -1375.27, 1992.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(10444, 854.75, -1375.34, 1991.66,   0.00, 0.00, 0.00);
	CreateDynamicObject(18762, 816.63, -1377.97, 1994.19,   0.00, 0.00, 0.00);
	CreateDynamicObject(18762, 816.63, -1377.97, 1998.72,   0.00, 0.00, 0.00);
	CreateDynamicObject(18762, 816.63, -1371.73, 1994.19,   0.00, 0.00, 0.00);
	CreateDynamicObject(18762, 816.62, -1371.72, 1998.71,   0.00, 0.00, 0.00);
	CreateDynamicObject(18762, 822.70, -1380.63, 2000.74,   0.02, 90.00, 90.00);
	CreateDynamicObject(18762, 822.74, -1375.65, 2000.74,   0.02, 90.00, 90.00);
	CreateDynamicObject(18762, 822.74, -1370.70, 2000.74,   0.02, 90.00, 90.00);
	CreateDynamicObject(18762, 822.74, -1365.75, 2000.74,   0.02, 90.00, 90.00);
	CreateDynamicObject(18762, 822.74, -1362.84, 2000.74,   0.02, 90.00, 90.00);
	CreateDynamicObject(19129, 812.69, -1380.57, 1994.99,   0.00, 0.00, 0.00);
	CreateDynamicObject(19379, 848.10, -1378.44, 1991.54,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 827.01, -1385.25, 1991.54,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 820.74, -1375.76, 1991.38,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 831.23, -1360.01, 1991.36,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 841.72, -1360.01, 1991.36,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 847.21, -1369.64, 1991.36,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 847.19, -1379.25, 1991.36,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 836.69, -1384.38, 1991.36,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 826.19, -1384.36, 1991.36,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 821.34, -1375.54, 1991.20,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 821.35, -1366.02, 1991.20,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 831.73, -1360.80, 1991.18,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 842.19, -1360.77, 1991.18,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 846.33, -1379.98, 1991.18,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 835.89, -1383.58, 1991.18,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 825.42, -1383.52, 1991.18,   0.00, 90.00, 0.00);
	CreateDynamicObject(18981, 860.63, -1376.44, 1979.58,   0.00, 0.00, 90.00);
	CreateDynamicObject(18981, 859.73, -1383.58, 1979.58,   0.00, 0.00, 90.00);
	CreateDynamicObject(18981, 860.57, -1367.64, 1979.58,   0.00, 0.00, 90.00);
	CreateDynamicObject(18981, 860.39, -1360.16, 1979.58,   0.00, 0.00, 90.00);
	CreateDynamicObject(19462, 818.15, -1378.41, 2000.35,   0.00, 90.00, 0.00);
	CreateDynamicObject(19462, 818.15, -1368.80, 2000.35,   0.00, 90.00, 0.00);
	CreateDynamicObject(19462, 818.15, -1359.16, 2000.35,   0.00, 90.00, 0.00);
	CreateDynamicObject(19462, 821.41, -1378.41, 2000.35,   -0.02, 90.00, 0.00);
	CreateDynamicObject(19462, 821.40, -1368.81, 2000.35,   -0.02, 90.00, 0.00);
	CreateDynamicObject(19462, 821.05, -1359.14, 2000.35,   -0.02, 90.00, 0.00);
	CreateDynamicObject(19462, 821.33, -1378.39, 2001.17,   -0.02, 90.00, 0.00);
	CreateDynamicObject(19462, 818.15, -1378.41, 2001.17,   0.00, 90.00, 0.00);
	CreateDynamicObject(19462, 821.34, -1368.79, 2001.17,   -0.02, 90.00, 0.00);
	CreateDynamicObject(19462, 818.12, -1368.80, 2001.17,   0.00, 90.00, 0.00);
	CreateDynamicObject(19462, 821.38, -1359.22, 2001.17,   -0.02, 90.00, 0.00);
	CreateDynamicObject(19462, 818.15, -1359.16, 2001.17,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, -1372.01, 1991.92, 1991.92,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 852.81, -1372.00, 1991.92,   0.00, 90.00, 0.00);
	CreateDynamicObject(18981, 847.75, -1389.31, 1979.58,   0.00, 0.00, 0.00);
	CreateDynamicObject(18762, 822.71, -1380.71, 2000.74,   0.02, 90.00, 90.00);
	CreateDynamicObject(2773, 822.85, -1382.06, 2001.77,   0.00, 0.00, 0.00);
	CreateDynamicObject(2773, 822.84, -1379.73, 2001.77,   0.00, 0.00, 0.00);
	CreateDynamicObject(2773, 822.85, -1377.41, 2001.77,   0.00, 0.00, 0.00);
	CreateDynamicObject(2773, 822.86, -1375.09, 2001.77,   0.00, 0.00, 0.00);
	CreateDynamicObject(2773, 822.84, -1372.77, 2001.75,   0.00, 0.00, 0.00);
	CreateDynamicObject(2773, 822.87, -1370.43, 2001.77,   0.00, 0.00, 0.00);
	CreateDynamicObject(2773, 822.87, -1368.10, 2001.77,   0.00, 0.00, 0.00);
	CreateDynamicObject(2773, 822.82, -1365.76, 2001.77,   0.00, 0.00, 0.00);
	CreateDynamicObject(2773, 822.86, -1363.46, 2001.77,   0.00, 0.00, 0.00);
	CreateDynamicObject(2773, 822.86, -1361.55, 2001.77,   0.00, 0.00, 0.00);
	CreateDynamicObject(1723, 816.91, -1382.75, 2001.25,   0.00, 0.00, 90.00);
	CreateDynamicObject(1723, 816.88, -1379.24, 2001.25,   0.00, 0.00, 90.00);
	CreateDynamicObject(1723, 816.88, -1375.76, 2001.25,   0.00, 0.00, 90.00);
	CreateDynamicObject(1723, 816.80, -1372.30, 2001.25,   0.00, 0.00, 90.00);
	CreateDynamicObject(1723, 820.16, -1360.89, 2001.25,   0.00, 0.00, 0.00);
	CreateDynamicObject(1723, 817.03, -1360.95, 2001.25,   0.00, 0.00, 0.00);
	CreateDynamicObject(4141, 800.30, -1364.47, 1969.75,   0.00, 0.00, 0.00);
	CreateDynamicObject(14391, 820.19, -1376.94, 1995.99,   0.00, 0.00, 180.00);
	CreateDynamicObject(2395, 823.07, -1382.72, 1995.12,   270.00, 0.00, 90.00);
	CreateDynamicObject(2395, 823.07, -1379.02, 1995.12,   270.00, 0.00, 90.00);
	CreateDynamicObject(2395, 823.07, -1375.30, 1995.12,   270.00, 0.00, 90.00);
	CreateDynamicObject(2395, 823.05, -1373.42, 1995.14,   270.00, 0.00, 90.00);
	CreateDynamicObject(2395, 819.82, -1370.18, 1995.12,   270.00, 0.00, 180.00);
	CreateDynamicObject(2395, 816.08, -1370.18, 1995.12,   270.00, 0.00, 180.00);
	CreateDynamicObject(19129, 831.19, -1371.61, 1991.03,   0.00, 0.00, 0.00);
	CreateDynamicObject(2395, 821.18, -1377.52, 1993.44,   0.00, 0.00, 90.00);
	CreateDynamicObject(2395, 821.18, -1379.24, 1993.44,   0.00, 0.00, 90.00);
	CreateDynamicObject(16088, 821.89, -1378.81, 1991.57,   0.00, 0.00, 0.00);
	CreateDynamicObject(16088, 821.94, -1389.05, 1991.57,   0.00, 0.00, 0.00);
	CreateDynamicObject(16088, 821.96, -1390.58, 1991.57,   0.00, 0.00, 0.00);
	CreateDynamicObject(2773, 822.75, -1371.38, 1995.61,   0.00, 0.00, 0.00);
	CreateDynamicObject(2773, 822.83, -1374.11, 1995.61,   0.00, 0.00, 0.00);
	CreateDynamicObject(2773, 822.83, -1377.32, 1995.61,   0.00, 0.00, 0.00);
	CreateDynamicObject(2773, 822.86, -1380.10, 1995.61,   0.00, 0.00, 0.00);
	CreateDynamicObject(2773, 822.86, -1382.00, 1995.61,   0.00, 0.00, 0.00);
	CreateDynamicObject(1723, 821.25, -1382.69, 2001.25,   0.00, 0.00, 180.00);
	CreateDynamicObject(8572, 820.33, -1369.25, 1993.82,   0.00, 0.00, 180.00);
	CreateDynamicObject(3851, 817.55, -1368.30, 1998.43,   0.00, 0.00, 90.00);
	CreateDynamicObject(3851, 817.55, -1368.30, 1994.47,   0.00, 0.00, 90.00);
	CreateDynamicObject(3851, 817.55, -1368.30, 1990.48,   0.00, 0.00, 90.00);
	CreateDynamicObject(18762, 822.76, -1367.81, 1994.19,   0.00, 0.00, 0.00);
	CreateDynamicObject(18762, 822.76, -1367.81, 1997.73,   0.00, 0.00, 0.00);
	CreateDynamicObject(948, 822.33, -1382.61, 2001.21,   0.00, 0.00, 0.00);
	CreateDynamicObject(948, 816.93, -1380.03, 2001.21,   0.00, 0.00, 0.00);
	CreateDynamicObject(948, 816.97, -1376.52, 2001.21,   0.00, 0.00, 0.00);
	CreateDynamicObject(948, 816.88, -1373.04, 2001.21,   0.00, 0.00, 0.00);
	CreateDynamicObject(948, 816.89, -1369.54, 2001.21,   0.00, 0.00, 0.00);
	CreateDynamicObject(948, 816.69, -1362.61, 2001.21,   0.00, 0.00, 0.00);
	CreateDynamicObject(3515, 850.44, -1364.03, 1990.75,   0.00, 0.00, 0.00);
	CreateDynamicObject(3515, 850.52, -1380.11, 1990.75,   0.00, 0.00, 0.00);
	CreateDynamicObject(19379, 846.32, -1370.43, 1991.18,   0.00, 90.00, 0.00);
	CreateDynamicObject(19462, 821.62, -1369.08, 1991.54,   0.00, 90.00, 0.00);
	CreateDynamicObject(19462, 823.44, -1369.01, 1991.56,   0.00, 90.00, 0.00);
	CreateDynamicObject(19462, 824.23, -1366.15, 1991.38,   0.00, 90.00, 0.00);
	CreateDynamicObject(14560, 834.21, -1350.31, 1996.12,   0.00, 0.00, 90.00);
	CreateDynamicObject(2785, 823.88, -1357.12, 1992.49,   0.00, 0.00, 90.00);
	CreateDynamicObject(2098, 823.49, -1357.24, 1993.59,   0.00, 0.00, 90.00);
	CreateDynamicObject(2785, 845.18, -1357.23, 1992.49,   0.00, 0.00, 270.00);
	CreateDynamicObject(2098, 845.78, -1357.17, 1993.59,   0.00, 0.00, 90.00);
	CreateDynamicObject(1978, 836.76, -1357.27, 1992.70,   0.00, 0.00, 270.00);
	CreateDynamicObject(1978, 841.48, -1357.33, 1992.70,   0.00, 0.00, 270.00);
	CreateDynamicObject(2188, 830.30, -1357.09, 1992.64,   0.00, 0.00, 90.00);
	CreateDynamicObject(2188, 828.37, -1357.09, 1992.64,   0.00, 0.00, 270.00);
	CreateDynamicObject(2773, 829.34, -1355.87, 1992.16,   0.00, 0.00, 90.00);
	CreateDynamicObject(2773, 829.35, -1358.36, 1992.16,   0.00, 0.00, 90.00);
	CreateDynamicObject(2785, 829.20, -1359.65, 1992.49,   0.00, 0.00, 180.00);
	CreateDynamicObject(2785, 826.64, -1359.69, 1992.49,   0.00, 0.00, 180.00);
	CreateDynamicObject(14565, 834.26, -1350.25, 1993.60,   0.00, 0.00, 90.00);
	CreateDynamicObject(18758, 814.34, -1366.11, 1993.11,   0.00, 0.00, 180.00);
	CreateDynamicObject(18758, 814.34, -1366.11, 2003.11,   0.00, 0.00, 180.00);
	CreateDynamicObject(18762, 822.94, -1360.69, 1994.19,   0.00, 0.00, 0.00);
	CreateDynamicObject(18762, 822.94, -1360.69, 1997.73,   0.00, 0.00, 0.00);
	CreateDynamicObject(2780, 838.24, -1368.42, 1984.36,   0.00, 0.00, 0.00);
	CreateDynamicObject(19462, 818.11, -1368.91, 1991.52,   0.00, 90.00, 0.00);
	CreateDynamicObject(2780, 837.39, -1374.90, 1984.36,   0.00, 0.00, 0.00);
	CreateDynamicObject(2780, 833.43, -1371.86, 1984.36,   0.00, 0.00, 0.00);
	CreateDynamicObject(2780, 831.40, -1375.33, 1984.36,   0.00, 0.00, 0.00);
	CreateDynamicObject(2780, 828.65, -1372.39, 1984.36,   0.00, 0.00, 0.00);
	CreateDynamicObject(2780, 830.10, -1368.48, 1984.36,   0.00, 0.00, 0.00);
	CreateDynamicObject(2780, 834.09, -1368.72, 1984.36,   0.00, 0.00, 0.00);
	CreateDynamicObject(10782, 845.17, -1339.93, 2012.54,   0.00, 0.00, 0.00);
	CreateDynamicObject(18758, 814.30, -1366.11, 2010.86,   0.00, 0.00, 180.00);
	CreateDynamicObject(18758, 814.30, -1373.80, 2010.86,   0.00, 0.00, 180.00);
	CreateDynamicObject(3851, 816.37, -1373.85, 2010.14,   0.00, 0.00, 0.00);
	CreateDynamicObject(3851, 816.37, -1358.27, 2010.08,   0.00, 0.00, 0.00);
	CreateDynamicObject(18758, 814.31, -1366.10, 2012.91,   0.00, 0.00, 180.00);
	CreateDynamicObject(18758, 814.30, -1373.63, 2012.91,   0.00, 0.00, 180.00);
	CreateDynamicObject(3851, 816.37, -1366.39, 2014.08,   0.00, 0.00, 0.00);
	CreateDynamicObject(2439, 845.67, -1389.23, 1991.65,   0.00, 0.00, 180.00);
	CreateDynamicObject(2439, 844.68, -1389.23, 1991.65,   0.00, 0.00, 180.00);
	CreateDynamicObject(2439, 843.69, -1389.23, 1991.65,   0.00, 0.00, 180.00);
	CreateDynamicObject(2439, 842.71, -1389.23, 1991.65,   0.00, 0.00, 180.00);
	CreateDynamicObject(2439, 841.71, -1389.23, 1991.65,   0.00, 0.00, 180.00);
	CreateDynamicObject(2439, 840.71, -1389.23, 1991.65,   0.00, 0.00, 180.00);
	CreateDynamicObject(2439, 839.71, -1389.23, 1991.65,   0.00, 0.00, 180.00);
	CreateDynamicObject(2439, 838.72, -1389.23, 1991.65,   0.00, 0.00, 180.00);
	CreateDynamicObject(2439, 837.73, -1389.23, 1991.65,   0.00, 0.00, 180.00);
	CreateDynamicObject(2439, 836.75, -1389.23, 1991.65,   0.00, 0.00, 180.00);
	CreateDynamicObject(2439, 835.75, -1389.23, 1991.65,   0.00, 0.00, 180.00);
	CreateDynamicObject(2439, 834.74, -1389.23, 1991.65,   0.00, 0.00, 180.00);
	CreateDynamicObject(2439, 834.57, -1389.38, 1991.65,   0.00, 0.00, 270.00);
	CreateDynamicObject(2439, 834.56, -1390.37, 1991.65,   0.00, 0.00, 270.00);
	CreateDynamicObject(2439, 834.48, -1392.68, 1991.65,   0.00, 0.00, 270.00);
	CreateDynamicObject(2808, 823.63, -1384.36, 1992.25,   0.00, 0.00, 270.00);
	CreateDynamicObject(2637, 825.23, -1384.36, 1992.06,   0.00, 0.00, 270.00);
	CreateDynamicObject(2638, 827.35, -1384.36, 1992.25,   0.00, 0.00, 270.00);
	CreateDynamicObject(2637, 829.48, -1384.36, 1992.06,   0.00, 0.00, 270.00);
	CreateDynamicObject(2638, 831.68, -1384.36, 1992.25,   0.00, 0.00, 270.00);
	CreateDynamicObject(2637, 833.74, -1384.36, 1992.06,   0.00, 0.00, 270.00);
	CreateDynamicObject(2808, 837.89, -1384.36, 1992.25,   0.00, 0.00, 270.00);
	CreateDynamicObject(2637, 839.45, -1384.36, 1992.06,   0.00, 0.00, 270.00);
	CreateDynamicObject(2638, 841.58, -1384.36, 1992.25,   0.00, 0.00, 270.00);
	CreateDynamicObject(2637, 843.74, -1384.36, 1992.06,   0.00, 0.00, 270.00);
	CreateDynamicObject(2808, 845.41, -1384.32, 1992.25,   0.00, 0.00, 90.00);
	CreateDynamicObject(2808, 825.56, -1391.33, 1992.25,   0.00, 0.00, 270.00);
	CreateDynamicObject(2637, 827.26, -1391.24, 1992.06,   0.00, 0.00, 270.00);
	CreateDynamicObject(2638, 829.56, -1391.39, 1992.25,   0.00, 0.00, 270.00);
	CreateDynamicObject(2637, 831.70, -1391.26, 1992.06,   0.00, 0.00, 270.00);
	CreateDynamicObject(2671, 824.63, -1387.50, 1991.66,   0.00, 0.00, 0.00);
	CreateDynamicObject(2671, 828.99, -1390.83, 1991.66,   0.00, 0.00, 0.00);
	CreateDynamicObject(2671, 840.91, -1384.26, 1991.66,   0.00, 0.00, 0.00);
	CreateDynamicObject(2683, 825.34, -1384.58, 1992.61,   0.00, 0.00, 0.00);
	CreateDynamicObject(2683, 829.61, -1383.96, 1992.63,   0.00, 0.00, 0.00);
	CreateDynamicObject(2683, 833.82, -1384.03, 1992.63,   0.00, 0.00, 0.00);
	CreateDynamicObject(2683, 839.36, -1384.42, 1992.63,   0.00, 0.00, 0.00);
	CreateDynamicObject(2683, 843.70, -1384.57, 1992.63,   0.00, 0.00, 0.00);
	CreateDynamicObject(2451, 845.65, -1391.87, 1991.65,   0.00, 0.00, 180.00);
	CreateDynamicObject(2417, 843.75, -1392.10, 1991.65,   0.00, 0.00, 180.00);
	CreateDynamicObject(2415, 842.76, -1391.81, 1991.65,   0.00, 0.00, 180.00);
	CreateDynamicObject(2415, 841.94, -1391.82, 1991.65,   0.00, 0.00, 180.00);
	CreateDynamicObject(2419, 841.08, -1391.94, 1991.65,   0.00, 0.00, 180.00);
	CreateDynamicObject(2419, 839.17, -1391.93, 1991.65,   0.00, 0.00, 180.00);
	CreateDynamicObject(2426, 840.26, -1392.29, 1992.60,   0.00, 0.00, 180.00);
	CreateDynamicObject(2426, 838.35, -1392.27, 1992.60,   0.00, 0.00, 180.00);
	CreateDynamicObject(2421, 844.53, -1392.47, 1993.45,   0.00, 0.00, 180.00);
	CreateDynamicObject(2421, 840.99, -1392.52, 1993.45,   0.00, 0.00, 180.00);
	CreateDynamicObject(2418, 837.25, -1391.83, 1991.65,   0.00, 0.00, 180.00);
	CreateDynamicObject(2700, 831.73, -1392.30, 1994.49,   0.00, 0.00, 90.00);
	CreateDynamicObject(2700, 823.37, -1385.29, 1994.49,   0.00, 0.00, 0.00);
	CreateDynamicObject(2700, 845.91, -1388.49, 1994.49,   0.00, 0.00, 180.00);
	CreateDynamicObject(19379, 810.86, -1366.17, 1991.20,   0.00, 90.00, 0.00);
	CreateDynamicObject(18981, 803.82, -1368.76, 2003.16,   0.00, 0.00, 90.00);
	CreateDynamicObject(18981, 803.09, -1363.27, 2003.16,   0.00, 0.00, 90.00);
	CreateDynamicObject(18981, 811.63, -1370.63, 2003.16,   0.00, 0.00, 0.00);
	CreateDynamicObject(3989, 849.94, -1352.42, 2009.26,   0.00, 180.00, 0.00);
	CreateDynamicObject(1569, 853.29, -1373.57, 1992.07,   0.00, 0.00, 90.00);
	CreateDynamicObject(1569, 853.29, -1370.58, 1992.07,   0.00, 0.00, 270.00);
	CreateDynamicObject(18981, 858.89, -1379.24, 2020.84,   0.00, 0.00, 89.38);
	CreateDynamicObject(11313, 861.53, -1378.76, 2010.94,   0.00, 0.00, 90.00);
    
    // CNN Interior
    CreateDynamicObject(6490, 717.48, -1357.30, 3998.54,   0.00, 0.00, 0.00);
	CreateDynamicObject(19379, 652.77, -1358.40, 4001.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 652.77, -1368.03, 4001.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 652.77, -1348.78, 4001.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 663.26, -1348.80, 4001.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 663.23, -1358.43, 4001.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 663.22, -1368.01, 4001.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(5848, 637.88, -1356.93, 4007.68,   0.00, 0.00, 261.47);
	CreateDynamicObject(5848, 653.90, -1376.67, 4007.68,   0.00, 0.00, 351.00);
	CreateDynamicObject(5848, 672.50, -1356.97, 4007.68,   0.00, 0.00, 441.00);
	CreateDynamicObject(5848, 659.84, -1337.10, 4007.68,   0.00, 0.00, 531.00);
	CreateDynamicObject(19379, 659.51, -1354.88, 4005.01,   0.00, 90.00, 0.00);
	CreateDynamicObject(19369, 650.99, -1363.96, 4006.83,   0.00, 0.00, 0.00);
	CreateDynamicObject(19369, 652.65, -1365.49, 4003.33,   0.00, 0.00, 90.00);
	CreateDynamicObject(19369, 654.16, -1363.96, 4003.33,   0.00, 0.00, 0.00);
	CreateDynamicObject(19369, 652.54, -1362.43, 4003.33,   0.00, 0.00, 90.00);
	CreateDynamicObject(14407, 648.88, -1362.78, 4000.12,   0.00, 0.00, 0.00);
	CreateDynamicObject(19379, 649.08, -1369.53, 4003.22,   0.00, 90.00, 0.00);
	CreateDynamicObject(14407, 651.65, -1367.40, 4001.88,   0.00, 0.00, 90.00);
	CreateDynamicObject(19415, 654.28, -1349.65, 4003.32,   0.00, 0.00, 0.00);
	CreateDynamicObject(19369, 654.27, -1346.44, 4003.32,   0.00, 0.00, 0.00);
	CreateDynamicObject(19369, 654.27, -1352.86, 4003.32,   0.00, 0.00, 0.00);
	CreateDynamicObject(19369, 654.29, -1358.47, 4003.32,   0.00, 0.00, 0.00);
	CreateDynamicObject(19397, 654.27, -1356.07, 4003.32,   0.00, 0.00, 0.00);
	CreateDynamicObject(19397, 654.27, -1360.95, 4003.32,   0.00, 0.00, 0.00);
	CreateDynamicObject(19461, 654.28, -1367.28, 4003.33,   0.00, 0.00, 0.00);
	CreateDynamicObject(19369, 650.99, -1363.96, 4003.33,   0.00, 0.00, 0.00);
	CreateDynamicObject(19369, 654.16, -1363.96, 4006.83,   0.00, 0.00, 0.00);
	CreateDynamicObject(19369, 652.54, -1362.43, 4006.83,   0.00, 0.00, 90.00);
	CreateDynamicObject(19369, 652.65, -1365.49, 4006.83,   0.00, 0.00, 90.00);
	CreateDynamicObject(14407, 664.39, -1348.11, 4001.91,   0.00, 0.00, 0.00);
	CreateDynamicObject(19379, 665.05, -1343.48, 4003.76,   0.00, 90.00, 0.00);
	CreateDynamicObject(14407, 661.81, -1350.14, 4000.66,   0.00, 0.00, 180.00);
	CreateDynamicObject(19369, 662.36, -1349.93, 4003.34,   0.00, 0.00, 0.00);
	CreateDynamicObject(19461, 659.88, -1346.75, 4003.34,   0.00, 0.00, 0.00);
	CreateDynamicObject(19369, 663.88, -1351.43, 4003.34,   0.00, 0.00, 90.00);
	CreateDynamicObject(19369, 655.90, -1351.49, 4003.32,   0.00, 0.00, 90.00);
	CreateDynamicObject(19397, 658.35, -1351.49, 4003.32,   0.00, 0.00, 90.00);
	CreateDynamicObject(19378, 659.52, -1344.88, 4001.66,   0.00, 90.00, 0.00);
	CreateDynamicObject(367, 655.97, -1349.62, 4002.93,   0.00, 0.00, 79.73);
	CreateDynamicObject(2423, 651.94, -1354.37, 4001.58,   0.00, 0.00, 180.00);
	CreateDynamicObject(2424, 651.88, -1355.39, 4001.58,   0.00, 0.00, 270.00);
	CreateDynamicObject(2424, 651.87, -1356.29, 4001.58,   0.00, 0.00, 270.00);
	CreateDynamicObject(2424, 651.87, -1357.20, 4001.58,   0.00, 0.00, 270.00);
	CreateDynamicObject(2424, 651.87, -1358.10, 4001.58,   0.00, 0.00, 270.00);
	CreateDynamicObject(2424, 651.87, -1359.01, 4001.58,   0.00, 0.00, 270.00);
	CreateDynamicObject(2424, 651.86, -1359.92, 4001.58,   0.00, 0.00, 270.00);
	CreateDynamicObject(2424, 651.85, -1360.84, 4001.58,   0.00, 0.00, 270.00);
	CreateDynamicObject(2424, 651.85, -1361.74, 4001.58,   0.00, 0.00, 270.00);
	CreateDynamicObject(2424, 651.85, -1362.65, 4001.58,   0.00, 0.00, 270.00);
	CreateDynamicObject(2424, 652.85, -1354.38, 4001.58,   0.00, 0.00, 180.00);
	CreateDynamicObject(2424, 653.75, -1354.36, 4001.58,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 653.42, -1356.65, 4001.58,   0.00, 0.00, 270.00);
	CreateDynamicObject(1714, 653.39, -1358.82, 4001.58,   0.00, 0.00, 270.00);
	CreateDynamicObject(1714, 653.36, -1361.03, 4001.58,   0.00, 0.00, 270.00);
	CreateDynamicObject(2165, 651.94, -1356.82, 4001.81,   0.00, 0.00, 90.00);
	CreateDynamicObject(2424, 651.87, -1358.10, 4001.58,   0.00, 0.00, 270.00);
	CreateDynamicObject(19461, 652.27, -1359.41, 4000.87,   0.00, 0.00, 0.00);
	CreateDynamicObject(2165, 651.94, -1358.94, 4001.81,   0.00, 0.00, 90.00);
	CreateDynamicObject(2165, 651.93, -1361.45, 4001.81,   0.00, 0.00, 90.00);
	CreateDynamicObject(14391, 657.80, -1367.10, 4002.53,   0.00, 0.00, 2700.00);
	CreateDynamicObject(5848, 670.13, -1370.92, 4002.66,   0.00, 0.00, 441.00);
	CreateDynamicObject(19397, 656.61, -1361.78, 4003.32,   0.00, 0.00, 90.00);
	CreateDynamicObject(19415, 659.81, -1361.78, 4003.32,   0.00, 0.00, 90.00);
	CreateDynamicObject(19369, 662.70, -1361.78, 4003.32,   0.00, 0.00, 90.00);
	CreateDynamicObject(19397, 658.73, -1363.33, 4003.32,   0.00, 0.00, 0.00);
	CreateDynamicObject(19461, 658.75, -1368.87, 4001.02,   0.00, 0.00, 0.00);
	CreateDynamicObject(19366, 660.66, -1360.14, 4001.68,   0.00, 90.00, 0.00);
	CreateDynamicObject(19366, 660.66, -1356.94, 4001.68,   0.00, 90.00, 0.00);
	CreateDynamicObject(1714, 655.33, -1365.32, 4001.58,   0.00, 0.00, 90.00);
	CreateDynamicObject(1714, 655.27, -1367.38, 4001.58,   0.00, 0.00, 90.00);
	CreateDynamicObject(19370, 656.00, -1348.48, 4005.01,   0.00, 90.00, 0.00);
	CreateDynamicObject(19370, 656.00, -1345.26, 4005.01,   0.00, 90.00, 0.00);
	CreateDynamicObject(19370, 658.18, -1348.46, 4004.99,   0.00, 90.00, 0.00);
	CreateDynamicObject(19370, 658.04, -1345.26, 4004.99,   0.00, 90.00, 0.00);
	CreateDynamicObject(3850, 654.20, -1346.60, 4005.54,   0.00, 0.00, 0.00);
	CreateDynamicObject(3850, 654.20, -1350.03, 4005.54,   0.00, 0.00, 0.00);
	CreateDynamicObject(3850, 654.19, -1353.45, 4005.54,   0.00, 0.00, 0.00);
	CreateDynamicObject(3850, 654.21, -1356.88, 4005.54,   0.00, 0.00, 0.00);
	CreateDynamicObject(3850, 654.22, -1360.30, 4005.54,   0.00, 0.00, 0.00);
	CreateDynamicObject(3850, 654.22, -1363.72, 4005.54,   0.00, 0.00, 0.00);
	CreateDynamicObject(3850, 654.17, -1363.86, 4005.54,   0.00, 0.00, 0.00);
	CreateDynamicObject(19379, 658.93, -1370.33, 4005.02,   0.00, 90.00, 0.00);
	CreateDynamicObject(3850, 659.68, -1348.35, 4005.54,   0.00, 0.00, 0.00);
	CreateDynamicObject(3850, 659.67, -1344.94, 4005.54,   0.00, 0.00, 0.00);
	CreateDynamicObject(19379, 659.54, -1364.45, 4005.00,   0.00, 90.00, 0.00);
	CreateDynamicObject(2198, 656.08, -1360.18, 4005.09,   0.00, 0.00, 270.00);
	CreateDynamicObject(2198, 656.10, -1358.28, 4005.09,   0.00, 0.00, 270.00);
	CreateDynamicObject(2198, 656.11, -1356.38, 4005.09,   0.00, 0.00, 270.00);
	CreateDynamicObject(2198, 656.11, -1354.52, 4005.09,   0.00, 0.00, 270.00);
	CreateDynamicObject(2165, 658.02, -1347.13, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2165, 658.11, -1349.61, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2165, 655.71, -1349.61, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2165, 655.76, -1347.22, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2198, 656.10, -1352.63, 4005.09,   0.00, 0.00, 270.00);
	CreateDynamicObject(2204, 664.70, -1352.41, 4005.10,   0.00, 0.00, 270.00);
	CreateDynamicObject(2198, 662.42, -1353.39, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2198, 661.42, -1352.36, 4005.09,   0.00, 0.00, 270.00);
	CreateDynamicObject(2198, 661.42, -1354.24, 4005.09,   0.00, 0.00, 270.00);
	CreateDynamicObject(2198, 662.44, -1355.26, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2165, 662.12, -1358.63, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2165, 662.04, -1361.38, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2165, 662.01, -1364.22, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2165, 662.03, -1366.86, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2165, 659.87, -1361.43, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2165, 659.87, -1358.58, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2165, 659.87, -1364.28, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2165, 659.87, -1366.96, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2165, 656.45, -1364.24, 4005.09,   0.00, 0.00, 270.00);
	CreateDynamicObject(2204, 664.57, -1360.38, 4005.10,   0.00, 0.00, 270.00);
	CreateDynamicObject(2204, 664.57, -1363.33, 4005.10,   0.00, 0.00, 270.00);
	CreateDynamicObject(2356, 654.94, -1364.78, 4005.09,   0.00, 0.00, 270.00);
	CreateDynamicObject(2356, 654.73, -1361.33, 4005.09,   0.00, 0.00, 270.00);
	CreateDynamicObject(2356, 654.55, -1356.99, 4005.09,   0.00, 0.00, 270.00);
	CreateDynamicObject(2356, 654.75, -1352.57, 4005.09,   0.00, 0.00, 270.00);
	CreateDynamicObject(2356, 657.12, -1349.32, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2356, 657.14, -1346.47, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2356, 659.41, -1349.25, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2356, 663.81, -1352.78, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2356, 663.87, -1354.58, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2356, 660.01, -1352.70, 4005.09,   0.00, 0.00, 270.00);
	CreateDynamicObject(2356, 663.58, -1357.76, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2356, 663.46, -1360.77, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2356, 663.46, -1360.77, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2356, 663.53, -1366.22, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2356, 661.27, -1363.59, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(2356, 661.31, -1358.25, 4005.09,   0.00, 0.00, 90.00);
	CreateDynamicObject(18762, 650.23, -1349.47, 4003.72,   0.00, 0.00, 0.00);
	CreateDynamicObject(1703, 648.42, -1345.38, 4001.58,   0.00, 0.00, 0.00);
	CreateDynamicObject(1703, 646.17, -1351.89, 4001.58,   0.00, 0.00, 90.00);
	CreateDynamicObject(1703, 646.16, -1348.18, 4001.58,   0.00, 0.00, 90.00);
	CreateDynamicObject(3989, 655.93, -1349.60, 4013.27,   0.00, 180.00, 0.00);
	CreateDynamicObject(14407, 644.94, -1362.78, 4000.12,   0.00, 0.00, 0.00);
	CreateDynamicObject(19379, 642.29, -1357.50, 4001.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 642.27, -1347.90, 4001.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(18762, 650.23, -1349.47, 4007.88,   0.00, 0.00, 0.00);
	CreateDynamicObject(3857, 654.21, -1348.87, 4001.80,   0.00, 0.00, 135.00);
	CreateDynamicObject(3857, 658.77, -1367.84, 4002.03,   0.00, 0.00, 135.00);
	CreateDynamicObject(4005, 658.66, -1380.69, 3990.74,   0.00, 270.00, 0.00);
	CreateDynamicObject(4005, 658.66, -1369.02, 3990.74,   0.00, 270.00, 1800.00);
	CreateDynamicObject(4005, 658.69, -1392.34, 3990.74,   0.00, 270.00, 0.00);
	CreateDynamicObject(3857, 648.45, -1348.43, 4001.59,   45.00, -90.00, 180.00);
	CreateDynamicObject(3857, 648.44, -1355.88, 4001.59,   45.00, -90.00, 180.00);
	CreateDynamicObject(3857, 648.55, -1363.33, 4001.59,   45.00, -90.00, 180.00);
	CreateDynamicObject(3857, 654.27, -1348.44, 4001.59,   45.00, -90.00, 180.00);
	CreateDynamicObject(3857, 660.09, -1348.43, 4001.59,   45.00, -90.00, 180.00);
	CreateDynamicObject(3857, 654.24, -1355.88, 4001.59,   45.00, -90.00, 180.00);
	CreateDynamicObject(3857, 660.05, -1355.89, 4001.59,   45.00, -90.00, 180.00);
	CreateDynamicObject(3857, 659.41, -1370.77, 4001.59,   45.00, -90.00, 180.00);
	CreateDynamicObject(3857, 654.26, -1363.34, 4001.59,   45.00, -90.00, 180.00);
	CreateDynamicObject(3857, 660.08, -1363.31, 4001.59,   45.00, -90.00, 180.00);
	CreateDynamicObject(3857, 653.61, -1370.80, 4001.59,   45.00, -90.00, 180.00);
	CreateDynamicObject(3857, 661.20, -1361.71, 4002.03,   0.00, 0.00, 45.00);
	CreateDynamicObject(19442, 655.03, -1361.77, 4003.32,   0.00, 0.00, 90.00);
	CreateDynamicObject(1502, 654.28, -1356.83, 4001.59,   0.00, 0.00, 90.00);
	CreateDynamicObject(1502, 654.28, -1361.68, 4001.58,   0.00, 0.00, 90.00);
	CreateDynamicObject(1502, 655.81, -1361.78, 4001.58,   0.00, 0.00, 0.00);
	CreateDynamicObject(1502, 658.70, -1362.54, 4001.58,   0.00, 0.00, 270.00);
	CreateDynamicObject(1502, 659.10, -1351.49, 4001.58,   0.00, 0.00, 180.00);
	CreateDynamicObject(16662, 657.63, -1345.03, 4011.12,   63.00, 90.00, 270.00);
	CreateDynamicObject(1886, 655.68, -1349.16, 4004.93,   0.00, 0.00, 156.32);
	CreateDynamicObject(1886, 657.82, -1349.19, 4004.93,   0.00, 0.00, 180.00);
	CreateDynamicObject(2491, 656.15, -1349.18, 4001.02,   0.00, 0.00, 0.00);
	CreateDynamicObject(2491, 657.35, -1349.20, 4001.02,   0.00, 0.00, 0.00);
	CreateDynamicObject(1886, 657.09, -1349.44, 4002.49,   0.00, 180.00, 180.00);
	CreateDynamicObject(2747, 657.19, -1347.09, 4002.14,   0.00, 0.00, 0.00);
	CreateDynamicObject(1714, 657.06, -1345.61, 4001.70,   0.00, 0.00, 0.00);
	CreateDynamicObject(1714, 658.93, -1346.67, 4001.70,   0.00, 0.00, 270.00);
	CreateDynamicObject(1714, 655.29, -1346.76, 4001.70,   0.00, 0.00, 90.00);
	CreateDynamicObject(2747, 660.74, -1358.00, 4002.18,   0.00, 0.00, 90.00);
	CreateDynamicObject(2747, 660.73, -1359.58, 4002.18,   0.00, 0.00, 90.00);
	CreateDynamicObject(1714, 662.08, -1357.62, 4001.70,   0.00, 0.00, 270.00);
	CreateDynamicObject(1714, 662.01, -1359.94, 4001.70,   0.00, 0.00, 270.00);
	CreateDynamicObject(1714, 662.11, -1358.85, 4001.70,   0.00, 0.00, 270.00);
	CreateDynamicObject(1714, 660.99, -1356.44, 4001.70,   0.00, 0.00, 0.00);
	CreateDynamicObject(1714, 660.99, -1361.14, 4001.70,   0.00, 0.00, 180.00);
	CreateDynamicObject(1886, 658.23, -1356.70, 4004.93,   0.00, 0.00, 90.00);
	CreateDynamicObject(1886, 658.01, -1358.65, 4004.93,   0.00, 0.00, 90.00);
	CreateDynamicObject(1886, 660.49, -1354.88, 4004.93,   0.00, 0.00, 0.00);
	CreateDynamicObject(1703, 654.93, -1354.69, 4001.59,   0.00, 0.00, 90.00);
	CreateDynamicObject(1703, 654.87, -1359.56, 4001.59,   0.00, 0.00, 90.00);
	CreateDynamicObject(1536, 645.68, -1358.05, 4001.59,   0.00, 0.00, 90.00);
	CreateDynamicObject(1536, 645.63, -1355.02, 4001.59,   0.00, 0.00, 270.00);
	CreateDynamicObject(1536, 662.48, -1351.86, 4001.59,   0.00, 0.00, 270.00);
	CreateDynamicObject(1536, 662.50, -1354.90, 4001.59,   0.00, 0.00, 90.00);
    
    //Interior Grotti, por Raul Lara
	CreateDynamicObject(6099, 542.23, -1279.21, 2000.00,   0.00, 0.00, 90.00);
	CreateDynamicObject(6099, 542.19, -1331.81, 2000.00,   0.00, 0.00, 90.00);
	CreateDynamicObject(6099, 501.03, -1305.10, 2000.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(6099, 583.06, -1300.78, 2000.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(19379, 519.22, -1304.66, 1995.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 529.68, -1314.07, 1995.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 529.68, -1304.45, 1995.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 540.13, -1304.47, 1995.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 540.15, -1314.09, 1995.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 550.63, -1314.14, 1995.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 550.62, -1304.55, 1995.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 561.11, -1314.18, 1995.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 561.08, -1304.57, 1995.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 571.57, -1314.10, 1995.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 571.55, -1304.47, 1995.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(2885, 519.38, -1301.56, 1996.05,   0.00, 0.00, 180.00);
	CreateObject(19379, 519.26, -1296.87, 1995.97,   0.00, 90.00, 0.00);
	CreateObject(19379, 529.75, -1296.87, 1995.97,   0.00, 90.00, 0.00);
	CreateDynamicObject(2885, 530.24, -1301.56, 1996.05,   0.00, 0.00, 180.00);
	CreateObject(19379, 540.23, -1296.87, 1995.97,   0.00, 90.00, 0.00);
	CreateObject(19379, 550.70, -1296.87, 1995.97,   0.00, 90.00, 0.00);
	CreateObject(19379, 561.16, -1296.87, 1995.97,   0.00, 90.00, 0.00);
	CreateObject(19379, 571.63, -1296.87, 1995.97,   0.00, 90.00, 0.00);
	CreateDynamicObject(2885, 541.11, -1301.56, 1996.05,   0.00, 0.00, 180.00);
	CreateDynamicObject(2885, 551.92, -1301.56, 1996.05,   0.00, 0.00, 180.00);
	CreateDynamicObject(2885, 562.77, -1301.56, 1996.05,   0.00, 0.00, 180.00);
	CreateDynamicObject(2885, 573.66, -1301.56, 1996.05,   0.00, 0.00, 180.00);
	CreateDynamicObject(6337, 550.05, -1293.74, 1998.88,   0.00, 0.00, 180.00);
	CreateDynamicObject(6337, 531.86, -1255.26, 1993.25,   0.00, 0.00, 50.00);
	CreateDynamicObject(6337, 563.87, -1255.14, 1993.25,   0.00, 0.00, 50.00);
	CreateDynamicObject(2885, 524.14, -1315.26, 2001.55,   0.00, 0.00, 180.00);
	CreateDynamicObject(14407, 524.60, -1311.36, 1995.73,   0.00, 0.00, 270.00);
	CreateDynamicObject(19379, 513.37, -1316.32, 1998.88,   0.00, 90.00, 0.00);
	CreateDynamicObject(14407, 520.27, -1313.27, 1998.36,   0.00, 0.00, 90.00);
	CreateDynamicObject(2885, 524.06, -1314.48, 1998.69,   0.00, 0.00, 180.00);
	CreateDynamicObject(19379, 527.49, -1315.49, 2001.47,   0.00, 90.00, 0.00);
	CreateDynamicObject(2885, 524.06, -1315.25, 2001.55,   0.00, 0.00, 0.00);
	CreateDynamicObject(2885, 516.58, -1311.42, 2000.73,   0.00, 0.00, 0.00);
	CreateDynamicObject(19379, 519.22, -1314.23, 1995.49,   0.00, 90.00, 0.00);
	CreateDynamicObject(2885, 529.41, -1315.45, 1996.07,   0.00, 90.00, 270.00);
	CreateDynamicObject(2885, 529.55, -1308.85, 1996.07,   0.00, 90.00, 0.00);
	CreateDynamicObject(2885, 522.86, -1308.85, 1996.07,   0.00, 90.00, 0.00);
	CreateDynamicObject(2885, 516.19, -1308.85, 1996.07,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 527.46, -1306.88, 2001.45,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 517.02, -1306.88, 2001.47,   0.00, 90.00, 0.00);
	CreateDynamicObject(2885, 516.60, -1311.53, 2001.56,   0.00, 0.00, 180.00);
	CreateDynamicObject(14407, 520.67, -1317.34, 1995.60,   0.00, 0.00, 270.00);
	CreateDynamicObject(19379, 537.92, -1306.88, 2001.45,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 548.39, -1306.88, 2001.45,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 558.87, -1306.88, 2001.45,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 569.30, -1306.88, 2001.45,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 537.88, -1316.36, 2001.47,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 548.25, -1316.36, 2001.47,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 558.69, -1316.36, 2001.47,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 569.15, -1316.36, 2001.47,   0.00, 90.00, 0.00);
	CreateDynamicObject(18766, 518.72, -1304.50, 2001.02,   90.00, 0.00, 0.00);
	CreateDynamicObject(18766, 528.67, -1304.50, 2001.02,   90.00, 0.00, 0.00);
	CreateDynamicObject(18766, 538.56, -1304.50, 2001.02,   90.00, 0.00, 0.00);
	CreateDynamicObject(18766, 548.38, -1304.50, 2001.02,   90.00, 0.00, 0.00);
	CreateDynamicObject(18766, 558.09, -1304.49, 2001.02,   90.00, 0.00, 0.00);
	CreateDynamicObject(18766, 567.95, -1304.49, 2001.02,   90.00, 0.00, 0.00);
	CreateDynamicObject(18766, 527.23, -1317.26, 2001.02,   90.00, 0.00, 0.00);
	CreateDynamicObject(19379, 527.49, -1315.49, 2000.59,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 517.02, -1306.88, 2000.59,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 527.46, -1306.88, 2000.59,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 537.92, -1306.88, 2000.59,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 537.88, -1316.36, 2000.59,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 548.25, -1316.36, 2000.59,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 548.39, -1306.88, 2000.59,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 558.87, -1306.88, 2000.59,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 558.69, -1316.36, 2000.59,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 569.15, -1316.36, 2000.59,   0.00, 90.00, 0.00);
	CreateDynamicObject(19379, 569.30, -1306.88, 2000.59,   0.00, 90.00, 0.00);
	CreateDynamicObject(970, 516.10, -1302.08, 2002.05,   0.00, 0.00, 0.00);
	CreateDynamicObject(970, 520.23, -1302.08, 2002.05,   0.00, 0.00, 0.00);
	CreateDynamicObject(970, 524.36, -1302.08, 2002.05,   0.00, 0.00, 0.00);
	CreateDynamicObject(970, 528.49, -1302.08, 2002.05,   0.00, 0.00, 0.00);
	CreateDynamicObject(970, 532.63, -1302.08, 2002.05,   0.00, 0.00, 0.00);
	CreateDynamicObject(970, 536.75, -1302.08, 2002.05,   0.00, 0.00, 0.00);
	CreateDynamicObject(970, 540.91, -1302.08, 2002.05,   0.00, 0.00, 0.00);
	CreateDynamicObject(970, 545.06, -1302.08, 2002.05,   0.00, 0.00, 0.00);
	CreateDynamicObject(970, 549.21, -1302.08, 2002.05,   0.00, 0.00, 0.00);
	CreateDynamicObject(970, 553.37, -1302.08, 2002.05,   0.00, 0.00, 0.00);
	CreateDynamicObject(970, 557.54, -1302.08, 2002.05,   0.00, 0.00, 0.00);
	CreateDynamicObject(970, 561.71, -1302.08, 2002.05,   0.00, 0.00, 0.00);
	CreateDynamicObject(970, 565.84, -1302.08, 2002.05,   0.00, 0.00, 0.00);
	CreateDynamicObject(970, 570.00, -1302.08, 2002.05,   0.00, 0.00, 0.00);
	//CreateDynamicObject(1703, 531.31, -1313.69, 90.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(1703, 530.12, -1315.21, 1995.55,   0.00, 0.00, 90.00);
	CreateDynamicObject(1703, 530.12, -1310.92, 1995.55,   0.00, 0.00, 90.00);
	CreateDynamicObject(1703, 529.10, -1308.13, 1995.55,   0.00, 0.00, 180.00);
	CreateDynamicObject(1703, 525.75, -1308.13, 1995.55,   0.00, 0.00, 180.00);
	CreateDynamicObject(1703, 522.27, -1308.13, 1995.55,   0.00, 0.00, 180.00);
	CreateDynamicObject(1703, 518.84, -1308.13, 1995.55,   0.00, 0.00, 180.00);
	CreateDynamicObject(2885, 529.38, -1315.37, 1996.07,   0.00, 90.00, 270.00);
	CreateDynamicObject(18070, 563.49, -1312.50, 1996.07,   0.00, 0.00, 270.00);
	CreateDynamicObject(2008, 561.80, -1311.69, 1995.75,   0.00, 0.00, 90.00);
	CreateDynamicObject(2008, 561.77, -1314.78, 1995.75,   0.00, 0.00, 90.00);
	CreateDynamicObject(2162, 563.21, -1315.13, 1995.64,   0.00, 0.00, 0.00);
	CreateDynamicObject(2162, 564.46, -1315.22, 1995.64,   0.00, 0.00, 0.00);
	CreateDynamicObject(2607, 564.61, -1309.69, 1996.17,   0.00, 0.00, 0.00);
	CreateDynamicObject(2607, 563.80, -1309.47, 1996.17,   0.00, 0.00, 0.00);
	CreateDynamicObject(2816, 562.76, -1309.61, 1996.58,   0.00, 0.00, 14.49);
	CreateDynamicObject(2816, 561.71, -1309.67, 1996.58,   0.00, 0.00, 325.12);
	CreateDynamicObject(18608, 558.71, -1304.45, 2009.24,   0.00, 0.00, 0.00);
	CreateDynamicObject(18608, 541.78, -1304.77, 2009.24,   0.00, 0.00, 0.00);
	CreateDynamicObject(18608, 524.44, -1305.56, 2009.24,   0.00, 0.00, 0.00);
	CreateDynamicObject(2165, 565.25, -1305.67, 2001.53,   0.00, 0.00, 90.00);
	CreateDynamicObject(2166, 566.25, -1307.63, 2001.53,   0.00, 0.00, 90.00);
	CreateDynamicObject(1714, 566.66, -1305.27, 2001.52,   0.00, 0.00, 270.00);
	CreateDynamicObject(1714, 566.63, -1306.69, 2001.52,   0.00, 0.00, 300.27);
	CreateDynamicObject(2165, 565.81, -1311.25, 2001.53,   0.00, 0.00, 0.00);
	CreateDynamicObject(2165, 557.86, -1311.39, 2001.53,   0.00, 0.00, 0.00);
	CreateDynamicObject(2165, 565.94, -1314.41, 2001.53,   0.00, 0.00, 0.00);
	CreateDynamicObject(2165, 565.81, -1311.25, 2001.53,   0.00, 0.00, 0.00);
	CreateDynamicObject(2165, 558.01, -1314.59, 2001.53,   0.00, 0.00, 0.00);
	CreateDynamicObject(2007, 568.57, -1318.32, 2001.56,   0.00, 0.00, 180.00);
	CreateDynamicObject(2007, 567.57, -1318.31, 2001.56,   0.00, 0.00, 180.00);
	CreateDynamicObject(2007, 565.35, -1318.26, 2001.56,   0.00, 0.00, 180.00);
	CreateDynamicObject(2007, 564.37, -1318.26, 2001.56,   0.00, 0.00, 180.00);
	CreateDynamicObject(2007, 563.38, -1318.25, 2001.56,   0.00, 0.00, 180.00);
	CreateDynamicObject(2007, 562.38, -1318.24, 2001.56,   0.00, 0.00, 180.00);
	CreateDynamicObject(2186, 561.22, -1318.32, 2001.54,   0.00, 0.00, 180.00);
	CreateDynamicObject(2186, 559.12, -1318.37, 2001.54,   0.00, 0.00, 180.00);
	CreateDynamicObject(2357, 559.24, -1306.44, 2001.96,   0.00, 0.00, 0.00);
	CreateDynamicObject(2357, 554.98, -1306.45, 2001.96,   0.00, 0.00, 0.00);
	CreateDynamicObject(2173, 549.74, -1311.52, 2001.53,   0.00, 0.00, 0.00);
	CreateDynamicObject(2173, 549.75, -1314.91, 2001.53,   0.00, 0.00, 0.00);
	CreateDynamicObject(2173, 545.65, -1313.27, 2001.53,   0.00, 0.00, 0.00);
	CreateDynamicObject(2186, 548.27, -1318.33, 2001.54,   0.00, 0.00, 180.00);
	CreateDynamicObject(2186, 545.87, -1318.30, 2001.54,   0.00, 0.00, 180.00);
	CreateDynamicObject(2166, 539.44, -1312.57, 2001.53,   0.00, 0.00, 0.00);
	CreateDynamicObject(2173, 541.37, -1311.58, 2001.53,   0.00, 0.00, 0.00);
	CreateDynamicObject(2165, 540.03, -1314.97, 2001.53,   0.00, 0.00, 0.00);
	CreateDynamicObject(1714, 566.20, -1312.61, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 566.31, -1315.72, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 558.57, -1312.58, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 558.68, -1315.99, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 550.50, -1315.95, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 550.24, -1312.68, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 546.24, -1314.96, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 541.01, -1316.16, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 541.98, -1312.66, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 540.67, -1312.81, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(2357, 550.74, -1306.45, 2001.96,   0.00, 0.00, 0.00);
	CreateDynamicObject(18762, 540.94, -1309.99, 1997.83,   0.00, 0.00, 0.00);
	CreateDynamicObject(18762, 552.96, -1310.01, 1997.83,   0.00, 0.00, 0.00);
	CreateDynamicObject(18762, 552.96, -1310.01, 1999.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(18762, 540.94, -1309.99, 1998.96,   0.00, 0.00, 0.00);
	CreateDynamicObject(1703, 541.75, -1307.95, 1995.55,   0.00, 0.00, 180.00);
	CreateDynamicObject(1703, 539.08, -1308.71, 1995.55,   0.00, 0.00, 270.00);
	CreateDynamicObject(1703, 542.44, -1310.71, 1995.55,   0.00, 0.00, 90.00);
	CreateDynamicObject(1703, 539.74, -1311.47, 1995.55,   0.00, 0.00, 0.00);
	CreateDynamicObject(1703, 554.82, -1310.84, 1995.55,   0.00, 0.00, 90.00);
	CreateDynamicObject(1703, 554.10, -1308.14, 1995.55,   0.00, 0.00, 180.00);
	CreateDynamicObject(1703, 551.32, -1308.83, 1995.55,   0.00, 0.00, 270.00);
	CreateDynamicObject(1703, 552.04, -1311.62, 1995.55,   0.00, 0.00, 0.00);
	CreateDynamicObject(1703, 554.93, -1318.27, 1995.55,   0.00, 0.00, 180.00);
	CreateDynamicObject(1703, 551.76, -1318.27, 1995.55,   0.00, 0.00, 180.00);
	CreateDynamicObject(1703, 541.08, -1318.28, 1995.55,   0.00, 0.00, 180.00);
	CreateDynamicObject(1703, 537.97, -1318.30, 1995.55,   0.00, 0.00, 180.00);
	CreateDynamicObject(1569, 543.87, -1318.85, 1995.57,   0.00, 0.00, 0.00);
	CreateDynamicObject(1569, 546.87, -1318.85, 1995.57,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 550.15, -1308.24, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 552.00, -1308.23, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 553.69, -1308.25, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 555.48, -1308.17, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 557.91, -1308.06, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 560.04, -1307.98, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 562.25, -1306.55, 2001.52,   0.00, 0.00, 270.00);
	CreateDynamicObject(1714, 560.16, -1304.81, 2001.52,   0.00, 0.00, 0.00);
	CreateDynamicObject(1714, 557.88, -1304.79, 2001.52,   0.00, 0.00, 0.00);
	CreateDynamicObject(1714, 555.78, -1304.80, 2001.52,   0.00, 0.00, 0.00);
	CreateDynamicObject(1714, 553.82, -1304.79, 2001.52,   0.00, 0.00, 0.00);
	CreateDynamicObject(1714, 551.27, -1304.85, 2001.52,   0.00, 0.00, 0.00);
	CreateDynamicObject(1714, 549.42, -1304.85, 2001.52,   0.00, 0.00, 0.00);
	CreateDynamicObject(1714, 547.50, -1306.48, 2001.52,   0.00, 0.00, 90.00);
	CreateDynamicObject(2173, 561.51, -1313.08, 2001.53,   0.00, 0.00, 0.00);
	CreateDynamicObject(1714, 561.75, -1314.09, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(2166, 541.35, -1308.15, 2001.53,   0.00, 0.00, 90.00);
	CreateDynamicObject(2173, 540.35, -1306.20, 2001.53,   0.00, 0.00, 90.00);
	CreateDynamicObject(1714, 541.69, -1306.08, 2001.52,   0.00, 0.00, 255.79);
	CreateDynamicObject(2165, 533.75, -1311.96, 2001.53,   0.00, 0.00, 0.00);
	CreateDynamicObject(2165, 533.69, -1315.38, 2001.53,   0.00, 0.00, 0.00);
	CreateDynamicObject(2165, 528.61, -1311.82, 2001.53,   0.00, 0.00, 0.00);
	CreateDynamicObject(2165, 528.37, -1315.20, 2001.53,   0.00, 0.00, 0.00);
	CreateDynamicObject(1714, 534.23, -1313.32, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 534.18, -1316.67, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 529.13, -1313.04, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(1714, 528.90, -1316.39, 2001.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(1811, 529.30, -1310.27, 2002.18,   0.00, 0.00, 90.00);
	CreateDynamicObject(1811, 533.73, -1310.64, 2002.18,   0.00, 0.00, 90.00);
	CreateDynamicObject(1811, 534.96, -1310.54, 2002.18,   0.00, 0.00, 90.00);
	CreateDynamicObject(1811, 539.85, -1310.12, 2002.18,   0.00, 0.00, 90.00);
	CreateDynamicObject(1811, 541.81, -1310.15, 2002.18,   0.00, 0.00, 90.00);
	CreateDynamicObject(1811, 545.88, -1311.83, 2002.18,   0.00, 0.00, 90.00);
	CreateDynamicObject(1811, 549.79, -1310.23, 2002.18,   0.00, 0.00, 90.00);
	CreateDynamicObject(1811, 550.99, -1310.07, 2002.18,   0.00, 0.00, 90.00);
	CreateDynamicObject(1811, 558.03, -1310.12, 2002.18,   0.00, 0.00, 90.00);
	CreateDynamicObject(1811, 561.59, -1311.68, 2002.18,   0.00, 0.00, 90.00);
	CreateDynamicObject(1811, 566.02, -1310.03, 2002.18,   0.00, 0.00, 90.00);
	CreateDynamicObject(2166, 530.72, -1307.81, 2001.53,   0.00, 0.00, 90.00);
	CreateDynamicObject(2166, 541.35, -1308.15, 2001.53,   0.00, 0.00, 90.00);
	CreateDynamicObject(2166, 533.15, -1304.59, 2001.53,   0.00, 0.00, 270.00);
	CreateDynamicObject(1714, 530.97, -1307.04, 2001.52,   0.00, 0.00, 264.88);
	CreateDynamicObject(1714, 532.84, -1305.48, 2001.52,   0.00, 0.00, 101.01);
	CreateDynamicObject(2030, 521.73, -1308.85, 2001.93,   0.00, 0.00, 0.00);
	CreateDynamicObject(2030, 517.38, -1304.87, 2001.93,   0.00, 0.00, 0.00);
	CreateDynamicObject(2030, 517.04, -1309.86, 2001.93,   0.00, 0.00, 0.00);
	CreateDynamicObject(2030, 524.07, -1305.23, 2001.93,   0.00, 0.00, 0.00);
	CreateDynamicObject(1704, 520.54, -1307.18, 2001.54,   0.00, 0.00, 19.88);
	CreateDynamicObject(1704, 523.84, -1308.65, 2001.54,   0.00, 0.00, 270.00);
	CreateDynamicObject(1704, 525.85, -1304.41, 2001.54,   0.00, 0.00, 283.77);
	CreateDynamicObject(1704, 525.27, -1307.08, 2001.54,   0.00, 0.00, 201.56);
	CreateDynamicObject(1704, 516.00, -1303.35, 2001.54,   0.00, 0.00, 19.88);
	CreateDynamicObject(1704, 519.04, -1304.78, 2001.54,   0.00, 0.00, 263.42);
	CreateDynamicObject(1704, 518.81, -1309.87, 2001.54,   0.00, 0.00, 263.42);
	CreateDynamicObject(1704, 515.34, -1308.56, 2001.54,   0.00, 0.00, 19.88);
	CreateDynamicObject(970, 520.04, -1311.67, 2002.05,   0.00, 0.00, 0.00);
	CreateDynamicObject(970, 515.88, -1311.67, 2002.05,   0.00, 0.00, 0.00);
	CreateDynamicObject(2816, 540.19, -1305.55, 2002.33,   0.00, 0.00, 90.00);
	CreateDynamicObject(2816, 549.25, -1306.41, 2002.39,   0.00, 0.00, 90.00);
	CreateDynamicObject(2816, 552.51, -1306.33, 2002.39,   0.00, 0.00, 0.00);
	CreateDynamicObject(2816, 555.49, -1306.76, 2002.39,   0.00, 0.00, 0.00);
	CreateDynamicObject(2816, 559.07, -1306.31, 2002.39,   0.00, 0.00, 0.00);
	CreateDynamicObject(2816, 524.19, -1305.43, 2002.33,   0.00, 0.00, 90.00);
	CreateDynamicObject(2816, 521.68, -1308.83, 2002.33,   0.00, 0.00, 90.00);
	CreateDynamicObject(1704, 522.51, -1304.43, 2001.54,   0.00, 0.00, 51.35);
	CreateDynamicObject(2816, 517.54, -1304.75, 2002.33,   0.00, 0.00, 90.00);
	CreateDynamicObject(3989, 535.92, -1314.14, 2013.52,   180.00, 0.00, 90.0);
    new GR_IN = CreateDynamicObject(8171, 558.45288, -1301.84851, 1994.75122,   0.00000, 90.00000, 90.00000);
    SetDynamicObjectMaterial(GR_IN, 0, 0, "null", "null");
    SetDynamicObjectMaterial(GR_IN, 1, 0, "null", "null");
    //Banderas de la playa:D
    CreateDynamicObject(2914, 202.23430, -1874.76587, 5.17571,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2914, 247.91109, -1875.23926, 5.17570,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2914, 290.73431, -1874.76587, 5.17570,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2914, 339.23431, -1874.76587, 5.51527,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2914, 446.73431, -1874.76587, 5.84344,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2914, 500.23431, -1874.76587, 6.12100,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2914, 554.73431, -1874.76587, 6.87857,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2914, 611.23431, -1874.76587, 7.16682,   0.00000, 0.00000, 0.00000);
	
	//Línea A
	CreateDynamicObject(1257, 2272.45337, -1755.43152, 13.69912,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1257, 2864.20752, -1936.07349, 11.26639,   0.00000, 0.00000, 0.00000);
	
	//Estación de buses
	new alsa = CreateDynamicObject(19353, 2091.6943, -1936.0585, 16.7529, 0.0000, 0.0000, -180);
	SetDynamicObjectMaterialText(alsa, 0, "ALSA", 140, "Arial", 190, 1, -16776961, 0, 1);
	CreateDynamicObject(19353, 2097.3312, -1916.6547, 16.4643, 0.0000, 0.0000, 90.0);
	SetDynamicObjectMaterialText(alsa+1, 0, "ALSA", 140, "Arial", 190, 1, -16776961, 0, 1);
	CreateDynamicObject(19353, 2101.8825, -1929.0711, 16.3706, 0.0000, 0.0000, 0.0);
	SetDynamicObjectMaterialText(alsa+2, 0, "ALSA", 140, "Arial", 190, 1, -16776961, 0, 1);
	CreateDynamicObject(19353, 2091.7246, -1920.8950, 16.2603, 0.0000, 0.0000, 180);
	SetDynamicObjectMaterialText(alsa+3, 0, "ALSA AUTOCARES", 140, "Arial", 64, 1, -16776961, 0, 1);
	CreateDynamicObject(8661, 2163.34961, -1942.65820, 12.51063,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(973, 2162.89648, -1925.79736, 13.35650,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2187.08008, -1931.11646, 12.43800,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2144.09277, -1907.89648, 12.43800,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2154.54053, -1907.81787, 12.43800,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(973, 2177.56738, -1939.12732, 13.35650,   0.00000, 0.00000, 40.00000);
	CreateDynamicObject(973, 2162.89648, -1929.63745, 13.35650,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(973, 2156.19702, -1929.64172, 13.35650,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2165.07251, -1927.69373, 12.92690,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2154.24707, -1927.75659, 12.92690,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2161.82593, -1927.96143, 12.92690,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(973, 2162.89648, -1925.79736, 13.35650,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(973, 2162.89648, -1929.63745, 13.35650,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(973, 2156.19702, -1929.64172, 13.35650,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1257, 2145.55566, -1909.55225, 13.76600,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1257, 2155.29565, -1909.55225, 13.76600,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1257, 2164.63574, -1909.55225, 13.76600,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1257, 2173.11572, -1909.55225, 13.76600,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3578, 2182.02295, -1917.42896, 11.75530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3578, 2173.67749, -1912.52368, 11.75530,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3578, 2163.85767, -1912.52368, 11.75530,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3578, 2154.01758, -1912.52368, 11.75530,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3578, 2177.01758, -1912.52368, 11.75530,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3578, 2182.00293, -1927.72900, 11.75530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3578, 2182.00293, -1931.40906, 11.75530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1229, 2175.58496, -1911.49817, 13.64750,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1229, 2148.88452, -1911.41614, 13.64750,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1229, 2158.43481, -1911.42676, 13.64750,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1229, 2167.46362, -1911.32837, 13.64750,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(641, 2191.14038, -1904.24207, 9.95020,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2092.87988, -1905.82019, 9.95020,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2159.78149, -1927.83496, 9.95020,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2152.10400, -1926.31677, 13.07830,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2152.10400, -1929.09680, 13.07830,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2177.91919, -1938.19043, 13.07830,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2166.79980, -1929.33691, 13.12340,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2166.79980, -1927.87695, 13.12340,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2166.79980, -1926.27686, 13.12340,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2121.41382, -1907.79480, 12.43840,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(3578, 2138.64355, -1907.45483, 11.75530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3578, 2126.89771, -1907.89136, 11.75530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3578, 2113.50708, -1912.85767, 11.75530,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3578, 2101.07495, -1917.69006, 11.75530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3626, 2196.89136, -1970.04407, 14.00000,   356.85840, 0.00000, 3.14159);
	CreateDynamicObject(3626, 2098.00000, 9614.00000, -1920.00000,   270.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2091.68994, -1935.68506, 10.10080,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2096.07129, -1940.69653, 12.58080,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3851, 2101.35522, -1936.51099, 13.16490,   -91.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2096.30713, -1921.38196, 18.80080,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19435, 2091.65088, -1928.69897, 14.01002,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19435, 2091.65088, -1928.69897, 17.03280,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2091.75830, -1935.68701, 12.58080,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2091.75830, -1935.68701, 10.52080,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3851, 2094.09497, -1940.84863, 13.24490,   -91.00000, 0.00000, 90.00000);
	CreateDynamicObject(3851, 2091.97925, -1926.69885, 13.00490,   -91.00000, 0.00000, 0.00000);
	CreateDynamicObject(3851, 2091.97925, -1922.69885, 13.00490,   -91.00000, 0.00000, 0.00000);
	CreateDynamicObject(3851, 2094.05542, -1916.78589, 13.00490,   -91.00000, 0.00000, 90.00000);
	CreateDynamicObject(19435, 2091.83081, -1928.69897, 13.99280,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19435, 2091.95093, -1928.69897, 13.99280,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19435, 2092.04712, -1928.70911, 13.99280,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19435, 2091.75098, -1928.69897, 17.03280,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19435, 2092.05078, -1928.69897, 17.03280,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2091.81934, -1921.63428, 12.58080,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2091.73950, -1921.63428, 12.58080,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2096.07422, -1940.85986, 12.58080,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19377, 2096.15405, -1940.85986, 12.58080,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3851, 2091.97925, -1935.57886, 13.16490,   -91.00000, 0.00000, 0.00000);
	CreateDynamicObject(3851, 2098.07495, -1940.86865, 13.24490,   -91.00000, 0.00000, 90.00000);
	CreateDynamicObject(3851, 2099.47510, -1940.86865, 13.24490,   -91.00000, 0.00000, 90.00000);
	CreateDynamicObject(19377, 2091.89941, -1936.01428, 12.56080,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3851, 2091.97925, -1931.55884, 13.16490,   -91.00000, 0.00000, 0.00000);
	CreateDynamicObject(3851, 2101.36523, -1932.59253, 13.16490,   -91.00000, 0.00000, 0.00000);
	CreateDynamicObject(3851, 2101.36523, -1938.95251, 13.16490,   -91.00000, 0.00000, 0.00000);
	CreateDynamicObject(3851, 2101.36523, -1926.07251, 13.16490,   -91.00000, 0.00000, 0.00000);
	CreateDynamicObject(3851, 2101.36523, -1922.53247, 13.16490,   -91.00000, 0.00000, 0.00000);
	CreateDynamicObject(3851, 2101.37671, -1918.67017, 13.16490,   -91.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2100.98853, -1921.56250, 12.58080,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2096.56177, -1916.71765, 12.58080,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3851, 2091.97925, -1918.81885, 13.00490,   -91.00000, 0.00000, 0.00000);
	CreateDynamicObject(3851, 2094.05542, -1916.78589, 13.00490,   -91.00000, 0.00000, 90.00000);
	CreateDynamicObject(3851, 2098.05542, -1916.78589, 13.10490,   -91.00000, 0.00000, 90.00000);
	CreateDynamicObject(3851, 2099.45532, -1916.78589, 13.10490,   -91.00000, 0.00000, 90.00000);
	CreateDynamicObject(19377, 2096.57422, -1940.85986, 12.58080,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19377, 2096.59131, -1940.69653, 12.58080,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3851, 2091.97925, -1938.97888, 13.16490,   -91.00000, 0.00000, 0.00000);
	CreateDynamicObject(3578, 2143.79761, -1912.52368, 11.75530,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3578, 2125.45972, -1941.28516, 11.91530,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2091.89941, -1921.63428, 12.58080,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2100.98853, -1935.90247, 12.58080,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1557, 2095.87378, -1916.66626, 12.41490,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1557, 2098.89404, -1916.63965, 12.43960,   0.00000, 0.00000, -180.00000);
	CreateDynamicObject(3578, 2106.05566, -1912.85315, 11.75530,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2104.51660, -1903.18884, 12.89570,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2102.73657, -1903.18884, 12.89570,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2105.18311, -1945.78357, 12.49840,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2116.04565, -1946.00049, 12.49840,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2124.34863, -1946.04919, 12.49840,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(3578, 2121.98706, -1912.87769, 11.75530,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3578, 2106.00171, -1941.23645, 11.91530,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3578, 2115.54077, -1941.26648, 11.91530,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3578, 2131.31982, -1941.28516, 11.91530,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2183.24878, -1904.12439, 14.35050,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2163.94873, -1904.12439, 14.35050,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2148.50879, -1904.12439, 14.31120,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3660, 2092.40356, -1913.96240, 14.35050,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(641, 2164.95239, -1927.91150, 9.95020,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2183.60034, -1904.24207, 9.95020,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2176.18042, -1904.24207, 9.95020,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2169.04028, -1904.24207, 9.95020,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2161.86035, -1904.24207, 9.95020,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2153.82031, -1904.24207, 9.95020,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2145.36035, -1904.24207, 9.95020,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(973, 2156.19702, -1925.80176, 13.35650,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(973, 2134.52148, -1950.24756, 13.35650,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(973, 2152.43579, -1949.58240, 13.35650,   0.00000, 0.00000, 9.00000);
	CreateDynamicObject(973, 2159.99976, -1948.43604, 13.35650,   0.00000, 0.00000, 9.00000);
	CreateDynamicObject(973, 2168.44897, -1945.49487, 13.35650,   0.00000, 0.00000, 30.00000);
	CreateDynamicObject(973, 2194.69580, -1909.88721, 13.35650,   0.00000, 0.00000, 80.00000);
	CreateDynamicObject(1215, 2152.10400, -1927.69678, 13.07830,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2148.46313, -1949.84961, 13.07830,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2172.48291, -1942.76538, 13.07830,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2164.75122, -1947.09216, 13.07830,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2155.71680, -1948.87427, 13.07830,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2153.71436, -1927.81226, 9.95020,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2092.87988, -1909.30017, 9.95020,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2092.87988, -1912.02014, 9.95020,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(641, 2092.87988, -1915.16016, 9.95020,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2168.76245, -1909.63098, 14.59110,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2160.07373, -1909.58618, 14.59110,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(973, 2176.20557, -1940.15063, 13.35650,   0.00000, 0.00000, 39.39021);
	CreateDynamicObject(973, 2183.58301, -1933.45728, 13.35650,   0.00000, 0.00000, 50.00000);
	CreateDynamicObject(973, 2188.74951, -1926.12585, 13.35650,   0.00000, 0.00000, 60.00000);
	CreateDynamicObject(973, 2192.63037, -1917.98877, 13.35650,   0.00000, 0.00000, 70.00000);
	CreateDynamicObject(1256, 2192.60132, -1911.76172, 13.29517,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1256, 2108.99097, -1947.24182, 13.29520,   0.00000, 0.00000, -90.02000);
	CreateDynamicObject(1256, 2190.93945, -1917.80176, 13.29517,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2102.65796, -1907.87134, 14.59110,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2178.82397, -1909.80542, 14.59110,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2184.39819, -1910.47510, 14.59110,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2184.88672, -1927.89209, 14.59110,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2185.29688, -1918.18665, 14.59110,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1256, 2189.11279, -1923.11841, 13.29517,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1256, 2124.66504, -1947.18787, 13.29520,   0.00000, 0.00000, -90.02000);
	CreateDynamicObject(1256, 2105.54932, -1907.52722, 13.29520,   0.00000, 0.00000, -90.02000);
	CreateDynamicObject(973, 2143.00000, 3257.00000, -1951.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(973, 2143.00000, 3257.00000, -1950.00000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2099.08228, -1915.79321, 13.75450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2095.33423, -1915.61975, 13.75450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2105.47363, -1947.03198, 13.78276,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2192.31470, -1908.93665, 13.78276,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2191.24707, -1914.58350, 13.78276,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2189.47607, -1920.26892, 13.78276,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2187.47021, -1925.82458, 13.78276,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2128.40039, -1947.22485, 13.78276,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2103.38208, -1907.67737, 13.78276,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2128.40039, -1947.22485, 13.78276,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2106.71606, -1947.41699, 14.20120,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2129.94922, -1947.33154, 14.20120,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2122.04834, -1947.37231, 14.20120,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2114.79565, -1947.30652, 14.20120,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2112.97681, -1947.29504, 13.78276,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(973, 2143.32568, -1950.25146, 13.35650,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(973, 2127.54150, -1950.24756, 13.35650,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(973, 2118.92139, -1950.24756, 13.35650,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(973, 2110.84155, -1950.24756, 13.35650,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(973, 2100.54883, -1945.61243, 13.35650,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(973, 2104.84155, -1950.24756, 13.35650,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2105.86475, -1946.02026, 12.49840,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2101.42627, -1928.70837, 12.24080,   45.00000, 0.00000, 0.00000);
	CreateDynamicObject(869, 2158.13208, -1927.91602, 12.92690,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2150.95605, -1909.29614, 14.59110,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2140.43018, -1909.41284, 14.59110,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2123.68872, -1907.90088, 14.59110,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2115.87671, -1907.95203, 14.59110,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1231, 2108.67822, -1908.04077, 14.59110,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1256, 2117.02417, -1947.30603, 13.29520,   0.00000, 0.00000, -90.02000);
	CreateDynamicObject(646, 2120.58813, -1947.35449, 13.78276,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2122.09741, -1907.78052, 13.78276,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2117.28784, -1907.72498, 13.78276,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2114.21924, -1907.76953, 13.78276,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2110.14014, -1907.94922, 13.78276,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(646, 2107.69800, -1907.92285, 13.78276,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1256, 2119.54639, -1907.72339, 13.29520,   0.00000, 0.00000, -90.02000);
	CreateDynamicObject(1256, 2105.62769, -1908.75891, 13.29520,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1256, 2112.23584, -1907.50073, 13.29520,   0.00000, 0.00000, -90.02000);
	CreateDynamicObject(1256, 2112.27417, -1908.83887, 13.29520,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1256, 2119.63232, -1908.94128, 13.29520,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3851, 2101.36523, -1929.99255, 13.16490,   -91.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2096.09131, -1940.57654, 12.58080,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19377, 2096.55786, -1945.57312, 12.44580,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2133.99536, -1946.04834, 12.49840,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(3578, 2134.03979, -1941.28516, 11.91530,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8843, 2155.36865, -1918.18970, 12.52850,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(8843, 2172.87939, -1927.69873, 12.52850,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8843, 2155.36182, -1937.20898, 12.52850,   0.00000, 0.00000, -90.02000);
	CreateDynamicObject(3578, 2143.49756, -1912.54370, 11.75530,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1215, 2106.61133, -1903.18530, 12.89570,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2101.36621, -1928.70837, 12.24080,   45.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2101.50635, -1928.70837, 12.24080,   45.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2101.66626, -1928.70837, 12.24080,   45.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2101.82642, -1928.70837, 12.24080,   45.00000, 0.00000, 0.00000);
	CreateDynamicObject(1315, 2134.95898, -1904.41711, 15.81250,   3.14160, 0.00000, 0.57080);
	CreateDynamicObject(1315, 2092.91406, -1891.37500, 15.81250,   3.14159, 0.00000, 1.57080);
	CreateDynamicObject(1315, 2111.69434, -1897.16431, 15.81250,   356.85840, 0.00000, -90.14160);
	CreateDynamicObject(1315, 2084.53125, -1905.49219, 15.81250,   356.85840, 0.00000, 3.14159);
	CreateDynamicObject(3627, 2124.18237, -1931.39026, 16.14126,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19377, 2110.91382, -1907.79480, 12.43840,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2100.41382, -1907.79480, 12.43840,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2092.41382, -1907.79480, 12.42540,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2095.91382, -1917.29480, 12.43840,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(8661, 2123.34961, -1942.65820, 12.51060,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8661, 2097.35815, -1929.10876, 12.50380,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(8661, 2163.34961, -1922.68945, 12.51060,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8661, 2123.34961, -1922.68945, 12.51060,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8661, 2135.81616, -1913.99829, 12.46450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19425, 2136.72974, -1912.72278, 12.44630,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19425, 2132.98315, -1912.72278, 12.44630,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19425, 2129.22974, -1912.72278, 12.44630,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(966, 2135.91821, -1907.14319, 12.38615,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(968, 2135.91821, -1907.14319, 13.13990,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19377, 2187.08008, -1921.61646, 12.43800,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2187.08008, -1911.97986, 12.43800,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2187.08008, -1904.97986, 12.45521,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2197.58008, -1908.97986, 12.45520,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2197.58008, -1918.47986, 12.45520,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2165.04053, -1907.81787, 12.43800,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2175.54053, -1907.81787, 12.43800,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2180.54053, -1907.81787, 12.42444,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2096.30713, -1930.88196, 18.80080,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19377, 2096.30713, -1936.38196, 18.84005,   0.00000, 90.00000, 0.00000);
	
    // Interior Hotel
    CreateDynamicObject(5709,1476.56000000,-1551.35000000,2000.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(5709,1476.52000000,-1567.51000000,2000.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(5709,1465.82000000,-1597.25000000,2000.00000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(5709,1453.07000000,-1531.97000000,2000.00000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(5709,1442.34000000,-1526.64000000,2000.00000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(5709,1417.03000000,-1542.09000000,2000.12000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(18755,1437.42000000,-1542.73000000,2012.27000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(5709,1435.12000000,-1522.43000000,2000.00000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(5709,1417.06000000,-1542.12000000,2000.16000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(5709,1468.56000000,-1577.75000000,2000.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(5709,1415.48000000,-1598.84000000,2000.00000000,0.00000000,0.00000000,219.14000000); //
	CreateDynamicObject(5709,1436.94000000,-1600.58000000,2000.00000000,0.00000000,0.00000000,265.75000000); //
	CreateDynamicObject(5709,1453.16000000,-1601.82000000,2000.00000000,0.00000000,0.00000000,265.75000000); //
	CreateDynamicObject(19379,1426.13000000,-1549.59000000,1991.09000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1436.63000000,-1549.65000000,1991.09000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1447.11000000,-1549.64000000,1991.09000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1457.62000000,-1549.63000000,1991.09000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1453.14000000,-1559.24000000,1991.09000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1453.12000000,-1568.85000000,1991.09000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1453.11000000,-1578.46000000,1991.09000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1442.65000000,-1559.20000000,1991.09000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1442.64000000,-1568.84000000,1991.09000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1442.63000000,-1578.24000000,1991.09000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1432.15000000,-1578.48000000,1991.09000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1421.66000000,-1578.47000000,1991.09000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1432.15000000,-1568.86000000,1991.09000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1421.68000000,-1568.87000000,1991.09000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1432.17000000,-1559.22000000,1991.09000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1421.69000000,-1559.22000000,1991.09000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(3851,1450.36000000,-1556.48000000,1991.78000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(3851,1450.36000000,-1570.81000000,1991.78000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1536,1450.35000000,-1565.08000000,1991.16000000,0.00000000,0.00000000,219.38000000); //
	CreateDynamicObject(1536,1450.42000000,-1562.18000000,1991.22000000,0.00000000,0.00000000,137.16000000); //
	CreateDynamicObject(3851,1450.36000000,-1569.36000000,1995.77000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(3851,1450.36000000,-1558.06000000,1995.78000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(3851,1450.38000000,-1545.19000000,1991.78000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(3851,1450.39000000,-1546.78000000,1995.74000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(3851,1450.36000000,-1569.36000000,1999.76000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(3851,1450.36000000,-1558.06000000,1999.77000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(3851,1450.39000000,-1546.78000000,1999.76000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(3851,1450.36000000,-1569.36000000,2003.75000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(3851,1450.36000000,-1558.06000000,2003.75000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(3851,1450.39000000,-1546.78000000,2003.75000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(5709,1472.62000000,-1577.77000000,2000.00000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(5709,1409.98000000,-1542.12000000,2000.12000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(3851,1444.72000000,-1575.19000000,1991.78000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1536,1439.05000000,-1575.22000000,1991.16000000,0.00000000,0.00000000,55.02000000); //
	CreateDynamicObject(1536,1436.09000000,-1575.21000000,1991.16000000,0.00000000,0.00000000,118.43000000); //
	CreateDynamicObject(3851,1430.46000000,-1575.19000000,1991.78000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(3851,1444.72000000,-1575.19000000,1995.78000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(3851,1433.41000000,-1575.19000000,1995.78000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(3851,1419.20000000,-1575.19000000,1991.78000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(3851,1422.10000000,-1575.19000000,1995.78000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(3851,1444.72000000,-1575.19000000,1999.77000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(3851,1433.41000000,-1575.19000000,1999.77000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(3851,1422.10000000,-1575.19000000,1999.77000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(3851,1444.72000000,-1575.19000000,2003.75000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(3851,1433.41000000,-1575.19000000,2003.75000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(3851,1422.10000000,-1575.19000000,2003.75000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(5709,1402.81000000,-1567.88000000,2000.10000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(5709,1401.74000000,-1577.40000000,2006.06000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(5709,1418.22000000,-1591.97000000,2000.00000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(14407,1414.59000000,-1572.23000000,1987.96000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(5709,1418.19000000,-1591.96000000,1986.24000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(5709,1405.37000000,-1552.37000000,1986.24000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(5709,1399.98000000,-1552.36000000,1993.32000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19379,1404.21000000,-1569.48000000,1985.79000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(5709,1402.99000000,-1553.38000000,2000.12000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(19379,1404.21000000,-1569.48000000,1991.23000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(5709,1391.28000000,-1571.34000000,2000.11000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(19379,1393.69000000,-1568.30000000,1991.23000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1393.69000000,-1577.93000000,1991.23000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1393.77000000,-1574.58000000,1985.77000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1392.37000000,-1568.20000000,1985.79000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(5709,1422.84000000,-1579.25000000,1986.18000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19379,1402.33000000,-1578.83000000,1985.79000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(5709,1402.42000000,-1597.15000000,1986.18000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(5709,1370.45000000,-1577.20000000,1987.37000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(19379,1389.96000000,-1551.22000000,1991.23000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19447,1431.66000000,-1549.73000000,1972.62000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19447,1431.66000000,-1559.38000000,1972.62000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(18981,1446.25000000,-1557.37000000,2004.19000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(18981,1446.01000000,-1577.05000000,2004.19000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(18981,1432.14000000,-1555.48000000,1979.61000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(18981,1421.24000000,-1577.73000000,2004.19000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(18981,1429.28000000,-1557.30000000,2004.19000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(18981,1420.15000000,-1567.52000000,1979.61000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(18981,1421.54000000,-1555.47000000,1979.61000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(18981,1420.03000000,-1545.25000000,1979.61000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19379,1434.76000000,-1556.13000000,1986.15000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19379,1434.55000000,-1556.13000000,1986.33000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19379,1434.36000000,-1556.13000000,1986.43000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19379,1434.20000000,-1556.13000000,1986.53000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19379,1434.04000000,-1556.13000000,1986.67000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19379,1433.85000000,-1556.13000000,1986.79000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19379,1433.67000000,-1556.13000000,1986.95000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19379,1433.50000000,-1556.13000000,1987.03000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19379,1428.21000000,-1556.13000000,1992.10000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1427.80000000,-1551.39000000,1986.86000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19379,1423.03000000,-1556.12000000,1986.86000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19379,1427.77000000,-1560.83000000,1986.86000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19379,1404.14000000,-1577.41000000,1991.23000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(3077,1452.01000000,-1568.95000000,1991.13000000,0.00000000,0.00000000,298.79000000); //
	CreateDynamicObject(1731,1441.94000000,-1545.00000000,1994.89000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1731,1443.84000000,-1545.00000000,1994.89000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1731,1445.60000000,-1545.09000000,1994.89000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1731,1447.34000000,-1545.00000000,1994.89000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(630,1441.52000000,-1545.42000000,1992.91000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(630,1443.33000000,-1545.59000000,1992.91000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(630,1445.62000000,-1545.54000000,1992.92000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(630,1447.82000000,-1545.60000000,1992.91000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(3851,1437.24000000,-1544.82000000,1999.71000000,90.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(3851,1441.23000000,-1544.82000000,1999.85000000,90.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1445.41000000,-1545.33000000,1991.19000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1445.79000000,-1545.04000000,1991.49000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1446.01000000,-1544.79000000,1991.67000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1445.57000000,-1545.20000000,1991.33000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1445.41000000,-1545.33000000,1991.19000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(1703,1445.49000000,-1557.10000000,1991.12000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1703,1441.95000000,-1555.07000000,1991.12000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1703,1442.71000000,-1557.88000000,1991.12000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(18762,1443.85000000,-1556.15000000,1993.18000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1703,1444.71000000,-1554.41000000,1991.12000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(18762,1443.85000000,-1556.15000000,1998.12000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(18762,1443.85000000,-1556.15000000,2001.68000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(18762,1443.58000000,-1570.37000000,1993.18000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(18762,1443.58000000,-1570.37000000,1997.96000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(18762,1443.58000000,-1570.37000000,2001.93000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1703,1442.37000000,-1572.13000000,1991.12000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1703,1441.65000000,-1569.32000000,1991.12000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1703,1445.11000000,-1571.40000000,1991.12000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1703,1444.39000000,-1568.62000000,1991.12000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(1704,1442.57000000,-1546.38000000,1991.76000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1704,1444.39000000,-1547.59000000,1991.76000000,0.00000000,0.00000000,260.28000000); //
	CreateDynamicObject(1704,1441.63000000,-1548.79000000,1991.76000000,0.00000000,0.00000000,105.56000000); //
	CreateDynamicObject(1704,1446.09000000,-1548.84000000,1991.76000000,0.00000000,0.00000000,110.90000000); //
	CreateDynamicObject(1704,1447.02000000,-1546.86000000,1991.76000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1704,1448.85000000,-1548.05000000,1991.76000000,0.00000000,0.00000000,260.28000000); //
	CreateDynamicObject(2030,1447.43000000,-1548.25000000,1992.13000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2030,1442.85000000,-1548.14000000,1992.13000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2002,1449.78000000,-1558.60000000,1991.18000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(2002,1449.82000000,-1568.28000000,1991.18000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1703,1449.85000000,-1555.13000000,1991.12000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1703,1441.95000000,-1555.07000000,1991.12000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1703,1449.83000000,-1551.82000000,1991.12000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1703,1449.71000000,-1569.05000000,1991.12000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1703,1449.71000000,-1572.19000000,1991.12000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1703,1457.71000000,-1556.84000000,1991.12000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1703,1457.75000000,-1567.48000000,1991.12000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1703,1457.74000000,-1570.85000000,1991.12000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1703,1456.55000000,-1574.31000000,1991.12000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2030,1455.37000000,-1571.93000000,1991.55000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2030,1455.30000000,-1569.31000000,1991.55000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1703,1457.70000000,-1553.42000000,1991.12000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1704,1454.93000000,-1552.45000000,1991.05000000,0.00000000,0.00000000,290.95000000); //
	CreateDynamicObject(1704,1452.25000000,-1552.32000000,1991.05000000,0.00000000,0.00000000,19.56000000); //
	CreateDynamicObject(1704,1452.56000000,-1554.63000000,1991.05000000,0.00000000,0.00000000,122.91000000); //
	CreateDynamicObject(2030,1453.66000000,-1553.92000000,1991.55000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(630,1457.75000000,-1556.08000000,1992.20000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(630,1457.77000000,-1570.19000000,1992.20000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(630,1457.64000000,-1574.20000000,1992.20000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(630,1453.89000000,-1574.48000000,1992.20000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(630,1457.74000000,-1552.58000000,1992.20000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(3851,1420.00000000,-1571.91000000,1999.77000000,90.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(14780,1392.41000000,-1575.51000000,1986.70000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1985,1400.88000000,-1575.64000000,1989.11000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19087,1400.88000000,-1575.67000000,1991.49000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19087,1402.86000000,-1575.27000000,1991.49000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1985,1402.87000000,-1575.25000000,1989.09000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2627,1390.88000000,-1570.90000000,1985.87000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2627,1390.86000000,-1569.50000000,1985.87000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2627,1390.83000000,-1568.08000000,1985.87000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2630,1395.70000000,-1565.12000000,1985.88000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(2630,1395.68000000,-1566.92000000,1985.88000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(2630,1395.68000000,-1568.88000000,1985.88000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(18762,1440.16000000,-1544.50000000,2007.80000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(18762,1440.17000000,-1540.35000000,2007.80000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(18762,1434.72000000,-1540.30000000,2007.80000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(18762,1434.79000000,-1544.51000000,2007.80000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19379,1437.10000000,-1549.59000000,2005.76000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1447.64000000,-1549.65000000,2005.76000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1426.64000000,-1549.63000000,2005.76000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1429.93000000,-1540.00000000,2005.76000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1430.05000000,-1530.38000000,2005.76000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1440.43000000,-1535.83000000,2005.76000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1444.94000000,-1541.27000000,2005.74000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1440.52000000,-1526.30000000,2005.76000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19446,1424.90000000,-1540.00000000,2007.60000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19446,1420.18000000,-1544.72000000,2007.60000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19446,1421.33000000,-1549.58000000,2007.60000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19446,1426.11000000,-1554.31000000,2007.60000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19446,1435.59000000,-1554.31000000,2007.60000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19446,1445.15000000,-1554.32000000,2007.60000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19446,1450.05000000,-1549.58000000,2007.60000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19446,1450.07000000,-1540.68000000,2007.60000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19446,1437.19000000,-1530.54000000,2007.60000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19446,1429.74000000,-1535.25000000,2007.60000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19446,1434.48000000,-1530.47000000,2007.60000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19446,1441.97000000,-1535.25000000,2007.60000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19446,1446.76000000,-1530.54000000,2007.60000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19446,1442.00000000,-1525.80000000,2007.60000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19446,1429.74000000,-1525.74000000,2007.60000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19446,1437.06000000,-1517.75000000,2007.60000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19379,1430.10000000,-1520.77000000,2005.76000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1440.61000000,-1516.70000000,2005.76000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19446,1441.83000000,-1522.52000000,2007.60000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19379,1451.00000000,-1526.26000000,2005.76000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1450.69000000,-1532.35000000,2005.74000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19446,1450.08000000,-1531.10000000,2007.60000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19446,1450.09000000,-1521.53000000,2007.60000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19446,1451.43000000,-1522.52000000,2007.60000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19446,1429.72000000,-1522.75000000,2007.60000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19446,1434.47000000,-1517.90000000,2007.60000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19446,1438.06000000,-1513.05000000,2007.60000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19379,1430.11000000,-1511.13000000,2005.76000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19446,1425.17000000,-1524.11000000,2007.60000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(3851,1437.18000000,-1539.98000000,2006.38000000,90.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(3851,1438.19000000,-1540.01000000,2006.38000000,90.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(3851,1440.32000000,-1542.37000000,2006.34000000,90.00000000,90.00000000,90.00000000); //
	CreateDynamicObject(3851,1434.99000000,-1542.46000000,2006.38000000,90.00000000,90.00000000,90.00000000); //
	CreateDynamicObject(18981,1452.10000000,-1545.38000000,2009.82000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(18981,1437.80000000,-1525.07000000,2009.74000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(18981,1422.78000000,-1547.57000000,2009.82000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(1703,1441.09000000,-1543.45000000,2005.66000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1703,1434.18000000,-1541.32000000,2005.66000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1703,1438.38000000,-1539.49000000,2005.66000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2030,1444.98000000,-1546.75000000,2006.19000000,-0.06000000,0.00000000,0.00000000); //
	CreateDynamicObject(1704,1444.00000000,-1548.40000000,2005.76000000,0.00000000,0.00000000,110.90000000); //
	CreateDynamicObject(630,1441.23000000,-1544.55000000,2006.81000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1704,1446.47000000,-1545.86000000,2005.76000000,0.00000000,0.00000000,281.83000000); //
	CreateDynamicObject(1704,1443.85000000,-1545.67000000,2005.76000000,0.00000000,0.00000000,20.76000000); //
	CreateDynamicObject(630,1441.28000000,-1540.30000000,2006.79000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(630,1440.24000000,-1539.40000000,2006.79000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(630,1434.80000000,-1539.20000000,2006.79000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(630,1433.84000000,-1540.30000000,2006.79000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(630,1433.79000000,-1544.49000000,2006.79000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2030,1431.24000000,-1548.22000000,2006.19000000,-0.06000000,0.00000000,0.00000000); //
	CreateDynamicObject(1704,1429.64000000,-1550.05000000,2005.76000000,0.00000000,0.00000000,110.90000000); //
	CreateDynamicObject(1704,1430.05000000,-1546.53000000,2005.76000000,0.00000000,0.00000000,20.76000000); //
	CreateDynamicObject(1704,1433.23000000,-1548.61000000,2005.76000000,0.00000000,0.00000000,246.84000000); //
	CreateDynamicObject(2030,1430.52000000,-1541.35000000,2006.19000000,-0.06000000,0.00000000,0.00000000); //
	CreateDynamicObject(1704,1431.05000000,-1543.25000000,2005.76000000,0.00000000,0.00000000,174.79000000); //
	CreateDynamicObject(1704,1429.72000000,-1539.99000000,2005.76000000,0.00000000,0.00000000,20.76000000); //
	CreateDynamicObject(18981,1438.70000000,-1557.36000000,2009.82000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(18981,1418.46000000,-1549.63000000,2009.82000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(18981,1437.94000000,-1528.23000000,2009.78000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(18762,1434.79000000,-1544.51000000,2012.54000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(18762,1440.14000000,-1544.50000000,2012.50000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(18762,1440.17000000,-1540.35000000,2012.27000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(18762,1434.72000000,-1540.30000000,2012.05000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19379,1440.46000000,-1535.88000000,2010.26000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1444.95000000,-1545.41000000,2010.24000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19446,1445.84000000,-1545.51000000,2011.88000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19379,1434.50000000,-1549.62000000,2010.26000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1429.97000000,-1540.06000000,2010.26000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1430.10000000,-1530.49000000,2010.26000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1424.07000000,-1549.63000000,2010.26000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1419.68000000,-1540.04000000,2010.26000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19446,1444.56000000,-1550.26000000,2011.88000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19446,1435.08000000,-1554.42000000,2011.88000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19446,1439.82000000,-1554.98000000,2011.88000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19446,1430.27000000,-1549.67000000,2011.88000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19446,1427.02000000,-1549.70000000,2011.88000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19446,1428.65000000,-1554.44000000,2011.88000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19384,1428.73000000,-1544.94000000,2011.88000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19446,1426.95000000,-1540.24000000,2011.88000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19446,1431.52000000,-1537.26000000,2011.88000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19446,1445.83000000,-1536.56000000,2011.88000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19446,1437.67000000,-1537.27000000,2011.88000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19446,1442.38000000,-1532.50000000,2011.88000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19446,1450.61000000,-1531.82000000,2011.88000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19446,1437.62000000,-1527.78000000,2011.88000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19446,1454.15000000,-1526.89000000,2011.88000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(19446,1449.44000000,-1522.84000000,2011.88000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19379,1451.14000000,-1527.58000000,2005.76000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1449.26000000,-1527.08000000,2010.24000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(18981,1437.94000000,-1528.23000000,2009.78000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19379,1438.76000000,-1527.08000000,2010.24000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19446,1439.96000000,-1522.84000000,2011.88000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19379,1428.28000000,-1520.92000000,2010.24000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(19446,1428.09000000,-1527.78000000,2011.76000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(19446,1435.16000000,-1523.89000000,2011.88000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(18981,1444.76000000,-1527.89000000,2014.05000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(18981,1440.14000000,-1557.34000000,2014.05000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(18981,1422.66000000,-1543.99000000,2014.05000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(1704,1433.40000000,-1550.32000000,2010.27000000,0.00000000,0.00000000,110.90000000); //
	CreateDynamicObject(2030,1434.73000000,-1549.52000000,2010.71000000,-0.06000000,0.00000000,0.72000000); //
	CreateDynamicObject(630,1433.86000000,-1544.46000000,2011.32000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1704,1435.29000000,-1548.05000000,2010.27000000,0.00000000,0.00000000,321.23000000); //
	CreateDynamicObject(1704,1448.65000000,-1525.87000000,2010.27000000,0.00000000,0.00000000,321.23000000); //
	CreateDynamicObject(2030,1447.40000000,-1527.30000000,2010.71000000,-0.06000000,0.00000000,0.72000000); //
	CreateDynamicObject(630,1441.26000000,-1544.28000000,2011.32000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1704,1446.07000000,-1528.05000000,2010.27000000,0.00000000,0.00000000,102.49000000); //
	CreateDynamicObject(1703,1441.12000000,-1543.46000000,2010.26000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(630,1441.29000000,-1540.48000000,2011.32000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1703,1434.15000000,-1541.36000000,2010.26000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(630,1433.92000000,-1540.36000000,2011.32000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1703,1438.20000000,-1539.39000000,2010.26000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(630,1434.95000000,-1539.42000000,2011.32000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(630,1439.74000000,-1539.38000000,2011.32000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(3851,1440.26000000,-1542.37000000,2013.23000000,90.00000000,90.00000000,90.00000000); //
	CreateDynamicObject(3851,1437.18000000,-1540.01000000,2010.35000000,90.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(3851,1435.01000000,-1542.46000000,2009.97000000,90.00000000,90.00000000,90.00000000); //
	CreateDynamicObject(18981,1451.82000000,-1534.15000000,2014.05000000,0.00000000,90.00000000,2.70000000); //
	CreateDynamicObject(18981,1441.96000000,-1534.59000000,2014.97000000,0.00000000,90.00000000,0.00000000); //
	CreateDynamicObject(18755,1437.42000000,-1542.73000000,2007.77000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(16151,1445.55000000,-1581.92000000,1991.49000000,0.00000000,0.00000000,267.91000000); //
	CreateDynamicObject(2455,1438.85000000,-1580.26000000,1991.16000000,0.00000000,0.00000000,179.29000000); //
	CreateDynamicObject(2454,1439.92000000,-1580.42000000,1991.16000000,0.00000000,0.00000000,89.00000000); //
	CreateDynamicObject(2455,1437.93000000,-1580.25000000,1991.16000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2455,1437.01000000,-1580.25000000,1991.16000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2455,1436.07000000,-1580.24000000,1991.16000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2455,1435.15000000,-1580.24000000,1991.16000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2454,1434.24000000,-1580.23000000,1991.16000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2455,1434.09000000,-1581.31000000,1991.16000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(2455,1434.09000000,-1582.23000000,1991.16000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(2416,1439.01000000,-1582.22000000,1991.14000000,0.00000000,0.00000000,176.63000000); //
	CreateDynamicObject(2429,1436.36000000,-1582.48000000,1992.71000000,0.00000000,0.00000000,178.23000000); //
	CreateDynamicObject(2425,1433.90000000,-1581.50000000,1992.18000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2422,1438.34000000,-1580.48000000,1992.18000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2422,1435.57000000,-1580.44000000,1992.18000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2416,1436.05000000,-1582.09000000,1991.14000000,0.00000000,0.00000000,176.63000000); //
	CreateDynamicObject(2430,1438.94000000,-1582.32000000,1994.26000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2439,1431.50000000,-1580.01000000,1991.17000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2439,1430.50000000,-1580.02000000,1991.17000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2439,1429.52000000,-1580.01000000,1991.17000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2439,1428.51000000,-1580.02000000,1991.17000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2439,1427.51000000,-1580.02000000,1991.17000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2439,1426.49000000,-1580.03000000,1991.17000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2439,1426.33000000,-1580.20000000,1991.15000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(2439,1426.34000000,-1581.18000000,1991.15000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(2439,1431.64000000,-1580.16000000,1991.15000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2665,1429.35000000,-1581.65000000,1994.34000000,0.00000000,0.00000000,175.87000000); //
	CreateDynamicObject(2453,1430.94000000,-1579.97000000,1992.58000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2422,1429.45000000,-1580.13000000,1992.20000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2422,1427.54000000,-1580.09000000,1992.20000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2638,1425.72000000,-1576.32000000,1991.83000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2638,1429.64000000,-1576.32000000,1991.83000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2639,1422.21000000,-1576.22000000,1991.68000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(2637,1423.78000000,-1576.32000000,1991.58000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2637,1427.70000000,-1576.32000000,1991.58000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2637,1431.40000000,-1576.32000000,1991.58000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2639,1432.84000000,-1576.32000000,1991.68000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2639,1439.75000000,-1576.35000000,1991.68000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(2637,1441.18000000,-1576.32000000,1991.58000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2638,1443.10000000,-1576.32000000,1991.83000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2637,1444.96000000,-1576.28000000,1991.58000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2638,1446.88000000,-1576.32000000,1991.83000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2639,1449.96000000,-1576.34000000,1991.68000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2637,1448.61000000,-1576.47000000,1991.58000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2435,1431.57000000,-1559.04000000,1992.18000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2435,1431.57000000,-1558.12000000,1992.18000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2435,1431.57000000,-1557.23000000,1992.18000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2435,1431.57000000,-1556.31000000,1992.18000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2435,1431.57000000,-1555.39000000,1992.18000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2435,1431.57000000,-1554.47000000,1992.18000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2435,1431.57000000,-1553.58000000,1992.18000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2435,1431.57000000,-1552.65000000,1992.18000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1806,1429.92000000,-1553.68000000,1992.17000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1806,1430.16000000,-1555.22000000,1992.17000000,0.00000000,0.00000000,278.35000000); //
	CreateDynamicObject(1806,1430.17000000,-1556.42000000,1992.17000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1806,1430.13000000,-1557.82000000,1992.17000000,0.00000000,0.00000000,264.04000000); //
	CreateDynamicObject(2161,1423.91000000,-1553.75000000,1992.17000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2161,1423.91000000,-1555.08000000,1992.17000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2161,1423.92000000,-1556.41000000,1992.17000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2197,1428.07000000,-1559.20000000,1992.15000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2197,1427.38000000,-1559.20000000,1992.15000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2197,1426.69000000,-1559.20000000,1992.15000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2197,1426.03000000,-1559.20000000,1992.15000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(2198,1427.51000000,-1552.17000000,1992.15000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(2198,1425.45000000,-1552.22000000,1992.15000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1806,1427.84000000,-1553.23000000,1992.17000000,0.00000000,0.00000000,304.93000000); //
	CreateDynamicObject(1806,1425.98000000,-1553.23000000,1992.17000000,0.00000000,0.00000000,343.10000000); //
	CreateDynamicObject(2191,1424.54000000,-1557.88000000,1992.01000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2191,1424.56000000,-1559.33000000,1992.01000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(2198,1427.04000000,-1556.62000000,1992.15000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1806,1427.37000000,-1557.64000000,1992.17000000,0.00000000,0.00000000,304.93000000); //
	CreateDynamicObject(10444,1424.92000000,-1551.92000000,1991.38000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(10444,1424.92000000,-1551.92000000,1991.68000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(10444,1424.92000000,-1551.92000000,1991.28000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(10444,1424.92000000,-1551.92000000,1991.99000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(3515,1427.40000000,-1548.62000000,1989.88000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(3515,1427.40000000,-1564.18000000,1989.96000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1569,1445.79000000,-1538.80000000,2010.31000000,0.00000000,0.00000000,90.41000000); //
	CreateDynamicObject(1569,1445.77000000,-1544.70000000,2010.31000000,0.00000000,0.00000000,89.68000000); //
	CreateDynamicObject(1569,1441.91000000,-1550.22000000,2010.31000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1569,1437.04000000,-1554.38000000,2010.31000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1569,1431.37000000,-1554.37000000,2010.31000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1569,1427.91000000,-1544.85000000,2010.31000000,0.00000000,0.00000000,113.17000000); //
	CreateDynamicObject(1569,1427.01000000,-1538.79000000,2010.31000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1569,1431.22000000,-1537.29000000,2010.31000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(1569,1436.66000000,-1537.31000000,2010.31000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(1569,1441.54000000,-1537.30000000,2010.31000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(1569,1442.42000000,-1533.24000000,2010.31000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1569,1442.43000000,-1528.61000000,2010.31000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1569,1449.18000000,-1531.76000000,2010.31000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1569,1454.11000000,-1530.19000000,2010.31000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1569,1454.10000000,-1525.97000000,2010.31000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1569,1435.20000000,-1524.39000000,2010.31000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1569,1438.83000000,-1527.74000000,2010.31000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1569,1439.63000000,-1522.88000000,2010.31000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(1569,1444.27000000,-1522.90000000,2010.31000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(1569,1450.37000000,-1522.89000000,2010.31000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(1569,1425.21000000,-1523.44000000,2005.85000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1569,1430.61000000,-1525.69000000,2005.85000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1569,1431.86000000,-1522.79000000,2005.85000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(1569,1436.44000000,-1513.10000000,2005.85000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(1569,1434.51000000,-1516.11000000,2005.85000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1569,1434.51000000,-1520.12000000,2005.85000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1569,1437.02000000,-1517.51000000,2005.85000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1569,1437.02000000,-1521.55000000,2005.85000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1569,1442.71000000,-1525.74000000,2005.85000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1569,1438.74000000,-1525.76000000,2005.85000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1569,1439.98000000,-1522.57000000,2005.85000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(1569,1444.68000000,-1522.55000000,2005.85000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(1569,1450.05000000,-1526.25000000,2005.85000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1569,1450.01000000,-1533.64000000,2005.85000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1569,1446.80000000,-1528.26000000,2005.85000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1569,1446.79000000,-1532.32000000,2005.85000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1569,1441.23000000,-1535.30000000,2005.85000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(1569,1445.18000000,-1535.29000000,2005.85000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(1569,1429.01000000,-1535.31000000,2005.85000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(1569,1433.10000000,-1535.28000000,2005.85000000,0.00000000,0.00000000,180.00000000); //
	CreateDynamicObject(1569,1424.94000000,-1538.15000000,2005.85000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1569,1424.95000000,-1543.19000000,2005.85000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(1569,1424.99000000,-1554.25000000,2005.85000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1569,1434.66000000,-1554.24000000,2005.85000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1569,1442.41000000,-1554.27000000,2005.85000000,0.00000000,0.00000000,0.00000000); //
	CreateDynamicObject(1569,1449.96000000,-1549.77000000,2005.85000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1569,1450.01000000,-1542.15000000,2005.85000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(18755,1437.42000000,-1542.73000000,1993.05000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1536,1458.36000000,-1565.21000000,1991.16000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(1536,1458.37000000,-1562.22000000,1991.16000000,0.00000000,0.00000000,270.00000000); //
	CreateDynamicObject(5709,1390.18000000,-1545.79000000,1993.32000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(14407,1284.96000000,-1606.16000000,2247.82000000,0.00000000,0.00000000,90.00000000); //
	CreateDynamicObject(14407,1428.16000000,-1552.69000000,2013.46000000,0.00000000,0.00000000,0.00000000); //
	
	//Despacho Ayunta
	CreateDynamicObject(19379, 1517.11560, -1786.04810, 64.75790,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(2184, 1481.26563, -1775.80286, 82.99261,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1714, 1482.36023, -1774.72131, 82.99325,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19375, 1522.27625, -1786.06213, 64.69950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1704, 1490.18774, -1787.51489, 82.49810,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(957, 1487.43982, -1773.97864, 86.86060,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1490.43982, -1787.47864, 86.86060,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(0, 1478.43982, -1779.97864, 86.86060,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19379, 1517.11560, -1786.04810, 68.65010,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1506.61365, -1786.04810, 64.75790,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1506.61365, -1786.04810, 68.65011,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19375, 1522.27502, -1794.43689, 64.69950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19375, 1501.27625, -1786.06213, 64.69950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19375, 1501.27820, -1794.57495, 64.69950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19379, 1506.61365, -1794.26611, 68.64810,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1517.11755, -1794.26611, 68.64810,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19375, 1517.43408, -1797.35730, 64.69950,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19375, 1507.80005, -1797.35730, 64.69950,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19375, 1498.19397, -1797.35730, 64.69950,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(9339, 1508.68506, -1781.10925, 55.63970,   90.00000, 0.00000, -90.00000);
	CreateDynamicObject(19325, 1504.68103, -1781.24719, 66.61119,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(9339, 1508.68506, -1781.10925, 55.63970,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(9339, 1516.68506, -1781.10925, 55.63970,   90.00000, 0.00000, -90.00000);
	CreateDynamicObject(9339, 1516.68506, -1781.10925, 55.63970,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(19325, 1519.04004, -1781.24719, 66.61120,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19325, 1512.39807, -1781.24719, 66.61120,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19379, 1517.11560, -1786.54810, 64.59376,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1517.11560, -1787.04810, 64.42968,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1517.11560, -1794.54810, 64.26560,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1506.61365, -1786.54810, 64.59380,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1506.61365, -1787.04810, 64.42970,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19379, 1506.61365, -1794.54810, 64.26560,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(2184, 1511.48120, -1783.83069, 64.83141,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1714, 1512.45313, -1782.51819, 64.84584,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1557, 1514.00195, -1797.30225, 64.35850,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1557, 1511.00195, -1797.30225, 64.35850,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1704, 1503.13879, -1786.44995, 64.74550,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1704, 1504.63879, -1783.94995, 64.74550,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2370, 1504.67896, -1786.34570, 64.56499,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1704, 1506.86926, -1785.65894, 64.74550,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1704, 1505.51270, -1787.91064, 64.74550,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1670, 1505.14148, -1785.88757, 65.41124,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2370, 1518.67896, -1786.34570, 64.56500,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1704, 1520.86926, -1785.65894, 64.74550,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1704, 1519.51270, -1787.91064, 64.74550,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1704, 1518.63879, -1783.94995, 64.74550,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1704, 1517.13879, -1786.44995, 64.74550,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1670, 1519.14148, -1785.88757, 65.41120,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19174, 1501.39099, -1794.03882, 66.88540,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19172, 1501.39099, -1786.03882, 66.88540,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19172, 1522.14453, -1794.03882, 66.88540,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(19174, 1522.14453, -1786.03882, 66.88540,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1704, 1505.51270, -1796.51135, 64.35140,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1704, 1519.51270, -1796.51135, 64.35140,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(2239, 1510.84851, -1782.04956, 64.81306,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1502.00146, -1782.03674, 68.53947,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1505.00146, -1782.03674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1508.00146, -1782.03674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1511.00146, -1782.03674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1514.00146, -1782.03674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1517.00146, -1782.03674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1520.00146, -1782.03674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1502.00146, -1786.53674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1502.00146, -1789.53674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1502.00146, -1792.53674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1502.00146, -1795.53674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1508.00146, -1786.53674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1514.00146, -1786.53674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1520.00146, -1786.53674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1508.00146, -1789.53674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1508.00146, -1792.53674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1508.00146, -1795.53674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1514.00146, -1789.53674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1514.00146, -1792.53674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1514.00146, -1795.53674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1520.00146, -1792.53674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1520.00146, -1795.53674, 68.53950,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(957, 1520.00146, -1789.53674, 68.53950,   0.00000, 0.00000, 0.00000);
	
	new tv = CreateDynamicObject(2267, 1508.63330, -1781.35510, 67.40113,   10.00000, 0.00000, 0.00000);
	CreateDynamicObject(2267, 1516.63330, -1781.35510, 67.40110,   10.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tv, 1, 19172, "samppictures", "samppicture1");
	SetDynamicObjectMaterial(tv+1, 1, 19172, "samppictures", "samppicture1");

	//MALL BY SAMP
	CreateDynamicObject(19322, 1117.57996, -1490.01001, 32.72000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19323, 1117.57996, -1490.01001, 32.72000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19325, 1155.40002, -1434.89001, 16.49000,   0.00000, 0.00000, 0.30000);
	CreateDynamicObject(19325, 1155.37000, -1445.41003, 16.31000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19325, 1155.29004, -1452.38000, 16.31000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19325, 1157.35999, -1468.34998, 16.31000,   0.00000, 0.00000, 18.66000);
	CreateDynamicObject(19325, 1160.64001, -1478.37000, 16.31000,   0.00000, 0.00000, 17.76000);
	CreateDynamicObject(19325, 1159.83997, -1502.06006, 16.31000,   0.00000, 0.00000, -19.92000);
	CreateDynamicObject(19325, 1139.28003, -1523.70996, 16.31000,   0.00000, 0.00000, -69.36000);
	CreateDynamicObject(19325, 1117.06006, -1523.43005, 16.51000,   0.00000, 0.00000, -109.44000);
	CreateDynamicObject(19325, 1097.18005, -1502.43005, 16.51000,   0.00000, 0.00000, -158.58000);
	CreateDynamicObject(19325, 1096.46997, -1478.29004, 16.51000,   0.00000, 0.00000, -197.94000);
	CreateDynamicObject(19325, 1099.69995, -1468.27002, 16.51000,   0.00000, 0.00000, -197.94000);
	CreateDynamicObject(19325, 1101.81006, -1445.44995, 16.22000,   0.00000, 0.00000, -180.24001);
	CreateDynamicObject(19325, 1101.76001, -1452.46997, 16.22000,   0.00000, 0.00000, -181.62000);
	CreateDynamicObject(19325, 1101.77002, -1434.88000, 16.22000,   0.00000, 0.00000, -180.24001);
	CreateDynamicObject(19325, 1094.31006, -1444.92004, 23.47000,   0.00000, 0.00000, -180.24001);
	CreateDynamicObject(19325, 1094.37000, -1458.37000, 23.47000,   0.00000, 0.00000, -179.46001);
	CreateDynamicObject(19325, 1093.01001, -1517.43994, 23.44000,   0.00000, 0.00000, -138.72000);
	CreateDynamicObject(19325, 1101.07996, -1526.64001, 23.42000,   0.00000, 0.00000, -137.34000);
	CreateDynamicObject(19325, 1155.12000, -1526.38000, 23.46000,   0.00000, 0.00000, -42.12000);
	CreateDynamicObject(19325, 1163.08997, -1517.25000, 23.46000,   0.00000, 0.00000, -40.74000);
	CreateDynamicObject(19325, 1163.04004, -1442.06006, 23.40000,   0.00000, 0.00000, -0.12000);
	CreateDynamicObject(19325, 1163.08997, -1428.46997, 23.50000,   0.00000, 0.00000, 0.54000);
	CreateDynamicObject(19326, 1155.33997, -1446.72998, 16.38000,   0.00000, 0.00000, -89.82000);
	CreateDynamicObject(19326, 1155.25000, -1443.84998, 16.36000,   0.00000, 0.00000, -89.82000);
	CreateDynamicObject(19326, 1155.37000, -1436.31995, 16.36000,   0.00000, 0.00000, -89.82000);
	CreateDynamicObject(19326, 1155.34998, -1433.51001, 16.36000,   0.00000, 0.00000, -89.70000);
	CreateDynamicObject(19329, 1155.18005, -1440.21997, 18.70000,   0.00000, 0.00000, 89.04000);
	CreateDynamicObject(19329, 1161.58997, -1431.50000, 17.93000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19329, 1160.40002, -1448.79004, 17.96000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2543, 1168.18005, -1436.39001, 14.79000,   0.00000, 0.00000, 0.30000);
	CreateDynamicObject(2535, 1182.73999, -1448.30005, 14.70000,   0.00000, 0.00000, -90.96000);
	CreateDynamicObject(2543, 1167.09998, -1436.40002, 14.79000,   0.00000, 0.00000, 0.31000);
	CreateDynamicObject(2538, 1172.31006, -1435.31995, 14.79000,   0.00000, 0.00000, 180.34000);
	CreateDynamicObject(2539, 1171.38000, -1435.31006, 14.79000,   0.00000, 0.00000, 180.19000);
	CreateDynamicObject(2540, 1169.56006, -1435.35999, 14.79000,   0.00000, 0.00000, 180.17000);
	CreateDynamicObject(1984, 1157.37000, -1442.58997, 14.79000,   0.00000, 0.00000, -450.06000);
	CreateDynamicObject(2012, 1163.25000, -1448.31006, 14.75000,   0.00000, 0.00000, -179.16000);
	CreateDynamicObject(2012, 1169.29004, -1431.92004, 14.75000,   0.00000, 0.00000, 359.79999);
	CreateDynamicObject(1987, 1163.13000, -1436.33997, 14.79000,   0.00000, 0.00000, 361.06000);
	CreateDynamicObject(1988, 1164.13000, -1436.32996, 14.79000,   0.00000, 0.00000, 360.79999);
	CreateDynamicObject(2871, 1164.79004, -1443.95996, 14.79000,   0.00000, 0.00000, 177.73000);
	CreateDynamicObject(2871, 1164.69995, -1444.97998, 14.79000,   0.00000, 0.00000, 358.07001);
	CreateDynamicObject(2942, 1155.52002, -1464.68005, 15.43000,   0.00000, 0.00000, -71.22000);
	CreateDynamicObject(1987, 1164.12000, -1435.31995, 14.77000,   0.00000, 0.00000, 180.96001);
	CreateDynamicObject(2530, 1171.13000, -1443.79004, 14.79000,   0.00000, 0.00000, -182.16000);
	CreateDynamicObject(1991, 1173.75000, -1439.56006, 14.79000,   0.00000, 0.00000, 179.47000);
	CreateDynamicObject(1996, 1169.81995, -1439.50000, 14.79000,   0.00000, 0.00000, 179.10001);
	CreateDynamicObject(1996, 1174.23999, -1435.38000, 14.79000,   0.00000, 0.00000, 179.24001);
	CreateDynamicObject(1991, 1175.22998, -1435.39001, 14.79000,   0.00000, 0.00000, 179.57001);
	CreateDynamicObject(1995, 1182.65002, -1435.09998, 14.79000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1994, 1182.66003, -1438.06995, 14.79000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1993, 1182.66003, -1437.07996, 14.79000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2542, 1163.78003, -1443.92004, 14.76000,   0.00000, 0.00000, 178.77000);
	CreateDynamicObject(2536, 1166.88000, -1445.06995, 14.70000,   0.00000, 0.00000, -0.42000);
	CreateDynamicObject(2542, 1163.69995, -1444.93005, 14.78000,   0.00000, 0.00000, -1.74000);
	CreateDynamicObject(1984, 1157.33997, -1435.70996, 14.79000,   0.00000, 0.00000, -450.06000);
	CreateDynamicObject(2012, 1166.31006, -1448.28003, 14.75000,   0.00000, 0.00000, -180.12000);
	CreateDynamicObject(2530, 1172.14001, -1443.82996, 14.79000,   0.00000, 0.00000, -181.38000);
	CreateDynamicObject(2530, 1173.14001, -1443.84998, 14.79000,   0.00000, 0.00000, -180.96001);
	CreateDynamicObject(2530, 1174.13000, -1443.88000, 14.79000,   0.00000, 0.00000, -181.50000);
	CreateDynamicObject(1981, 1170.76001, -1439.52002, 14.79000,   0.00000, 0.00000, -181.74001);
	CreateDynamicObject(1981, 1171.76001, -1439.54004, 14.79000,   0.00000, 0.00000, -180.80000);
	CreateDynamicObject(1981, 1172.75000, -1439.55005, 14.79000,   0.00000, 0.00000, -180.84000);
	CreateDynamicObject(2535, 1182.75000, -1447.28003, 14.70000,   0.00000, 0.00000, -90.78000);
	CreateDynamicObject(2535, 1182.73999, -1446.28003, 14.70000,   0.00000, 0.00000, -90.78000);
	CreateDynamicObject(2535, 1182.73999, -1445.26001, 14.70000,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(2541, 1182.75000, -1444.21997, 14.79000,   0.00000, 0.00000, -90.06000);
	CreateDynamicObject(2541, 1182.75000, -1443.19995, 14.79000,   0.00000, 0.00000, -90.06000);
	CreateDynamicObject(2541, 1182.73999, -1442.16003, 14.79000,   0.00000, 0.00000, -90.06000);
	CreateDynamicObject(2543, 1182.76001, -1441.18005, 14.79000,   0.00000, 0.00000, -90.84000);
	CreateDynamicObject(2541, 1182.79004, -1440.17004, 14.79000,   0.00000, 0.00000, -90.06000);
	CreateDynamicObject(2543, 1182.71997, -1439.15002, 14.79000,   0.00000, 0.00000, -90.84000);
	CreateDynamicObject(1990, 1182.66003, -1431.67004, 14.79000,   0.00000, 0.00000, 3.30000);
	CreateDynamicObject(1990, 1181.63000, -1431.72998, 14.79000,   0.00000, 0.00000, 3.30000);
	CreateDynamicObject(1990, 1180.60999, -1431.81006, 14.79000,   0.00000, 0.00000, 3.30000);
	CreateDynamicObject(1990, 1179.60999, -1431.82996, 14.79000,   0.00000, 0.00000, 3.30000);
	CreateDynamicObject(1990, 1178.60999, -1431.89001, 14.79000,   0.00000, 0.00000, 3.30000);
	CreateDynamicObject(1990, 1177.58997, -1431.85999, 14.79000,   0.00000, 0.00000, 3.30000);
	CreateDynamicObject(1993, 1182.66003, -1436.08997, 14.79000,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(2012, 1175.50000, -1431.81995, 14.75000,   0.00000, 0.00000, 361.17001);
	CreateDynamicObject(2012, 1172.42004, -1431.87000, 14.75000,   0.00000, 0.00000, 359.92999);
	CreateDynamicObject(2012, 1160.09998, -1448.34998, 14.75000,   0.00000, 0.00000, -179.94000);
	CreateDynamicObject(2539, 1170.44995, -1435.32996, 14.79000,   0.00000, 0.00000, 181.25999);
	CreateDynamicObject(2545, 1161.81995, -1431.83997, 14.91000,   0.00000, 0.00000, -90.54000);
	CreateDynamicObject(2545, 1160.81995, -1431.82996, 14.91000,   0.00000, 0.00000, -90.54000);
	CreateDynamicObject(2545, 1159.81006, -1431.85999, 14.91000,   0.00000, 0.00000, -90.54000);
	CreateDynamicObject(2545, 1162.81995, -1431.87000, 14.91000,   0.00000, 0.00000, -90.54000);
	CreateDynamicObject(1988, 1163.13000, -1435.33997, 14.79000,   0.00000, 0.00000, 541.46002);
	CreateDynamicObject(1988, 1166.06995, -1436.31995, 14.79000,   0.00000, 0.00000, 360.79999);
	CreateDynamicObject(1987, 1165.06995, -1436.32996, 14.79000,   0.00000, 0.00000, 361.06000);
	CreateDynamicObject(1987, 1166.10999, -1435.30005, 14.77000,   0.00000, 0.00000, 180.96001);
	CreateDynamicObject(1988, 1165.06995, -1435.31006, 14.79000,   0.00000, 0.00000, 540.44000);
	CreateDynamicObject(2536, 1165.79004, -1445.06995, 14.70000,   0.00000, 0.00000, -1.20000);
	CreateDynamicObject(2536, 1167.82996, -1445.06995, 14.70000,   0.00000, 0.00000, -0.06000);
	CreateDynamicObject(2871, 1165.79004, -1444.00000, 14.79000,   0.00000, 0.00000, 178.27000);
	CreateDynamicObject(2871, 1166.81006, -1444.03003, 14.79000,   0.00000, 0.00000, 179.35001);
	CreateDynamicObject(2871, 1167.79004, -1444.04004, 14.79000,   0.00000, 0.00000, 179.89000);
	CreateDynamicObject(2543, 1168.13000, -1435.35999, 14.79000,   0.00000, 0.00000, 180.05000);
	CreateDynamicObject(2543, 1167.09998, -1435.37000, 14.79000,   0.00000, 0.00000, 180.35001);
	CreateDynamicObject(2012, 1170.63000, -1440.67004, 14.75000,   0.00000, 0.00000, 359.50000);
	CreateDynamicObject(2012, 1173.77002, -1440.71997, 14.75000,   0.00000, 0.00000, 359.82001);
	CreateDynamicObject(2012, 1177.30005, -1445.31006, 14.75000,   0.00000, 0.00000, 359.92999);
	CreateDynamicObject(1996, 1173.35999, -1448.30005, 14.79000,   0.00000, 0.00000, 179.10001);
	CreateDynamicObject(1981, 1174.32996, -1448.31995, 14.79000,   0.00000, 0.00000, -181.74001);
	CreateDynamicObject(1981, 1175.31995, -1448.34998, 14.79000,   0.00000, 0.00000, -180.84000);
	CreateDynamicObject(1981, 1176.30005, -1448.37000, 14.79000,   0.00000, 0.00000, -180.84000);
	CreateDynamicObject(1991, 1177.28003, -1448.37000, 14.79000,   0.00000, 0.00000, 179.47000);
	CreateDynamicObject(1996, 1178.32996, -1448.35999, 14.79000,   0.00000, 0.00000, 179.24001);
	CreateDynamicObject(1991, 1179.32996, -1448.37000, 14.79000,   0.00000, 0.00000, 179.57001);
	CreateDynamicObject(1994, 1176.81995, -1444.16003, 14.79000,   0.00000, 0.00000, -0.84000);
	CreateDynamicObject(1995, 1178.81006, -1444.19995, 14.79000,   0.00000, 0.00000, -1.26000);
	CreateDynamicObject(2543, 1168.89001, -1444.06006, 14.79000,   0.00000, 0.00000, 178.97000);
	CreateDynamicObject(2543, 1169.91003, -1444.06995, 14.79000,   0.00000, 0.00000, 179.69000);
	CreateDynamicObject(2543, 1169.87000, -1445.12000, 14.79000,   0.00000, 0.00000, -0.06000);
	CreateDynamicObject(2543, 1168.85999, -1445.10999, 14.79000,   0.00000, 0.00000, 0.31000);
	CreateDynamicObject(2538, 1167.02002, -1431.87000, 14.79000,   0.00000, 0.00000, 0.42000);
	CreateDynamicObject(2539, 1166.03003, -1431.89001, 14.79000,   0.00000, 0.00000, 0.70000);
	CreateDynamicObject(2540, 1164.04004, -1431.91003, 14.79000,   0.00000, 0.00000, 0.60000);
	CreateDynamicObject(2539, 1165.03003, -1431.91003, 14.79000,   0.00000, 0.00000, 1.02000);
	CreateDynamicObject(2538, 1176.17004, -1436.38000, 14.79000,   0.00000, 0.00000, 0.24000);
	CreateDynamicObject(2539, 1174.21997, -1436.37000, 14.79000,   0.00000, 0.00000, -0.06000);
	CreateDynamicObject(2540, 1173.21997, -1436.35999, 14.79000,   0.00000, 0.00000, 0.18000);
	CreateDynamicObject(2539, 1175.19995, -1436.38000, 14.79000,   0.00000, 0.00000, -2.06000);
	CreateDynamicObject(2540, 1173.26001, -1435.31006, 14.79000,   0.00000, 0.00000, 180.17000);
	CreateDynamicObject(1991, 1175.73999, -1439.57996, 14.79000,   0.00000, 0.00000, 179.57001);
	CreateDynamicObject(1996, 1174.73999, -1439.56995, 14.79000,   0.00000, 0.00000, 179.24001);
	CreateDynamicObject(1996, 1176.17004, -1435.37000, 14.79000,   0.00000, 0.00000, 179.24001);
	CreateDynamicObject(1991, 1177.16003, -1435.38000, 14.79000,   0.00000, 0.00000, 179.57001);
	CreateDynamicObject(2540, 1169.43994, -1436.34998, 14.79000,   0.00000, 0.00000, 0.18000);
	CreateDynamicObject(2539, 1170.43005, -1436.34998, 14.79000,   0.00000, 0.00000, 0.90000);
	CreateDynamicObject(2539, 1171.33997, -1436.32996, 14.79000,   0.00000, 0.00000, 0.58000);
	CreateDynamicObject(2538, 1172.21997, -1436.31995, 14.79000,   0.00000, 0.00000, 0.30000);
	CreateDynamicObject(2871, 1163.40002, -1440.68005, 14.79000,   0.00000, 0.00000, 360.41000);
	CreateDynamicObject(2536, 1164.48999, -1440.72998, 14.70000,   0.00000, 0.00000, -1.20000);
	CreateDynamicObject(2536, 1165.48999, -1440.75000, 14.70000,   0.00000, 0.00000, -0.42000);
	CreateDynamicObject(2536, 1166.50000, -1440.75000, 14.70000,   0.00000, 0.00000, -0.06000);
	CreateDynamicObject(2543, 1167.60999, -1440.64001, 14.79000,   0.00000, 0.00000, 0.31000);
	CreateDynamicObject(2543, 1168.62000, -1440.64001, 14.79000,   0.00000, 0.00000, 0.30000);
	CreateDynamicObject(2543, 1168.64001, -1439.59998, 14.79000,   0.00000, 0.00000, 180.05000);
	CreateDynamicObject(2543, 1167.67004, -1439.60999, 14.79000,   0.00000, 0.00000, 180.35001);
	CreateDynamicObject(2871, 1163.65002, -1439.67004, 14.79000,   0.00000, 0.00000, 180.61000);
	CreateDynamicObject(2871, 1164.68005, -1439.67004, 14.79000,   0.00000, 0.00000, 179.77000);
	CreateDynamicObject(2871, 1165.68005, -1439.68005, 14.79000,   0.00000, 0.00000, 180.61000);
	CreateDynamicObject(2871, 1166.68005, -1439.66003, 14.79000,   0.00000, 0.00000, 180.61000);
	CreateDynamicObject(1990, 1175.08997, -1444.96997, 14.79000,   0.00000, 0.00000, -2.46000);
	CreateDynamicObject(1990, 1181.63000, -1431.72998, 14.79000,   0.00000, 0.00000, 3.30000);
	CreateDynamicObject(1990, 1174.06995, -1444.93994, 14.79000,   0.00000, 0.00000, 0.48000);
	CreateDynamicObject(1990, 1173.08997, -1444.93994, 14.79000,   0.00000, 0.00000, -1.20000);
	CreateDynamicObject(1990, 1172.10999, -1444.92004, 14.79000,   0.00000, 0.00000, -1.14000);
	CreateDynamicObject(1990, 1171.12000, -1444.91003, 14.79000,   0.00000, 0.00000, -0.72000);
	CreateDynamicObject(2530, 1168.54004, -1448.31006, 14.79000,   0.00000, 0.00000, -178.98000);
	CreateDynamicObject(2530, 1169.59998, -1448.29004, 14.79000,   0.00000, 0.00000, -178.98000);
	CreateDynamicObject(2530, 1170.67004, -1448.30005, 14.79000,   0.00000, 0.00000, -178.98000);
	CreateDynamicObject(2530, 1171.71997, -1448.31995, 14.79000,   0.00000, 0.00000, -181.50000);
	CreateDynamicObject(2530, 1175.13000, -1443.91003, 14.79000,   0.00000, 0.00000, -181.50000);
	CreateDynamicObject(2012, 1176.81995, -1440.75000, 14.75000,   0.00000, 0.00000, 359.92999);
	CreateDynamicObject(1995, 1177.70996, -1439.63000, 14.79000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1994, 1176.72998, -1439.63000, 14.79000,   0.00000, 0.00000, 0.06000);
	CreateDynamicObject(1993, 1177.82996, -1444.15002, 14.79000,   0.00000, 0.00000, 179.46001);

    // -------------> Texturas
    //[Banco Nacional LS]
	//[14576 - Escaleras]
	SetDynamicObjectMaterial(BancoLS[2], 3, 16407, "des_airfieldhus", "btdeck256", 0);
	SetDynamicObjectMaterial(BancoLS[2], 4, 19376, "all_walls", "gym_floor5", 0);
	SetDynamicObjectMaterial(BancoLS[2], 5, 19464, "all_walls", "officewallsnew1", 0);
	SetDynamicObjectMaterial(BancoLS[2], 6, 6295, "lawland2", "boardwalk2_la", 0);
 //[6959 - Vidrio]
	SetDynamicObjectMaterial(BancoLS[1], 0, 19466, "lsmall_shops", "lsmall_window01", 0);
	SetDynamicObjectMaterial(BancoLS[1], 1, 19466, "lsmall_shops", "lsmall_window01", 0);
	SetDynamicObjectMaterial(BancoLS[5], 0, 19466, "lsmall_shops", "lsmall_window01", 0);
	SetDynamicObjectMaterial(BancoLS[5], 1, 19466, "lsmall_shops", "lsmall_window01", 0);
	//[Huecos - 18766]
	SetDynamicObjectMaterial(BancoLS[3], 0, 16005, "des_stownmain2", "sanruf", 0);
	SetDynamicObjectMaterial(BancoLS[4], 0, 16005, "des_stownmain2", "sanruf", 0);

	// Vehicles:
	VVehicleGrotti[0] = AddStaticVehicle(411, 544.1366, -1298.1511, 1997.2629+5, 180.0000, 196, 300);
	AddStaticVehicleEx(429, 536.6366, -1297.1511, 1996.7765+5, 215.0000, 208, 138, 300);
	AddStaticVehicleEx(451, 529.1366, -1296.6511, 1996.7765+5, 215.0000, 175, 175, 300);
	AddStaticVehicleEx(506, 521.6366, -1296.1511, 1996.7765+5, 215.0000, 6, 6, 300);
	AddStaticVehicleEx(541, 551.6366, -1297.1511, 1996.7765+5, 145.0000, 208, 138, 300);
	AddStaticVehicleEx(415, 559.1479, -1296.5100, 1996.7765+5, 145.0000, 175, 175, 300);
	VVehicleGrotti[1] = AddStaticVehicle(603, 566.6479, -1296.0100, 1996.7765+5, 145.0000, 6, 300);
	LinkVehicleToInterior(VVehicleGrotti[0], 1);
	LinkVehicleToInterior(VVehicleGrotti[0]+1, 1);
	LinkVehicleToInterior(VVehicleGrotti[0]+2, 1);
	LinkVehicleToInterior(VVehicleGrotti[0]+3, 1);
	LinkVehicleToInterior(VVehicleGrotti[0]+4, 1);
	LinkVehicleToInterior(VVehicleGrotti[0]+5, 1);
	LinkVehicleToInterior(VVehicleGrotti[1], 1);
	
	VBikeRent[0] = AddStaticVehicleEx(509, 1670.9375, -1692.8521, 15.2844, 0.0000, -1, -1, 300);
	AddStaticVehicleEx(509, 1669.4375, -1692.8521, 15.2844, 0.0000, -1, -1, 300);
	AddStaticVehicleEx(509, 1667.9375, -1692.8521, 15.2844, 0.0000, -1, -1, 300);
	AddStaticVehicleEx(509, 1666.4375, -1692.8521, 15.2844, 0.0000, -1, -1, 300);
	AddStaticVehicleEx(509, 1664.9375, -1692.8521, 15.2844, 0.0000, -1, -1, 300);
	AddStaticVehicleEx(509, 1663.4375, -1692.8521, 15.2844, 0.0000, -1, -1, 300);
	AddStaticVehicleEx(509, 1384.6119, -1655.8807, 13.0992, 90.0000, -1, -1, 300);
	AddStaticVehicleEx(509, 1384.6119, -1657.3807, 13.0992, 90.0000, -1, -1, 300);
	AddStaticVehicleEx(509, 1384.6119, -1658.8807, 13.0992, 90.0000, -1, -1, 300);
	VBikeRent[1] = AddStaticVehicleEx(509, 1384.6119, -1660.3807, 13.0992, 90.0000, -1, -1, 300);
	
	AddStaticVehicleEx(437, 2113.7488, -1931.3782, 13.5345, 0.0000, -1, -1, 100);
	AddStaticVehicleEx(437, 2123.2488, -1931.3782, 13.5345, 0.0000, -1, -1, 100);
	CoachBus = AddStaticVehicleEx(437, 2133.7488, -1931.3782, 13.5345, 0.0000, -1, -1, 100);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}
funcion:SP(playerid)
{
    P_newuser[playerid] = -1;
    SpawnPlayer(playerid);
    return 1;
}
public OnPlayerRequestClass(playerid, classid)
{
    if(IsPlayerNPC(playerid)) return 1;
    if(P_newuser[playerid] == -1)
	{
	    P_newuser[playerid] = -2;
	    SetTimerEx("SP", 100, 0, "i", playerid);
		return 1;
	}
    TogglePlayerSpectating(playerid, true);
	DeleteChatForPlayer(playerid, 32, remove);
	TextDrawHideForPlayer(playerid, WelcomeTD[0]);
	TextDrawHideForPlayer(playerid, WelcomeTD[1]);
	TextDrawHideForPlayer(playerid, WelcomeTD[2]);
	TextDrawHideForPlayer(playerid, WelcomeTD[3]);
	if(P_newuser[playerid] == 0)
	{
        SetPlayerTime(playerid, ServerTime, ServerMinute);
        loop(0, 4, l) TextDrawShowForPlayer(playerid, TD_ST[l]);
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, " ", "{FFFFFF}¡Bienvenido de nuevo!\n\n\t{aeff3a}Ingresa tu contraseña para comenzar a jugar", "Ingresar", "Salir");
		if(GetPlayerInteriorEx(playerid) != 0)
		{
			new i = PlayerInfo[playerid][Interior];
			InterpolateCameraPos(playerid, Exteriors[i][0], Exteriors[i][1], Exteriors[playerid][2]+100.0, Exteriors[i][0], Exteriors[i][1], Exteriors[playerid][2]+100.0, 1000, CAMERA_CUT);
            InterpolateCameraLookAt(playerid, Exteriors[i][0], Exteriors[i][1], Exteriors[i][2], Exteriors[i][0], Exteriors[i][1], Exteriors[i][2], 1000, CAMERA_CUT);
		}
		else
		{
			InterpolateCameraPos(playerid, PlayerInfo[playerid][posx], PlayerInfo[playerid][posy], PlayerInfo[playerid][posz]+100.0, PlayerInfo[playerid][posx], PlayerInfo[playerid][posy], PlayerInfo[playerid][posz]+100.0, 1000, CAMERA_CUT);
            InterpolateCameraLookAt(playerid, PlayerInfo[playerid][posx], PlayerInfo[playerid][posy], PlayerInfo[playerid][posz], PlayerInfo[playerid][posx], PlayerInfo[playerid][posy], PlayerInfo[playerid][posz], 1000, CAMERA_CUT);
		}
	}
	else if(P_newuser[playerid] == 1)
	{
		loop(0, 4, l) TextDrawShowForPlayer(playerid, TD_ST[l]);
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "eXtreme RolePlay", "{FFFFFF}¡Bienvenido! parece que es la primera vez que\n{FFFFFF}entra a eXtremeROL, regístrese\n{FFFFFF}para poder continuar\n\n\t{FF0000}La contraseña debe estar entre 3-16 caracteres", "Continuar", "Salir");
		SetPlayerTime(playerid, 12, 0);
		InterpolateCameraPos(playerid, 1346.2476, -928.5945, 114.5656, 1349.3835, -923.1544, 112.7538, 30000);
		InterpolateCameraLookAt(playerid, 1346.7494, -927.7241, 114.2757, 1349.8854, -922.2840, 112.4639, 30000);
		SetPlayerScore(playerid, 0);
		ResetPlayerMoney(playerid);
		ResetPlayerWeapons(playerid);
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(IsPlayerNPC(playerid)) return SpawnPlayer(playerid);
	new name[24];
    GetPlayerName(playerid, name, 24);
	if(!IsValidName(name))
	{
		Kick(playerid);
		return 1;
	}
	TextDrawShowForPlayer(playerid, WelcomeTD[0]);
	TextDrawShowForPlayer(playerid, WelcomeTD[1]);
	TextDrawShowForPlayer(playerid, WelcomeTD[2]);
	TextDrawShowForPlayer(playerid, WelcomeTD[3]);
	new Query[150],
		DBResult:Result;
	format(Query, sizeof(Query), "SELECT * FROM `USERS` WHERE `NAME` = '%s'", PlayerNameNormal(playerid));
	Result = db_query(Database, Query);
	if(db_num_rows(Result))
	{
	    new f[24];
		db_get_field(Result, 3, f, 24), PlayerInfo[playerid][posx] = floatstr(f);
		db_get_field(Result, 4, f, 24), PlayerInfo[playerid][posy] = floatstr(f);
		db_get_field(Result, 5, f, 24), PlayerInfo[playerid][posz] = floatstr(f);
		db_get_field(Result, 6, f, 24), PlayerInfo[playerid][angle] = floatstr(f);
		db_get_field(Result, 7, f, 24), PlayerInfo[playerid][interiorid] = strval(f);
		db_get_field(Result, 8, f, 24), PlayerInfo[playerid][bikerent] = strval(f);
		db_get_field(Result, 9, f, 24), format(PlayerInfo[playerid][email], 24, "%s", f);
		db_get_field(Result, 10, f, 24), PlayerInfo[playerid][dinero] = strval(f);
		db_get_field(Result, 11, f, 24), PlayerInfo[playerid][dinerobank] = strval(f);
		db_get_field(Result, 12, f, 24), PlayerInfo[playerid][sexo] = strval(f);
        db_get_field(Result, 13, f, 24), PlayerInfo[playerid][edad] = strval(f);
        db_get_field(Result, 14, f, 24), PlayerInfo[playerid][skin] = strval(f);
		db_get_field(Result, 15, f, 24), PlayerInfo[playerid][vida] = floatstr(f);
		db_get_field(Result, 16, f, 24), PlayerInfo[playerid][chaleco] = floatstr(f);
		db_get_field(Result, 17, f, 24), PlayerInfo[playerid][admlvl] = strval(f);
		db_get_field(Result, 18, f, 24), PlayerInfo[playerid][phonenumber] = strval(f);
        db_get_field(Result, 19, f, 24), PlayerInfo[playerid][Interior] = strval(f);
        db_get_field(Result, 20, f, 24), PlayerInfo[playerid][BankA] = strval(f);
        db_get_field(Result, 21, f, 24), PlayerInfo[playerid][VBank] = strval(f);
        db_get_field(Result, 22, f, 24), PlayerInfo[playerid][VGrotti] = strval(f);
        db_get_field(Result, 23, f, 24), PlayerInfo[playerid][V247] = strval(f);
        db_get_field(Result, 24, f, 24), PlayerInfo[playerid][VRopa] = strval(f);
        db_get_field(Result, 25, f, 24), PlayerInfo[playerid][VComida] = strval(f);
        db_get_field(Result, 26, f, 24), PlayerInfo[playerid][DudeChannel] = strval(f);
        db_get_field(Result, 27, f, 24), PlayerInfo[playerid][Work] = strval(f);
        db_get_field(Result, 28, f, 24), PlayerInfo[playerid][Plevel] = strval(f);
        db_get_field(Result, 33, f, 24), PlayerInfo[playerid][PlayerVehicleKey][0] = strval(f);
        db_get_field(Result, 34, f, 24), PlayerInfo[playerid][PlayerVehicleKey][1] = strval(f);
        db_get_field(Result, 35, f, 24), PlayerInfo[playerid][PlayerVehicleKey][2] = strval(f);
        db_get_field(Result, 36, f, 24), PlayerInfo[playerid][PlayerVehicleKey][3] = strval(f);
        db_free_result(Result);
        PlayerInfo[playerid][PlayerVehicle][0] = -1;
        PlayerInfo[playerid][PlayerVehicle][1] = -1;
        PlayerInfo[playerid][PlayerVehicle][2] = -1;
        PlayerInfo[playerid][PlayerVehicle][3] = -1;
		P_newuser[playerid] = 0;
		PlayAudioStreamForPlayer(playerid, RandMusic[random(sizeof(RandMusic))]);
	}
	else
	{
	    PlayerInfo[playerid][posx] = 0.0;
		PlayerInfo[playerid][posy] = 0.0;
		PlayerInfo[playerid][posz] = 0.0;
		PlayerInfo[playerid][angle] = 0.0;
		PlayerInfo[playerid][interiorid] = 0;
		PlayerInfo[playerid][bikerent] = 0;
		format(PlayerInfo[playerid][passtext], 24, "none");
	    format(PlayerInfo[playerid][email], 24, "none");
		PlayerInfo[playerid][dinero] = 0;
		PlayerInfo[playerid][dinerobank] = 0;
		PlayerInfo[playerid][sexo] = 0;
		PlayerInfo[playerid][edad] = 0;
		PlayerInfo[playerid][skin] = 0;
		PlayerInfo[playerid][vida] = 0;
		PlayerInfo[playerid][chaleco] = 0;
		PlayerInfo[playerid][admlvl] = 0;
	  	PlayerInfo[playerid][phonenumber] = 0;
	 	PlayerInfo[playerid][Interior] = 0;
	 	PlayerInfo[playerid][BankA] = 0;
	 	PlayerInfo[playerid][Work] = 0;
	 	PlayerInfo[playerid][VBank] = 0;
	 	PlayerInfo[playerid][VGrotti] = 0;
	 	PlayerInfo[playerid][V247] = 0;
	 	PlayerInfo[playerid][VRopa] = 0;
	 	PlayerInfo[playerid][VComida] = 0;
	 	PlayerInfo[playerid][DudeChannel] = 0;
	 	PlayerInfo[playerid][Plevel] = 0;
	 	PlayerInfo[playerid][PlayerVehicle][0] = -1;
	 	PlayerInfo[playerid][PlayerVehicle][1] = -1;
	 	PlayerInfo[playerid][PlayerVehicle][2] = -1;
	 	PlayerInfo[playerid][PlayerVehicle][3] = -1;
	 	PlayerInfo[playerid][PlayerVehicleKey][0] = -1;
	 	PlayerInfo[playerid][PlayerVehicleKey][1] = -1;
	 	PlayerInfo[playerid][PlayerVehicleKey][2] = -1;
	 	PlayerInfo[playerid][PlayerVehicleKey][3] = -1;
		P_newuser[playerid] = 1;
		PlayAudioStreamForPlayer(playerid, "https://dl.dropboxusercontent.com/s/fvrfgq5mw45nhoe/newintro.mp3");
	}
	PoliciaAvisada[playerid] = 0;
	DudeTime[playerid] = 0;
	CarWashUsedBy[playerid] = 0;
    P_register_step[playerid] = -1;
    P_catalogogrotti[playerid] = -1;
    UsingPhone[playerid] = 0;
    NumeroMarcado[playerid] = 0;
    CreatePlayerTextDraws(playerid);
	RemoveBuildings(playerid);
    ChatLogDisabled[playerid] = true;
    SetPlayerColor(playerid, 0xFFFFFFFF);
    new s[128]; format(s, sizeof s, "%s (%d)", PlayerName(playerid), playerid);
	IDlabel[playerid] = Create3DTextLabel(s, 0xFFFFFFFF, 30.0, 40.0, 50.0, 40.0, 1);
    Attach3DTextLabelToPlayer(IDlabel[playerid], playerid, 0.0, 0.0, 0.2);
	return 1;
}

funcion:ExpulsarTimer(playerid) return Kick(playerid);

public OnPlayerDisconnect(playerid, reason)
{
	if(IsPlayerNPC(playerid)) return 1;
	Delete3DTextLabel(IDlabel[playerid]);
	DestroyPlayerTextDraws(playerid);
    loop(0, 50, l) KillTimer(MyTimers[playerid][l]);
    P_conocerid[playerid] = -1;
    P_No_Message_Atraco[playerid] = -1;
    P_circularmenu_active[playerid] = -1;
    P_player_tutorial[playerid] = -1;
    P_bank_state[playerid] = -1;
    P_register_step[playerid] = -1;
    P_catalogogrotti[playerid] = -1;

	if(P_newuser[playerid] == 0) return P_newuser[playerid] = -1;
	if(P_newuser[playerid] > 0)
	{
	    P_newuser[playerid] = -1;
		new Query[128];
		format(Query, 128, "DELETE FROM `USERS` WHERE `NAME` = '%s'", PlayerNameNormal(playerid));
        db_free_result(db_query(Database, Query));
 		new str[128];
  		format(str, 128, "/eXtremeROL/emails/%s.ini", PlayerInfo[playerid][email]);
		fremove(str);
		return 1;
	}
    if(CarWashUsedBy[playerid] == 1)
    {
        CarWashUsed = 0;
        CarWashUsedBy[playerid] = 0;
        
        SetDynamicObjectPos(CarWash[0], 0, 0, -100);
        SetDynamicObjectPos(CarWash[1], 0, 0, -100);
        SetDynamicObjectPos(CarWash[2], 0, 0, -100);
        SetDynamicObjectPos(CarWash[3], 0, 0, -100);
        SetObjectPos(CarWash[4], 0, 0, -100);
    }
    if(NPC_USED[NPCS[BITCH_BJ]])
	{
	    if(PlayerEvent[playerid][BITCH_BJ])
	    {
	        ApplyAnimation(NPCS[BITCH_BJ],"PED","WALK_player",4.0,0,0,0,0,1);
	        ApplyAnimation(NPCS[BITCH_BJ],"PED","WALK_player",4.0,0,0,0,0,1);
	        NPC_USED[NPCS[BITCH_BJ]] = false;
	        PlayerEvent[playerid][BITCH_BJ] = false;
	    }
	}
	if(NPC_USED[NPCS[SHOP_UNITY]] == 2)
	{
	    if(PlayerEvent[playerid][SHOP_UNITY])
	    {
			ApplyAnimation(NPCS[SHOP_UNITY],"PED","WALK_player",4.0,0,0,0,0,1);
			ApplyAnimation(NPCS[SHOP_UNITY],"PED","WALK_player",4.0,0,0,0,0,1);
			NPC_USED[NPCS[SHOP_UNITY]] = false;
			PlayerEvent[playerid][SHOP_UNITY] = false;
		}
	}
	if(NPC_USED[NPCS[SHOP_AYUNT]] == 2)
	{
	    if(PlayerEvent[playerid][SHOP_AYUNT])
	    {
			ApplyAnimation(NPCS[SHOP_AYUNT],"PED","WALK_player",4.0,0,0,0,0,1);
			ApplyAnimation(NPCS[SHOP_AYUNT],"PED","WALK_player",4.0,0,0,0,0,1);
			NPC_USED[NPCS[SHOP_AYUNT]] = false;
			PlayerEvent[playerid][SHOP_AYUNT] = false;
		}
	}
	if(NPC_USED[NPCS[SHOP_VINE]] == 2)
	{
	    if(PlayerEvent[playerid][SHOP_VINE])
	    {
			ApplyAnimation(NPCS[SHOP_VINE],"PED","WALK_player",4.0,0,0,0,0,1);
			ApplyAnimation(NPCS[SHOP_VINE],"PED","WALK_player",4.0,0,0,0,0,1);
			NPC_USED[NPCS[SHOP_VINE]] = false;
			PlayerEvent[playerid][SHOP_VINE] = false;
		}
	}
	if(NPC_USED[NPCS[30]] == 1)
	{
	    if(PlayerEvent[playerid][10] == 1 || PlayerEvent[playerid][10] == 2)
	    {
			PlayerEvent[playerid][10] = 0;
			NPC_USED[NPCS[30]] = false;
			ApplyAnimation(NPCS[30],"PED","WALK_player",4.0,0,0,0,0,1);
			ApplyAnimation(NPCS[30],"PED","WALK_player",4.0,0,0,0,0,1);
		}
	}
	P_newuser[playerid] = -1;
	UpdateUserData(playerid);
	for(new i = 0; i != 5; i++)
	{
		if(PlayerInfo[playerid][PlayerVehicleKey][i] != -1)
		{
		    new Query[600], Float:p[4], str[600];
		    new veh = PlayerInfo[playerid][PlayerVehicle][i];
			GetVehiclePos(veh, p[0], p[1], p[2]);
			GetVehicleZAngle(veh, p[3]);
		    format(Query, sizeof(Query), "UPDATE `VEHS` SET ");
		    format(str, 600, "`VPOSX` = '%f', `VPOSY` = '%f', `VPOSZ` = '%f', `VANGLE` = '%f', `VCOLOR1` = '%d', `VCOLOR2` = '%d', `VPAINTJOB` = '%d', `VM1` = '%d', `VM2` = '%d', `VM3` = '%d', `VM4` = '%d', `VM5` = '%d', `VM6` = '%d', `VM7` = '%d', `VM8` = '%d', `VM9` = '%d', ", p[0], p[1], p[2], p[3],
			VehicleInfo[veh][vcolor1],
			VehicleInfo[veh][vcolor2],
			VehicleInfo[veh][vpaintjob],
			VehicleInfo[veh][mod1],
			VehicleInfo[veh][mod2],
			VehicleInfo[veh][mod3],
			VehicleInfo[veh][mod4],
			VehicleInfo[veh][mod5],
			VehicleInfo[veh][mod6],
			VehicleInfo[veh][mod7],
			VehicleInfo[veh][mod8],
			VehicleInfo[veh][mod9]);
			strcat(Query, str);
			format(str, 600, "`VM10` = '%d', `VM11` = '%d', `VM12` = '%d', `VM13` = '%d', `VM14` = '%d', `VM15` = '%d', `VM16` = '%d', `VM17` = '%d' WHERE `VKEY` = '%d' AND `VD` = '%s'", VehicleInfo[veh][mod10], VehicleInfo[veh][mod11], VehicleInfo[veh][mod12], VehicleInfo[veh][mod13], VehicleInfo[veh][mod14], VehicleInfo[veh][mod15], VehicleInfo[veh][mod16], VehicleInfo[veh][mod17], PlayerInfo[playerid][PlayerVehicleKey][i], PlayerNameNormal(playerid));
            strcat(Query, str);
			db_query(Database, Query);//600000
			DestroyVehiclesTimer[PlayerInfo[playerid][PlayerVehicle][i]] = SetTimerEx("DestroyPlayerVehicle", 5000, false, "d", PlayerInfo[playerid][PlayerVehicle][i]);
		}
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
    for(new i = 0; i < 11; i++) SetPlayerSkillLevel(playerid, i, 1);
	if(IsPlayerNPC(playerid))
	{
	    CargarAnim(playerid);
		new npcname[24];
		GetPlayerName(playerid, npcname, 24);
		if(!strcmp(npcname, "NPC_001", true))
		{
			NPCS[SHOP_UNITY] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 184);
			SetPlayerInteriorEx(playerid, 17);
			return 1;
		}
		if(!strcmp(npcname, "NPC_002", true))
		{
			NPCS[BITCH_BJ] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 152);
			SetPlayerInteriorEx(playerid, 2);
			return 1;
		}
		if(!strcmp(npcname, "NPC_003", true))
		{
			NPCS[2] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 15);
			SetPlayerInteriorEx(playerid, 4);
			return 1;
		}
		if(!strcmp(npcname, "NPC_004", true))
		{
			NPCS[3] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 258);
			SetPlayerInteriorEx(playerid, 10);
			return 1;
		}
		if(!strcmp(npcname, "NPC_005", true))
		{
			NPCS[4] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 219);
			SetPlayerInteriorEx(playerid, 0);
			return 1;
		}
		if(!strcmp(npcname, "NPC_006", true))
		{
			NPCS[5] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 141);
			SetPlayerInteriorEx(playerid, 0);
			return 1;
		}
		if(!strcmp(npcname, "NPC_007", true))
		{
			NPCS[6] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 219);
			SetPlayerInteriorEx(playerid, 0);
			return 1;
		}
		if(!strcmp(npcname, "NPC_008", true))
		{
			NPCS[7] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 44);
			SetPlayerInteriorEx(playerid, 11);
			return 1;
		}
		if(!strcmp(npcname, "NPC_009", true))
		{
			NPCS[8] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 211);
			SetPlayerInteriorEx(playerid, 15);
			return 1;
		}
		if(!strcmp(npcname, "NPC_010", true))
		{
			NPCS[9] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 205);
			SetPlayerInteriorEx(playerid, 10);
			return 1;
		}
		if(!strcmp(npcname, "NPC_011", true))
		{
			NPCS[10] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 167);
			SetPlayerInteriorEx(playerid, 9);
			return 1;
		}
		if(!strcmp(npcname, "NPC_012", true))
		{
			NPCS[11] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 152);
			SetPlayerInteriorEx(playerid, 2);
			return 1;
		}
		if(!strcmp(npcname, "NPC_013", true))
		{
			NPCS[12] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 63);
			SetPlayerInteriorEx(playerid, 2);
			return 1;
		}
		if(!strcmp(npcname, "NPC_014", true))
		{
			NPCS[13] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 177);
			SetPlayerInteriorEx(playerid, 12);
			return 1;
		}
		if(!strcmp(npcname, "NPC_015", true))
		{
			NPCS[14] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 155);
			SetPlayerInteriorEx(playerid, 5);
			return 1;
		}
		if(!strcmp(npcname, "NPC_016", true))
		{
			NPCS[15] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 217);
			SetPlayerInteriorEx(playerid, 3);
			return 1;
		}
		if(!strcmp(npcname, "NPC_017", true))
		{
			NPCS[16] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 211);
			SetPlayerInteriorEx(playerid, 1);
			return 1;
		}
		if(!strcmp(npcname, "NPC_018", true))
		{
			NPCS[17] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 217);
			SetPlayerInteriorEx(playerid, 5);
			return 1;
		}
		if(!strcmp(npcname, "NPC_019", true))
		{
			NPCS[18] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 211);
			SetPlayerInteriorEx(playerid, 18);
			return 1;
		}
		if(!strcmp(npcname, "NPC_020", true))
		{
			NPCS[19] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 12);
			SetPlayerInteriorEx(playerid, 3);
			ApplyAnimation(playerid,"PED","SEAT_IDLE",4,0,0,0, 1,0);
			return 1;
		}
		if(!strcmp(npcname, "NPC_021", true))
		{
			NPCS[20] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 280);
			SetPlayerInteriorEx(playerid, 1);
			return 1;
		}
		if(!strcmp(npcname, "NPC_022", true))
		{
			NPCS[21] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 281);
			SetPlayerInteriorEx(playerid, 1);
			return 1;
		}
		if(!strcmp(npcname, "NPC_023", true))
		{
			NPCS[22] = playerid;
			TogglePlayerControllable(playerid, true);
			SetPlayerSkin(playerid, 280);
			SetPlayerInteriorEx(playerid, 1);
			return 1;
		}
		if(!strcmp(npcname, "NPC_024", true))
		{
			NPCS[23] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 171);
			SetPlayerInteriorEx(playerid, 0);
			return 1;
		}
		if(!strcmp(npcname, "NPC_025", true))
		{
			NPCS[24] = playerid;
			TogglePlayerControllable(playerid, false);
			SetPlayerSkin(playerid, 172);
			SetPlayerInteriorEx(playerid, 0);
			return 1;
		}
		if(!strcmp(npcname, "NPC_026", true))
		{
			NPCS[25] = playerid;
			TogglePlayerControllable(playerid, true);
			SetPlayerSkin(playerid, 71);
			SetPlayerInteriorEx(playerid, 0);
			return 1;
		}
		if(!strcmp(npcname, "NPC_027", true))
		{
			NPCS[26] = playerid;
			TogglePlayerControllable(playerid, true);
			SetPlayerSkin(playerid, 71);
			SetPlayerInteriorEx(playerid, 0);
			return 1;
		}
		if(!strcmp(npcname, "NPC_028", true))
		{
			NPCS[27] = playerid;
			TogglePlayerControllable(playerid, true);
			SetPlayerSkin(playerid, 71);
			SetPlayerInteriorEx(playerid, 0);
			return 1;
		}
		if(!strcmp(npcname, "NPC_029", true))
		{
			NPCS[28] = playerid;
			TogglePlayerControllable(playerid, true);
			SetPlayerSkin(playerid, 17);
			SetPlayerInteriorEx(playerid, 0);
			PutPlayerInVehicle(playerid, CoachBus, 0);
			return 1;
		}
		if(!strcmp(npcname, "NPC_030", true))
		{
			NPCS[29] = playerid;
			SetPlayerSkin(playerid, 23);
			SetPlayerInteriorEx(playerid, 17);
			return 1;
		}
		if(!strcmp(npcname, "NPC_031", true))
		{
			NPCS[30] = playerid;
			SetPlayerSkin(playerid, 192);
			SetPlayerInteriorEx(playerid, 17);
			return 1;
		}
		return 1;
	}
	if(P_newuser[playerid] == -2) return Kick(playerid);
	if(P_newuser[playerid] == 0)
	{
	    SetSpawnInfo(playerid, NO_TEAM, PlayerInfo[playerid][skin], 1172.856201, -1323.368774, 15.399730, 0, 0, 0, 0, 0, 0, 0);
		if(GetPlayerInteriorEx(playerid) != 0)
		{
		    new i = PlayerInfo[playerid][Interior];
	    	SetPlayerPos(playerid, Exteriors[i][0], Exteriors[i][1], Exteriors[i][2]);
		    SetPlayerFacingAngle(playerid, Exteriors[i][3]);
		    SetPlayerInteriorEx(playerid, 0, INT_NONE);
		}
		else
		{
		    SetPlayerPos(playerid, PlayerInfo[playerid][posx], PlayerInfo[playerid][posy], PlayerInfo[playerid][posz]); // Setea al jugador en la pos. que se desconectó
	    	SetPlayerFacingAngle(playerid, PlayerInfo[playerid][angle]); // Ángulo del jugador al spawnear
		}
	    SetPlayerSkin(playerid, PlayerInfo[playerid][skin]); // Skin usado por el jugador
	    ResetPlayerMoney(playerid);
	    GivePlayerMoney(playerid, PlayerInfo[playerid][dinero]); // Da al jugador el dinero con el que se desconectó
	    SetPlayerHealth(playerid, PlayerInfo[playerid][vida]); // Setea al jugador la vida con la que se desconectó
	    SetPlayerArmour(playerid, PlayerInfo[playerid][chaleco]); // Setea el blindaje con el que el jugador se desconectó
	    StopAudioStreamForPlayer(playerid);
	    P_newuser[playerid] = -1;
	    SendClientMessageEx(playerid, -1, "Bienvenido de nuevo a {00CCFF}eXtreme Roleplay{FFFFFF}, %s.", PlayerName(playerid));
	    ChatLogDisabled[playerid] = false;
	    CargarAnim(playerid);
	    return 1;
	}
	if(P_newuser[playerid] > 0)
	{
		SetPlayerPos(playerid, 1714.9587, -1910.3481, 13.4926);
		SetPlayerFacingAngle(playerid, 180.0);
		SetPlayerCameraPos(playerid, 1714.9827, -1918.4736, 42.1101);
		SetPlayerCameraLookAt(playerid, 1714.9911, -1917.4761, 32.1101);
		TogglePlayerControllable(playerid, false);
		SetPlayerSkin(playerid, PlayerInfo[playerid][skin]);
  		SetPlayerTime(playerid, ServerTime, ServerMinute);
		return 1;
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    if(UsingPhone[playerid] == 1 || UsingPhone[playerid] == 3 || UsingPhone[playerid] == 4)
    {
        new toplayerid = NumeroMarcado[playerid];
        ShowPlayerPhone(toplayerid, "", "Llamada finalizada");
        MyTimers[toplayerid][15] = SetTimerEx("MyPhoneContinue", 2000, false, "idi", toplayerid, 0, -1);
        MyPhoneContinue(playerid, 0, -1);
        UsingPhone[playerid] = 0;
        UsingPhone[toplayerid] = 0;
		NumeroMarcado[playerid] = 0;
		NumeroMarcado[toplayerid] = 0;
    }
    else if(UsingPhone[playerid] == 2)
    {
	    HidePlayerPhone(playerid);
	    UsingPhone[playerid] = 0;
	    NumeroMarcado[playerid] = 0;
  		KillTimer(MyTimers[playerid][15]);
    }
    if(P_bank_state[playerid] > 0)
    {
        loop(0, 20, l) TextDrawHideForPlayer(playerid, Bank[l]);
        PlayerTextDrawHide(playerid, PlayerBank[playerid][0]);
        PlayerTextDrawHide(playerid, PlayerBank[playerid][1]);
    	P_bank_state[playerid] = -1;
    	ChatLogDisabled[playerid] = false;
    }
    if(P_catalogogrotti[playerid] >= 0)
	{
	    KillTimer(MyTimers[playerid][16]);
	    SetCameraBehindPlayer(playerid);
	    TogglePlayerControllable(playerid, true);
		P_catalogogrotti[playerid] = -1;
		ChatLogDisabled[playerid] = false;
		loop(0, 9, i) TextDrawHideForPlayer(playerid, TD_GrottiCatalogo[i]);
		PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][0]);
		PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][1]);
		PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][2]);
		PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][3]);
		CancelSelectTextDraw(playerid);
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	if(VehicleInfo[vehicleid][vmodelid] != 0)
	{
		ChangeVehiclePaintjob(vehicleid, VehicleInfo[vehicleid][vpaintjob]);
	    ModVehicle(vehicleid);
	}
	return 1;
}

stock ModVehicle(vehicleid)
{
	if(VehicleInfo[vehicleid][mod1] != 0) AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod1]);
	if(VehicleInfo[vehicleid][mod2] != 0) AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod2]);
	if(VehicleInfo[vehicleid][mod3] != 0) AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod3]);
	if(VehicleInfo[vehicleid][mod4] != 0) AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod4]);
	if(VehicleInfo[vehicleid][mod5] != 0) AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod5]);
	if(VehicleInfo[vehicleid][mod6] != 0) AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod6]);
	if(VehicleInfo[vehicleid][mod7] != 0) AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod7]);
	if(VehicleInfo[vehicleid][mod8] != 0) AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod8]);
	if(VehicleInfo[vehicleid][mod9] != 0) AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod9]);
	if(VehicleInfo[vehicleid][mod10] != 0) AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod10]);
	if(VehicleInfo[vehicleid][mod11] != 0) AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod11]);
	if(VehicleInfo[vehicleid][mod12] != 0) AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod12]);
	if(VehicleInfo[vehicleid][mod13] != 0) AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod13]);
	if(VehicleInfo[vehicleid][mod14] != 0) AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod14]);
	if(VehicleInfo[vehicleid][mod15] != 0) AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod15]);
	if(VehicleInfo[vehicleid][mod16] != 0) AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod16]);
	if(VehicleInfo[vehicleid][mod17] != 0) AddVehicleComponent(vehicleid,VehicleInfo[vehicleid][mod17]);
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
    if(ChatLogDisabled[playerid]) return 0;
	if(UsingPhone[playerid] == 3)
	{
	    new toplayerid = NumeroMarcado[playerid];
	    SendClientMessageEx(toplayerid, -1, "{00CCFF}* Telefóno: {FFFFFF}%s", text);
	    SendClientMessageEx(playerid, -1, "{CCCCCC}* Telefóno: {FFFFFF}%s", text);
	    return 0;
	}
    if(text[0] == '!')
    {
		if(text[1] != '\0')
		{
		    new str[145], str2[145];
	      	format(str,sizeof(str),"		{CCCCCC}%s {FFFFFF} %s.", PlayerName(playerid), text[1]);
	      	format(str2,sizeof(str2),"		 {CCCCCC}%s {FFFFFF} %s.", "Desconocido", text[1]);
	 		SendPlayersMessage(10.0, playerid, 0xF000D8FF, str, str2);
	 		return 0;
		}
	}
	if(ChatLogDisabled[playerid] == 0)
	{
		new str[145], str2[145];
	  	format(str,sizeof(str),"%s dice: %s", PlayerName(playerid), text);
	  	format(str2,sizeof(str2),"%s dice: %s", "Desconocido", text);
		SendPlayersMessage(10.0, playerid, 0xCCCCCCFF, str, str2);
		return false;
	}
	return false;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(vehicleid >= VBikeRent[0] && vehicleid <= VBikeRent[1])
    {
        if(PlayerInfo[playerid][bikerent] == 0)
        {
            InfoMSG(playerid, 3000, "Para usar el préstamo de bicicleta, debe hacerse~n~un carnet en el ~b~Ayuntamiento ~w~primero.");
            ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1);
            ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1);
            return 1;
        }
    }
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(vehicleid >= VBikeRent[0] && vehicleid <= VBikeRent[1])
	    {
	        if(PlayerInfo[playerid][bikerent] == 0)
	        {
	            InfoMSG(playerid, 3000, "Para usar el préstamo de bicicleta, debe hacerse~n~un carnet en el ~b~Ayuntamiento ~w~primero.");
	            RemovePlayerFromVehicle(playerid);
	            return 1;
	        }
	        else if(PlayerInfo[playerid][bikerent] == 1)
	        {
	            SetVehicleParamsEx(vehicleid, 1, 0, 0, 0, 0, 0, 0);
	            SendClientMessage(playerid, -1, "Estás usando el servicio de préstamos del ayuntamiento de Los Santos.");
	            SendClientMessage(playerid, -1, "{CCCCCC}(Si pasan 5 mins sin la bici, esta se devolverá a su lugar)");
	            return 1;
	        }
	    }
	    if(vehicleid >= VVehicleGrotti[0] && vehicleid <= VVehicleGrotti[1])
	    {
			SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 0, 0, 0);
            InfoMSG(playerid, 3000, "Has entrado a un vehículo de exposición,~n~~b~dirígase al mostrador si desea comprar uno.");
	    }
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(P_No_Message_Atraco[playerid] == 1)
	{
	    if(GetPlayerInteriorEx(playerid) == INT_247U)
	    {
	        if(NPC_USED[NPCS[SHOP_UNITY]] == 0)
	        {
				NPC_USED[NPCS[SHOP_UNITY]] = 2;
				PlayerEvent[playerid][SHOP_UNITY] = true;
				SetPlayerPos(playerid, -28.446060, -185.112228, 1003.546875);
				SetPlayerFacingAngle(playerid, 194.485290);
			    KillTimer(MyTimers[playerid][13]);


			    SetCameraBehindPlayer(playerid);
			    TogglePlayerControllable(playerid, false);

				ApplyAnimation(playerid,"SHOP","ROB_Loop_Threat",4.1,1,1,1,1,1,1);
				ApplyAnimation(playerid,"SHOP","ROB_Loop_Threat",4.1,1,1,1,1,1,1);
				ApplyAnimation(playerid,"SHOP","ROB_Loop_Threat",4.1,1,1,1,1,1,1);
				ApplyAnimation(playerid,"SHOP","ROB_Loop_Threat",4.1,1,1,1,1,1,1);

				ApplyAnimation(NPCS[SHOP_UNITY],"SHOP","SHP_Rob_React",4.1,0,1,1,1,1,1);
				ApplyAnimation(NPCS[SHOP_UNITY],"SHOP","SHP_Rob_React",4.1,0,1,1,1,1,1);
				ApplyAnimation(NPCS[SHOP_UNITY],"SHOP","SHP_Rob_React",4.1,0,1,1,1,1,1);
				ApplyAnimation(NPCS[SHOP_UNITY],"SHOP","SHP_Rob_React",4.1,0,1,1,1,1,1);
				SetPlayerDrunkLevel(playerid, 2500);
				InterpolateCameraPos(playerid, -28.919799, -183.278396, 1004.433410, -24.371448, -184.631881, 1005.830017, 3000);
				InterpolateCameraLookAt(playerid, -28.672475, -184.235733, 1004.283996, -28.462133, -186.144622, 1003.385009, 3000);
		        DisablePlayerCheckpoint(playerid);
		        P_No_Message_Atraco[playerid] = -1;
		        DeleteChatForPlayer(playerid, 32, remove);

		        TextDrawShowForPlayer(playerid, TD_BX[0]);
		    	TextDrawShowForPlayer(playerid, TD_BX[1]);
				ChatLogDisabled[playerid] = true;
				PlayerTextDrawSetString(playerid, TD_IO[playerid], "_~n~__El atraco ha comenzado.~n~__Espera que el vendedor llene~n~__la bolsa de dinero...~n~~n~");
				PlayerTextDrawShow(playerid, TD_IO[playerid]);
				MyTimers[playerid][12] = SetTimerEx("RobContinue", 7000, 0, "idi", playerid, 0, SHOP_UNITY);
				return 1;
			}
		}
		if(GetPlayerInteriorEx(playerid) == INT_247VIN)
	    {
	        if(NPC_USED[NPCS[SHOP_VINE]] == 0)
	        {
				NPC_USED[NPCS[SHOP_VINE]] = 2;
				PlayerEvent[playerid][SHOP_VINE] = true;

				SetPlayerPos(playerid, 2.412037, -28.959587, 1003.549438);
				SetPlayerFacingAngle(playerid, 210.103500);
			    KillTimer(MyTimers[playerid][13]);


			    SetCameraBehindPlayer(playerid);
			    TogglePlayerControllable(playerid, false);

				ApplyAnimation(playerid,"SHOP","ROB_Loop_Threat",4.1,1,1,1,1,1,1);
				ApplyAnimation(playerid,"SHOP","ROB_Loop_Threat",4.1,1,1,1,1,1,1);
				ApplyAnimation(playerid,"SHOP","ROB_Loop_Threat",4.1,1,1,1,1,1,1);
				ApplyAnimation(playerid,"SHOP","ROB_Loop_Threat",4.1,1,1,1,1,1,1);

				ApplyAnimation(NPCS[SHOP_VINE],"SHOP","SHP_Rob_React",4.1,0,1,1,1,1,1);
				ApplyAnimation(NPCS[SHOP_VINE],"SHOP","SHP_Rob_React",4.1,0,1,1,1,1,1);
				ApplyAnimation(NPCS[SHOP_VINE],"SHOP","SHP_Rob_React",4.1,0,1,1,1,1,1);
				ApplyAnimation(NPCS[SHOP_VINE],"SHOP","SHP_Rob_React",4.1,0,1,1,1,1,1);
				SetPlayerDrunkLevel(playerid, 2500);
				InterpolateCameraPos(playerid, 1.124199, -26.738199, 1004.537780, 7.980316, -27.542730, 1005.657958, 3000);
				InterpolateCameraLookAt(playerid, 1.620131, -27.593605, 1004.388366, 7.156741, -27.963136, 1005.277221, 3000);
		        DisablePlayerCheckpoint(playerid);
		        P_No_Message_Atraco[playerid] = -1;
		        DeleteChatForPlayer(playerid, 32, remove);

		        TextDrawShowForPlayer(playerid, TD_BX[0]);
		    	TextDrawShowForPlayer(playerid, TD_BX[1]);
	            ChatLogDisabled[playerid] = true;
				PlayerTextDrawSetString(playerid, TD_IO[playerid], "_~n~__El atraco ha comenzado.~n~__Espera que el vendedor llene~n~__la bolsa de dinero...~n~~n~");
				PlayerTextDrawShow(playerid, TD_IO[playerid]);
				MyTimers[playerid][12] = SetTimerEx("RobContinue", 7000, 0, "idi", playerid, 0, SHOP_VINE);
				return 1;
			}
		}
		if(GetPlayerInteriorEx(playerid) == INT_247AYU)
	    {
	        if(NPC_USED[NPCS[SHOP_AYUNT]] == 0)
	        {
				NPC_USED[NPCS[SHOP_AYUNT]] = 2;
				PlayerEvent[playerid][SHOP_AYUNT] = true;

				SetPlayerPos(playerid, -30.413436, -28.982168, 1003.557250);
				SetPlayerFacingAngle(playerid, 199.426803);
			    KillTimer(MyTimers[playerid][13]);


			    SetCameraBehindPlayer(playerid);
			    TogglePlayerControllable(playerid, false);

				ApplyAnimation(playerid,"SHOP","ROB_Loop_Threat",4.1,1,1,1,1,1,1);
				ApplyAnimation(playerid,"SHOP","ROB_Loop_Threat",4.1,1,1,1,1,1,1);
				ApplyAnimation(playerid,"SHOP","ROB_Loop_Threat",4.1,1,1,1,1,1,1);
				ApplyAnimation(playerid,"SHOP","ROB_Loop_Threat",4.1,1,1,1,1,1,1);

				ApplyAnimation(NPCS[SHOP_AYUNT],"SHOP","SHP_Rob_React",4.1,0,1,1,1,1,1);
				ApplyAnimation(NPCS[SHOP_AYUNT],"SHOP","SHP_Rob_React",4.1,0,1,1,1,1,1);
				ApplyAnimation(NPCS[SHOP_AYUNT],"SHOP","SHP_Rob_React",4.1,0,1,1,1,1,1);
				ApplyAnimation(NPCS[SHOP_AYUNT],"SHOP","SHP_Rob_React",4.1,0,1,1,1,1,1);
				SetPlayerDrunkLevel(playerid, 2500);

				InterpolateCameraPos(playerid, -31.010599, -27.289100, 1004.428771, -27.082044, -27.978450, 1005.534057, 3000);
				InterpolateCameraLookAt(playerid, -30.681732, -28.221578, 1004.279357, -27.810798, -28.538206, 1005.139587, 3000);
		        DisablePlayerCheckpoint(playerid);
		        P_No_Message_Atraco[playerid] = -1;
		        DeleteChatForPlayer(playerid, 32, remove);

		        TextDrawShowForPlayer(playerid, TD_BX[0]);
		    	TextDrawShowForPlayer(playerid, TD_BX[1]);
	            ChatLogDisabled[playerid] = true;
				PlayerTextDrawSetString(playerid, TD_IO[playerid], "_~n~__El atraco ha comenzado.~n~__Espera que el vendedor llene~n~__la bolsa de dinero...~n~~n~");
				PlayerTextDrawShow(playerid, TD_IO[playerid]);
				MyTimers[playerid][12] = SetTimerEx("RobContinue", 7000, 0, "idi", playerid, 0, SHOP_AYUNT);
				return 1;
			}
		}
	}
	else DisablePlayerCheckpoint(playerid);
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

public OnPlayerEnterDynamicArea(playerid, areaid)
{
	if(areaid == Area_CarWash)
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        if(GetPlayerVehicleSeat(playerid) == 0)
	        {
			    new Float:p[3];
			    GetPlayerPos(playerid, p[0], p[1], p[2]);
			    if(p[2] >= 10.0 && 15.0 >= p[2])
			    {
			        PlayerTextDrawSetString(playerid, ErrorCommand[playerid], simbolos("Presiona ~b~~k~~CONVERSATION_YES~ ~w~para lavar tu vehículo"));
					PlayerTextDrawShow(playerid, ErrorCommand[playerid]);
				}
			}
		}
	}
	return 1;
}

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
	if(areaid == Area_CarWash) PlayerTextDrawHide(playerid, ErrorCommand[playerid]);
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
    if(IsPlayerNPC(playerid)) return 1;
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
    if(pickupid == Alhambra_Pick)
    {
        if(NPC_USED[NPCS[30]] == 0)
        {
			NPC_USED[NPCS[30]] = 1;
			ApplyAnimation(NPCS[30], "BAR", "Barserve_order", 4.0, 0, 0, 0, 0, 0, 1);
			ApplyAnimation(NPCS[30], "BAR", "Barserve_order", 4.0, 0, 0, 0, 0, 0, 1);
			SetPlayerPos(playerid, 481.611053, -10.849586, 993.276672);
			SetPlayerFacingAngle(playerid, 90.0);
			TogglePlayerControllable(playerid, false);
			ShowMenuForPlayer(AlhambraMenu, playerid);
			PlayerEvent[playerid][10] = 2;
			return 1;
		}
	}
	if(pickupid == Conce_Pick1 || pickupid == Conce_Pick2)
    {
        if(P_catalogogrotti[playerid] == -1)
        {
        	InfoMSG(playerid, 3000, "Presiona ~y~~k~~VEHICLE_ENTER_EXIT~ ~w~para ver el ~y~catálogo");
		}
    }
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
    SaveComponent(playerid, vehicleid, componentid);
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	    if(!strcmp(VehicleInfo[vehicleid][VD], PlayerNameNormal(playerid), false))
		{
		    VehicleInfo[vehicleid][vpaintjob] = paintjobid;
		}
	}
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	    if(!strcmp(VehicleInfo[vehicleid][VD], PlayerNameNormal(playerid), false))
		{
		    VehicleInfo[vehicleid][vcolor1] = color1;
		    VehicleInfo[vehicleid][vcolor2] = color2;
		}
	}
	return 1;
}
funcion:BarContinue(playerid, t, d)
{
	switch(t)
	{
	    case 0:
	    {
	        ApplyAnimation(playerid, "BAR", "Barcustom_get", 4.0, 0, 0, 0, 0, 0, 1);
        	ApplyAnimation(playerid, "BAR", "Barcustom_get", 4.0, 0, 0, 0, 0, 0, 1);
        	SetTimerEx("BarContinue", 1200, false, "idd", playerid, 1, d);
         
	    }
	    case 1:
	    {
	        if(d == 0) SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
	        else SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);
	        ApplyAnimation(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 0, 0, 0, 0, 1);
	        InfoMSG(playerid, 5000, "Usa ~b~~k~~VEHICLE_FIREWEAPON~ ~w~para beber, y ~b~~k~~CONVERSATION_NO~ ~w~para irte.");
	        PlayerEvent[playerid][10] = 1;
	    }
	    case 2:
	    {
	        NPC_USED[NPCS[30]] = 0;
	    }
	}
	return 1;
}
public OnPlayerSelectedMenuRow(playerid, row)
{	
    if(GetPlayerMenu(playerid) == AlhambraMenu)
    {
        if(row == 0) SetTimerEx("BarContinue", 1000, false, "idd", playerid, 0, 0);
        else SetTimerEx("BarContinue", 1000, false, "idd", playerid, 0, 1);
        ApplyAnimation(NPCS[30], "BAR", "Barserve_bottle", 4.0, 0, 0, 0, 0, 0, 1);
        ApplyAnimation(NPCS[30], "BAR", "Barserve_bottle", 4.0, 0, 0, 0, 0, 0, 1);
    }
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	TogglePlayerControllable(playerid, true);
    PlayerEvent[playerid][10] = 0;
    SetPlayerSpecialAction(playerid, 0);
    ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1);
    ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1);
    SetTimerEx("BarContinue", 3000, false, "id", playerid, 2);
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_ANALOG_UP)
	{
	    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
	        new vehicleid = GetPlayerVehicleID(playerid);
			new engine, vlights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(vehicleid, engine, vlights, alarm, doors, bonnet, boot, objective);
			if(engine) SetVehicleParamsEx(vehicleid, 0, vlights, alarm, doors, bonnet, boot, objective);
			else SetVehicleParamsEx(vehicleid, 1, vlights, alarm, doors, bonnet, boot, objective);
		}
	}
	if(newkeys & KEY_ANALOG_DOWN)
	{
	    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
	        new vehicleid = GetPlayerVehicleID(playerid);
			new engine, vlights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(vehicleid, engine, vlights, alarm, doors, bonnet, boot, objective);
			if(vlights) SetVehicleParamsEx(vehicleid, engine, 0, alarm, doors, bonnet, boot, objective);
			else SetVehicleParamsEx(vehicleid, engine, 1, alarm, doors, bonnet, boot, objective);
		}
	}
	if(newkeys & KEY_YES)
	{
	    if(UsingPhone[playerid] == 1)
	    {
	        new toplayerid = NumeroMarcado[playerid];
	        ShowPlayerPhone(playerid, "", "Llamada establecida");
	        ShowPlayerPhone(toplayerid, "", "Llamada establecida");
	        UsingPhone[playerid] = 3;
	        UsingPhone[toplayerid] = 3;
	        PlayerPlaySound(playerid, 0, 0, 0, 0);
	        return 1;
	    }
	    
	    if(IsPlayerInDynamicArea(playerid, Area_CarWash))
        {
            if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
            new Float:p[3];
		    GetPlayerPos(playerid, p[0], p[1], p[2]);
		    if(p[2] >= 10.0 && 15.0 >= p[2])
		    {
				if(CarWashUsed == 1) return SendClientMessage(playerid, -1, "Espera que la persona que hay dentro acabe.");
				if(25 > PlayerInfo[playerid][dinero]) return SendClientMessage(playerid, -1, "Necesitas {00CCFF}$25 {FFFFFF}para usar este servicio.");
				for(new x = 0; x < sizeof(unwashable); x++)
				{
					if(GetVehicleModel(GetPlayerVehicleID(playerid)) == unwashable[x][0])
					{
						SendClientMessage(playerid, -1, "No puedes lavar este vehículo.");
						return 1;
					}
				}
				CarWashUsed = 1;
				CarWashUsedBy[playerid] = 1;
				new vehicleid = GetPlayerVehicleID(playerid);
				SetVehiclePos(vehicleid, 1911.1471, -1782.4995, 13.0840);
				SetPlayerCameraPos(playerid, 1906.8824, -1784.9575, 15.1860);
				SetPlayerCameraLookAt(playerid, 1907.5662, -1784.2316, 14.9760);
				SetVehicleZAngle(vehicleid, 0.0);
				TogglePlayerControllable(playerid, true);
				MyTimers[playerid][20] = SetTimerEx("washcontinue", 100, 0, "idd", playerid, vehicleid, 0);
				return 1;
			}
        }
	    return 1;
	}
	else if(newkeys & KEY_NO)
	{
	    if(PlayerEvent[playerid][10] == 1)
	    {
	        TogglePlayerControllable(playerid, true);
	        SetPlayerSpecialAction(playerid, 0);
	        ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1);
            ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1);
            PlayerEvent[playerid][10] = 0;
            SetTimerEx("BarContinue", 3000, false, "id", playerid, 2);
	    }
	    if(UsingPhone[playerid] == 1 || UsingPhone[playerid] == 3 || UsingPhone[playerid] == 4)
	    {
	        new toplayerid = NumeroMarcado[playerid];
	        ShowPlayerPhone(toplayerid, "", "Llamada finalizada");
	        MyTimers[toplayerid][15] = SetTimerEx("MyPhoneContinue", 2000, false, "idi", toplayerid, 0, -1);
	        MyPhoneContinue(playerid, 0, -1);
	        UsingPhone[playerid] = 0;
	        UsingPhone[toplayerid] = 0;
			NumeroMarcado[playerid] = 0;
			NumeroMarcado[toplayerid] = 0;
	    }
	    else if(UsingPhone[playerid] == 2)
	    {
		    HidePlayerPhone(playerid);
		    UsingPhone[playerid] = 0;
		    NumeroMarcado[playerid] = 0;
      		KillTimer(MyTimers[playerid][15]);
	    }
	    return 1;
	}
	if(newkeys & KEY_SECONDARY_ATTACK)
	{
	    //if(GetPlayerVirtualWorld(playerid) != 0) return 1;
	    if(IsPlayerInRangeOfPoint(playerid, 1.0, 361.829895, 173.562728, 1008.0)) // Info ayunta
	    {
			ShowPlayerDialog(playerid, DIALOG_AYUNTA, DIALOG_STYLE_LIST, "Ayuntamiento", "Carnet de préstamo de bicicletas", "Continuar", "Cancelar");
            return 1;
	    }
	    //concesionario catalogo
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 560.660095, -1310.996093, 1996.575927) || IsPlayerInRangeOfPoint(playerid, 1.0, 560.660095, -1313.875244, 1996.575927)) // Grotti
	    {
	        if(P_catalogogrotti[playerid] == -1)
        	{
	        	new Float:p[6];
				GetPlayerCameraPos(playerid, p[0], p[1], p[2]);
				GetPlayerCameraLookAt(playerid, p[3], p[4], p[5]);
				InterpolateCameraPos(playerid, p[0], p[1], p[2], 544.1366, -1307.1511, 1999.2629, 2000);
				InterpolateCameraLookAt(playerid, p[3], p[4], p[5], 544.1366, -1298.1511, 1997.2629, 2000);
				TogglePlayerControllable(playerid, false);
				P_catalogogrotti[playerid] = 3;
				DeleteChatForPlayer(playerid,32,a);
				ChatLogDisabled[playerid] = true;
				loop(0, 9, i) TextDrawShowForPlayer(playerid, TD_GrottiCatalogo[i]);
				PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][0], "Infernus");
				PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][1], "$450.000");
				PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][2], 580.0, 0.000000);
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][3], 575.0, 0.000000);
				PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][0]);
				PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][1]);
				PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][2]);
				PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][3]);
				SelectTextDraw(playerid, -1);
				MyTimers[playerid][16] = SetTimerEx("GrottiContinue", 2000, false, "id", playerid, 0);
				SendClientMessage(playerid, -1, "Usa la tecla {FFFF00}ESC {FFFFFF}para salir del catálogo");
				return 1;
			}
		}
	    // ----> Entradas
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 542.3840,-1293.5125,17.2422)) // Grotti
	    {
	        if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "La ~b~tienda ~w~está cerrada.");
            SetPlayerPosAndFreeze(playerid, 545.4426,-1318.3784,1996.5759, 0);
            SetPlayerFacingAngle(playerid, 350);
            SetPlayerInteriorEx(playerid, 1, INT_GROTTI);
            
            if(PlayerInfo[playerid][VGrotti] == 0)
            {
                TogglePlayerSpectating(playerid, true);
				InterpolateCameraPos(playerid, 563.4124, -1307.5094, 1997.8839, 560.8727, -1307.2117, 1997.7656, 10000);
				InterpolateCameraLookAt(playerid, 562.7654, -1306.7488, 1997.8208, 560.2227, -1306.4536, 1997.7225, 10000);
				PlayerTextDrawSetString(playerid, TD_IO[playerid], simbolos("_~n~__Bienvenido a Grotti.~n~__En Grotti podrás comprar~n~__vehículos de alta gama...~n~~n~"));
				PlayerTextDrawShow(playerid, TD_IO[playerid]);
				DeleteChatForPlayer(playerid,32,a);
				ChatLogDisabled[playerid] = true;
				MyTimers[playerid][21] = SetTimerEx("GrottiNextView", 9000, 0, "id", playerid, 0);
            }
            return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1464.851318, -1010.793090, 26.843750)) // Banco
	    {
	        if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "El ~b~banco ~w~está cerrado.");
	        SetPlayerPos(playerid, 1464.995117, -1009.071533, 26.815937);
	        SetPlayerFacingAngle(playerid, 0);
	        SetPlayerInteriorEx(playerid, 0, INT_BANCO);
	        
	        if(PlayerInfo[playerid][VBank] == 0)
            {
                TogglePlayerSpectating(playerid, true);
				InterpolateCameraPos(playerid, 1462.3059, -1035.7103, 28.8558, 1462.3125, -1037.5824, 29.4559, 10000);
				InterpolateCameraLookAt(playerid, 1462.3025, -1034.7119, 28.5358, 1462.3091, -1036.5840, 29.1359, 10000);
				PlayerTextDrawSetString(playerid, TD_IO[playerid], simbolos("_~n~__Bienvenido a Banco LS.~n~__Este es el banco nacional~n~__de Los Santos...~n~~n~"));
				PlayerTextDrawShow(playerid, TD_IO[playerid]);
				DeleteChatForPlayer(playerid,32,a);
				ChatLogDisabled[playerid] = true;
				MyTimers[playerid][21] = SetTimerEx("BankNextView", 9000, 0, "id", playerid, 0);
            }
	        return 1;
	    }

	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 648.8630,-1360.6012,13.5863)) // CNN
	    {
	        if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "~b~CNN ~w~está cerrado.");
	        SetPlayerPosAndFreeze(playerid, 646.0635,-1356.4440,4002.5896, 0);
	        SetPlayerFacingAngle(playerid, 270);
	        SetPlayerInteriorEx(playerid, 1, INT_CNN);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1654.2700,-1654.8944,22.5156)) // Vip place
	    {
	        if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "La ~b~tienda ~w~está cerrada.");
	        SetPlayerPosAndFreeze(playerid, 852.8785,-1372.0012,1993.0859, 0);
			SetPlayerFacingAngle(playerid, 90);
	        SetPlayerInteriorEx(playerid, 1, INT_VIP);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1204.8596, 12.2682, 1000.9991)) // Bitch
	    {
	        if(NPC_USED[NPCS[BITCH_BJ]]) return InfoMSG(playerid, 1500, "Hay alguien dentro, espera a que acabe.");
	        if(PlayerInfo[playerid][sexo] == 1) return InfoMSG(playerid, 1500, "Este ~b~servicio ~w~es solo para chicos.");
			ApplyAnimation(NPCS[BITCH_BJ], "BLOWJOBZ", "BJ_COUCH_LOOP_W", 4.0, 1, 1, 1, 1, 1);
			ApplyAnimation(NPCS[BITCH_BJ], "BLOWJOBZ", "BJ_COUCH_LOOP_W", 4.0, 1, 1, 1, 1, 1);
		    ApplyAnimation(NPCS[BITCH_BJ], "BLOWJOBZ", "BJ_COUCH_LOOP_W", 4.0, 1, 1, 1, 1, 1);

		    SetPlayerInteriorEx(playerid, 2, INT_BITCH);
		    SetPlayerPos(playerid, 1204.495849, 17.410648, 1000.921875);
		    SetPlayerFacingAngle(playerid, 145.0);
		    TogglePlayerControllable(playerid, false);
		    SetPlayerAttachedObject(playerid,0,322,1,-0.183999,0.331000,0.017000,-81.499977,54.600013,-5.900000,1.000000,1.000000,1.000000);
			ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_START_P", 4.0, 0, 1, 1, 1, 1);
			ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_START_P", 4.0, 0, 1, 1, 1, 1);
			ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_START_P", 4.0, 0, 1, 1, 1, 1);
			PlayerPlaySound(playerid, 31400, 1206.4519, 13.3467, 1002.5107);
			MyTimers[playerid][11] = SetTimerEx("BitchContinue", 10000, false, "id", playerid, 0);
			SetPlayerCameraPos(playerid, 1206.4519, 13.3467, 1002.5107);
			SetPlayerCameraLookAt(playerid, 1205.9796, 14.2284, 1002.1209);
			PlayerEvent[playerid][BITCH_BJ] = true;
			NPC_USED[NPCS[BITCH_BJ]] = true;
			return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1833.149780, -1842.485717, 13.578125)) // 24/7 Unity
	    {
	        if(NPC_USED[NPCS[SHOP_UNITY]]) return InfoMSG(playerid, 1500, "La ~b~tienda ~w~está cerrada temporalmente.");
            if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "La ~b~tienda ~w~está cerrada.");
	        SetPlayerPos(playerid, -25.7535, -187.7502, 1004.1781);
	        SetPlayerFacingAngle(playerid, 0);
	        SetPlayerInteriorEx(playerid, 17, INT_247U);

	        new newweaponid = GetPlayerWeapon(playerid);
	        switch(newweaponid)
			{
			    case 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34:
			    {
			        if(P_No_Message_Atraco[playerid] == 0)
			        {
				 		SendPlayersMessage(10.0, playerid, 0xF000D8FF, "{CCCCCC}Vendedor dice: {FFFFFF}¡Por favor señor, guarde eso!", "{CCCCCC}Vendedor dice: {FFFFFF}¡Por favor señor, guarde eso!");
				 		InfoMSG(playerid, 1500, "Para empezar un atraco, dirígite al~n~~b~punto rojo señalado en el mapa.");
				 		MyTimers[playerid][13] = SetTimerEx("RobContinue", 10000, 0, "idi", playerid, 3, SHOP_UNITY);
				 		SetPlayerCheckpoint(playerid, -28.501539, -185.122360, 1003.546875, 1.0);
				 		P_No_Message_Atraco[playerid] = 1;
				 		return 1;
					}
			    }
			}
			
			MyTimers[playerid][16] = SetTimerEx("opwc_timer", 1000, true, "i", playerid);
			return 1;
	    }
        else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1836.4471,-1682.3042,13.3476)) // Alhambra
	    {
	        //if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, " ~b~Alhambra ~w~está cerrado.");
	        SetPlayerPosAndFreeze(playerid, 490.257934, -23.031440, 993.276672, 0);
	        SetPlayerFacingAngle(playerid, 270);
	        SetPlayerInteriorEx(playerid, 17, INT_ALHAM);
	        PlayAudioStreamForPlayer(playerid, "https://dl.dropboxusercontent.com/s/mhlwhx33fgfv9kg/animals.mp3");
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1315.4854,-897.6839,39.5781)) // 24/7 VineWood
	    {
	        if(NPC_USED[NPCS[SHOP_VINE]]) return InfoMSG(playerid, 1500, "La ~b~tienda ~w~está cerrada temporalmente.");
	        if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "La ~b~tienda ~w~está cerrada.");
	        SetPlayerPos(playerid, 6.0969,-31.7571,1003.5494);
	        SetPlayerFacingAngle(playerid, 360);
	        SetPlayerInteriorEx(playerid, 10, INT_247VIN);
	        
	        new newweaponid = GetPlayerWeapon(playerid);
	        switch(newweaponid)
			{
			    case 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34:
			    {
			        if(P_No_Message_Atraco[playerid] == 0)
			        {
				 		SendPlayersMessage(10.0, playerid, 0xF000D8FF, "{CCCCCC}Vendedor dice: {FFFFFF}¡Por favor señor, guarde eso!", "{CCCCCC}Vendedor dice: {FFFFFF}¡Por favor señor, guarde eso!");
				 		InfoMSG(playerid, 1500, "Para empezar un atraco, dirígite al~n~~b~punto rojo señalado en el mapa.");
				 		MyTimers[playerid][13] = SetTimerEx("RobContinue", 10000, 0, "idi", playerid, 3, SHOP_VINE);
				 		SetPlayerCheckpoint(playerid, 2.412037, -28.959587, 1003.549438, 1.0);
				 		P_No_Message_Atraco[playerid] = 1;
				 		return 1;
					}
			    }
			}
			MyTimers[playerid][16] = SetTimerEx("opwc_timer", 1000, true, "i", playerid);
			return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1352.3815,-1759.2286,13.5078)) // 24/7 Ayuntamiento
	    {
	        if(NPC_USED[NPCS[SHOP_AYUNT]]) return InfoMSG(playerid, 1500, "La ~b~tienda ~w~está cerrada temporalmente.");
	        if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "La ~b~tienda ~w~está cerrada.");
	        SetPlayerPos(playerid, -27.2896,-31.7540,1003.5573);
	        SetPlayerFacingAngle(playerid, 0);
	        SetPlayerInteriorEx(playerid, 4, INT_247AYU);
	        
	        new newweaponid = GetPlayerWeapon(playerid);
	        switch(newweaponid)
			{
			    case 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34:
			    {
			        if(P_No_Message_Atraco[playerid] == 0)
			        {
				 		SendPlayersMessage(10.0, playerid, 0xF000D8FF, "{CCCCCC}Vendedor dice: {FFFFFF}¡Por favor señor, guarde eso!", "{CCCCCC}Vendedor dice: {FFFFFF}¡Por favor señor, guarde eso!");
				 		InfoMSG(playerid, 1500, "Para empezar un atraco, dirígite al~n~~b~punto rojo señalado en el mapa.");
				 		MyTimers[playerid][13] = SetTimerEx("RobContinue", 10000, 0, "idi", playerid, 3, SHOP_AYUNT);
				 		SetPlayerCheckpoint(playerid, -30.413436, -28.982168, 1003.557250, 1.0);
				 		P_No_Message_Atraco[playerid] = 1;
				 		return 1;
					}
			    }
			}
			MyTimers[playerid][16] = SetTimerEx("opwc_timer", 1000, true, "i", playerid);
			return 1;
	    }
        else if(IsPlayerInRangeOfPoint(playerid, 1.0, 2244.3567,-1665.5562,15.4766)) // Binco
	    {
	        if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "La ~b~tienda ~w~está cerrada.");
	        SetPlayerPos(playerid, 207.6649,-110.9614,1005.1328);
	        SetPlayerFacingAngle(playerid, 360);
	        SetPlayerInteriorEx(playerid, 15, INT_BINCO);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1456.4344,-1137.6427,23.9484)) // Zip
	    {
	        if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "La ~b~tienda ~w~está cerrada.");
	        SetPlayerPos(playerid, 161.2850,-97.0387,1001.8047);
	        SetPlayerFacingAngle(playerid, 0);
	        SetPlayerInteriorEx(playerid, 18, INT_ZIP);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 499.5753,-1360.6145,16.3664)) // ProLaps
	    {
	        if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "La ~b~tienda ~w~está cerrada.");
	        SetPlayerPos(playerid, 206.9300,-140.3754,1003.5078);
	        SetPlayerFacingAngle(playerid, 360);
	        SetPlayerInteriorEx(playerid, 3, INT_PROLAPS);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 2112.7739,-1211.6287,23.9631)) // Suburban
	    {
	        if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "La ~b~tienda ~w~está cerrada.");
	        SetPlayerPos(playerid, 203.7609,-50.6566,1001.8047);
	        SetPlayerFacingAngle(playerid, 360);
	        SetPlayerInteriorEx(playerid, 1, INT_SUBURBA);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 597.2778,-1249.4883,18.3021)) // Victim
	    {
	        if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "La ~b~tienda ~w~está cerrada.");
	        SetPlayerPos(playerid, 227.5633,-8.0725,1002.2109);
	        SetPlayerFacingAngle(playerid, 90);
	        SetPlayerInteriorEx(playerid, 5, INT_VICTIM);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 810.6630,-1616.1554,13.5469)) // Burger Shot
	    {
	        if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "La ~b~tienda ~w~está cerrada.");
	        SetPlayerPos(playerid, 362.8626,-75.1578,1001.5078);
	        SetPlayerFacingAngle(playerid, 300);
	        SetPlayerInteriorEx(playerid, 10, INT_BURGER);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 2105.4858,-1806.5336,13.5547)) // Pizzeria
	    {
	        if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "La ~b~tienda ~w~está cerrada.");
	        SetPlayerPos(playerid, 372.2221,-133.5210,1001.4922);
	        SetPlayerFacingAngle(playerid, 360);
	        SetPlayerInteriorEx(playerid, 5, INT_PIZZA);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 2070.6365,-1793.7847,13.5469)) // Peluqueria
	    {
	        if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "La ~b~tienda ~w~está cerrada.");
	        SetPlayerPos(playerid, 411.9010,-54.4360,1001.8984);
	        SetPlayerFacingAngle(playerid, 360);
	        SetPlayerInteriorEx(playerid, 12, INT_PELU);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 2068.5840,-1779.7758,13.5596)) // Tattoo studio
	    {
	        if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "La ~b~tienda ~w~está cerrada.");
	        SetPlayerPos(playerid, -204.4305,-9.0783,1002.2734);
	        SetPlayerFacingAngle(playerid, 360);
	        SetPlayerInteriorEx(playerid, 17, INT_TATTO);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 823.9835,-1588.2754,13.5545)) // Peluquería 2
	    {
	        if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "La ~b~tienda ~w~está cerrada.");
	        SetPlayerPos(playerid, 411.5989,-23.1412,1001.8047);
	        SetPlayerFacingAngle(playerid, 360);
	        SetPlayerInteriorEx(playerid, 2, INT_PELU2);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 928.7275,-1352.9547,13.3438)) // Clukin' bell
	    {
	        if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "La ~b~tienda ~w~está cerrada.");
	        SetPlayerPos(playerid, 364.9832,-11.8308,1001.8516);
	        SetPlayerFacingAngle(playerid, 0);
	        SetPlayerInteriorEx(playerid, 9, INT_BELL);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 2421.3159,-1219.6179,25.5382)) // Pig Pen (Prostíbulo)
	    {
	        SetPlayerPos(playerid, 1204.7631,-13.8169,1000.9219);
	        SetPlayerFacingAngle(playerid, 360);
	        SetPlayerInteriorEx(playerid, 2, INT_PIGPEN);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 2310.0977,-1643.5522,14.8270)) // Bar Groove
	    {
	        if(ServerTime > 22 || ServerTime < 8) return InfoMSG(playerid, 1500, "El ~b~bar ~w~está cerrado.");
	        SetPlayerPos(playerid, 501.9994,-67.7072,998.7578);
	        SetPlayerFacingAngle(playerid, 180);
	        SetPlayerInteriorEx(playerid, 11, INT_BARGR);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 2229.8601,-1721.4545,13.5633)) // Caton gym
	    {
	        if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "El ~b~gimnasio ~w~está cerrado.");
	        SetPlayerPos(playerid, 772.4008,-5.5150,1000.7287);
	        SetPlayerFacingAngle(playerid, 0);
	        SetPlayerInteriorEx(playerid, 5, INT_GYMLS);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1555.142822, -1675.475341, 16.195312)) //LSPD
	    {
	    	SetPlayerPosAndFreeze(playerid, 1557.468750, -1676.613159, 1990.540039, 0);
			SetPlayerFacingAngle(playerid, 260);
	        SetPlayerInteriorEx(playerid, 1, INT_LSPD);
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1481.037597, -1771.786376, 18.795755)) // Ayuntamiento
	    {
	        if(ServerTime > 20 || ServerTime < 8) return InfoMSG(playerid, 1500, "El ~b~ayuntamiento ~w~está cerrado.");
	        SetPlayerPos(playerid, 390.414337, 174.018325, 1008.382812);
	        SetPlayerFacingAngle(playerid, 90);
	        SetPlayerInteriorEx(playerid, 3, INT_AYUNT);
	        return 1;
	    }
	    // ----> Salidas
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 545.3146,-1318.3827,1996.5759)) // Grotti
	    {
            SetPlayerPos(playerid, 542.3840,-1293.5125,17.2422);
            SetPlayerFacingAngle(playerid, 350);
            SetPlayerInteriorEx(playerid, 0, INT_NONE);
            return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1464.995117, -1009.071533, 26.815937)) // Banco
	    {
	        SetPlayerPos(playerid, 1464.851318, -1010.793090, 26.843750);
	        SetPlayerFacingAngle(playerid, 180);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 646.0635,-1356.4440,4002.5896)) // CNN
	    {
	        SetPlayerPos(playerid, 648.8630,-1360.6012,13.5863);
	        SetPlayerFacingAngle(playerid, 70);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        return 1;
	    }
        else if(IsPlayerInRangeOfPoint(playerid, 1.0, 852.8785,-1372.0012,1993.0859)) // Vip place
	    {
	        SetPlayerPos(playerid, 1654.2700,-1654.8944,22.5156);
	        SetPlayerFacingAngle(playerid, 180);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        return 1;
	    }
        else if(IsPlayerInRangeOfPoint(playerid, 1.0, -25.7535, -187.7502, 1004.1781)) //24/7 Unity
	    {
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        SetPlayerFacingAngle(playerid, 90);
	        SetPlayerPos(playerid, 1833.149780, -1842.485717, 13.578125);

	        if(P_No_Message_Atraco[playerid] > 0)
	        {
	            KillTimer(MyTimers[playerid][13]);
		        DisablePlayerCheckpoint(playerid);
			    P_No_Message_Atraco[playerid] = -1;
			    return 1;
			}
			KillTimer(MyTimers[playerid][16]);
			return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 489.798309, -22.848724, 993.276672)) // Alhambra
	    {
	        SetPlayerPos(playerid, 1836.4471,-1682.3042,13.3476);
	        SetPlayerFacingAngle(playerid, 90);
	        StopAudioStreamForPlayer(playerid);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 6.0969,-31.7571,1003.5494)) // 24/7 VineWood
	    {
	        SetPlayerPos(playerid, 1315.4854,-897.6839,39.5781);
	        SetPlayerFacingAngle(playerid, 180);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        
	        if(P_No_Message_Atraco[playerid] > 0)
	        {
	            KillTimer(MyTimers[playerid][13]);
		        DisablePlayerCheckpoint(playerid);
			    P_No_Message_Atraco[playerid] = -1;
			    return 1;
			}
			KillTimer(MyTimers[playerid][16]);
			return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, -27.2896,-31.7540,1003.5573)) // 24/7 Ayuntamiento
	    {
	        SetPlayerPos(playerid, 1352.3815,-1759.2286,13.5078);
	        SetPlayerFacingAngle(playerid, 0);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        
	        if(P_No_Message_Atraco[playerid] > 0)
	        {
	            KillTimer(MyTimers[playerid][13]);
		        DisablePlayerCheckpoint(playerid);
			    P_No_Message_Atraco[playerid] = -1;
				return 1;
			}
			KillTimer(MyTimers[playerid][16]);
			return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 207.6649,-110.9614,1005.1328)) // Binco
	    {
	        SetPlayerPos(playerid, 2244.3567,-1665.5562,15.4766);
	        SetPlayerFacingAngle(playerid, 360);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 161.2850,-97.0387,1001.8047)) // Zip
	    {
	        SetPlayerPos(playerid, 1456.4344,-1137.6427,23.9484);
	        SetPlayerFacingAngle(playerid, 220);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 206.9300,-140.3754,1003.5078)) // ProLaps
	    {
	        SetPlayerPos(playerid, 499.5753,-1360.6145,16.3664);
	        SetPlayerFacingAngle(playerid, 360);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 203.7609,-50.6566,1001.8047)) // Suburban
	    {
	        SetPlayerPos(playerid, 2112.7739,-1211.6287,23.9631);
	        SetPlayerFacingAngle(playerid, 180);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 227.5633,-8.0725,1002.2109)) // Victim
	    {
	        SetPlayerPos(playerid, 597.2778,-1249.4883,18.3021);
	        SetPlayerFacingAngle(playerid, 30);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 362.8626,-75.1578,1001.5078)) // Burger Shot
	    {
	        SetPlayerPos(playerid, 810.6630,-1616.1554,13.5469);
	        SetPlayerFacingAngle(playerid, 270);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 372.2221,-133.5210,1001.4922)) // Pizzeria
	    {
	        SetPlayerPos(playerid, 2105.4858,-1806.5336,13.5547);
	        SetPlayerFacingAngle(playerid, 90);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 411.9010,-54.4360,1001.8984)) // Peluqueria
	    {
	        SetPlayerPos(playerid, 2070.6365,-1793.7847,13.5469);
	        SetPlayerFacingAngle(playerid, 260);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, -204.4305,-9.0783,1002.2734)) // Tattoo studio
	    {
	        SetPlayerPos(playerid, 2068.5840,-1779.7758,13.5596);
	        SetPlayerFacingAngle(playerid, 280);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 411.5989,-23.1412,1001.8047)) // Peluquería 2
	    {
	        SetPlayerPos(playerid, 823.9835,-1588.2754,13.5545);
	        SetPlayerFacingAngle(playerid, 140);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 364.9832,-11.8308,1001.8516)) // Clukin' bell
	    {
	        SetPlayerPos(playerid, 928.7275,-1352.9547,13.3438);
	        SetPlayerFacingAngle(playerid, 90);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1204.7631,-13.8169,1000.9219)) // Pig Pen (Prostíbulo)
	    {
	        SetPlayerPos(playerid, 2421.3159,-1219.6179,25.5382);
	        SetPlayerFacingAngle(playerid, 180);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 501.9994,-67.7072,998.7578)) // Bar Groove
	    {
	        SetPlayerPos(playerid, 2310.0977,-1643.5522,14.8270);
	        SetPlayerFacingAngle(playerid, 150);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 772.4008,-5.5150,1000.7287)) // Caton gym
	    {
	        SetPlayerPos(playerid, 2229.8601,-1721.4545,13.5633);
	        SetPlayerFacingAngle(playerid, 125);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        return 1;
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1471.842773, -1002.820617, 26.815937) || IsPlayerInRangeOfPoint(playerid, 1.0, 1463.410522, -1002.820617, 26.815937) || IsPlayerInRangeOfPoint(playerid, 1.0, 1457.344238, -1002.820617, 26.815937))
		{
		    if(PlayerInfo[playerid][BankA] == 0) ShowPlayerDialog(playerid, DIALOG_BANCO, DIALOG_STYLE_LIST, "Banco Los Santos", "{FFFFFF}Crear cuenta bancaria\n{CCCCCC}Retirar\n{CCCCCC}Depositar\n{CCCCCC}Transferir", "Continuar", "Cancelar");
		    else ShowPlayerDialog(playerid, DIALOG_BANCO, DIALOG_STYLE_LIST, "Banco Los Santos", "{FFFFFF}Retirar\n{FFFFFF}Depositar\n{FFFFFF}Transferir", "Continuar", "Cancelar");
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 1.0, 1557.468750, -1676.613159, 1990.540039)) //LSPD
	    {
	    	SetPlayerPos(playerid, 1555.142822, -1675.475341, 16.195312);
			SetPlayerFacingAngle(playerid, 90);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	    }
	    else if(IsPlayerInRangeOfPoint(playerid, 1.0, 390.414337, 174.018325, 1008.382812)) // Ayuntamiento
	    {
	        SetPlayerPos(playerid, 1481.037597, -1771.786376, 18.795755);
	        SetPlayerFacingAngle(playerid, 0);
	        SetPlayerInteriorEx(playerid, 0, INT_NONE);
	        return 1;
	    }
		for(new i = 0; i != sizeof(Cajeros); i++)
		{
		    if(IsPlayerInRangeOfPoint(playerid, 1.0, Cajeros[i][0], Cajeros[i][1], Cajeros[i][2]))
		    {
		        if(P_bank_state[playerid] > 0) return 1;
		        ChatLogDisabled[playerid] = true;
		    	loop(0, 11, l)
				{
					TextDrawShowForPlayer(playerid, Bank[l]);
					SendClientMessage(playerid, -1, " ");
				}
				P_bank_state[playerid] = 1;
				if(PlayerInfo[playerid][BankA] == 0) MyTimers[playerid][17] = SetTimerEx("BankContinue", 600, false, "id", playerid, 5);
				else MyTimers[playerid][17] = SetTimerEx("BankContinue", 500, false, "id", playerid, 0);
				return 1;
			}
		}
	}
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
	switch(dialogid)
    {
        case DIALOG_REGISTER:
        {
            if(response)
            {
                new Query[700], ip[16];
				GetPlayerIp(playerid, ip, sizeof(ip));
                if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, " ", "Dejaste el campo vacío, por favor\ningrese una contraseña", "Reintentar", "Salir");
				if(strlen(inputtext) <= 3 || strlen(inputtext) >= 16) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, " ", "Ha ocurrido un error:\n\n\tLa contraseña debe ser superior a 3 letras\n\te inferior a 16\n\nVuele a intentarlo", "Reintentar", "Salir");
				
				new str[24];
				format(Query, sizeof(Query), "INSERT INTO `USERS` ");
				strcat(Query, "(`NAME`,");
				strcat(Query, "`PASSWORD`,");
				strcat(Query, "`IP`,");
				strcat(Query, "`POSX`,");
				strcat(Query, "`POSY`,");
				strcat(Query, "`POSZ`,");
				strcat(Query, "`ANGLE`,");
				strcat(Query, "`INTERIORID`,");
				strcat(Query, "`BR`,");
				strcat(Query, "`EMAIL`,");
				strcat(Query, "`DINERO`,");
				strcat(Query, "`DINEROBANK`,");
				strcat(Query, "`SEXO`,");
				strcat(Query, "`EDAD`,");
				strcat(Query, "`SKIN`,");
				strcat(Query, "`VIDA`,");
				strcat(Query, "`CHALECO`,");
				strcat(Query, "`ADMLVL`,");
				strcat(Query, "`PHONENUMBER`,");
				strcat(Query, "`INTERIOR`,");
				strcat(Query, "`BANKA`,");
				strcat(Query, "`VBANK`,");
				strcat(Query, "`VGROTTI`,");
				strcat(Query, "`V247`,");
				strcat(Query, "`VROPA`,");
				strcat(Query, "`VFOOD`,");
				strcat(Query, "`DUDE`,");
				strcat(Query, "`WORK`,");
				strcat(Query, "`LVL`,");
				strcat(Query, "`VEH0`,");
				strcat(Query, "`VEH1`,");
				strcat(Query, "`VEH2`,");
				strcat(Query, "`VEH3`,");
				strcat(Query, "`VKEY0`,");
				strcat(Query, "`VKEY1`,");
				strcat(Query, "`VKEY2`,");
				strcat(Query, "`VKEY3`)");
                strcat(Query, "VALUES");
                format(str, 24, "('%s',", PlayerNameNormal(playerid));
                strcat(Query, str);
                format(str, 24, "'%s',", inputtext);
				strcat(Query, str);
				format(str, 24, "'%s',", ip);
                strcat(Query, str);
                strcat(Query, "'0.0',");
				strcat(Query, "'0.0',");
				strcat(Query, "'0.0',");
				strcat(Query, "'0.0',");
				strcat(Query, "'0',");
				strcat(Query, "'-1',");
				strcat(Query, "'0',");
				strcat(Query, "'0',");
				strcat(Query, "'0',");
				strcat(Query, "'0',");
				strcat(Query, "'21',");
				strcat(Query, "'60',");
				strcat(Query, "'100.0',");
				strcat(Query, "'0.0',");
				strcat(Query, "'0',");
				strcat(Query, "'0',");
				strcat(Query, "'0',");
				strcat(Query, "'0',");
				strcat(Query, "'0',");
				strcat(Query, "'0',");
				strcat(Query, "'0',");
				strcat(Query, "'0',");
				strcat(Query, "'0',");
				strcat(Query, "'0',");
				strcat(Query, "'0',");	
				strcat(Query, "'0',");
				strcat(Query, "'-1',");
				strcat(Query, "'-1',");
				strcat(Query, "'-1',");
				strcat(Query, "'-1',");
				strcat(Query, "'-1',");
				strcat(Query, "'-1',");
				strcat(Query, "'-1',");
				strcat(Query, "'-1')");
				db_query(Database, Query);
                foreach(new i : Player)
				{
					PlayerKnownPlayer[playerid][i] = false;
					PlayerKnownPlayer[i][playerid] = false;
				}
                PlayerKnownPlayer[playerid][playerid] = true;
                PlayerInfo[playerid][edad] = 21;
                PlayerInfo[playerid][skin] = RandomMen[random(sizeof(RandomMen))];
				ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, " ", ""VERDE"Por favor introduzca un EMAIL.\n{FFFFFF}ya que si usted olvida su contraseña, esta será\n{FFFFFF}la única forma de recuperarla\n\n\t{FF0000}¡Debe de ser verdadero!", "Continuar", "");
            }
            else Kick(playerid);
        }

        case DIALOG_LOGIN:
        {
            if(response)
            {
                new Query[600], DBResult:Result, ip[16];
				GetPlayerIp(playerid, ip, sizeof(ip));
				format(Query, sizeof(Query), "SELECT * FROM `USERS` WHERE `NAME` = '%s' AND `PASSWORD` = '%s'", PlayerNameNormal(playerid), inputtext);
				Result = db_query(Database, Query);
				if(db_num_rows(Result))
				{
				    loop(0, 4, l) TextDrawHideForPlayer(playerid, TD_ST[l]);
			        SetSpawnInfo(playerid, NO_TEAM, PlayerInfo[playerid][skin], 1172.856201, -1323.368774, 15.399730, 0, 0, 0, 0, 0, 0, 0);
					LoadUserData(playerid);
				}
				else { ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, " ", "Ha ocurrido un error\n\n\tLa contraseña es incorrecta", "Ingresar", "Salir"); }
				db_free_result(Result);
				return 1;
            }
            else Kick(playerid);
        }
        case DIALOG_EMAIL:
        {
            if(response)
            {
                if(strfind(inputtext, "@", true) != -1 && strfind(inputtext, ".", true) != -1)
				{
				    if(!EmailAvaliable(inputtext)) return ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, " ", "Este EMAIL ya está en uso\n\nPor favor inténtelo de nuevo con un correo alternativo\n\n\t¡Gracias!", "Continuar", "");
				    new str[128];
				    format(str, 128, "/eXtremeROL/emails/%s.ini", inputtext);
					new File:femail = fopen(str, io_write);
					new str2[64];
					format(str2, 64, "%s\r\n\r\nSistema de email de eXtremeROL", PlayerNameNormal(playerid));
					fwrite(femail, str2);
    				fclose(femail);
	                format(PlayerInfo[playerid][email], 64, "%s", inputtext);
	                new str3[64];
	                format(str3, 128, "{FFFFFF}¿Tu email es correcto?\n\n\t{00CCFF}%s", inputtext);
	                ShowPlayerDialog(playerid, DIALOG_EMAIL2, DIALOG_STYLE_MSGBOX, " ", str3, "Sí", "No");
				}
				else ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, " ", "{FFFFFF}El EMAIL introducido no es correcto\n\n{FF0000}Formato:\n\t{FFFFFF}ejemplo@ejemplo.com\n\n\n{FFFFFF}Vuelva a intentarlo", "Continuar", "");
			}
            else ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, " ", ""VERDE"Por favor introduzca un EMAIL.\n{FFFFFF}ya que si usted olvida su contraseña, esta será\n{FFFFFF}la única forma de recuperarla\n\n\t{FF0000}¡Debe de ser verdadero!", "Continuar", "");
        }
        case DIALOG_EMAIL2:
        {
            if(response)
            {
				SelectTextDraw(playerid, -1);
				loop(0, 10, l) TextDrawShowForPlayer(playerid, TD_ST[l]);
				PlayerTextDrawShow(playerid, PTD_ST[playerid][0]);
				PlayerTextDrawSetString(playerid, PTD_ST[playerid][1],  PlayerNameNormal(playerid));
				PlayerTextDrawShow(playerid, PTD_ST[playerid][1]);
				P_register_step[playerid] = 0;
				P_newuser[playerid] = 11;
			}
            else
            {
		        new str[128];
		  		format(str, 128, "/eXtremeROL/emails/%s.ini", PlayerInfo[playerid][email]);
				fremove(str);
			    ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, " ", ""VERDE"Por favor introduzca un EMAIL.\n{FFFFFF}ya que si usted olvida su contraseña, esta será\n{FFFFFF}la única forma de recuperarla\n\n\t{FF0000}¡Debe de ser verdadero!", "Continuar", "");
            }
        }
        case DIALOG_CONFIRME:
        {
            if(response)
            {
		        PlayerPlaySound(playerid,1135,0.0,0.0,0.0);
		        P_newuser[playerid] = 1;
		        P_register_step[playerid] = -1;
		        //StopAudioStreamForPlayer(playerid);
				//PlayAudioStreamForPlayer(playerid, "https://dl.dropboxusercontent.com/s/gqqhiahls4mgu9m/intro.mp3");//"https://dl.dropboxusercontent.com/s/bw2a4503jsa1orl/intro.mp3");
				loop(0, 10, l)
				{
					TextDrawHideForPlayer(playerid, TD_ST[l]);
					SendClientMessage(playerid, -1, " ");
				}
				PlayerTextDrawHide(playerid, PTD_ST[playerid][0]);
				PlayerTextDrawHide(playerid, PTD_ST[playerid][1]);
				PlayerTextDrawBoxColor(playerid, Background[playerid], 0x000000FF);
				PlayerTextDrawShow(playerid, Background[playerid]);
				MyTimers[playerid][0] = SetTimerEx("FadeIn", 1500, false, "id", playerid, 250);
				CancelSelectTextDraw(playerid);
				TogglePlayerSpectating(playerid, true);
				InterpolateCameraPos(playerid, CameraPositions[0][0], CameraPositions[0][1], CameraPositions[0][2], CameraPositions[0][3], CameraPositions[0][4], CameraPositions[0][5], 5000);
				InterpolateCameraLookAt(playerid, CameraPositions[0][6], CameraPositions[0][7], CameraPositions[0][8], CameraPositions[0][9], CameraPositions[0][10], CameraPositions[0][11], 5000);
		        SetPlayerVirtualWorld(playerid, playerid);
				MyTimers[playerid][1] = SetTimerEx("OnPlayerFinishInterpolateCamera", 5000-600, false, "id", playerid, 1);
            }
            else SelectTextDraw(playerid, -1);
        }
        case DIALOG_KNOW:
        {
            if(response)
            {
                new conocerid = P_conocerid[playerid];
			    SetPlayerToFacePlayer(conocerid, playerid);
                ApplyAnimation(playerid,"GANGS","hndshkaa",4.1,0,0,0,0,0);
				ApplyAnimation(playerid,"GANGS","hndshkaa",4.1,0,0,0,0,0);
				ApplyAnimation(conocerid,"GANGS","hndshkaa",4.1,0,0,0,0,0);
				ApplyAnimation(conocerid,"GANGS","hndshkaa",4.1,0,0,0,0,0);
				
				new str[128];
			    format(str, 128, "/eXtremeROL/conocidos/%s.ini", PlayerNameNormal(conocerid));
				new File:femail = fopen(str, io_append);
				new str2[64];
				format(str2, 64, "%s\r\n", PlayerNameNormal(playerid));
				fwrite(femail, str2);
				fclose(femail);
                
			    format(str, 128, "/eXtremeROL/conocidos/%s.ini", PlayerNameNormal(playerid));
				new File:femail2 = fopen(str, io_append);
				format(str2, 64, "%s\r\n", PlayerNameNormal(conocerid));
				fwrite(femail2, str2);
				fclose(femail2);
                
                PlayerKnownPlayer[playerid][conocerid] = true;
                PlayerKnownPlayer[conocerid][playerid] = true;
                
                P_conocerid[playerid] = -1;
                P_conocerid[conocerid] = -1;

            }
            else
            {
				new conocerid = P_conocerid[playerid];
				
				SendClientMessageEx(conocerid, -1, "{00CCFF}%s {FFFFFF}no quiere conocerte.", PlayerName(playerid));
            }
		}
        case DIALOG_RETIRAR:
        {
            if(response)
            {
				new money;
                if(sscanf(inputtext, "d", money)) return ShowPlayerDialog(playerid, DIALOG_RETIRAR, DIALOG_STYLE_INPUT, "BANCO LS - RETIRAR", "Cantidad incorrecta\n\t¿Cuánto quiere retirar?\n", "Retirar", "Cancelar");
				if(money > PlayerInfo[playerid][dinerobank] || money <= 0) return ShowPlayerDialog(playerid, DIALOG_RETIRAR, DIALOG_STYLE_INPUT, "BANCO LS - RETIRAR", "Cantidad incorrecta\n\t¿Cuánto quiere retirar?\n", "Retirar", "Cancelar");
				PlayerInfo[playerid][dinerobank] -= money;
				PlayerInfo[playerid][dinero] += money;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid, PlayerInfo[playerid][dinero]);
				
				new str[128];
			    format(str, 128, "Balance actual: $%d", PlayerInfo[playerid][dinerobank]);
			    PlayerTextDrawSetString(playerid, PlayerBank[playerid][0], str);
			    
			    TextDrawShowForPlayer(playerid, Bank[15]);
			    TextDrawShowForPlayer(playerid, Bank[16]);
			    TextDrawShowForPlayer(playerid, Bank[17]);
			    TextDrawShowForPlayer(playerid, Bank[18]);
			    TextDrawShowForPlayer(playerid, Bank[19]);
			    PlayerPlaySound(playerid, 45400, 0.0, 0.0, 0.0);
            }
            else
            {
                TextDrawShowForPlayer(playerid, Bank[15]);
			    TextDrawShowForPlayer(playerid, Bank[16]);
			    TextDrawShowForPlayer(playerid, Bank[17]);
			    TextDrawShowForPlayer(playerid, Bank[18]);
			    TextDrawShowForPlayer(playerid, Bank[19]);
            }
        }
        case DIALOG_DEPOSIT:
        {
            if(response)
            {
				new money;
                if(sscanf(inputtext, "d", money)) return ShowPlayerDialog(playerid, DIALOG_DEPOSIT, DIALOG_STYLE_INPUT, "BANCO LS - DEPOSITAR", "Cantidad incorrecta\n\t¿Cuánto quiere depositar?\n", "Depositar", "Cancelar");
				if(money > PlayerInfo[playerid][dinero] || money <= 0) return ShowPlayerDialog(playerid, DIALOG_DEPOSIT, DIALOG_STYLE_INPUT, "BANCO LS - DEPOSITAR", "Cantidad incorrecta\n\t¿Cuánto quiere depositar?\n", "Depositar", "Cancelar");
				PlayerInfo[playerid][dinerobank] += money;
				PlayerInfo[playerid][dinero] -= money;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid, PlayerInfo[playerid][dinero]);
				
				new str[128];
			    format(str, 128, "Balance actual: $%d", PlayerInfo[playerid][dinerobank]);
			    PlayerTextDrawSetString(playerid, PlayerBank[playerid][0], str);
			    
			    TextDrawShowForPlayer(playerid, Bank[15]);
			    TextDrawShowForPlayer(playerid, Bank[16]);
			    TextDrawShowForPlayer(playerid, Bank[17]);
			    TextDrawShowForPlayer(playerid, Bank[18]);
			    TextDrawShowForPlayer(playerid, Bank[19]);
			    PlayerPlaySound(playerid, 45400, 0.0, 0.0, 0.0);
            }
            else
            {
                TextDrawShowForPlayer(playerid, Bank[15]);
			    TextDrawShowForPlayer(playerid, Bank[16]);
			    TextDrawShowForPlayer(playerid, Bank[17]);
			    TextDrawShowForPlayer(playerid, Bank[18]);
			    TextDrawShowForPlayer(playerid, Bank[19]);
            }
        }
        case DIALOG_BANCO:
        {
            if(response)
            {
                if(PlayerInfo[playerid][BankA] == 0)
                {
                    switch(listitem)
                    {
						case 0:
						{
						    if(50 > PlayerInfo[playerid][dinero]) return SendClientMessage(playerid, -1, "Necesitas un depósito mínimo de {00CCFF}$50 {FFFFFF}para crearte una cuenta bancaria.");
						    SendClientMessage(playerid, -1, "Acabas de crearte una cuenta bancaria, ya puedes beneficiarte de sus privilegios. {00CCFF}Se han necesitado $50 para un depósito mínimo.");
						    PlayerInfo[playerid][dinero] -= 50;
						    PlayerInfo[playerid][dinerobank] += 50;
						    PlayerInfo[playerid][BankA] = 1;
						    ResetPlayerMoney(playerid);
							GivePlayerMoney(playerid, PlayerInfo[playerid][dinero]);
						}
						default: ShowPlayerDialog(playerid, DIALOG_BANCO, DIALOG_STYLE_LIST, "Banco Los Santos", "{FFFFFF}Crear cuenta bancaria\n{CCCCCC}Retirar\n{CCCCCC}Depositar\n{CCCCCC}Transferir", "Continuar", "Cancelar");
                    }
                }
                else
                {
                    switch(listitem)
                    {
                        case 0:
						{
						    new str[128];
							format(str, 128, "Balance actual: $%d\n\t¿Cuánto quiere retirar?\n", PlayerInfo[playerid][dinerobank]);
							ShowPlayerDialog(playerid, DIALOG_RETIRAR2, DIALOG_STYLE_INPUT, "BANCO LS - RETIRAR", str, "Retirar", "Cancelar");
						}
						case 1:
						{
						    new str[128];
							format(str, 128, "Balance actual: $%d\n\t¿Cuánto quiere depositar?\n", PlayerInfo[playerid][dinerobank]);
							ShowPlayerDialog(playerid, DIALOG_DEPOSIT2, DIALOG_STYLE_INPUT, "BANCO LS - DEPOSITAR", str, "Depositar", "Cancelar");
						}
						case 2: SendClientMessage(playerid, -1, "asd");
                    }
                }
            }
        }
        case DIALOG_RETIRAR2:
        {
            if(response)
            {
				new money;
                if(sscanf(inputtext, "d", money)) return ShowPlayerDialog(playerid, DIALOG_RETIRAR2, DIALOG_STYLE_INPUT, "BANCO LS - RETIRAR", "Cantidad incorrecta\n\t¿Cuánto quiere retirar?\n", "Retirar", "Cancelar");
				if(money > PlayerInfo[playerid][dinerobank] || money <= 0) return ShowPlayerDialog(playerid, DIALOG_RETIRAR2, DIALOG_STYLE_INPUT, "BANCO LS - RETIRAR", "Cantidad incorrecta\n\t¿Cuánto quiere retirar?\n", "Retirar", "Cancelar");
				PlayerInfo[playerid][dinerobank] -= money;
				PlayerInfo[playerid][dinero] += money;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid, PlayerInfo[playerid][dinero]);
				ShowBankCash(playerid, 2000);
			}
        }
        case DIALOG_DEPOSIT2:
        {
            if(response)
            {
				new money;
                if(sscanf(inputtext, "d", money)) return ShowPlayerDialog(playerid, DIALOG_DEPOSIT2, DIALOG_STYLE_INPUT, "BANCO LS - DEPOSITAR", "Cantidad incorrecta\n\t¿Cuánto quiere depositar?\n", "Depositar", "Cancelar");
				if(money > PlayerInfo[playerid][dinero] || money <= 0) return ShowPlayerDialog(playerid, DIALOG_DEPOSIT2, DIALOG_STYLE_INPUT, "BANCO LS - DEPOSITAR", "Cantidad incorrecta\n\t¿Cuánto quiere depositar?\n", "Depositar", "Cancelar");
				PlayerInfo[playerid][dinerobank] += money;
				PlayerInfo[playerid][dinero] -= money;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid, PlayerInfo[playerid][dinero]);
				ShowBankCash(playerid, 2000);
            }
        }
        case DIALOG_AYUNTA:
        {
            if(response)
            {
                switch(listitem)
                {
                    case 0:
                    {
                        if(PlayerInfo[playerid][bikerent] == 0) ShowPlayerDialog(playerid, DIALOG_BIKE, DIALOG_STYLE_MSGBOX, " ", "Carnet de préstamo de bicicletas de Los Santos\n\n\tHaciendo este carnet te comprometes con:\n\n\t\t{00CCFF}* En caso de que la bicicleta quede dañada, pagar la reparación.\n\t\t{00CCFF}* Devolver la bicicleta en un plazo de 48hrs.\n\t\t{00CCFF}* Ser cuidadoso con ella\n\n\n{FFFFFF}El costo de este carnet es de {00CCFF}$50.", "Continuar", "Cancelar");
                        else SendClientMessage(playerid, -1, "Ya tienes este carnet.");
                    }
                }
            }
        }
        case DIALOG_BIKE:
        {
            if(response)
            {
                if(50 > PlayerInfo[playerid][dinero]) return SendClientMessage(playerid, -1, "Necesitas {00CCFF}$50 {FFFFFF}para crear este carnet.");
                PlayerInfo[playerid][bikerent] = 1;
                PlayerInfo[playerid][dinero] -= 50;
                ResetPlayerMoney(playerid);
                GivePlayerMoney(playerid, PlayerInfo[playerid][dinero]);
                SendClientMessage(playerid, -1, "Felicidades, tu carnet ha sido creado, {00CCFF}¡ya puedes disfrutar de sus beneficios!.");
            }
		}
		case DIALOG_DUDAS:
        {
            if(response)
            {
                new str[128];
                format(str, 128, "%s", DudeMsg[playerid]);
          		new tiempo_ms = 1 * 60000;
				DudeTime[playerid] = GetTickCount() + tiempo_ms;
				EnviarDuda(playerid, str);
            }
        }
        case DIALOG_GROTTI:
        {
            if(response)
            {
				if(PlayerInfo[playerid][PlayerVehicleKey][0] == -1)
				{
				    new r = random(sizeof(VehicleGrottiSpawns));
					new modelid = GetVehicleModelGrotti(P_catalogogrotti[playerid]);
					new money = GetVehiclePriceGrotti(P_catalogogrotti[playerid]);
				    CreatePersonalCar(playerid, modelid, VehicleGrottiSpawns[r][0], VehicleGrottiSpawns[r][1], VehicleGrottiSpawns[r][2], VehicleGrottiSpawns[r][3], 1, 1, 0);

					SetCameraBehindPlayer(playerid);
					SetPlayerPos(playerid, 546.407897, -1309.471191, 1996.575927);
				    TogglePlayerControllable(playerid, true);
					P_catalogogrotti[playerid] = -1;
					ChatLogDisabled[playerid] = false;
					loop(0, 9, i) TextDrawHideForPlayer(playerid, TD_GrottiCatalogo[i]);
					PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][0]);
					PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][1]);
					PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][2]);
					PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][3]);
					InfoMSG(playerid, 10000, "Vehículo comprado, puedes ir al punto ~r~rojo ~w~a recojerlo.");
					PlayerPlaySound(playerid,1058,0.0,0.0,0.0);
					PlayerInfo[playerid][dinerobank] -= money;
					ShowBankCash(playerid, 2000);
					SetPlayerCheckpoint(playerid, VehicleGrottiSpawns[r][0], VehicleGrottiSpawns[r][1], VehicleGrottiSpawns[r][2], 1.0);
					CancelSelectTextDraw(playerid);
					return 1;
				}
				if(PlayerInfo[playerid][PlayerVehicleKey][1] == -1)
				{
				    new r = random(sizeof(VehicleGrottiSpawns));
					new modelid = GetVehicleModelGrotti(P_catalogogrotti[playerid]);
					new money = GetVehiclePriceGrotti(P_catalogogrotti[playerid]);
				    CreatePersonalCar(playerid, modelid, VehicleGrottiSpawns[r][0], VehicleGrottiSpawns[r][1], VehicleGrottiSpawns[r][2], VehicleGrottiSpawns[r][3], 1, 1, 1);

					SetCameraBehindPlayer(playerid);
					SetPlayerPos(playerid, 546.407897, -1309.471191, 1996.575927);
				    TogglePlayerControllable(playerid, true);
					P_catalogogrotti[playerid] = -1;
					ChatLogDisabled[playerid] = false;
					loop(0, 9, i) TextDrawHideForPlayer(playerid, TD_GrottiCatalogo[i]);
					PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][0]);
					PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][1]);
					PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][2]);
					PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][3]);
					InfoMSG(playerid, 10000, "Vehículo comprado, puedes ir al ~r~rojo ~w~a recojerlo.");
					PlayerPlaySound(playerid,1058,0.0,0.0,0.0);
					PlayerInfo[playerid][dinerobank] -= money;
					ShowBankCash(playerid, 2000);
					SetPlayerCheckpoint(playerid, VehicleGrottiSpawns[r][0], VehicleGrottiSpawns[r][1], VehicleGrottiSpawns[r][2], 1.0);
					CancelSelectTextDraw(playerid);
				    return 1;
				}
				if(PlayerInfo[playerid][PlayerVehicleKey][2] == -1)
				{
				    new r = random(sizeof(VehicleGrottiSpawns));
					new modelid = GetVehicleModelGrotti(P_catalogogrotti[playerid]);
					new money = GetVehiclePriceGrotti(P_catalogogrotti[playerid]);
				    CreatePersonalCar(playerid, modelid, VehicleGrottiSpawns[r][0], VehicleGrottiSpawns[r][1], VehicleGrottiSpawns[r][2], VehicleGrottiSpawns[r][3], 1, 1, 2);

					SetCameraBehindPlayer(playerid);
					SetPlayerPos(playerid, 546.407897, -1309.471191, 1996.575927);
				    TogglePlayerControllable(playerid, true);
					P_catalogogrotti[playerid] = -1;
					ChatLogDisabled[playerid] = false;
					loop(0, 9, i) TextDrawHideForPlayer(playerid, TD_GrottiCatalogo[i]);
					PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][0]);
					PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][1]);
					PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][2]);
					PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][3]);
					InfoMSG(playerid, 10000, "Vehículo comprado, puedes ir al punto ~r~rojo ~w~a recojerlo.");
					PlayerPlaySound(playerid,1058,0.0,0.0,0.0);
					PlayerInfo[playerid][dinerobank] -= money;
					ShowBankCash(playerid, 2000);
					SetPlayerCheckpoint(playerid, VehicleGrottiSpawns[r][0], VehicleGrottiSpawns[r][1], VehicleGrottiSpawns[r][2], 1.0);
					CancelSelectTextDraw(playerid);
				    return 1;
				}
				if(PlayerInfo[playerid][PlayerVehicleKey][3] == -1)
				{
				    new r = random(sizeof(VehicleGrottiSpawns));
					new modelid = GetVehicleModelGrotti(P_catalogogrotti[playerid]);
					new money = GetVehiclePriceGrotti(P_catalogogrotti[playerid]);
				    CreatePersonalCar(playerid, modelid, VehicleGrottiSpawns[r][0], VehicleGrottiSpawns[r][1], VehicleGrottiSpawns[r][2], VehicleGrottiSpawns[r][3], 1, 1, 3);

					SetCameraBehindPlayer(playerid);
					SetPlayerPos(playerid, 546.407897, -1309.471191, 1996.575927);
				    TogglePlayerControllable(playerid, true);
					P_catalogogrotti[playerid] = -1;
					ChatLogDisabled[playerid] = false;
					loop(0, 9, i) TextDrawHideForPlayer(playerid, TD_GrottiCatalogo[i]);
					PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][0]);
					PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][1]);
					PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][2]);
					PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][3]);
					InfoMSG(playerid, 10000, "Vehículo comprado, puedes ir al punto ~r~rojo ~w~ recojerlo.");
					PlayerPlaySound(playerid,1058,0.0,0.0,0.0);
					PlayerInfo[playerid][dinerobank] -= money;
					ShowBankCash(playerid, 2000);
					SetPlayerCheckpoint(playerid, VehicleGrottiSpawns[r][0], VehicleGrottiSpawns[r][1], VehicleGrottiSpawns[r][2], 1.0);
					CancelSelectTextDraw(playerid);
				    return 1;
				}
				InfoMSG(playerid, 3000, "No puedes tener más de 4 vehículos.");
				SelectTextDraw(playerid, -1);
            }
            else SelectTextDraw(playerid, -1);
        }
	}
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart)
{
	if(PoliciaAvisada[playerid] == 1) return 1;
	new Float:p[3];
	new Float:fDistance;
	GetPlayerPos(NPCS[25], p[0], p[1], p[2]);
	fDistance = GetPlayerDistanceFromPoint(playerid, p[0], p[1], p[2]);
	if(fDistance <= 15)
	{
	    SendClientMessage(playerid, -1, "Un guarda de la zona te vió, {00CCFF}¡la policia fue avisada!");
	    PoliciaAvisada[playerid] = 1;
	    MyTimers[playerid][22] = SetTimerEx("Wanted", 300000, 0, "i", playerid);
	    return 1;
	}
	GetPlayerPos(NPCS[26], p[0], p[1], p[2]);
	fDistance = GetPlayerDistanceFromPoint(playerid, p[0], p[1], p[2]);
	if(fDistance <= 15)
	{
	    SendClientMessage(playerid, -1, "Un guarda de la zona te vió, {00CCFF}¡la policia fue avisada!");
	    PoliciaAvisada[playerid] = 1;
	    MyTimers[playerid][22] = SetTimerEx("Wanted", 300000, 0, "i", playerid);
	    return 1;
	}
	GetPlayerPos(NPCS[27], p[0], p[1], p[2]);
	fDistance = GetPlayerDistanceFromPoint(playerid, p[0], p[1], p[2]);
	if(fDistance <= 15)
	{
	    SendClientMessage(playerid, -1, "Un guarda de la zona te vió, {00CCFF}¡la policia fue avisada!");
	    PoliciaAvisada[playerid] = 1;
	    MyTimers[playerid][22] = SetTimerEx("Wanted", 300000, 0, "i", playerid);
	    return 1;
	}
    return 1;
}

funcion:Wanted(playerid)
{
    SendClientMessage(playerid, -1, "La policía {00CCFF}perdió tu rastro.");
    PoliciaAvisada[playerid] = 0;
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerWeaponChange(playerid, newweaponid, oldweaponid)
{
	if(GetPlayerInteriorEx(playerid) == INT_247U)
	{
	    if(NPC_USED[NPCS[SHOP_UNITY]]) return 1;
		switch(newweaponid)
		{
		    case 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34:
		    {
		        if(P_No_Message_Atraco[playerid] == 0)
		        {
			 		SendPlayersMessage(10.0, playerid, 0xF000D8FF, "{CCCCCC}Vendedor dice: {FFFFFF}¡Por favor señor, guarde eso!", "{CCCCCC}Vendedor dice: {FFFFFF}¡Por favor señor, guarde eso!");
			 		InfoMSG(playerid, 1500, "Para empezar un atraco, dirígite al~n~~b~punto rojo señalado en el mapa.");
			 		MyTimers[playerid][13] = SetTimerEx("RobContinue", 10000, 0, "idi", playerid, 3, SHOP_UNITY);
			 		SetPlayerCheckpoint(playerid, -28.501539, -185.122360, 1003.546875, 1.0);
			 		P_No_Message_Atraco[playerid] = 1;
				}
		    }
		    case 0..15, 35..46:
		    {
		        KillTimer(MyTimers[playerid][13]);
		        DisablePlayerCheckpoint(playerid);
		    	P_No_Message_Atraco[playerid] = 0;
		    }
		}
	}
	else if(GetPlayerInteriorEx(playerid) == INT_247VIN)
	{
	    if(NPC_USED[NPCS[SHOP_VINE]]) return 1;
		switch(newweaponid)
		{
		    case 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34:
		    {
		        if(P_No_Message_Atraco[playerid] == 0)
		        {
			 		SendPlayersMessage(10.0, playerid, 0xF000D8FF, "{CCCCCC}Vendedor dice: {FFFFFF}¡Por favor señor, guarde eso!", "{CCCCCC}Vendedor dice: {FFFFFF}¡Por favor señor, guarde eso!");
			 		InfoMSG(playerid, 1500, "Para empezar un atraco, dirígite al~n~~b~punto rojo señalado en el mapa.");
			 		MyTimers[playerid][13] = SetTimerEx("RobContinue", 10000, 0, "idi", playerid, 3, SHOP_VINE);
			 		SetPlayerCheckpoint(playerid, 2.412037, -28.959587, 1003.549438, 1.0);
			 		P_No_Message_Atraco[playerid] = 1;
				}
		    }
		    case 0..15, 35..46:
		    {
		        DisablePlayerCheckpoint(playerid);
		    	P_No_Message_Atraco[playerid] = 0;
		    }
		}
	}
	else if(GetPlayerInteriorEx(playerid) == INT_247AYU)
	{
	    if(NPC_USED[NPCS[SHOP_AYUNT]]) return 1;
		switch(newweaponid)
		{
		    case 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34:
		    {
		        if(P_No_Message_Atraco[playerid] == 0)
		        {
			 		SendPlayersMessage(10.0, playerid, 0xF000D8FF, "{CCCCCC}Vendedor dice: {FFFFFF}¡Por favor señor, guarde eso!", "{CCCCCC}Vendedor dice: {FFFFFF}¡Por favor señor, guarde eso!");
			 		InfoMSG(playerid, 1500, "Para empezar un atraco, dirígite al~n~~b~punto rojo señalado en el mapa.");
			 		MyTimers[playerid][13] = SetTimerEx("RobContinue", 10000, 0, "idi", playerid, 3, SHOP_AYUNT);
			 		SetPlayerCheckpoint(playerid, -30.413436, -28.982168, 1003.557250, 1.0);
			 		P_No_Message_Atraco[playerid] = 1;
				}
		    }
		    case 0..15, 35..46:
		    {
		        DisablePlayerCheckpoint(playerid);
		    	P_No_Message_Atraco[playerid] = 0;
		    }
		}
	}
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(clickedid == Text:INVALID_TEXT_DRAW)
    {
		if(P_newuser[playerid] == 11 || P_newuser[playerid] == 12) return SelectTextDraw(playerid, -1); //ESC
		if(P_player_tutorial[playerid] > 0) return SelectTextDraw(playerid, 0x33AA33AA);
	    if(P_catalogogrotti[playerid] >= 0)
	    {
	        KillTimer(MyTimers[playerid][16]);
	        SetCameraBehindPlayer(playerid);
	        TogglePlayerControllable(playerid, true);
			P_catalogogrotti[playerid] = -1;
			ChatLogDisabled[playerid] = false;
			loop(0, 9, i) TextDrawHideForPlayer(playerid, TD_GrottiCatalogo[i]);
			PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][0]);
			PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][1]);
			PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][2]);
			PlayerTextDrawHide(playerid, PTD_GrottiCatalogo[playerid][3]);
			CancelSelectTextDraw(playerid);
	    }
		if(P_circularmenu_active[playerid] == 1)
		{
		    loop(0, 12, a) TextDrawHideForPlayer(playerid, CircularMenu[a]);
		    CancelSelectTextDraw(playerid);
		   	P_circularmenu_active[playerid] = -1;
		   	ShowBankCash(playerid, -1);
		}
		else if(P_circularmenu_active[playerid] == 2)
		{
	        TextDrawHideForPlayer(playerid, UserBox[0]);
	        TextDrawHideForPlayer(playerid, UserBox[1]);
	        TextDrawHideForPlayer(playerid, UserBox[2]);
	        TextDrawHideForPlayer(playerid, UserBox[3]);

	        PlayerTextDrawHide(playerid, PlayerUserBox[playerid][0]);
	        PlayerTextDrawHide(playerid, PlayerUserBox[playerid][1]);
		    CancelSelectTextDraw(playerid);
		   	P_circularmenu_active[playerid] = -1;
		   	ShowBankCash(playerid, -1);
		}
		else if(P_circularmenu_active[playerid] == 3)
		{
	        TextDrawHideForPlayer(playerid, UserBox[0]);
	        TextDrawHideForPlayer(playerid, UserBox[1]);
	        TextDrawHideForPlayer(playerid, UserBox[2]);
	        TextDrawHideForPlayer(playerid, UserBox[3]);

	        PlayerTextDrawHide(playerid, PlayerUserBox[playerid][0]);
	        PlayerTextDrawHide(playerid, PlayerUserBox[playerid][1]);
		    CancelSelectTextDraw(playerid);
		   	P_circularmenu_active[playerid] = -1;
		   	loop(0, 4, l) PlayerTextDrawHide(playerid, CosasPorHacer[playerid][l]);
		}
		if(P_bank_state[playerid] == 1)
		{
		    loop(0, 20, l) TextDrawHideForPlayer(playerid, Bank[l]);
      		PlayerTextDrawHide(playerid, PlayerBank[playerid][0]);
        	PlayerTextDrawHide(playerid, PlayerBank[playerid][1]);
		    P_bank_state[playerid] = -1;
			KillTimer(MyTimers[playerid][17]);
			ChatLogDisabled[playerid] = false;
			ShowBankCash(playerid, 2000);
		}
		return 1;
	}
	/*
	if(clickedid == TD_RO[9])
	{
	    if(P_newuser[playerid] == 12)
	    {
	        new str[128];
	  		format(str, 128, "/eXtremeROL/emails/%s.ini", PlayerInfo[playerid][email]);
			fremove(str);
	    }
	    CancelSelectTextDraw(playerid);
	    ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, " ", ""VERDE"Por favor introduzca un EMAIL.\n{FFFFFF}ya que si usted olvida su contraseña, esta será\n{FFFFFF}la única forma de recuperarla\n\n\t{FF0000}¡Debe de ser verdadero!", "Continuar", "");
		return 1;
	}
	if(clickedid == TD_RO[10])
	{
		if(PlayerInfo[playerid][sexo] == 1)
		{
		    PlayerInfo[playerid][skin] = RandomMen[random(sizeof(RandomMen))];
		    PlayerInfo[playerid][sexo] = 0;
		    PlayerTextDrawSetString(playerid, PTD_RO[playerid][2], "Masculino");
		    PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
		}
		else
		{
		    PlayerInfo[playerid][skin] = RandomWoman[random(sizeof(RandomWoman))];
		    PlayerInfo[playerid][sexo] = 1;
		    PlayerTextDrawSetString(playerid, PTD_RO[playerid][2], "Femenino");
		    PlayerPlaySound(playerid,1053,0.0,0.0,0.0);
		}
		return 1;
	}
	
	if(clickedid == TD_RO[8]) //+
	{
	    if(PlayerInfo[playerid][edad] == 40) return PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
		PlayerInfo[playerid][edad]++;
		new str[5];
		format(str, 5, "%d", PlayerInfo[playerid][edad]);
		PlayerTextDrawSetString(playerid, PTD_RO[playerid][3], str);
		PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
		return 1;
	}
	
	if(clickedid == TD_RO[12]) //-
	{
	    if(PlayerInfo[playerid][edad] == 21) return PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
		PlayerInfo[playerid][edad]--;
		new str[5];
		format(str, 5, "%d", PlayerInfo[playerid][edad]);
		PlayerTextDrawSetString(playerid, PTD_RO[playerid][3], str);
		PlayerPlaySound(playerid,1053,0.0,0.0,0.0);
		return 1;
	}
	
    if(clickedid == TD_RO[7])
    {
        if(P_newuser[playerid] != 12) return PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
        PlayerPlaySound(playerid,1135,0.0,0.0,0.0);
        P_newuser[playerid] = 1;
        StopAudioStreamForPlayer(playerid);
		PlayAudioStreamForPlayer(playerid, "https://dl.dropboxusercontent.com/s/bw2a4503jsa1orl/intro.mp3");//https://dl.dropboxusercontent.com/s/gqqhiahls4mgu9m/intro.mp3");
	    loop(0, 13, td_ro)
		{
		    SendClientMessage(playerid, -1, " ");
		    TextDrawHideForPlayer(playerid, TD_RO[td_ro]);
		    if(td_ro < 4) PlayerTextDrawHide(playerid, PTD_RO[playerid][td_ro]);
		}
		PlayerTextDrawHide(playerid, TD_IO[playerid]);
		PlayerTextDrawBoxColor(playerid, Background[playerid], 0x000000FF);
		PlayerTextDrawShow(playerid, Background[playerid]);
		MyTimers[playerid][0] = SetTimerEx("FadeIn", 1500, false, "id", playerid, 250);
		CancelSelectTextDraw(playerid);
		TogglePlayerSpectating(playerid, true);
		InterpolateCameraPos(playerid, CameraPositions[0][0], CameraPositions[0][1], CameraPositions[0][2], CameraPositions[0][3], CameraPositions[0][4], CameraPositions[0][5], 10000);
		InterpolateCameraLookAt(playerid, CameraPositions[0][6], CameraPositions[0][7], CameraPositions[0][8], CameraPositions[0][9], CameraPositions[0][10], CameraPositions[0][11], 10000);
        SetPlayerVirtualWorld(playerid, random(100));
	
		MyTimers[playerid][1] = SetTimerEx("OnPlayerFinishInterpolateCamera", 7000-600, false, "id", playerid, 1);
		return 1;
    }*/
    if(clickedid == TD_GrottiCatalogo[7]) // >>>
    {
        ShowPlayerDialog( playerid, -1, DIALOG_STYLE_MSGBOX, "_", "_", "_", "");
        switch(P_catalogogrotti[playerid])
        {
            case 0:
            {
                InterpolateCameraPos(playerid, 521.6366, -1307.1511, 1999.2629, 529.1366, -1307.1511, 1999.2629, 1000);
				InterpolateCameraLookAt(playerid, 521.6366, -1296.1511, 1996.7765, 529.1366, -1296.6511, 1996.7765, 1000);
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][0], "Turismo");
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][1], "$350.000");
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][2], 576.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][2]);
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][3], 562.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][3]);
                P_catalogogrotti[playerid] = 1;
            }
            case 1:
            {
                InterpolateCameraPos(playerid, 529.1366, -1307.1511, 1999.2629, 536.6366, -1307.1511, 1999.2629, 1000);
				InterpolateCameraLookAt(playerid, 529.1366, -1296.6511, 1996.7765, 536.6366, -1297.1511, 1996.7765, 1000);
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][0], "Banshee");
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][1], "$190.000");
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][2], 555.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][2]);
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][3], 565.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][3]);
                P_catalogogrotti[playerid] = 2;
            }
            case 2:
            {
                InterpolateCameraPos(playerid, 536.6366, -1307.1511, 1999.2629, 544.1366, -1307.1511, 1999.2629, 1000);
				InterpolateCameraLookAt(playerid, 536.6366, -1297.1511, 1996.7765, 544.1366, -1298.1511, 1997.2629, 1000);
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][0], "Infernus");
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][1], "$450.000");
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][2], 580.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][2]);
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][3], 575.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][3]);
                P_catalogogrotti[playerid] = 3;
            }
            case 3:
            {
                InterpolateCameraPos(playerid, 544.1366, -1307.1511, 1999.2629, 551.6366, -1307.1511, 1999.2629, 1000);
				InterpolateCameraLookAt(playerid, 544.1366, -1298.1511, 1997.2629, 551.6366, -1297.1511, 1996.7765, 1000);
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][0], "Bullet");
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][1], "$260.000");
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][2], 570.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][2]);
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][3], 565.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][3]);
                P_catalogogrotti[playerid] = 4;
            }
            case 4:
            {
                InterpolateCameraPos(playerid, 551.6366, -1307.1511, 1999.2629, 559.1479, -1307.1511, 1999.2629, 1000);
				InterpolateCameraLookAt(playerid, 551.6366, -1297.1511, 1996.7765, 559.1479, -1296.5100, 1996.7765, 1000);
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][0], "Cheetah");
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][1], "$420.000");
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][2], 575.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][2]);
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][3], 570.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][3]);
                P_catalogogrotti[playerid] = 5;
            }
            case 5:
            {
                InterpolateCameraPos(playerid, 559.1479, -1307.1511, 1999.2629, 566.6479, -1307.1511, 1999.2629, 1000);
				InterpolateCameraLookAt(playerid, 559.1479, -1296.5100, 1996.7765, 566.6479, -1296.0100, 1996.7765, 1000);
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][0], "Phoenix");
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][1], "$80.000");
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][2], 540.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][2]);
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][3], 535.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][3]);
                P_catalogogrotti[playerid] = 6;
            }
        }
        return 1;
    }
	if(clickedid == TD_GrottiCatalogo[8]) // <<<
	{
	    ShowPlayerDialog( playerid, -1, DIALOG_STYLE_MSGBOX, "_", "_", "_", "");
 		switch(P_catalogogrotti[playerid])
        {
            case 1:
            {
                InterpolateCameraPos(playerid, 529.1366, -1307.1511, 1999.2629, 521.6366, -1307.1511, 1999.2629, 1000);
				InterpolateCameraLookAt(playerid, 529.1366, -1296.6511, 1996.7765, 521.6366, -1296.1511, 1996.7765, 1000);
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][0], "Supergt");
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][1], "$300.000");
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][2], 572.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][2]);
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][3], 568.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][3]);
                P_catalogogrotti[playerid] = 0;
            }
            case 2:
            {
                InterpolateCameraPos(playerid, 536.6366, -1307.1511, 1999.2629, 529.1366, -1307.1511, 1999.2629, 1000);
				InterpolateCameraLookAt(playerid, 536.6366, -1297.1511, 1996.7765, 529.1366, -1296.6511, 1996.7765, 1000);
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][0], "Turismo");
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][1], "$350.000");
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][2], 576.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][2]);
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][3], 562.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][3]);
                P_catalogogrotti[playerid] = 1;
            }
            case 3:
            {
                InterpolateCameraPos(playerid, 544.1366, -1307.1511, 1999.2629, 536.6366, -1307.1511, 1999.2629, 1000);
				InterpolateCameraLookAt(playerid, 544.1366, -1298.1511, 1997.2629, 536.6366, -1297.1511, 1996.7765, 1000);
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][0], "Banshee");
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][1], "$190.000");
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][2], 555.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][2]);
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][3], 565.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][3]);
                P_catalogogrotti[playerid] = 2;
            }
            case 4:
            {
                InterpolateCameraPos(playerid, 551.6366, -1307.1511, 1999.2629, 544.1366, -1307.1511, 1999.2629, 1000);
				InterpolateCameraLookAt(playerid, 551.6366, -1297.1511, 1996.7765, 544.1366, -1298.1511, 1997.2629, 1000);
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][0], "Infernus");
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][1], "$450.000");
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][2], 580.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][2]);
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][3], 575.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][3]);
                P_catalogogrotti[playerid] = 3;
            }
            case 5:
            {
                InterpolateCameraPos(playerid, 559.1479, -1307.1511, 1999.2629, 551.6366, -1307.1511, 1999.2629, 1000);
				InterpolateCameraLookAt(playerid, 559.1479, -1296.5100, 1996.7765, 551.6366, -1297.1511, 1996.7765, 1000);
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][0], "Bullet");
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][1], "$260.000");
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][2], 570.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][2]);
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][3], 565.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][3]);
                P_catalogogrotti[playerid] = 4;
            }
            case 6:
            {
                InterpolateCameraPos(playerid, 566.6479, -1307.1511, 1999.2629, 559.1479, -1307.1511, 1999.2629, 1000);
				InterpolateCameraLookAt(playerid, 566.6479, -1296.0100, 1996.7765, 559.1479, -1296.5100, 1996.7765, 1000);
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][0], "Cheetah");
                PlayerTextDrawSetString(playerid, PTD_GrottiCatalogo[playerid][1], "$420.000");
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][2], 575.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][2]);
                PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][3], 570.0, 0.000000);
                PlayerTextDrawShow(playerid, PTD_GrottiCatalogo[playerid][3]);
                P_catalogogrotti[playerid] = 5;
            }
        }
		return 1;
	}
	if(clickedid == TD_GrottiCatalogo[6])
	{
	    switch(P_catalogogrotti[playerid])
	    {
	        case 0:
	        {
			    if(300000 > PlayerInfo[playerid][dinerobank])
				{
					InfoMSG(playerid, 3000, "No tienes suficiente dinero. (banco)");
					PlayerPlaySound(playerid,1053,0.0,0.0,0.0);
					return 1;
				}
                ShowPlayerDialog(playerid, DIALOG_GROTTI, DIALOG_STYLE_MSGBOX, "Super GT", "Puedes comprar este vehículo.\n\n\t¿Quieres adquirir este vehiculo por $300.000?\n\nGrotti SL.", "Comprar", "Cancelar");
			}
			case 1:
	        {
			    if(350000 > PlayerInfo[playerid][dinerobank])
				{
					InfoMSG(playerid, 3000, "No tienes suficiente dinero. (banco)");
					PlayerPlaySound(playerid,1053,0.0,0.0,0.0);
					return 1;
				}
				ShowPlayerDialog(playerid, DIALOG_GROTTI, DIALOG_STYLE_MSGBOX, "Turismo", "Puedes comprar este vehículo.\n\n\t¿Quieres adquirir este vehiculo por $350.000?\n\nGrotti SL.", "Comprar", "Cancelar");
			}
			case 2:
	        {
			    if(190000 > PlayerInfo[playerid][dinerobank])
				{
					InfoMSG(playerid, 3000, "No tienes suficiente dinero. (banco)");
					PlayerPlaySound(playerid,1053,0.0,0.0,0.0);
					return 1;
				}
				ShowPlayerDialog(playerid, DIALOG_GROTTI, DIALOG_STYLE_MSGBOX, "Banshee", "Puedes comprar este vehículo.\n\n\t¿Quieres adquirir este vehiculo por $190.000?\n\nGrotti SL.", "Comprar", "Cancelar");
			}
			case 3:
	        {
			    if(450000 > PlayerInfo[playerid][dinerobank])
				{
					InfoMSG(playerid, 3000, "No tienes suficiente dinero. (banco)");
					PlayerPlaySound(playerid,1053,0.0,0.0,0.0);
					return 1;
				}
				ShowPlayerDialog(playerid, DIALOG_GROTTI, DIALOG_STYLE_MSGBOX, "Infernus", "Puedes comprar este vehículo.\n\n\t¿Quieres adquirir este vehiculo por $450.000?\n\nGrotti SL.", "Comprar", "Cancelar");
			}
			case 4:
	        {
			    if(260000 > PlayerInfo[playerid][dinerobank])
				{
					InfoMSG(playerid, 3000, "No tienes suficiente dinero. (banco)");
					PlayerPlaySound(playerid,1053,0.0,0.0,0.0);
					return 1;
				}
				ShowPlayerDialog(playerid, DIALOG_GROTTI, DIALOG_STYLE_MSGBOX, "Bullet", "Puedes comprar este vehículo.\n\n\t¿Quieres adquirir este vehiculo por $260.000?\n\nGrotti SL.", "Comprar", "Cancelar");
			}
			case 5:
	        {
			    if(420000 > PlayerInfo[playerid][dinerobank])
				{
					InfoMSG(playerid, 3000, "No tienes suficiente dinero. (banco)");
					PlayerPlaySound(playerid,1053,0.0,0.0,0.0);
					return 1;
				}
				ShowPlayerDialog(playerid, DIALOG_GROTTI, DIALOG_STYLE_MSGBOX, "Cheetah", "Puedes comprar este vehículo.\n\n\t¿Quieres adquirir este vehiculo por $420.000?\n\nGrotti SL.", "Comprar", "Cancelar");
			}
			case 6:
	        {
			    if(80000 > PlayerInfo[playerid][dinerobank])
				{
					InfoMSG(playerid, 3000, "No tienes suficiente dinero. (banco)");
					PlayerPlaySound(playerid,1053,0.0,0.0,0.0);
					return 1;
				}
				ShowPlayerDialog(playerid, DIALOG_GROTTI, DIALOG_STYLE_MSGBOX, "Phoenix", "Puedes comprar este vehículo.\n\n\t¿Quieres adquirir este vehiculo por $80.000?\n\nGrotti SL.", "Comprar", "Cancelar");
			}
		}
	}
        /*
		SUPERGT      		230.0 					26.0 --- $300mil
		TURISMO      		240.0 					30.0 --- $350mil
		BANSHEE      		200.0 					33.0 --- $190mil
		INFERNUS     		240.0 					30.0 --- $450mil
		BULLET       		230.0 					30.0 --- $260mil
		CHEETAH      		230.0 					30.0 --- $420mil
		PHOENIX      		200.0 					26.0 --- $80mil
	*/
    if(clickedid == TD_ST[5]) // IZQ 2
    {
        PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
    	switch(P_register_step[playerid])
		{
		    case 0: //Nombre
		    {
				PlayerTextDrawSetString(playerid, PTD_ST[playerid][0],  "edad");
		        new str[5];
				format(str, 5, "%d", PlayerInfo[playerid][edad]);
		        PlayerTextDrawSetString(playerid, PTD_ST[playerid][1],  str);
				P_register_step[playerid] = 2;
				return 1;
		    }
		    case 1: //Género
		    {
				PlayerTextDrawSetString(playerid, PTD_ST[playerid][0],  "nombre");
		        PlayerTextDrawSetString(playerid, PTD_ST[playerid][1],  PlayerNameNormal(playerid));
				P_register_step[playerid] = 0;
				return 1;
		    }
		    case 2: //Edad
		    {
		        PlayerTextDrawSetString(playerid, PTD_ST[playerid][0],  simbolos("género"));
		        if(PlayerInfo[playerid][sexo] == 0) PlayerTextDrawSetString(playerid, PTD_ST[playerid][1],  "masculino");
		        else PlayerTextDrawSetString(playerid, PTD_ST[playerid][1],  "femenino");
				P_register_step[playerid] = 1;
				return 1;
		    }
		}
        return 1;
    }
    if(clickedid == TD_ST[6]) // IZQ 1
    {
        switch(P_register_step[playerid])
		{
		    case 0: return PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
		    case 1:
			{
				if(PlayerInfo[playerid][sexo] == 1)
				{
				    PlayerInfo[playerid][skin] = RandomMen[random(sizeof(RandomMen))];
				    PlayerInfo[playerid][sexo] = 0;
				    PlayerTextDrawSetString(playerid, PTD_ST[playerid][1], "masculino");
				    PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
				    SetSpawnInfo(playerid, NO_TEAM, PlayerInfo[playerid][skin], 1172.856201, -1323.368774, 15.399730, 0, 0, 0, 0, 0, 0, 0);
				}
				else
				{
				    PlayerInfo[playerid][skin] = RandomWoman[random(sizeof(RandomWoman))];
				    PlayerInfo[playerid][sexo] = 1;
				    PlayerTextDrawSetString(playerid, PTD_ST[playerid][1], "femenino");
				    PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
				    SetSpawnInfo(playerid, NO_TEAM, PlayerInfo[playerid][skin], 1172.856201, -1323.368774, 15.399730, 0, 0, 0, 0, 0, 0, 0);
				}
			}
			case 2:
			{
			    if(PlayerInfo[playerid][edad] == 21) return PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
			  	PlayerInfo[playerid][edad]--;
				new str[5];
				format(str, 5, "%d", PlayerInfo[playerid][edad]);
				PlayerTextDrawSetString(playerid, PTD_ST[playerid][1], str);
				PlayerPlaySound(playerid,1052,0.0,0.0,0.0);
			}
		}
        return 1;
    }
    if(clickedid == TD_ST[7]) // DER 1
    {
		switch(P_register_step[playerid])
		{
		    case 0: return PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
		    case 1:
		    {
		        if(PlayerInfo[playerid][sexo] == 1)
				{
				    PlayerInfo[playerid][skin] = RandomMen[random(sizeof(RandomMen))];
				    PlayerInfo[playerid][sexo] = 0;
				    PlayerTextDrawSetString(playerid, PTD_ST[playerid][1], "masculino");
				    PlayerPlaySound(playerid,1053,0.0,0.0,0.0);
				}
				else
				{
				    PlayerInfo[playerid][skin] = RandomWoman[random(sizeof(RandomWoman))];
				    PlayerInfo[playerid][sexo] = 1;
				    PlayerTextDrawSetString(playerid, PTD_ST[playerid][1], "femenino");
				    PlayerPlaySound(playerid,1053,0.0,0.0,0.0);
				}
		    }
		    case 2:
		    {
		        if(PlayerInfo[playerid][edad] == 40) return PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
				PlayerInfo[playerid][edad]++;
				new str[5];
				format(str, 5, "%d", PlayerInfo[playerid][edad]);
				PlayerTextDrawSetString(playerid, PTD_ST[playerid][1], str);
				PlayerPlaySound(playerid,1053,0.0,0.0,0.0);
				return 1;
		    }
		}
        return 1;
    }
    if(clickedid == TD_ST[8]) // DER 2
    {
        PlayerPlaySound(playerid,1053,0.0,0.0,0.0);
    	switch(P_register_step[playerid])
		{
		    case 0: //Nombre
		    {
		        PlayerTextDrawSetString(playerid, PTD_ST[playerid][0],  simbolos("género"));
		        if(PlayerInfo[playerid][sexo] == 0) PlayerTextDrawSetString(playerid, PTD_ST[playerid][1],  "masculino");
		        else PlayerTextDrawSetString(playerid, PTD_ST[playerid][1],  "femenino");
				P_register_step[playerid] = 1;
				return 1;
		    }
		    case 1: //Género
		    {
		        PlayerTextDrawSetString(playerid, PTD_ST[playerid][0],  "edad");
		        new str[5];
				format(str, 5, "%d", PlayerInfo[playerid][edad]);
		        PlayerTextDrawSetString(playerid, PTD_ST[playerid][1],  str);
				P_register_step[playerid] = 2;
				return 1;
		    }
		    case 2: //Edad
		    {
		        PlayerTextDrawSetString(playerid, PTD_ST[playerid][0],  "nombre");
		        PlayerTextDrawSetString(playerid, PTD_ST[playerid][1],  PlayerNameNormal(playerid));
				P_register_step[playerid] = 0;
				return 1;
		    }
		}
        return 1;
    }
    if(clickedid == TD_ST[9])
    {
        /*
        CancelSelectTextDraw(playerid);
	    new str[500];
        format(str, 500, "\n\tNombre: %s\n\tEdad: %d\n\tGénero: %d\n\tCorreo: %s\n\n{00CCFF}¿Son correctos?", PlayerNameNormal(playerid), PlayerInfo[playerid][edad], PlayerInfo[playerid][sexo], PlayerInfo[playerid][email]);
        ShowPlayerDialog(playerid, DIALOG_CONFIRME, DIALOG_STYLE_MSGBOX, "Estos son tus datos", str, "Sí", "No");
        */
        loop(0, 6, pd) TextDrawShowForPlayer(playerid, TD_PLAYERDATA[pd]);
		new string[145];
		format(string, 145, "%s~n~~n~%d~n~~n~%s~n~~n~_", PlayerName(playerid), PlayerInfo[playerid][edad], PlayerInfo[playerid][sexo] == 0 ? ("Masculino"):("Femenino"));
        PlayerTextDrawSetString(playerid, PTD_PD[playerid], string);
        PlayerTextDrawShow(playerid, PTD_PD[playerid]);
        loop(4, 10, id) TextDrawHideForPlayer(playerid, TD_ST[id]);
        PlayerTextDrawHide(playerid, PTD_ST[playerid][0]);
        PlayerTextDrawHide(playerid, PTD_ST[playerid][1]);
        return 1;
    }
    
    if(clickedid == TD_PLAYERDATA[3])
    {
    	PlayerPlaySound(playerid,1135,0.0,0.0,0.0);
        P_newuser[playerid] = 1;
        P_register_step[playerid] = -1;
        StopAudioStreamForPlayer(playerid);
		PlayAudioStreamForPlayer(playerid, "https://dl.dropboxusercontent.com/s/gqqhiahls4mgu9m/intro.mp3");//"https://dl.dropboxusercontent.com/s/bw2a4503jsa1orl/intro.mp3");
		PlayerTextDrawHide(playerid, PTD_PD[playerid]);
		loop(0, 10, l) TextDrawHideForPlayer(playerid, TD_ST[l]);
		loop(0, 6, i) TextDrawHideForPlayer(playerid, TD_PLAYERDATA[i]);
		loop(0, 20, a) SendClientMessage(playerid, -1, " ");
		
		PlayerTextDrawBoxColor(playerid, Background[playerid], 0x000000FF);
		PlayerTextDrawShow(playerid, Background[playerid]);
		MyTimers[playerid][0] = SetTimerEx("FadeIn", 1500, false, "id", playerid, 250);
		CancelSelectTextDraw(playerid);
		TogglePlayerSpectating(playerid, true);
		InterpolateCameraPos(playerid, CameraPositions[0][0], CameraPositions[0][1], CameraPositions[0][2], CameraPositions[0][3], CameraPositions[0][4], CameraPositions[0][5], 10000);
		InterpolateCameraLookAt(playerid, CameraPositions[0][6], CameraPositions[0][7], CameraPositions[0][8], CameraPositions[0][9], CameraPositions[0][10], CameraPositions[0][11], 10000);
        SetPlayerVirtualWorld(playerid, playerid);
		MyTimers[playerid][1] = SetTimerEx("OnPlayerFinishInterpolateCamera", 8000, false, "id", playerid, 1);
        return 1;
    }
    
    if(clickedid == TD_PLAYERDATA[2])
    {
    	loop(0, 6, pd) TextDrawHideForPlayer(playerid, TD_PLAYERDATA[pd]);
        PlayerTextDrawHide(playerid, PTD_PD[playerid]);
        loop(4, 10, id) TextDrawShowForPlayer(playerid, TD_ST[id]);
        PlayerTextDrawShow(playerid, PTD_ST[playerid][0]);
        PlayerTextDrawShow(playerid, PTD_ST[playerid][1]);
    }
    
    if(clickedid == CircularMenu[8]) //Cuenta
    {
        P_circularmenu_active[playerid] = 2;
        loop(0, 12, a) TextDrawHideForPlayer(playerid, CircularMenu[a]);
        TextDrawShowForPlayer(playerid, UserBox[0]);
        TextDrawShowForPlayer(playerid, UserBox[1]);
        TextDrawShowForPlayer(playerid, UserBox[2]);
        TextDrawShowForPlayer(playerid, UserBox[3]);

        PlayerTextDrawSetString(playerid, PlayerUserBox[playerid][0], "Cuenta");
        PlayerTextDrawShow(playerid, PlayerUserBox[playerid][0]);
        PlayerTextDrawShow(playerid, PlayerUserBox[playerid][1]);
        
		new str2[32];
		format(str2, 32, "%d", PlayerInfo[playerid][phonenumber]);
        new str[150];
        format(str, 150, "Nombre: %s~n~Edad: %d~n~Género: %s~n~Dinero: %d~n~Dinero en el banco: %d~n~Móvil: %s",
		PlayerNameNormal(playerid),
		PlayerInfo[playerid][edad],
		GetSex(playerid),
		PlayerInfo[playerid][dinero],
		PlayerInfo[playerid][dinerobank],
		PlayerInfo[playerid][phonenumber] == 0 ? ("desactivado"):(str2));
		PlayerTextDrawSetString(playerid, PlayerUserBox[playerid][1], simbolos(str));
        return 1;
    }
    if(clickedid == CircularMenu[9]) //Info
	{
	    P_circularmenu_active[playerid] = 2;
	    loop(0, 12, a) TextDrawHideForPlayer(playerid, CircularMenu[a]);
     	TextDrawShowForPlayer(playerid, UserBox[0]);
        TextDrawShowForPlayer(playerid, UserBox[1]);
        TextDrawShowForPlayer(playerid, UserBox[2]);
        TextDrawShowForPlayer(playerid, UserBox[3]);
        
        PlayerTextDrawSetString(playerid, PlayerUserBox[playerid][0], simbolos("Información"));
        PlayerTextDrawShow(playerid, PlayerUserBox[playerid][0]);
        PlayerTextDrawShow(playerid, PlayerUserBox[playerid][1]);
        
        PlayerTextDrawSetString(playerid, PlayerUserBox[playerid][1], simbolos("eXtreme Roleplay es un servidor de rol, tendrás~n~que simular como si fuera la vida real.~n~~n~eXtreme Roleplay ha sido creado por...~n~adri1, Jeff, Ner0x, raul.lg98."));
        return 1;
    }
    if(clickedid == CircularMenu[10]) //Trabajo
    {
        P_circularmenu_active[playerid] = 2;
        loop(0, 12, a) TextDrawHideForPlayer(playerid, CircularMenu[a]);
        TextDrawShowForPlayer(playerid, UserBox[0]);
        TextDrawShowForPlayer(playerid, UserBox[1]);
        TextDrawShowForPlayer(playerid, UserBox[2]);
        TextDrawShowForPlayer(playerid, UserBox[3]);
        
        PlayerTextDrawSetString(playerid, PlayerUserBox[playerid][0], "Trabajo");
        PlayerTextDrawShow(playerid, PlayerUserBox[playerid][0]);
        PlayerTextDrawShow(playerid, PlayerUserBox[playerid][1]);
        
        PlayerTextDrawSetString(playerid, PlayerUserBox[playerid][1], simbolos("Esta opción aún no está disponible"));
        return 1;
    }
    if(clickedid == CircularMenu[11]) //Comandos
    {
        P_circularmenu_active[playerid] = 2;
        loop(0, 12, a) TextDrawHideForPlayer(playerid, CircularMenu[a]);
        TextDrawShowForPlayer(playerid, UserBox[0]);
        TextDrawShowForPlayer(playerid, UserBox[1]);
        TextDrawShowForPlayer(playerid, UserBox[2]);
        TextDrawShowForPlayer(playerid, UserBox[3]);
        
        PlayerTextDrawSetString(playerid, PlayerUserBox[playerid][0], "Comandos");
        PlayerTextDrawShow(playerid, PlayerUserBox[playerid][0]);
        PlayerTextDrawShow(playerid, PlayerUserBox[playerid][1]);
        
        PlayerTextDrawSetString(playerid, PlayerUserBox[playerid][1], simbolos("Próximamente"));
        return 1;
    }
    if(clickedid == Bank[16]) // Retirar
    {
  		TextDrawHideForPlayer(playerid, Bank[15]);
	    TextDrawHideForPlayer(playerid, Bank[16]);
	    TextDrawHideForPlayer(playerid, Bank[17]);
	    TextDrawHideForPlayer(playerid, Bank[18]);
	    TextDrawHideForPlayer(playerid, Bank[19]);
    	ShowPlayerDialog(playerid, DIALOG_RETIRAR, DIALOG_STYLE_INPUT, "BANCO LS - RETIRAR", "\n\t¿Cuánto quiere retirar?\n", "Retirar", "Cancelar");
    	return 1;
    }
    if(clickedid == Bank[17]) // Depositar
    {
		TextDrawHideForPlayer(playerid, Bank[15]);
	    TextDrawHideForPlayer(playerid, Bank[16]);
	    TextDrawHideForPlayer(playerid, Bank[17]);
	    TextDrawHideForPlayer(playerid, Bank[18]);
	    TextDrawHideForPlayer(playerid, Bank[19]);
        ShowPlayerDialog(playerid, DIALOG_DEPOSIT, DIALOG_STYLE_INPUT, "BANCO LS - DEPOSITAR", "\n\t¿Cuánto quiere depositar?\n", "Depositar", "Cancelar");
        return 1;
    }
    if(clickedid == Bank[18]) // Salir
    {
        loop(0, 20, l) TextDrawHideForPlayer(playerid, Bank[l]);
        PlayerTextDrawHide(playerid, PlayerBank[playerid][0]);
        PlayerTextDrawHide(playerid, PlayerBank[playerid][1]);
    	P_bank_state[playerid] = -1;
    	CancelSelectTextDraw(playerid);
    	ChatLogDisabled[playerid] = false;
    	ShowBankCash(playerid, 2000);
    	return 1;
    }
	return 1;
}

funcion:OnPlayerFinishInterpolateCamera(playerid, type)
{
	switch(type)
	{
	    case 1: PlayerTextDrawShow(playerid, TD_IO[playerid]), PlayerTextDrawSetString(playerid, TD_IO[playerid], simbolos("_~n~__Bienvenido a Los Santos...~n~~n~"));
	    case 3: PlayerTextDrawSetString(playerid, TD_IO[playerid], simbolos("_~n~__Donde podrás divertirte~n~__con trabajos, fiestas y más~n~__eventos interesantes.~n~~n~"));
	    case 5: PlayerTextDrawSetString(playerid, TD_IO[playerid], simbolos("_~n~__Además de una gran variedad~n~__de sistemas y funciones...~n~~n~"));
	    case 8: PlayerTextDrawSetString(playerid, TD_IO[playerid], simbolos("_~n~__¡Bienvenido a eXtreme RolePlay!~n~~n~"));
	    case 10:
		{
			PlayerTextDrawHide(playerid, TD_IO[playerid]);
			InterpolateCameraPos(playerid, CameraPositions[type][0], CameraPositions[type][1], CameraPositions[type][2], CameraPositions[type][3], CameraPositions[type][4], CameraPositions[type][5], 10000);
			InterpolateCameraLookAt(playerid, CameraPositions[type][6], CameraPositions[type][7], CameraPositions[type][8], CameraPositions[type][9], CameraPositions[type][10], CameraPositions[type][11], 10000);
			MyTimers[playerid][5] = SetTimerEx("OnPlayerFinishInterpolateCamera", 5000, false, "id", playerid, type+1);
			return 1;
		}
		case 11:
		{
		    PlayerTextDrawBoxColor(playerid, Background[playerid], 0x00000000);
			PlayerTextDrawShow(playerid, Background[playerid]);
			MyTimers[playerid][2] = SetTimerEx("FadeOut", 500, false, "id", playerid, 0);
		    return 1;
		}
	}
    InterpolateCameraPos(playerid, CameraPositions[type][0], CameraPositions[type][1], CameraPositions[type][2], CameraPositions[type][3], CameraPositions[type][4], CameraPositions[type][5], 10000);
	InterpolateCameraLookAt(playerid, CameraPositions[type][6], CameraPositions[type][7], CameraPositions[type][8], CameraPositions[type][9], CameraPositions[type][10], CameraPositions[type][11], 10000);
	MyTimers[playerid][5] = SetTimerEx("OnPlayerFinishInterpolateCamera", 8000, false, "id", playerid, type+1);
	return 1;
}

funcion:FadeIn(playerid, A, b)
{
    PlayerTextDrawBoxColor(playerid, Background[playerid], RGBToHex(0, 0, 0, A));
    PlayerTextDrawShow(playerid, Background[playerid]);
    switch(A)
    {
	    case 11 .. 500: MyTimers[playerid][6] = SetTimerEx("FadeIn", DELAY, false, "idd", playerid, A-20, b);
		case 10:
		{
			PlayerTextDrawHide(playerid, Background[playerid]);
		}
	}
	return 1;
}

funcion:FadeOut(playerid, A)
{
    PlayerTextDrawBoxColor(playerid, Background[playerid], RGBToHex(0, 0, 0, A));
    PlayerTextDrawShow(playerid, Background[playerid]);
    switch(A)
    {
	    case 0 .. 220: MyTimers[playerid][8] = SetTimerEx("FadeOut", DELAY, false, "id", playerid, A+20);
		case 240:
		{
			PlayerTextDrawBoxColor(playerid, Background[playerid], 0x000000FF);
			PlayerTextDrawShow(playerid, Background[playerid]);
			NextIntroStep(playerid);
		}
	}
	return 1;
}

funcion:ShowBigLogoForPlayer(playerid) return TextDrawShowForPlayer(playerid, TD_EY[0]), TextDrawShowForPlayer(playerid, TD_EY[1]), TextDrawShowForPlayer(playerid, TD_EY[2]);

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == Conceptos[5][playerid])
    {
		new step = P_newuser[playerid];
		if(step == 8)
		{
 			TogglePlayerControllable(playerid, true);
			ApplyAnimation(playerid, "ped", "SEAT_idle", 4.0, 0, 0, 0, 1, 0, 0);
		}
        if(step == 10)
        {
            TextDrawShowForPlayer(playerid, TD_BX[0]);
    		TextDrawShowForPlayer(playerid, TD_BX[1]);
            PlayerTextDrawHide(playerid, Background[playerid]);
	        for(new i = 0; i < sizeof(Conceptos); i++) PlayerTextDrawHide(playerid, Conceptos[i][playerid]);
	        CancelSelectTextDraw(playerid);
		    SetCameraBehindPlayer(playerid);
			MyTimers[playerid][7] = SetTimerEx("FinishPlayerTutorial", 3000, false, "i", playerid);
			PlayerInfo[playerid][dinero] = 500;
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid, PlayerInfo[playerid][dinero]);
			SendClientMessage(playerid, -1, "Usa el comando {00CCFF}/ayuda {FFFFFF} para mostrar un menú de ayuda.");
			SendClientMessage(playerid, -1, "{FFFF00}¡Importante! {FFFFFF}No desperdicies el dinero que te hemos dado, usa el comando {FFFF00}/empezar {FFFFFF}si quieres empezar bien.");
            P_player_tutorial[playerid] = -1;
            return 1;
        }
        ShowConceptPage(playerid, step+1); //MG
    }
    if(playertextid == Conceptos[4][playerid])
    {
        new step = P_newuser[playerid];
		if(step == 1) return 1;
        ShowConceptPage(playerid, step-1); //DM
    }
    return 1;
}

stock NextIntroStep(playerid)
{
    TextDrawHideForPlayer(playerid, TD_EY[0]);
	TextDrawHideForPlayer(playerid, TD_EY[1]);
	TextDrawHideForPlayer(playerid, TD_EY[2]);
	
	P_newuser[playerid] = 1;
	PlayerTextDrawSetString(playerid, Conceptos[2][playerid], "Conceptos de ROL - OP");
	PlayerTextDrawSetString(playerid, Conceptos[3][playerid], simbolos("OnPlayer~n~Quiere decir En el personaje~n~lo cual significa que es cuando se rolea~n~Ejemplo: \"Buenos días, señor\" ~n~~n~Los canales OP son: /s /g /me /do"));
    for(new i = 0; i < 15; i++) SendClientMessage(playerid, -1, " ");
    for(new i = 0; i < sizeof(Conceptos); i++) PlayerTextDrawShow(playerid, Conceptos[i][playerid]);
    SelectTextDraw(playerid, 0x33AA33AA);
    P_player_tutorial[playerid] = 1;
	TogglePlayerSpectating(playerid, false);
    SpawnPlayer(playerid);
	return 1;
}

stock ShowConceptPage(playerid, page)
{
	switch(page)
	{
	    case 1:
	    {
			PlayerTextDrawSetString(playerid, Conceptos[2][playerid], "Conceptos de ROL - OP");
			PlayerTextDrawSetString(playerid, Conceptos[3][playerid], simbolos("OnPlayer~n~Quiere decir En el personaje~n~lo cual significa que es cuando se rolea~n~Ejemplo: \"Buenos días, señor\" ~n~~n~Los canales OP son: /s /g /me /do"));
	        PlayerTextDrawSetString(playerid, Conceptos[6][playerid], "1/10");
	        P_newuser[playerid] = page;
	    }
	    case 2:
	    {
			PlayerTextDrawSetString(playerid, Conceptos[2][playerid], "Conceptos de ROL - OTP");
			PlayerTextDrawSetString(playerid, Conceptos[3][playerid], simbolos("OutPlayer~n~Quiere decir Fuera del personaje~n~lo cual significa que es cuando se habla de~n~la vida real~n~Ejemplo: \"Ayer llovió en mi ciudad\" ~n~~n~Los canales OTP son: /b y /d"));
	        PlayerTextDrawSetString(playerid, Conceptos[6][playerid], "2/10");
	        P_newuser[playerid] = page;
	    }
	    case 3:
	    {
			PlayerTextDrawSetString(playerid, Conceptos[2][playerid], "Conceptos de ROL - CC");
			PlayerTextDrawSetString(playerid, Conceptos[3][playerid], simbolos("ConfundirCanales~n~Esto pasa muy a menudo en los servidores~n~de rol pero es algo que hay que corregir~n~~n~Esto es confundir OP con OTP~n~Ejemplo de CC en OP: \"Está lloviendo\"~n~Cuando en realidad no llueve en el juego"));
	        PlayerTextDrawSetString(playerid, Conceptos[6][playerid], "3/10");
	        P_newuser[playerid] = page;
	    }
	    case 4:
	    {
			PlayerTextDrawSetString(playerid, Conceptos[2][playerid], "Conceptos de ROL - DM/ASR");
			PlayerTextDrawSetString(playerid, Conceptos[3][playerid], simbolos("DM y ASR~n~En un servidor de rol, no puedes ir~n~matando personas (DM)~n~ni tampoco agrediéndolas (ASR) sin~n~ninguna razón"));
	        PlayerTextDrawSetString(playerid, Conceptos[6][playerid], "4/10");
	        P_newuser[playerid] = page;
	    }
	    case 5:
	    {
			PlayerTextDrawSetString(playerid, Conceptos[2][playerid], "Conceptos de ROL - VM");
			PlayerTextDrawSetString(playerid, Conceptos[3][playerid], simbolos("Vengarse tras la muerte~n~Si alguien te mata (DM) con razón~n~después no puedes ir a vengarte~n~ya que al morir pierdes la memoria"));
	        PlayerTextDrawSetString(playerid, Conceptos[6][playerid], "5/10");
	        P_newuser[playerid] = page;
	        CargarAnim(playerid);
	    }
	    case 6:
	    {
			PlayerTextDrawSetString(playerid, Conceptos[2][playerid], "Conceptos de ROL - RV");
			PlayerTextDrawSetString(playerid, Conceptos[3][playerid], simbolos("Robar vehículo~n~No puedes robar un vehículo sin rolearlo~n~~n~¡Si intentas robarlo sin rol, quedarás~n~congelado por 15 segundos!"));
	        PlayerTextDrawSetString(playerid, Conceptos[6][playerid], "6/10");
	        P_newuser[playerid] = page;
	    }
	    case 7:
	    {
			PlayerTextDrawSetString(playerid, Conceptos[2][playerid], "Conceptos de ROL - PG");
			PlayerTextDrawSetString(playerid, Conceptos[3][playerid], simbolos("PowerGaming~n~Es hacer cosas que no se pueden ~n~hacer en la vida real.~n~EJ: te apuntan con un arma y sales~n~corriendo, sería PG~n~Nunca puedes hacer PG en el servidor~n~iSerás sancionado si lo haces!"));
	        PlayerTextDrawSetString(playerid, Conceptos[6][playerid], "7/10");
	        P_newuser[playerid] = page;
	    }
	    case 8:
	    {
			PlayerTextDrawSetString(playerid, Conceptos[2][playerid], "Conceptos de ROL - AB");
			PlayerTextDrawSetString(playerid, Conceptos[3][playerid], simbolos("Abusar de un bug~n~Un bug es un error del juego~n~Si encuentras uno, reportalo pero no~n~abuses de él."));
	        PlayerTextDrawSetString(playerid, Conceptos[6][playerid], "8/10");
	        P_newuser[playerid] = page;
	    }
	    case 9:
	    {
			PlayerTextDrawSetString(playerid, Conceptos[2][playerid], "Conceptos de ROL - DUDAS");
			PlayerTextDrawSetString(playerid, Conceptos[3][playerid], simbolos("CANAL DE DUDAS~n~Para usar el canal de dudas~n~debes de activarlo con el comando /cduda~n~y posteriormente el comando /d [duda]"));
	        PlayerTextDrawSetString(playerid, Conceptos[6][playerid], "9/10");
	        P_newuser[playerid] = page;
	    }
	    case 10:
	    {
			PlayerTextDrawSetString(playerid, Conceptos[2][playerid], "Conceptos de ROL - FIN");
			PlayerTextDrawSetString(playerid, Conceptos[3][playerid], simbolos("FIN~n~Final de la guía~n~ahora estás preparado para empezar.~n~Para escribir usa la tecla 'T'~n~~n~~n~iDiviértete!"));
	        PlayerTextDrawSetString(playerid, Conceptos[6][playerid], "10/10");
	        P_newuser[playerid] = page;
	    }
	}
	return 1;
}

funcion:FinishPlayerTutorial(playerid)
{
    TextDrawHideForPlayer(playerid, TD_BX[0]);
	TextDrawHideForPlayer(playerid, TD_BX[1]);
    ApplyAnimation(playerid, "ped", "SEAT_up", 4.0, 0, 0, 1, 0, 0, 0);
    SetPlayerVirtualWorld(playerid, 0);
 	StopAudioStreamForPlayer(playerid);
	ChatLogDisabled[playerid] = false;
	P_newuser[playerid] = -1;
	UpdateUserData(playerid);
	return 1;
}

funcion:GrottiContinue(playerid, type)
{
	/*switch(type)
	{
	    case 0:
	}*/
}

DestroyPlayerTextDraws(playerid)
{
    PlayerTextDrawDestroy(playerid, PTD_PhoneString1[playerid]);
    PlayerTextDrawDestroy(playerid, PTD_PhoneString2[playerid]);
	PlayerTextDrawDestroy(playerid, ErrorCommand[playerid]);
	PlayerTextDrawDestroy(playerid, Background[playerid]);
	PlayerTextDrawDestroy(playerid, TD_IO[playerid]);
	PlayerTextDrawDestroy(playerid, PlayerUserBox[playerid][0]);
	PlayerTextDrawDestroy(playerid, PlayerUserBox[playerid][1]);
    PlayerTextDrawDestroy(playerid, PlayerBank[playerid][0]);
    PlayerTextDrawDestroy(playerid, PlayerBank[playerid][1]);
    PlayerTextDrawDestroy(playerid, BankCash[playerid]);
    PlayerTextDrawDestroy(playerid, CosasPorHacer[playerid][0]);
    PlayerTextDrawDestroy(playerid, CosasPorHacer[playerid][1]);
    PlayerTextDrawDestroy(playerid, CosasPorHacer[playerid][2]);
    PlayerTextDrawDestroy(playerid, CosasPorHacer[playerid][3]);
    /*PlayerTextDrawDestroy(playerid, PlayerInventarioTD[playerid][0]);
    PlayerTextDrawDestroy(playerid, PlayerInventarioTD[playerid][1]);
    PlayerTextDrawDestroy(playerid, PlayerInventarioTD[playerid][2]);
    PlayerTextDrawDestroy(playerid, PlayerInventarioTD[playerid][3]);
    PlayerTextDrawDestroy(playerid, PlayerInventarioTD[playerid][4]);
    PlayerTextDrawDestroy(playerid, PlayerInventarioTD[playerid][5]);
    PlayerTextDrawDestroy(playerid, PlayerInventarioTD[playerid][6]);
    PlayerTextDrawDestroy(playerid, PlayerInventarioTD[playerid][7]);
    PlayerTextDrawDestroy(playerid, PlayerInventarioTD[playerid][8]);
    PlayerTextDrawDestroy(playerid, PlayerInventarioTD[playerid][9]);*/
    PlayerTextDrawDestroy(playerid, Conceptos[0][playerid]);
    PlayerTextDrawDestroy(playerid, Conceptos[1][playerid]);
    PlayerTextDrawDestroy(playerid, Conceptos[2][playerid]);
    PlayerTextDrawDestroy(playerid, Conceptos[3][playerid]);
    PlayerTextDrawDestroy(playerid, Conceptos[4][playerid]);
    PlayerTextDrawDestroy(playerid, Conceptos[5][playerid]);
    PlayerTextDrawDestroy(playerid, Conceptos[6][playerid]);
    /*PlayerTextDrawDestroy(playerid, PTD_RO[playerid][0]);
    PlayerTextDrawDestroy(playerid, PTD_RO[playerid][1]);
    PlayerTextDrawDestroy(playerid, PTD_RO[playerid][2]);
    PlayerTextDrawDestroy(playerid, PTD_RO[playerid][3]);*/
    PlayerTextDrawDestroy(playerid, PTD_ST[playerid][0]);
    PlayerTextDrawDestroy(playerid, PTD_ST[playerid][1]);
    PlayerTextDrawDestroy(playerid, PTD_PD[playerid]);
    PlayerTextDrawDestroy(playerid, PTD_GrottiCatalogo[playerid][0]);
    PlayerTextDrawDestroy(playerid, PTD_GrottiCatalogo[playerid][1]);
    PlayerTextDrawDestroy(playerid, PTD_GrottiCatalogo[playerid][2]);
    PlayerTextDrawDestroy(playerid, PTD_GrottiCatalogo[playerid][3]);
	return 1;
}

CreatePlayerTextDraws(playerid)
{
    PTD_GrottiCatalogo[playerid][0] = CreatePlayerTextDraw(playerid, 502.254699, 330.166687, "Infernus");
	PlayerTextDrawLetterSize(playerid, PTD_GrottiCatalogo[playerid][0], 0.440160, 1.541666);
	PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][0], 32.000000, 32.000000);
	PlayerTextDrawAlignment(playerid, PTD_GrottiCatalogo[playerid][0], 1);
	PlayerTextDrawColor(playerid, PTD_GrottiCatalogo[playerid][0], -3211009);
	PlayerTextDrawSetShadow(playerid, PTD_GrottiCatalogo[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, PTD_GrottiCatalogo[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, PTD_GrottiCatalogo[playerid][0], 255);
	PlayerTextDrawFont(playerid, PTD_GrottiCatalogo[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, PTD_GrottiCatalogo[playerid][0], 1);

	PTD_GrottiCatalogo[playerid][1] = CreatePlayerTextDraw(playerid, 553.792053, 396.083312, "$450.000");
	PlayerTextDrawLetterSize(playerid, PTD_GrottiCatalogo[playerid][1], 0.269618, 1.366665);
	PlayerTextDrawAlignment(playerid, PTD_GrottiCatalogo[playerid][1], 2);
	PlayerTextDrawColor(playerid, PTD_GrottiCatalogo[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, PTD_GrottiCatalogo[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, PTD_GrottiCatalogo[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, PTD_GrottiCatalogo[playerid][1], 51);
	PlayerTextDrawFont(playerid, PTD_GrottiCatalogo[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, PTD_GrottiCatalogo[playerid][1], 1);

	PTD_GrottiCatalogo[playerid][2] = CreatePlayerTextDraw(playerid, 601.770141, 367.083343, "maximobarraedit");
	PlayerTextDrawLetterSize(playerid, PTD_GrottiCatalogo[playerid][2], 0.000000, -0.165925);
	PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][2], 504.002929, 0.000000);
	PlayerTextDrawAlignment(playerid, PTD_GrottiCatalogo[playerid][2], 1);
	PlayerTextDrawColor(playerid, PTD_GrottiCatalogo[playerid][2], 0);
	PlayerTextDrawUseBox(playerid, PTD_GrottiCatalogo[playerid][2], true);
	PlayerTextDrawBoxColor(playerid, PTD_GrottiCatalogo[playerid][2], -2139062017);
	PlayerTextDrawSetShadow(playerid, PTD_GrottiCatalogo[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, PTD_GrottiCatalogo[playerid][2], 0);
	PlayerTextDrawFont(playerid, PTD_GrottiCatalogo[playerid][2], 0);

	PTD_GrottiCatalogo[playerid][3] = CreatePlayerTextDraw(playerid, 601.770141, 389.666687, "acelebarraedit");
	PlayerTextDrawLetterSize(playerid, PTD_GrottiCatalogo[playerid][3], 0.000000, -0.165925);
	PlayerTextDrawTextSize(playerid, PTD_GrottiCatalogo[playerid][3], 504.002929, 0.000000);
	PlayerTextDrawAlignment(playerid, PTD_GrottiCatalogo[playerid][3], 1);
	PlayerTextDrawColor(playerid, PTD_GrottiCatalogo[playerid][3], 0);
	PlayerTextDrawUseBox(playerid, PTD_GrottiCatalogo[playerid][3], true);
	PlayerTextDrawBoxColor(playerid, PTD_GrottiCatalogo[playerid][3], -2139062017);
	PlayerTextDrawSetShadow(playerid, PTD_GrottiCatalogo[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, PTD_GrottiCatalogo[playerid][3], 0);
	PlayerTextDrawFont(playerid, PTD_GrottiCatalogo[playerid][3], 0);

    PTD_PhoneString1[playerid] = CreatePlayerTextDraw(playerid, 554.854980, 224.816757, " ");
	PlayerTextDrawLetterSize(playerid, PTD_PhoneString1[playerid], 0.303352, 1.279166);
	PlayerTextDrawAlignment(playerid, PTD_PhoneString1[playerid], 2);
	PlayerTextDrawColor(playerid, PTD_PhoneString1[playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_PhoneString1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_PhoneString1[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, PTD_PhoneString1[playerid], 51);
	PlayerTextDrawFont(playerid, PTD_PhoneString1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, PTD_PhoneString1[playerid], 1);

	PTD_PhoneString2[playerid] = CreatePlayerTextDraw(playerid, 553.723388, 349.416717, " ");
	PlayerTextDrawLetterSize(playerid, PTD_PhoneString2[playerid], 0.212459, 1.086665);
	PlayerTextDrawAlignment(playerid, PTD_PhoneString2[playerid], 2);
	PlayerTextDrawColor(playerid, PTD_PhoneString2[playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_PhoneString2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_PhoneString2[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, PTD_PhoneString2[playerid], 51);
	PlayerTextDrawFont(playerid, PTD_PhoneString2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, PTD_PhoneString2[playerid], 1);
	
	PTD_PD[playerid] = CreatePlayerTextDraw(playerid, 423.667327, 187.666687, "_");
	PlayerTextDrawLetterSize(playerid, PTD_PD[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, PTD_PD[playerid], 3);
	PlayerTextDrawColor(playerid, PTD_PD[playerid], -1);
	PlayerTextDrawSetShadow(playerid, PTD_PD[playerid], 0);
	PlayerTextDrawSetOutline(playerid, PTD_PD[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, PTD_PD[playerid], 51);
	PlayerTextDrawFont(playerid, PTD_PD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, PTD_PD[playerid], 1);

	PTD_ST[playerid][0] = CreatePlayerTextDraw(playerid, 319.555908, 188.160049, "nombre");
	PlayerTextDrawLetterSize(playerid, PTD_ST[playerid][0], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, PTD_ST[playerid][0], 47.555545, 198.115554);
	PlayerTextDrawAlignment(playerid, PTD_ST[playerid][0], 2);
	PlayerTextDrawColor(playerid, PTD_ST[playerid][0], -1507073);
	PlayerTextDrawUseBox(playerid, PTD_ST[playerid][0], true);
	PlayerTextDrawBoxColor(playerid, PTD_ST[playerid][0], 1162697215);
	PlayerTextDrawSetShadow(playerid, PTD_ST[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, PTD_ST[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, PTD_ST[playerid][0], 51);
	PlayerTextDrawFont(playerid, PTD_ST[playerid][0], 3);
	PlayerTextDrawSetProportional(playerid, PTD_ST[playerid][0], 1);

	PTD_ST[playerid][1] = CreatePlayerTextDraw(playerid, 319.555908, 243.417709, "_");
	PlayerTextDrawLetterSize(playerid, PTD_ST[playerid][1], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, PTD_ST[playerid][1], 47.555545, 198.115554);
	PlayerTextDrawAlignment(playerid, PTD_ST[playerid][1], 2);
	PlayerTextDrawColor(playerid, PTD_ST[playerid][1], -1507073);
	PlayerTextDrawUseBox(playerid, PTD_ST[playerid][1], true);
	PlayerTextDrawBoxColor(playerid, PTD_ST[playerid][1], 1162697215);
	PlayerTextDrawSetShadow(playerid, PTD_ST[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, PTD_ST[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, PTD_ST[playerid][1], 51);
	PlayerTextDrawFont(playerid, PTD_ST[playerid][1], 3);
	PlayerTextDrawSetProportional(playerid, PTD_ST[playerid][1], 1);

	ErrorCommand[playerid] = CreatePlayerTextDraw(playerid, 330.0, 360.0, "_");
	PlayerTextDrawBackgroundColor(playerid, ErrorCommand[playerid], 51);
	PlayerTextDrawAlignment(playerid, ErrorCommand[playerid], 2);
	PlayerTextDrawFont(playerid, ErrorCommand[playerid], 1);
	PlayerTextDrawLetterSize(playerid, ErrorCommand[playerid], 0.449999, 1.600000);
	PlayerTextDrawColor(playerid, ErrorCommand[playerid], -1);
	PlayerTextDrawSetOutline(playerid, ErrorCommand[playerid], 0);
	PlayerTextDrawSetProportional(playerid, ErrorCommand[playerid], 1);
	PlayerTextDrawSetShadow(playerid, ErrorCommand[playerid], 1);
	
	
	CosasPorHacer[playerid][0] = CreatePlayerTextDraw(playerid,480.000000, 179.000000, "ld_chat:thumbup");
	PlayerTextDrawBackgroundColor(playerid,CosasPorHacer[playerid][0], 255);
	PlayerTextDrawFont(playerid,CosasPorHacer[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid,CosasPorHacer[playerid][0], 0.460000, -2.000000);
	PlayerTextDrawColor(playerid,CosasPorHacer[playerid][0], -1);
	PlayerTextDrawSetOutline(playerid,CosasPorHacer[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid,CosasPorHacer[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid,CosasPorHacer[playerid][0], 1);
	PlayerTextDrawUseBox(playerid,CosasPorHacer[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid,CosasPorHacer[playerid][0], 255);
	PlayerTextDrawTextSize(playerid,CosasPorHacer[playerid][0], 10.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,CosasPorHacer[playerid][0], 0);

	CosasPorHacer[playerid][1] = CreatePlayerTextDraw(playerid,480.000000, 192.000000, "ld_chat:thumbup");
	PlayerTextDrawBackgroundColor(playerid,CosasPorHacer[playerid][1], 255);
	PlayerTextDrawFont(playerid,CosasPorHacer[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid,CosasPorHacer[playerid][1], 0.460000, -2.000000);
	PlayerTextDrawColor(playerid,CosasPorHacer[playerid][1], -1);
	PlayerTextDrawSetOutline(playerid,CosasPorHacer[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid,CosasPorHacer[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid,CosasPorHacer[playerid][1], 1);
	PlayerTextDrawUseBox(playerid,CosasPorHacer[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid,CosasPorHacer[playerid][1], 255);
	PlayerTextDrawTextSize(playerid,CosasPorHacer[playerid][1], 10.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,CosasPorHacer[playerid][1], 0);

	CosasPorHacer[playerid][2] = CreatePlayerTextDraw(playerid,480.000000, 206.000000, "ld_chat:thumbup");
	PlayerTextDrawBackgroundColor(playerid,CosasPorHacer[playerid][2], 255);
	PlayerTextDrawFont(playerid,CosasPorHacer[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid,CosasPorHacer[playerid][2], 0.460000, -2.000000);
	PlayerTextDrawColor(playerid,CosasPorHacer[playerid][2], -1);
	PlayerTextDrawSetOutline(playerid,CosasPorHacer[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid,CosasPorHacer[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid,CosasPorHacer[playerid][2], 1);
	PlayerTextDrawUseBox(playerid,CosasPorHacer[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid,CosasPorHacer[playerid][2], 255);
	PlayerTextDrawTextSize(playerid,CosasPorHacer[playerid][2], 10.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,CosasPorHacer[playerid][2], 0);

	CosasPorHacer[playerid][3] = CreatePlayerTextDraw(playerid,480.000000, 220.000000, "ld_chat:thumbup");
	PlayerTextDrawBackgroundColor(playerid,CosasPorHacer[playerid][3], 255);
	PlayerTextDrawFont(playerid,CosasPorHacer[playerid][3], 4);
	PlayerTextDrawLetterSize(playerid,CosasPorHacer[playerid][3], 0.460000, -2.000000);
	PlayerTextDrawColor(playerid,CosasPorHacer[playerid][3], -1);
	PlayerTextDrawSetOutline(playerid,CosasPorHacer[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid,CosasPorHacer[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid,CosasPorHacer[playerid][3], 1);
	PlayerTextDrawUseBox(playerid,CosasPorHacer[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid,CosasPorHacer[playerid][3], 255);
	PlayerTextDrawTextSize(playerid,CosasPorHacer[playerid][3], 10.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,CosasPorHacer[playerid][3], 0);

	//PlayerUserBox
	PlayerUserBox[playerid][0] = CreatePlayerTextDraw(playerid, 142.666778, 132.408950, "_");
	PlayerTextDrawLetterSize(playerid, PlayerUserBox[playerid][0], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, PlayerUserBox[playerid][0], 1);
	PlayerTextDrawColor(playerid, PlayerUserBox[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, PlayerUserBox[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, PlayerUserBox[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayerUserBox[playerid][0], 51);
	PlayerTextDrawFont(playerid, PlayerUserBox[playerid][0], 3);
	PlayerTextDrawSetProportional(playerid, PlayerUserBox[playerid][0], 1);

	PlayerUserBox[playerid][1] = CreatePlayerTextDraw(playerid, 144.888931, 177.208816, "_");
	PlayerTextDrawLetterSize(playerid, PlayerUserBox[playerid][1], 0.370000, 1.385955);
	PlayerTextDrawAlignment(playerid, PlayerUserBox[playerid][1], 1);
	PlayerTextDrawColor(playerid, PlayerUserBox[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, PlayerUserBox[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, PlayerUserBox[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayerUserBox[playerid][1], 51);
	PlayerTextDrawFont(playerid, PlayerUserBox[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, PlayerUserBox[playerid][1], 1);

    
   	//FadeScreen
	Background[playerid] = CreatePlayerTextDraw(playerid, 320, 0, "_");
    PlayerTextDrawUseBox(playerid, Background[playerid], 1);
    PlayerTextDrawLetterSize(playerid, Background[playerid], 1.0, 49.6);
    PlayerTextDrawTextSize(playerid, Background[playerid], 1.0, 640);
    PlayerTextDrawBoxColor(playerid, Background[playerid], 0x00000000);
    PlayerTextDrawAlignment(playerid, Background[playerid], 2);
    
    //Concepts
 	Conceptos[0][playerid] = CreatePlayerTextDraw(playerid, 641.531494, 1.500000, "usebox");
	PlayerTextDrawLetterSize(playerid, Conceptos[0][playerid], 0.000000, 49.396297);
	PlayerTextDrawTextSize(playerid, Conceptos[0][playerid], -2.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Conceptos[0][playerid], 1);
	PlayerTextDrawColor(playerid, Conceptos[0][playerid], 0);
	PlayerTextDrawUseBox(playerid, Conceptos[0][playerid], true);
	PlayerTextDrawBoxColor(playerid, Conceptos[0][playerid], 102);
	PlayerTextDrawSetShadow(playerid, Conceptos[0][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Conceptos[0][playerid], 0);
	PlayerTextDrawFont(playerid, Conceptos[0][playerid], 0);

	Conceptos[1][playerid] = CreatePlayerTextDraw(playerid, 498.632354, 138.000030, "usebox");
	PlayerTextDrawLetterSize(playerid, Conceptos[1][playerid], 0.000000, 17.183336);
	PlayerTextDrawTextSize(playerid, Conceptos[1][playerid], 143.241592, 0.000000);
	PlayerTextDrawAlignment(playerid, Conceptos[1][playerid], 1);
	PlayerTextDrawColor(playerid, Conceptos[1][playerid], 0);
	PlayerTextDrawUseBox(playerid, Conceptos[1][playerid], true);
	PlayerTextDrawBoxColor(playerid, Conceptos[1][playerid], -5963710);
	PlayerTextDrawSetShadow(playerid, Conceptos[1][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Conceptos[1][playerid], 0);
	PlayerTextDrawFont(playerid, Conceptos[1][playerid], 0);

	Conceptos[2][playerid] = CreatePlayerTextDraw(playerid, 146.647491, 137.666793, "Conceptos de ROL - PG");
	PlayerTextDrawLetterSize(playerid, Conceptos[2][playerid], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, Conceptos[2][playerid], 495.227416, -439.833343);
	PlayerTextDrawAlignment(playerid, Conceptos[2][playerid], 1);
	PlayerTextDrawColor(playerid, Conceptos[2][playerid], -1);
	PlayerTextDrawUseBox(playerid, Conceptos[2][playerid], true);
	PlayerTextDrawBoxColor(playerid, Conceptos[2][playerid], 255);
	PlayerTextDrawSetShadow(playerid, Conceptos[2][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Conceptos[2][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Conceptos[2][playerid], 51);
	PlayerTextDrawFont(playerid, Conceptos[2][playerid], 2);
	PlayerTextDrawSetProportional(playerid, Conceptos[2][playerid], 1);

	Conceptos[3][playerid] = CreatePlayerTextDraw(playerid, 150.395294, 160.416671, "a~n~a~n~a~n~a~n~a~n~a~n~a");
	PlayerTextDrawLetterSize(playerid, Conceptos[3][playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, Conceptos[3][playerid], 1);
	PlayerTextDrawColor(playerid, Conceptos[3][playerid], -1);
	PlayerTextDrawSetShadow(playerid, Conceptos[3][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Conceptos[3][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Conceptos[3][playerid], 51);
	PlayerTextDrawFont(playerid, Conceptos[3][playerid], 1);
	PlayerTextDrawSetProportional(playerid, Conceptos[3][playerid], 1);

    Conceptos[4][playerid] = CreatePlayerTextDraw(playerid, 195.841644, 266.583221, "~<~ Anterior");
	PlayerTextDrawLetterSize(playerid, Conceptos[4][playerid], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, Conceptos[4][playerid], 20, 80);
	PlayerTextDrawAlignment(playerid, Conceptos[4][playerid], 2);
	PlayerTextDrawColor(playerid, Conceptos[4][playerid], -1);
	PlayerTextDrawSetShadow(playerid, Conceptos[4][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Conceptos[4][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Conceptos[4][playerid], 51);
	PlayerTextDrawFont(playerid, Conceptos[4][playerid], 1);
	PlayerTextDrawSetProportional(playerid, Conceptos[4][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Conceptos[4][playerid], true);

	Conceptos[5][playerid] = CreatePlayerTextDraw(playerid, 429.697357, 266.999664, "Siguiente ~>~");
	PlayerTextDrawLetterSize(playerid, Conceptos[5][playerid], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, Conceptos[5][playerid], 20, 80);
	PlayerTextDrawAlignment(playerid, Conceptos[5][playerid], 2);
	PlayerTextDrawColor(playerid, Conceptos[5][playerid], -1);
	PlayerTextDrawSetShadow(playerid, Conceptos[5][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Conceptos[5][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Conceptos[5][playerid], 51);
	PlayerTextDrawFont(playerid, Conceptos[5][playerid], 1);
	PlayerTextDrawSetProportional(playerid, Conceptos[5][playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Conceptos[5][playerid], true);

	Conceptos[6][playerid] = CreatePlayerTextDraw(playerid, 300.790618, 270.666717, "1/10");
	PlayerTextDrawLetterSize(playerid, Conceptos[6][playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, Conceptos[6][playerid], 1);
	PlayerTextDrawColor(playerid, Conceptos[6][playerid], 16777215);
	PlayerTextDrawSetShadow(playerid, Conceptos[6][playerid], 0);
	PlayerTextDrawSetOutline(playerid, Conceptos[6][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Conceptos[6][playerid], 51);
	PlayerTextDrawFont(playerid, Conceptos[6][playerid], 3);
	PlayerTextDrawSetProportional(playerid, Conceptos[6][playerid], 1);
	
	TD_IO[playerid] = CreatePlayerTextDraw(playerid, 28.500000, 36.866592, "_~n~__Bienvenido a eXtreme Roleplay.~n~__Al parecer eres nuevo...~n~~n~__Complete el formulario para~n~__continuar.~n~~n~");
	PlayerTextDrawLetterSize(playerid, TD_IO[playerid], 0.259999, 1.212665);
	PlayerTextDrawTextSize(playerid, TD_IO[playerid], 184.000000, 39.000003);
	PlayerTextDrawAlignment(playerid, TD_IO[playerid], 1);
	PlayerTextDrawColor(playerid, TD_IO[playerid], -1);
	PlayerTextDrawUseBox(playerid, TD_IO[playerid], true);
	PlayerTextDrawBoxColor(playerid, TD_IO[playerid], 120);
	PlayerTextDrawSetShadow(playerid, TD_IO[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TD_IO[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, TD_IO[playerid], 51);
	PlayerTextDrawFont(playerid, TD_IO[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TD_IO[playerid], 1);
	
	//Banco
	PlayerBank[playerid][0] = CreatePlayerTextDraw(playerid, 514.777954, 74.675552, "Balance actual: 1992$");
	PlayerTextDrawLetterSize(playerid, PlayerBank[playerid][0], 0.314000, 1.306310);
	PlayerTextDrawAlignment(playerid, PlayerBank[playerid][0], 3);
	PlayerTextDrawColor(playerid, PlayerBank[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, PlayerBank[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, PlayerBank[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerBank[playerid][0], 51);
	PlayerTextDrawFont(playerid, PlayerBank[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, PlayerBank[playerid][0], 1);

	PlayerBank[playerid][1] = CreatePlayerTextDraw(playerid, 124.666900, 74.675552, "Miguel");
	PlayerTextDrawLetterSize(playerid, PlayerBank[playerid][1], 0.314000, 1.306310);
	PlayerTextDrawAlignment(playerid, PlayerBank[playerid][1], 1);
	PlayerTextDrawColor(playerid, PlayerBank[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, PlayerBank[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, PlayerBank[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, PlayerBank[playerid][1], 51);
	PlayerTextDrawFont(playerid, PlayerBank[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, PlayerBank[playerid][1], 1);
	
	BankCash[playerid] = CreatePlayerTextDraw(playerid, 607.999816, 98.559906, "$00000000");
	PlayerTextDrawLetterSize(playerid, BankCash[playerid], 0.551333, 2.182402);
	PlayerTextDrawTextSize(playerid, BankCash[playerid], 376.888885, -98.915557);
	PlayerTextDrawAlignment(playerid, BankCash[playerid], 3);
	PlayerTextDrawColor(playerid, BankCash[playerid], 7864319);
	PlayerTextDrawSetShadow(playerid, BankCash[playerid], 0);
	PlayerTextDrawSetOutline(playerid, BankCash[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, BankCash[playerid], 255);
	PlayerTextDrawFont(playerid, BankCash[playerid], 3);
	PlayerTextDrawSetProportional(playerid, BankCash[playerid], 1);
	
	
/*	PlayerInventarioTD[playerid][0] = CreatePlayerTextDraw(playerid, 221.333297, 149.831161, "Bebidas");
	PlayerTextDrawLetterSize(playerid, PlayerInventarioTD[playerid][0], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, PlayerInventarioTD[playerid][0], 7.111105, 107.022201);
	PlayerTextDrawAlignment(playerid, PlayerInventarioTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, PlayerInventarioTD[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, PlayerInventarioTD[playerid][0], true);
	PlayerTextDrawBoxColor(playerid, PlayerInventarioTD[playerid][0], 41215);
	PlayerTextDrawSetShadow(playerid, PlayerInventarioTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, PlayerInventarioTD[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayerInventarioTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, PlayerInventarioTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, PlayerInventarioTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerInventarioTD[playerid][0], true);

	PlayerInventarioTD[playerid][1] = CreatePlayerTextDraw(playerid, 221.333297, 168.253387, "Comida");
	PlayerTextDrawLetterSize(playerid, PlayerInventarioTD[playerid][1], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, PlayerInventarioTD[playerid][1], 7.111105, 107.022201);
	PlayerTextDrawAlignment(playerid, PlayerInventarioTD[playerid][1], 2);
	PlayerTextDrawColor(playerid, PlayerInventarioTD[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, PlayerInventarioTD[playerid][1], true);
	PlayerTextDrawBoxColor(playerid, PlayerInventarioTD[playerid][1], -1378294017);
	PlayerTextDrawSetShadow(playerid, PlayerInventarioTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, PlayerInventarioTD[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayerInventarioTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, PlayerInventarioTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, PlayerInventarioTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerInventarioTD[playerid][1], true);

	PlayerInventarioTD[playerid][2] = CreatePlayerTextDraw(playerid, 221.333297, 186.177673, "Gorros");
	PlayerTextDrawLetterSize(playerid, PlayerInventarioTD[playerid][2], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, PlayerInventarioTD[playerid][2], 7.111105, 107.022201);
	PlayerTextDrawAlignment(playerid, PlayerInventarioTD[playerid][2], 2);
	PlayerTextDrawColor(playerid, PlayerInventarioTD[playerid][2], -1);
	PlayerTextDrawUseBox(playerid, PlayerInventarioTD[playerid][2], true);
	PlayerTextDrawBoxColor(playerid, PlayerInventarioTD[playerid][2], -1378294017);
	PlayerTextDrawSetShadow(playerid, PlayerInventarioTD[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, PlayerInventarioTD[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayerInventarioTD[playerid][2], 255);
	PlayerTextDrawFont(playerid, PlayerInventarioTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, PlayerInventarioTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerInventarioTD[playerid][2], true);

	PlayerInventarioTD[playerid][3] = CreatePlayerTextDraw(playerid, 221.333297, 204.101974, "Cara");
	PlayerTextDrawLetterSize(playerid, PlayerInventarioTD[playerid][3], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, PlayerInventarioTD[playerid][3], 7.111105, 107.022201);
	PlayerTextDrawAlignment(playerid, PlayerInventarioTD[playerid][3], 2);
	PlayerTextDrawColor(playerid, PlayerInventarioTD[playerid][3], -1);
	PlayerTextDrawUseBox(playerid, PlayerInventarioTD[playerid][3], true);
	PlayerTextDrawBoxColor(playerid, PlayerInventarioTD[playerid][3], -1378294017);
	PlayerTextDrawSetShadow(playerid, PlayerInventarioTD[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, PlayerInventarioTD[playerid][3], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayerInventarioTD[playerid][3], 255);
	PlayerTextDrawFont(playerid, PlayerInventarioTD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, PlayerInventarioTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerInventarioTD[playerid][3], true);

	PlayerInventarioTD[playerid][4] = CreatePlayerTextDraw(playerid,221.333297, 222.524108, "Otros");
	PlayerTextDrawLetterSize(playerid, PlayerInventarioTD[playerid][4], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, PlayerInventarioTD[playerid][4], 7.111105, 107.022201);
	PlayerTextDrawAlignment(playerid, PlayerInventarioTD[playerid][4], 2);
	PlayerTextDrawColor(playerid, PlayerInventarioTD[playerid][4], -1);
	PlayerTextDrawUseBox(playerid, PlayerInventarioTD[playerid][4], true);
	PlayerTextDrawBoxColor(playerid, PlayerInventarioTD[playerid][4], -1378294017);
	PlayerTextDrawSetShadow(playerid, PlayerInventarioTD[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, PlayerInventarioTD[playerid][4], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayerInventarioTD[playerid][4], 255);
	PlayerTextDrawFont(playerid, PlayerInventarioTD[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, PlayerInventarioTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerInventarioTD[playerid][4], true);

	PlayerInventarioTD[playerid][5] = CreatePlayerTextDraw(playerid, 380.444580, 149.831161, "inv1");
	PlayerTextDrawLetterSize(playerid, PlayerInventarioTD[playerid][5], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, PlayerInventarioTD[playerid][5], 20.000000, 200.106567);
	PlayerTextDrawAlignment(playerid, PlayerInventarioTD[playerid][5], 2);
	PlayerTextDrawColor(playerid, PlayerInventarioTD[playerid][5], -1);
	PlayerTextDrawUseBox(playerid, PlayerInventarioTD[playerid][5], true);
	PlayerTextDrawBoxColor(playerid, PlayerInventarioTD[playerid][5], -1378294017);
	PlayerTextDrawSetShadow(playerid, PlayerInventarioTD[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, PlayerInventarioTD[playerid][5], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayerInventarioTD[playerid][5], 255);
	PlayerTextDrawFont(playerid, PlayerInventarioTD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, PlayerInventarioTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerInventarioTD[playerid][5], true);

	PlayerInventarioTD[playerid][6] = CreatePlayerTextDraw(playerid, 380.444580, 168.253387, "inv2");
	PlayerTextDrawLetterSize(playerid, PlayerInventarioTD[playerid][6], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, PlayerInventarioTD[playerid][6], 20.000000, 200.106567);
	PlayerTextDrawAlignment(playerid, PlayerInventarioTD[playerid][6], 2);
	PlayerTextDrawColor(playerid, PlayerInventarioTD[playerid][6], -1);
	PlayerTextDrawUseBox(playerid, PlayerInventarioTD[playerid][6], true);
	PlayerTextDrawBoxColor(playerid, PlayerInventarioTD[playerid][6], -1378294017);
	PlayerTextDrawSetShadow(playerid, PlayerInventarioTD[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, PlayerInventarioTD[playerid][6], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayerInventarioTD[playerid][6], 255);
	PlayerTextDrawFont(playerid, PlayerInventarioTD[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, PlayerInventarioTD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerInventarioTD[playerid][6], true);

	PlayerInventarioTD[playerid][7] = CreatePlayerTextDraw(playerid, 380.444580, 186.177673, "inv3");
	PlayerTextDrawLetterSize(playerid, PlayerInventarioTD[playerid][7], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, PlayerInventarioTD[playerid][7], 20.000000, 200.106567);
	PlayerTextDrawAlignment(playerid, PlayerInventarioTD[playerid][7], 2);
	PlayerTextDrawColor(playerid, PlayerInventarioTD[playerid][7], -1);
	PlayerTextDrawUseBox(playerid, PlayerInventarioTD[playerid][7], true);
	PlayerTextDrawBoxColor(playerid, PlayerInventarioTD[playerid][7], -1378294017);
	PlayerTextDrawSetShadow(playerid, PlayerInventarioTD[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, PlayerInventarioTD[playerid][7], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayerInventarioTD[playerid][7], 255);
	PlayerTextDrawFont(playerid, PlayerInventarioTD[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, PlayerInventarioTD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerInventarioTD[playerid][7], true);

	PlayerInventarioTD[playerid][8] = CreatePlayerTextDraw(playerid, 380.444580, 204.101974, "inv4");
	PlayerTextDrawLetterSize(playerid, PlayerInventarioTD[playerid][8], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, PlayerInventarioTD[playerid][8], 20.000000, 200.106567);
	PlayerTextDrawAlignment(playerid, PlayerInventarioTD[playerid][8], 2);
	PlayerTextDrawColor(playerid, PlayerInventarioTD[playerid][8], -1);
	PlayerTextDrawUseBox(playerid, PlayerInventarioTD[playerid][8], true);
	PlayerTextDrawBoxColor(playerid, PlayerInventarioTD[playerid][8], -1378294017);
	PlayerTextDrawSetShadow(playerid, PlayerInventarioTD[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, PlayerInventarioTD[playerid][8], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayerInventarioTD[playerid][8], 255);
	PlayerTextDrawFont(playerid, PlayerInventarioTD[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, PlayerInventarioTD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerInventarioTD[playerid][8], true);

	PlayerInventarioTD[playerid][9] = CreatePlayerTextDraw(playerid, 380.444580, 222.524108, "inv5");
	PlayerTextDrawLetterSize(playerid, PlayerInventarioTD[playerid][9], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, PlayerInventarioTD[playerid][9], 20.000000, 200.106567);
	PlayerTextDrawAlignment(playerid, PlayerInventarioTD[playerid][9], 2);
	PlayerTextDrawColor(playerid, PlayerInventarioTD[playerid][9], -1);
	PlayerTextDrawUseBox(playerid, PlayerInventarioTD[playerid][9], true);
	PlayerTextDrawBoxColor(playerid, PlayerInventarioTD[playerid][9], -1378294017);
	PlayerTextDrawSetShadow(playerid, PlayerInventarioTD[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, PlayerInventarioTD[playerid][9], 1);
	PlayerTextDrawBackgroundColor(playerid, PlayerInventarioTD[playerid][9], 255);
	PlayerTextDrawFont(playerid, PlayerInventarioTD[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, PlayerInventarioTD[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerInventarioTD[playerid][9], true);*/
	return 1;
}

stock simbolos(string[])
{
    new
        szFixed[1024],
        iPos,
        iLen;

    for (iLen = strlen(string); iPos < iLen; iPos ++)
    switch (string[iPos])
    {
        case 'à':   szFixed[iPos] = 151;
        case 'á':   szFixed[iPos] = 152;
        case 'â':   szFixed[iPos] = 153;
        case 'ä':   szFixed[iPos] = 154;
        case 'À':   szFixed[iPos] = 128;
        case 'Á':   szFixed[iPos] = 129;
        case 'Â':   szFixed[iPos] = 130;
        case 'Ä':   szFixed[iPos] = 131;
        case 'è':   szFixed[iPos] = 157;
        case 'é':   szFixed[iPos] = 158;
        case 'ê':   szFixed[iPos] = 159;
        case 'ë':   szFixed[iPos] = 160;
        case 'È':   szFixed[iPos] = 134;
        case 'É':   szFixed[iPos] = 135;
        case 'Ê':   szFixed[iPos] = 136;
        case 'Ë':   szFixed[iPos] = 137;
        case 'ì':   szFixed[iPos] = 161;
        case 'í':   szFixed[iPos] = 162;
        case 'î':   szFixed[iPos] = 163;
        case 'ï':   szFixed[iPos] = 164;
        case 'Ì':   szFixed[iPos] = 138;
        case 'Í':   szFixed[iPos] = 139;
        case 'Î':   szFixed[iPos] = 140;
        case 'Ï':   szFixed[iPos] = 141;
        case 'ò':   szFixed[iPos] = 165;
        case 'ó':   szFixed[iPos] = 166;
        case 'ô':   szFixed[iPos] = 167;
        case 'ö':   szFixed[iPos] = 168;
        case 'Ò':   szFixed[iPos] = 142;
        case 'Ó':   szFixed[iPos] = 143;
        case 'Ô':   szFixed[iPos] = 144;
        case 'Ö':   szFixed[iPos] = 145;
        case 'ù':   szFixed[iPos] = 169;
        case 'ú':   szFixed[iPos] = 170;
        case 'û':   szFixed[iPos] = 171;
        case 'ü':   szFixed[iPos] = 172;
        case 'Ù':   szFixed[iPos] = 146;
        case 'Ú':   szFixed[iPos] = 147;
        case 'Û':   szFixed[iPos] = 148;
        case 'Ü':   szFixed[iPos] = 149;
        case 'ñ':   szFixed[iPos] = 174;
        case 'Ñ':   szFixed[iPos] = 173;
        case '¡':   szFixed[iPos] = 64;
        case '¿':   szFixed[iPos] = 175;
        case '`':   szFixed[iPos] = 177;
        case '&':   szFixed[iPos] = 38;
        default:    szFixed[iPos] = string[iPos];
    }
    return szFixed;
}

stock GetPlayerCameraLookAt(playerid, &Float:X, &Float:Y, &Float:Z)
{
    new Float:pos[6];
    GetPlayerCameraPos(playerid, pos[0], pos[1], pos[2]);
    GetPlayerCameraFrontVector(playerid, pos[3], pos[4], pos[5]);
    X = floatadd(pos[0], pos[3]);
    Y = floatadd(pos[1], pos[4]);
    Z = floatadd(pos[2], pos[5]);
    return 1;
}

stock UserPath(playerid)
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), PATH, playername);
    return string;
}

stock UserPatx(playerid)
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), PATX, playername);
    return string;
}

stock UpdateUserData(playerid)
{
 	new Query[750], Float:p[4], Float:ha[2], name[MAX_PLAYER_NAME], str[700], str2[400];
 	GetPlayerName(playerid, name, sizeof(name));
    GetPlayerHealth(playerid, ha[0]);
    GetPlayerArmour(playerid, ha[1]);
    GetPlayerPos(playerid, p[0], p[1], p[2]);
    GetPlayerFacingAngle(playerid, p[3]);
    format(Query, sizeof(Query), "UPDATE `USERS` SET ");
    format(str, 700, "`POSX` = '%f', `POSY` = '%f', `POSZ` = '%f', `ANGLE` = '%f', `INTERIORID` = '%d', `BR` = '%d', `EMAIL` = '%s', `DINERO` = '%d', `DINEROBANK` = '%d', `SEXO` = '%d', `EDAD` = '%d', \
	`SKIN` = '%d', `VIDA` = '%f', `CHALECO` = '%f', `ADMLVL` = '%d', `PHONENUMBER` = '%d', `INTERIOR` = '%d', `BANKA` = '%d', `VBANK` = '%d', `VGROTTI` = '%d', `V247` = '%d', `VROPA` = '%d', `VFOOD` = '%d', `DUDE` = '%d', `WORK` = '%d', `LVL` = '%d',",
	p[0], p[1], p[2], p[3], GetPlayerInterior(playerid), PlayerInfo[playerid][bikerent], PlayerInfo[playerid][email], PlayerInfo[playerid][dinero], PlayerInfo[playerid][dinerobank], PlayerInfo[playerid][sexo],
	PlayerInfo[playerid][edad], GetPlayerSkin(playerid), ha[0], ha[1], PlayerInfo[playerid][admlvl], PlayerInfo[playerid][phonenumber], PlayerInfo[playerid][Interior], PlayerInfo[playerid][BankA], PlayerInfo[playerid][VBank], PlayerInfo[playerid][VGrotti], PlayerInfo[playerid][V247], PlayerInfo[playerid][VRopa], PlayerInfo[playerid][VComida], PlayerInfo[playerid][DudeChannel], PlayerInfo[playerid][Work], PlayerInfo[playerid][Plevel]);
 	format(str2, 400, " `VEH0` = '%d', `VEH1` = '%d', `VEH2` = '%d', `VEH3` = '%d', `VKEY0` = '%d', `VKEY1` = '%d', `VKEY2` = '%d', `VKEY3` = '%d' WHERE `NAME` = '%s'", PlayerInfo[playerid][PlayerVehicle][0], PlayerInfo[playerid][PlayerVehicle][1], PlayerInfo[playerid][PlayerVehicle][2], PlayerInfo[playerid][PlayerVehicle][3], PlayerInfo[playerid][PlayerVehicleKey][0], PlayerInfo[playerid][PlayerVehicleKey][1], PlayerInfo[playerid][PlayerVehicleKey][2], PlayerInfo[playerid][PlayerVehicleKey][3], name);
 	strcat(str, str2);
	strcat(Query, str);
	db_query(Database, Query);
	return 1;
}

stock PlayerNameNormal(playerid)
{
    new name[24];
    GetPlayerName(playerid, name, MAX_PLAYER_NAME);
    return name;
}

stock EmailAvaliable(femail[])
{
	new str[128];
	format(str, 128, "/eXtremeROL/emails/%s.ini", femail);
	if(fexist(str))
	{
	    return false;
	}
	else
	{
	    return true;
	}
}

funcion:LoadUserData(playerid)
{
	TogglePlayerSpectating(playerid, false);
	SpawnPlayer(playerid);
    
    if(fexist(UserPatx(playerid)))
    {
	    new string[24];
	    new File:example = fopen(UserPatx(playerid), io_read);
	    while(fread(example, string))
	    {
			StripNewLine(string);
	        foreach(new i : Player)
		    {
		        if(!strcmp(PlayerNameNormal(i), string))
		        {
		            PlayerKnownPlayer[playerid][i] = true;
		            PlayerKnownPlayer[i][playerid] = true;
		        }
		        else
		        {
		            PlayerKnownPlayer[playerid][i] = false;
		            PlayerKnownPlayer[i][playerid] = false;
		        }
		    }
		}
	    fclose(example);
	}
 	else
	{
		foreach(new i : Player)
		{
			PlayerKnownPlayer[playerid][i] = false;
			PlayerKnownPlayer[i][playerid] = false;
		}
	}
	PlayerKnownPlayer[playerid][playerid] = 1;
	new name[24];
    GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	for(new i = 0; i != MAX_VEHICLES; i ++)
	{
	    if(IsValidVehicle(i))
	    {
			if(!isnull(VehicleInfo[i][VD]))
			{
			    if(!strcmp(name, VehicleInfo[i][VD], false))
			    {
			        PlayerInfo[playerid][PlayerVehicle][VehicleInfo[i][slot]] = i;
			        PlayerInfo[playerid][PlayerVehicleKey][VehicleInfo[i][slot]] = VehicleInfo[i][VKEY];
			        KillTimer(DestroyVehiclesTimer[i]);
			    }
			}
		}
	}
	LoadPlayerCar(playerid);
	return 1;
}

stock PlayerName(playerid) // Función para coger el nombre de un player y borrar el "_"
{
    new n[24],
	str[24];
	GetPlayerName(playerid, n, 24); strmid(str, n, 0, strlen(n), 24);
    for(new i = 0; i < MAX_PLAYER_NAME; i++) {
		if (str[i] == '_') str[i] = ' ';
	}
    return str;
}

stock FirstName(playerid)
{
    new n[24],
        iCh;
	GetPlayerName(playerid, n, 24); 
    iCh = strfind(n, "_", true);
    strdel(n, iCh, strlen(n));
    return n;
}

// --------> Comandos

CMD:dj(playerid, params[])
{
	
	switch(strval(params))
	{
	case 1: ApplyAnimation(playerid, "SCRATCHING", "scdldlp", 4.0, 1, 0, 0, 0, 0, 1);
	case 2: ApplyAnimation(playerid, "SCRATCHING", "scdlulp", 4.0, 1, 0, 0, 0, 0, 1);
	case 3: ApplyAnimation(playerid, "SCRATCHING", "scdrdlp", 4.0, 1, 0, 0, 0, 0, 1);
	case 4: ApplyAnimation(playerid, "SCRATCHING", "scdrulp", 4.0, 1, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, -1, "USAGE: /dj [1-4]");
	}
	return 1;
}

CMD:bar(playerid, params[])
{

	switch(strval(params))
	{
	case 1: ApplyAnimation(playerid, "BAR", "Barcustom_get", 4.0, 0, 0, 0, 0, 0, 1);
	case 2: ApplyAnimation(playerid, "BAR", "Barcustom_loop", 4.0, 0, 0, 0, 0, 0, 1);
	case 3: ApplyAnimation(playerid, "BAR", "Barcustom_order", 4.0, 0, 0, 0, 0, 0, 1);
	case 4: ApplyAnimation(playerid, "BAR", "BARman_idle", 4.0, 0, 0, 0, 0, 0, 1);
	case 5: ApplyAnimation(playerid, "BAR", "Barserve_bottle", 4.0, 0, 0, 0, 0, 0, 1);
	case 6: ApplyAnimation(playerid, "BAR", "Barserve_give", 4.0, 0, 0, 0, 0, 0, 1);
	case 7: ApplyAnimation(playerid, "BAR", "Barserve_glass", 4.0, 0, 0, 0, 0, 0, 1);
	case 8: ApplyAnimation(playerid, "BAR", "Barserve_in", 4.0, 1, 0, 0, 0, 0, 1);
	case 9: ApplyAnimation(playerid, "BAR", "Barserve_loop", 4.0, 0, 0, 0, 0, 0, 1);
	case 10: ApplyAnimation(playerid, "BAR", "Barserve_order", 4.0, 0, 0, 0, 0, 0, 1);
	case 11: ApplyAnimation(playerid, "BAR", "dnk_stndF_loop", 4.0, 0, 0, 0, 0, 0, 1);
	case 12: ApplyAnimation(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 0, 0, 0, 0, 1);
	default: SendClientMessage(playerid, -1, "USAGE: /dj [1-4]");
	}
	return 1;
}

CMD:st(playerid, params[])
{
	ServerTime = 0;
	SetWorldTime(0);
	return 1;
}

CMD:d(playerid, params[])
{
    if(isnull(params)) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} /d [duda]");
    if(ChatLogDisabled[playerid]) return 1;
   	if(PlayerInfo[playerid][DudeChannel] == 0) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}Tienes el canal de dudas desactivado. Puedes activarlo con el comando{00CCFF}/cduda.");

    if(DudeTime[playerid] > GetTickCount())
    {
		new Float:tiempo = floatdiv(floatsub(DudeTime[playerid], GetTickCount()), 60000);
		SendClientMessageEx(playerid, -1, "Debe de esperar {FFFF00}%.2f {FFFFFF}minuto(s) para volver a publicar otra duda.", tiempo);
		return 1;
	}

	new string[542];
	strcat(string, ""GREEN"Al usar el canal te comprometeras a aceptar las siguientes reglas:\n\n");
	strcat(string, "\t{00CCFF}1. En este canal solo podrás publicar dudas respecto del servidor (gamemode)\n");
	strcat(string, "\t{00CCFF}2. Este es un canal que puedes activar/desactivar en el /menu principal, en ajustes\n");
	strcat(string, "\t{00CCFF}3. Si publicas un mensaje que no tiene nada que ver con una duda, puedes ser advertido\n");
	strcat(string, "\t{00CCFF}4. Cuando publiques una duda, los otros jugadores te la podrán responder\n");
	strcat(string, "\t{00CCFF}5. Tan solo se puede publicar una duda cada 1 minuto(s)\n\n");
	strcat(string, ""YELLOW"¿Estás seguro de publicar la duda?");

	ShowPlayerDialog(playerid, DIALOG_DUDAS, DIALOG_STYLE_MSGBOX, "Canal de dudas", string, "Continuar", "Cerrar");
	format(DudeMsg[playerid], 128, "%s", params);
	return 1;
}

CMD:cduda(playerid, params[])
{
    if(PlayerInfo[playerid][DudeChannel] == 0)
    {
        PlayerInfo[playerid][DudeChannel] = 1;
        SendClientMessage(playerid, -1, "Canal de dudas {00CCFF}activado.");
    }
    else
    {
        PlayerInfo[playerid][DudeChannel] = 0;
        SendClientMessage(playerid, -1, "Canal de dudas {00CCFF}desactivado.");
    }
	return 1;
}

CMD:rostro(playerid, params[])
{
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
 		if(!sscanf(params, "d", params[0]))
		{
		    switch(params[0])
		    {
		        case 1: ApplyAnimation(playerid,"PED","facanger",3.0,1,1,1,1,1);
		        case 2: ApplyAnimation(playerid,"PED","facgum",3.0,1,1,1,1,1);
		        case 3: ApplyAnimation(playerid,"PED","facsurp",3.0,1,1,1,1,1);
		        case 4: ApplyAnimation(playerid,"PED","facsurpm",3.0,1,1,1,1,1);
		        case 5: ApplyAnimation(playerid,"PED","factalk",3.0,1,1,1,1,1);
		        case 6: ApplyAnimation(playerid,"PED","facurios",3.0,1,1,1,1,1);
		        default: SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} /rostro [1-6]");
      		}
		}
		else SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} /rostro [1-6]");
	}
	return 1;
}

CMD:borracho(playerid, params[])
{
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		ApplyAnimation(playerid,"PED", "WALK_DRUNK",4.0,1,1,1,1,500);
	}
	return 1;
}

CMD:hablar(playerid, params[])
{
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		ApplyAnimation(playerid,"PED","IDLE_chat",4.1,7,5,1,1,1);
	}
	return 1;
}

CMD:masturbar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		ApplyAnimation(playerid, "PAULNMAC", "wank_loop", 4.0, 1, 0, 0, 1, 0);
	}
	return SendClientMessage(playerid, -1, "Para continuar utiliza /masturbarend");
}

CMD:masturbarend(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid, "PAULNMAC", "wank_out", 4.0, 0, 0, 0, 0, 0);
	}
	return 1;
}

CMD:arrestado(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		ApplyAnimation( playerid,"ped", "ARRESTgun", 4.0, 0, 1, 1, 1,500);
	}
	return 1;
}

CMD:amenazar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 0, 0, 0, 1,500);
	}
	return 1;
}

CMD:reirse(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0,0);
	}
}

CMD:agredido(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
		ApplyAnimation(playerid, "POLICE", "crm_drgbst_01", 4.0, 0, 0, 0, 1, 0);
	}
	return 1;
}

CMD:herido(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		ApplyAnimation(playerid, "SWEET", "LaFin_Sweet", 4.0, 0, 1, 1, 1, 0);
		SendClientMessage(playerid, -1, "Para continuar utiliza /agonizar");
	}
	return 1;
}

CMD:asustado(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid,"PED","handscower",4.1,0,1,1,1,1);
	}
	return 1;
}

CMD:dolorido(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		ApplyAnimation(playerid,"PED","KO_shot_stom",4.1,0,1,1,1,1);
	}
	return 1;
}

CMD:vigilar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 1, 1, 1, 0, 4000);
	}
	return 1;
}

CMD:tumbarse(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		ApplyAnimation(playerid,"SUNBATHE", "Lay_Bac_in", 4.0, 0, 0, 0, 1, 0);
	}
	return 1;
}

CMD:cubrirse(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid, "ped", "cower", 4.0, 1, 0, 0, 0, 0);
	}
	return 1;
}

CMD:vomitar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0);
	}
	return 1;
}

CMD:agonizar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid, "WUZI", "CS_Dead_Guy", 4.0, 0, 0, 0, 1, 0);
	}
	return 1;
}

CMD:levantarse(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid, "ped", "getup_front", 4.000000, 0, 0, 0, 0, 0);
	}
	return 1;
}

CMD:rodar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid,"MD_CHASE","MD_HANG_Lnd_Roll",4.1,0,1,1,1,0);
	}
	return 1;
}

CMD:traficar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0);
	}
	return 1;
}

CMD:beso(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid, "KISSING", "Playa_Kiss_02", 4.0, 0, 0, 0, 0, 0);
	}
	return 1;
}

CMD:sentarse(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		ApplyAnimation(playerid, "SUNBATHE", "ParkSit_M_in", 4.000000, 0, 1, 1, 1, 0);
	}
	return 1;
}

CMD:stop(playerid, params[])
{
	ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1);
	return 1;
}

CMD:depie(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid, "ped", "SEAT_up", 4.0, 0, 0, 1, 0, 0, 0);
	}
	return 1;
}

CMD:peineta(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation( playerid,"ped", "fucku", 4.0, 0, 1, 1, 1, 1 );
	}
	return 1;
}

CMD:siquiero(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid, "GANGS", "Invite_Yes", 4.0, 0, 0, 0, 0, 0);
	}
	return 1;
}

CMD:noquiero(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid, "GANGS", "Invite_No", 4.0, 0, 0, 0, 0, 0);
	}
	return 1;
}

CMD:comerciar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid, "DEALER", "shop_pay", 4.000000, 0, 1, 1, 0, 0);
	}
	return 1;
}

CMD:piquero(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid, "DAM_JUMP", "DAM_Launch", 4.0, 0, 1, 1, 1, 1);
	}
	return 1;
}

CMD:taichi(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid, "PARK", "Tai_Chi_Loop",  4.1,7,5,1,1,1);
	}
	return 1;
}

CMD:boxear(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid, "GYMNASIUM", "gym_shadowbox",  4.1,7,5,1,1,1);
	}
	return 1;
}

CMD:fuerza(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid,"benchpress","gym_bp_celebrate",4.1,0,1,1,1,1);
	}
	return 1;
}

CMD:curar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid,"MEDIC","CPR",4.1,0,0,0,0,0);
	}
	return 1;
}

CMD:llorar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid,"GRAVEYARD","mrnF_loop",4.1,0,0,0,0,0);
	}
	return 1;
}

CMD:dormir(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid,"INT_HOUSE","BED_In_R",4.1,0,0,0,1,0);
	}
	return 1;
}

CMD:detener(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid,"POLICE","CopTraf_Stop",4.1,0,0,0,0,0);
	}
	return 1;
}

CMD:rapear(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid,"RAPPING","RAP_B_Loop",4.0,1,0,0,0,8000);
	}
	return 1;
}

CMD:alzar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid,"GHANDS","gsign2LH",4.1,0,1,1,1,1);
	}
	return 1;
}

CMD:sapiar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid,"PED","roadcross_female",4.1,0,0,0,0,0);
	}
	return 1;
}

CMD:asiento(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid, "ped", "SEAT_down", 4.0, 0, 0, 0, 1, 0, 0);
	}
	return 1;
}

CMD:pensar(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid,"COP_AMBIENT","Coplook_think",4.1,0,0,0,0,0);
	}
	return 1;
}

CMD:taxi(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid,"PED","IDLE_taxi",4.1,0,1,1,1,1);
	}
	return 1;
}

CMD:seacabo(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid,"PED","Shove_Partial",4.1,0,1,1,1,1);
	}
	return 1;
}

CMD:sorprenderse(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid,"ON_LOOKERS","shout_02",4.1,7,5,1,1,1);
	}
	return 1;
}

CMD:quepasa(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid,"GHANDS","gsign1LH",4.1,0,1,1,1,1);
	}
	return 1;
}

CMD:comodo(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
	    ApplyAnimation(playerid,"INT_HOUSE","LOU_In",4.1,0,1,1,1,1);
	}
	return 1;
}

CMD:bailar(playerid, params[])
{
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
 		if(!sscanf(params, "d", params[0]))
		{
		    switch(params[0])
		    {
		        case 1: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
		        case 2: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
		        case 3: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
		        case 4: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
		        default: SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} /bailar [1-4]");
      		}
		}
		else SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} /bailar [1-4]");
	}
	return 1;
}

CMD:conocer(playerid, params[])
{
	if(sscanf(params, "d", params[0])) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} /conocer [playerid]");
	if(IsKnowPlayer(playerid, params[0])) return SendClientMessageEx(playerid, -1, "{FF0000}ERROR: {FFFFFF} Ya conoces a {00CCFF}%s", PlayerName(params[0]));
	if(PlayerNearPlayer(playerid, params[0], 1.0))
	{
	    new str[128];
	    format(str, 128, "{00CCFF}%s {FFFFFF}te quiere conocer.\n\n\t¿Aceptas la invitación?", PlayerName(playerid));
	    P_conocerid[playerid] = params[0];
	    P_conocerid[params[0]] = playerid;
	    ShowPlayerDialog(params[0], DIALOG_KNOW, DIALOG_STYLE_MSGBOX, " ", str, "Conocer", "Ignorar");
	}
	return 1;
}

CMD:llamar(playerid, params[])
{
    if(strlen(params) > 9) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} número erroneo");
    if(UsingPhone[playerid] != 0) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} ya estás en una llamada telefónica");
    if(sscanf(params, "d", params[0])) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} /llamar [número]");
    if(params[0] == 0) return  SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} número erroneo");
	if(PlayerInfo[playerid][phonenumber] == 0)
	{
	    if(params[0] == 333)
	    {
			ShowPlayerPhone(playerid, simbolos("Atención al clnt."), "Estableciendo llamada");
		    MyTimers[playerid][15] = SetTimerEx("MyPhoneContinue", 5000, false, "idi", playerid, 1, -1);
		    PlayerPlaySound(playerid, 3600, 0, 0, 0);
		    UsingPhone[playerid] = 2;
		    NumeroMarcado[playerid] = -1;
	        return 1;
	    }
	    new str[10];
	    format(str, 10, "%d", params[0]);
	    ShowPlayerPhone(playerid, str, "Fuera de cobertura");
	    
	    SendClientMessage(playerid, -1, "Tu telefóno móvil no funciona aún. Debes de activar tu tarjeta llamando al {00CCFF}333.");
	    MyTimers[playerid][15] = SetTimerEx("MyPhoneContinue", 2000, false, "idi", playerid, 0, -1);
	    UsingPhone[playerid] = 2;
	    NumeroMarcado[playerid] = -1;
	    return 1;
	}
	if(PlayerInfo[playerid][phonenumber] == params[0]) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} número erroneo");
	PlayerPlaySound(playerid, 3600, 0, 0, 0);
	foreach(new i : Player)
	{
		if(PlayerInfo[i][phonenumber] == params[0])
		{
		    if(IsKnowPlayer(playerid, i))
		    {
		        new str[10];
			    format(str, 10, "%s", FirstName(i));
			    ShowPlayerPhone(playerid, str, "Estableciendo llamada");
		    }
		    else
		    {
			    new str[10];
			    format(str, 10, "%d", params[0]);
			    ShowPlayerPhone(playerid, str, "Estableciendo llamada");
			}
		    UsingPhone[playerid] = 2;
		    NumeroMarcado[playerid] = i;
		    MyTimers[playerid][15] = SetTimerEx("MyPhoneContinue", 3000, false, "idi", playerid, 2, i);
		    return 1;
		}
	}

    new str[64];
    format(str, 64, "%d", params[0]);
    ShowPlayerPhone(playerid, str, "Estableciendo llamada");
    
    MyTimers[playerid][15] = SetTimerEx("MyPhoneContinue", 3000, false, "idi", playerid, 3, -1);
    UsingPhone[playerid] = 2;
    NumeroMarcado[playerid] = -1;
	return 1;
}

CMD:ayuda(playerid, params[])
{
	loop(0, 12, a) TextDrawShowForPlayer(playerid, CircularMenu[a]);
	SendClientMessage(playerid, -1, "Usa {00CCFF}'ESC' {FFFFFF}para cerrar la ventana");
	P_circularmenu_active[playerid] = 1;
	SelectTextDraw(playerid, -1);
	if(PlayerInfo[playerid][BankA] != 0) ShowBankCash(playerid, 0);
	return 1;
}

CMD:empezar(playerid, params[])
{
	P_circularmenu_active[playerid] = 3;
    loop(0, 12, a) TextDrawHideForPlayer(playerid, CircularMenu[a]);
    TextDrawShowForPlayer(playerid, UserBox[0]);
    TextDrawShowForPlayer(playerid, UserBox[1]);
    TextDrawShowForPlayer(playerid, UserBox[2]);
    TextDrawShowForPlayer(playerid, UserBox[3]);
	SelectTextDraw(playerid, -1);
	SendClientMessage(playerid, -1, "Usa {00CCFF}'ESC' {FFFFFF}para cerrar la ventana");
    PlayerTextDrawSetString(playerid, PlayerUserBox[playerid][0], simbolos("Cosas básicas que hacer"));
    PlayerTextDrawShow(playerid, PlayerUserBox[playerid][0]);
    PlayerTextDrawShow(playerid, PlayerUserBox[playerid][1]);

    PlayerTextDrawSetString(playerid, PlayerUserBox[playerid][1], simbolos("Activar número telefónico~n~Crear una cuenta bancaria~n~Conseguir un trabajo~n~Comprar algo de comida"));
    
    if(PlayerInfo[playerid][phonenumber] == 0) PlayerTextDrawSetString(playerid, CosasPorHacer[playerid][0], "ld_chat:thumbdn");
    else PlayerTextDrawSetString(playerid, CosasPorHacer[playerid][0], "ld_chat:thumbup");
    
    if(PlayerInfo[playerid][BankA] == 0) PlayerTextDrawSetString(playerid, CosasPorHacer[playerid][1], "ld_chat:thumbdn");
    else PlayerTextDrawSetString(playerid, CosasPorHacer[playerid][1], "ld_chat:thumbup");
    
    if(PlayerInfo[playerid][Work] == 0) PlayerTextDrawSetString(playerid, CosasPorHacer[playerid][2], "ld_chat:thumbdn");
    else PlayerTextDrawSetString(playerid, CosasPorHacer[playerid][2], "ld_chat:thumbup");
    
    PlayerTextDrawSetString(playerid, CosasPorHacer[playerid][3], "ld_chat:thumbdn");
    loop(0, 4, l) PlayerTextDrawShow(playerid, CosasPorHacer[playerid][l]);
    return 1;
}

CMD:b(playerid, params[])
{
    if(isnull(params)) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} /b [CHAT OOC]");
    new str[145];
    format(str, sizeof(str), "ID: %d | %s: (( %s ))", playerid, PlayerName(playerid), params);
    SendPlayersMessage(10.0, playerid, 0x00F090FF, str, str);
	return 1;
}

CMD:do(playerid, params[])
{
    if(isnull(params)) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} /do [acción]");
    new str[145], str2[145];
    format(str, sizeof(str), "* %s [ %s ]", PlayerName(playerid), params);
    format(str2, sizeof(str2), "* %s [ %s ]", "Desconocido", params);
    SendPlayersMessage(10.0, playerid, 0xADFF2FAA, str, str2);
	return 1;
}

CMD:me(playerid, params[])
{
    SendClientMessage(playerid, -1, "Usa {FFFF00}!acción {FFFFFF}en lugar de de {FFFF00}/me acción{FFFFFF}.");
	return 1;
}

//CMDS que serán borrados:
CMD:vid(playerid, params[])
{
    //if(IsPlayerAdmin(playerid)){
	    if(sscanf(params, "d", params[0])) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} /vid [Model ID] [Col1] [Col2]");
		new Float:pos[3];
		GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
		new Float:anglea;
		GetPlayerFacingAngle(playerid, anglea);
		AddCar(params[0],pos[0],pos[1]+1,pos[2]+0.5,anglea, -1, -1);
 		return 1;
}

CMD:ls(playerid, params[])
{
    SetPlayerInteriorEx(playerid, 0);
    SetPlayerPos(playerid,1509.156860, -1739.629028, 13.546875);
	return 1;
}

CMD:pos(playerid, params[])
{
    if(isnull(params)) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} /pos [name]");
	new Float:p[4];
	GetPlayerPos(playerid, p[0], p[1], p[2]);
	GetPlayerFacingAngle(playerid, p[3]);
	printf("%s: %f, %f, %f, %f, %d", params, p[0], p[1], p[2], p[3], GetPlayerInterior(playerid));
	return 1;
}

CMD:cam(playerid, params[])
{
    if(isnull(params)) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} /cam [name]");
	new Float:p[6];
	GetPlayerCameraPos(playerid, p[0], p[1], p[2]);
	GetPlayerCameraLookAt(playerid, p[3], p[4], p[5]);
	print(params);
	printf("SetPlayerCameraPos(playerid, %f, %f, %f);", p[0], p[1], p[2]);
	printf("SetPlayerCameraLookAt(playerid, %f, %f, %f);", p[3], p[4], p[5]);
	return 1;
}

CMD:w(playerid, params[])
{
    if(sscanf(params, "d", params[0])) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} /w [weaponid]");
	GivePlayerWeapon(playerid, params[0], 99999999999999999);
	return 1;
}

CMD:skin(playerid, params[])
{
    if(sscanf(params, "d", params[0])) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} /skin [skinud]");
	SetPlayerSkin(playerid, params[0]);
	return 1;
}

CMD:dr(playerid, params[])
{
    if(sscanf(params, "d", params[0])) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} /dr [1-2]");
	switch(params[0])
	{
	    case 1:
	    {
	        MoveDynamicObject(LSPD_Doors[0], 1588.5118, -1637.8339, 16.4417, 0.5, 90.0, 0.0, 0.0);
	    }
		case 2:
		{
		    MoveDynamicObject(LSPD_Doors[0], 1588.5118, -1637.83386, 14.59201, 0.5, 0.0, 0.0, 0.0);
		}
		case 3:
		{
		    MoveDynamicObject(LSPD_Doors[1], 1582.6172, -1637.9052, 12.3299+0.01, 0.025, 0.0, 0.0, -60.0);
		}
		case 4:
		{
		    MoveDynamicObject(LSPD_Doors[1], 1582.6172, -1637.9052, 12.3299-0.01, 0.025, 0.0, 0.0, 0.0);
		}
	    default: SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} /dr [1-2]");
	}
	return 1;
}

CMD:m(playerid, params[])
{
    if(sscanf(params, "d", params[0])) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} /m [cantidad]");
	PlayerInfo[playerid][dinero] += params[0];
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, PlayerInfo[playerid][dinero]);
	return 1;
}

CMD:s(playerid, params[])
{
    if(sscanf(params, "d", params[0])) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} /s [acion]");
	PlayerPlaySound(playerid, params[0], 0, 0, 0);
	return 1;
}
 
CMD:ir(playerid, params[])
{
    if(sscanf(params, "i", params[0])) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF} /ir [id]");
	new Float:p[3];
	GetPlayerPos(params[0], p[0], p[1], p[2]);
	SetPlayerPos(playerid, p[0], p[1], p[2]);
	return 1;
}

CMD:asd(playerid, params[])
{
	new Float:p[3];
	GetPlayerPos(playerid, p[0], p[1], p[2]);
	SetPlayerPos(playerid, p[0], p[1], p[2]+1.0);
	return 1;
}

CMD:pp(playerid, params[])
{
	SetPlayerPos(playerid, 1421.38794, -1184.1919, 137.13000);
	return 1;
}
CMD:ppa(playerid, params[])
{
	SetPlayerPos(playerid, 1481.26563, -1775.80286, 82.99261);
	return 1;
}
public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
    if(success == 0) InfoMSG(playerid, 1500, "Lo sentimos, ~b~el comando no existe.");
    return 1;
}

funcion:InfoMSG(playerid, time, text[])
{
	PlayerTextDrawSetString(playerid, ErrorCommand[playerid], simbolos(text));
	PlayerTextDrawShow(playerid, ErrorCommand[playerid]);
	MyTimers[playerid][19] = SetTimerEx("RemoveMSGDraw", time, 0, "i", playerid);
	return 1;
}

funcion:RemoveMSGDraw(playerid) return PlayerTextDrawHide(playerid, ErrorCommand[playerid]);

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	loop(0, 8, i) TextDrawShowForPlayer(playerid, DeadTD[i]);
	KillTimer(MyTimers[playerid][23]);
    MyTimers[playerid][23] = SetTimerEx("HideDeadTD", 500, false, "i", playerid);
    if(IsPlayerConnected(issuerid))
    {
        if(weaponid >= 22 && weaponid <= 34)
        {
			if(bodypart == 9) SetPlayerHealth(playerid, 0.0);
		}
	}
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(hittype == BULLET_HIT_TYPE_NONE)
	{
	    new m = 19280;
		m += random(4);
		CreateDynamicObject(m, fX, fY, fZ, 0.0, 0.0, 0.0);
		Streamer_Update(playerid);
	}
	return 1;
}

funcion:HideDeadTD(playerid)
{
	loop(0, 8, i) TextDrawHideForPlayer(playerid, DeadTD[i]);
	return 1;
}

funcion:UpdateServerTime()
{
    ServerMinute++;
    if(ServerMinute == 60)
	{
		ServerTime ++;
		ServerMinute = 0;
	}
    if(ServerTime == 23) ServerTime = 0;
	foreach(new i : Player)
	{
		if(P_newuser[i] == -1)
		{
			SetPlayerTime(i, ServerTime, ServerMinute);
		}
 	}
	return 1;
}

SendPlayersMessage(Float:distancia, playerid, color, Knowtext[], Unknowtext[])
{
    new Float:pidx, Float:pidy, Float:pidz;
    new Float:ptox, Float:ptoy, Float:ptoz;
    new vwa = GetPlayerVirtualWorld(playerid);
    GetPlayerPos(playerid, pidx, pidy, pidz);
	foreach(new i : Player)
	{
	    new vwb = GetPlayerVirtualWorld(i);
	    GetPlayerPos(i, ptox, ptoy, ptoz);
	    if(ChatLogDisabled[i] == 0 && vwb == vwa && floatcmp(distancia, floatabs(floatsub(pidx, ptox))) == 1 && floatcmp(distancia, floatabs(floatsub(pidy, ptoy))) == 1 && floatcmp(distancia, floatabs(floatsub(pidz, ptoz))) == 1)
		{
  			if(PlayerKnownPlayer[playerid][i] == 1) SendClientMessage(i, color, Knowtext);
  			else SendClientMessage(i, color, Unknowtext);
		}
    }
    return 1;
}

stock Hide@(str[]) // Función para coger el nombre de un player y borrar el "_"
{
    new n[24];
	strmid(n, str, 0, strlen(str), 24);
    for(new i = 0; i < MAX_PLAYER_NAME; i++) {
		if (n[i] == '_') n[i] = ' ';
	}
    return n;
}

stock RemoveBuildings(playerid)
{
	//MALL BY SAMP
	RemoveBuildingForPlayer(playerid, 6130, 1117.5859, -1490.0078, 32.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 6255, 1117.5859, -1490.0078, 32.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 762, 1175.3594, -1420.1875, 19.8828, 0.25);
	RemoveBuildingForPlayer(playerid, 615, 1166.3516, -1417.6953, 13.9531, 0.25);
	//
    RemoveBuildingForPlayer(playerid, 4629, 1405.1172, -1191.4063, 85.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 4586, 1405.1172, -1191.4063, 85.0313, 0.25);
	//Alhambra
	RemoveBuildingForPlayer(playerid, 1823, 482.0625, -25.0938, 1002.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 1544, 482.3906, -24.8672, 1002.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 1754, 482.0469, -23.2891, 1002.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 1544, 482.8906, -24.5547, 1002.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 2290, 483.5156, -26.3516, 1002.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 1754, 484.1250, -24.6172, 1002.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 2596, 482.4453, -20.5938, 1002.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 482.2656, -20.5078, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 484.8359, -20.5000, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 2670, 479.5078, -20.3828, 999.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 1754, 485.4531, -24.7031, 1002.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 1823, 486.3906, -25.2891, 1002.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 1544, 486.6797, -24.6406, 1002.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 1544, 486.8125, -24.7500, 1002.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 2596, 485.7422, -20.5938, 1002.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 486.0859, -20.5625, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 2290, 487.8203, -26.3516, 1002.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 1544, 487.2031, -24.5859, 1002.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 1544, 487.1797, -25.1094, 1002.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 487.2266, -20.5391, 1000.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 1754, 488.4219, -25.1719, 1002.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 1754, 488.0313, -23.3906, 1002.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 488.2266, -20.5000, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 2690, 489.1953, -20.7891, 1000.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 2670, 490.6328, -24.3906, 999.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 2372, 497.8438, -24.6563, 999.6563, 0.25);
	RemoveBuildingForPlayer(playerid, 1775, 495.9688, -24.3203, 1000.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 500.6250, -24.1563, 1000.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 500.7578, -23.7344, 1000.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 500.7969, -23.4922, 1000.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 2350, 499.8359, -23.3359, 1000.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 2707, 500.8125, -23.6250, 1002.6641, 0.25);
	RemoveBuildingForPlayer(playerid, 2707, 500.8125, -24.4766, 1002.6641, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 501.0000, -23.7969, 1000.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 1520, 500.8047, -23.1484, 1000.7969, 0.25);
	RemoveBuildingForPlayer(playerid, 1541, 501.4375, -23.1563, 1000.8906, 0.25);
	RemoveBuildingForPlayer(playerid, 1547, 501.1641, -23.7813, 1000.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 2707, 500.8125, -22.8203, 1002.6641, 0.25);
	RemoveBuildingForPlayer(playerid, 2707, 500.8125, -22.0391, 1002.6641, 0.25);
	RemoveBuildingForPlayer(playerid, 1543, 500.8125, -21.8672, 1000.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 1542, 501.4297, -22.1719, 1000.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1544, 501.0469, -22.2813, 1000.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 1547, 501.1094, -22.8125, 1000.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 2707, 500.8125, -21.2500, 1002.6641, 0.25);
	RemoveBuildingForPlayer(playerid, 1541, 501.4375, -21.2266, 1000.8906, 0.25);
	RemoveBuildingForPlayer(playerid, 1548, 501.1094, -21.2266, 1000.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 2350, 499.8594, -21.6328, 1000.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 2707, 500.8125, -20.4453, 1002.6641, 0.25);
	RemoveBuildingForPlayer(playerid, 2596, 502.8281, -22.1094, 1002.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 503.2656, -23.1328, 1000.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 1520, 503.2734, -22.7891, 1000.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 503.4688, -22.9453, 1000.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 503.3828, -23.0859, 1002.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 1520, 503.3906, -22.7422, 1001.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 1545, 503.1484, -21.0938, 1001.5313, 0.25);
	RemoveBuildingForPlayer(playerid, 1520, 503.3906, -20.9922, 1001.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 503.5859, -21.1484, 1002.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 503.3828, -21.3359, 1002.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 503.5859, -20.5703, 1002.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 503.3828, -20.7578, 1002.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 18090, 502.1016, -20.2266, 1002.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 2670, 478.2188, -19.4141, 999.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 482.6094, -19.5156, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1544, 477.2109, -16.1016, 1003.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 2173, 476.5313, -14.4453, 1002.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 1544, 477.3203, -13.9375, 1003.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 1520, 483.3359, -20.1094, 1000.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 1520, 483.6797, -20.1016, 1000.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 484.2266, -19.5547, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1823, 484.1094, -19.9141, 999.6563, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 486.0938, -19.5938, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1520, 487.3359, -20.1484, 1000.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 488.3281, -19.6094, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1823, 487.6250, -19.9141, 999.6563, 0.25);
	RemoveBuildingForPlayer(playerid, 18089, 488.3828, -13.4063, 1000.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 1823, 493.3750, -18.1250, 999.6563, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 493.3516, -18.6641, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 494.3906, -18.6563, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 494.1797, -17.6016, 1000.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 494.3281, -16.5234, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 493.5391, -16.4219, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 18018, 493.3594, -14.8984, 999.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 1823, 495.9844, -17.4844, 999.6563, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 495.9922, -16.0000, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 495.9219, -18.1719, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 496.0156, -14.9688, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1823, 495.6484, -14.5703, 999.6563, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 495.7891, -13.1797, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1520, 496.1484, -13.8672, 1000.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 496.7656, -16.8359, 1000.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 496.4297, -16.7734, 1000.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 496.9375, -15.8828, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 497.0859, -17.9922, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 497.2813, -13.7422, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 2350, 499.8359, -19.6875, 1000.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 2350, 499.8594, -17.9844, 1000.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 2707, 500.8125, -18.8125, 1002.6641, 0.25);
	RemoveBuildingForPlayer(playerid, 2707, 500.8125, -18.0078, 1002.6641, 0.25);
	RemoveBuildingForPlayer(playerid, 2707, 500.8125, -19.6641, 1002.6641, 0.25);
	RemoveBuildingForPlayer(playerid, 1520, 500.8828, -19.6875, 1000.7969, 0.25);
	RemoveBuildingForPlayer(playerid, 1541, 501.4375, -18.0625, 1000.8906, 0.25);
	RemoveBuildingForPlayer(playerid, 1542, 501.4297, -19.0078, 1000.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1547, 500.9766, -19.2344, 1000.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 1548, 501.1250, -18.1172, 1000.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 2707, 500.8125, -17.2266, 1002.6641, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 500.8906, -16.5625, 1000.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 501.5859, -16.5625, 1000.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 1520, 500.6953, -17.0469, 1000.7969, 0.25);
	RemoveBuildingForPlayer(playerid, 2707, 501.0625, -16.4609, 1002.6641, 0.25);
	RemoveBuildingForPlayer(playerid, 2707, 501.7422, -16.1484, 1002.6641, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 501.1406, -16.2891, 1000.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 501.1406, -16.5469, 1000.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 2350, 499.8516, -16.1484, 1000.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 2596, 502.8281, -18.4375, 1002.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1545, 503.1484, -19.4297, 1001.5313, 0.25);
	RemoveBuildingForPlayer(playerid, 2707, 502.5234, -16.1484, 1002.6641, 0.25);
	RemoveBuildingForPlayer(playerid, 2707, 503.3281, -16.1484, 1002.6641, 0.25);
	RemoveBuildingForPlayer(playerid, 1520, 503.3047, -16.8906, 1000.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1520, 503.3906, -18.4531, 1001.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 503.3828, -18.7969, 1002.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 1544, 503.3906, -17.6172, 1001.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 1544, 503.3516, -17.8047, 1001.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 1520, 503.4375, -17.1641, 1000.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 503.5859, -18.6094, 1002.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 1544, 503.5625, -17.6406, 1001.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 1544, 503.5625, -17.4453, 1001.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 2780, 478.2188, -9.1250, 994.5078, 0.25);
	RemoveBuildingForPlayer(playerid, 2649, 477.8438, -7.7266, 1003.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 2670, 478.1953, -7.1719, 999.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 2670, 478.6016, -7.6953, 999.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 1436, 479.5938, -8.9922, 1001.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 2232, 478.3359, -5.5859, 1001.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 2670, 479.2891, -5.4063, 1001.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 2670, 479.8203, -5.8125, 1001.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 2232, 480.7969, -5.1016, 1001.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1544, 480.8594, -5.0156, 1002.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 1436, 479.5938, -4.2969, 1002.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 2232, 482.5781, -3.2188, 1001.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 493.2266, -12.3906, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 494.3672, -12.3984, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1823, 493.3750, -11.9688, 999.6563, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 494.3281, -10.3672, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 493.2266, -10.2656, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 495.9531, -9.3828, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 495.9531, -11.5078, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1823, 496.1016, -11.0859, 999.6563, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 497.1172, -11.6172, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 2125, 497.0547, -9.4844, 1000.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1517, 496.8906, -10.4063, 1000.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 2596, 499.9922, -8.9688, 1003.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 2670, 501.4141, -7.5547, 999.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 2779, 501.4688, -10.3672, 999.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 2778, 502.4063, -7.5313, 999.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 2681, 503.6484, -7.5156, 999.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 2232, 495.0391, -5.4063, 1001.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1544, 495.0078, -5.4453, 1002.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 1544, 495.2031, -5.3828, 1002.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 2670, 497.1563, -7.1094, 999.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 2232, 496.3750, -5.6953, 1001.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 2670, 505.6797, -7.0156, 999.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 2653, 506.1406, -4.3672, 1004.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 2232, 494.0625, -2.5156, 1001.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 2670, 502.1641, -1.8906, 999.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 2670, 499.8438, -1.6172, 999.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 2670, 505.8125, -1.5625, 999.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 1776, 500.5625, -1.3672, 1000.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 1775, 501.8281, -1.4297, 1000.7344, 0.25);
	//GRUAS
	RemoveBuildingForPlayer(playerid, 16328, 709.2881, 915.8592, -14.8962, 10.0);
	RemoveBuildingForPlayer(playerid, 16329, 709.2881, 915.8592, -14.8962, 10.0);
	
	RemoveBuildingForPlayer(playerid, 1396, -1723.5781, 188.9219, 27.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 1397, -1728.9141, 188.9063, 22.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 10774, -1739.2109, 166.7109, 5.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 1376, -1728.9141, 188.9063, 22.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 1386, -1728.9141, 188.9063, 35.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 1377, -1754.3906, 188.9219, 29.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 1378, -1723.5781, 188.9219, 27.0313, 0.25);
	
	//Pizzería ls decoración
	RemoveBuildingForPlayer(playerid, 1226, 2085.7500, -1809.7031, 16.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, 2091.1641, -1826.8359, 12.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 712, 2100.8125, -1764.3750, 21.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 2105.0859, -1765.6094, 10.8047, 0.25);
	
	//mecanico taller
	RemoveBuildingForPlayer(playerid, 1215, 1195.3594, -1820.2734, 13.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 3244, 2632.3906, -2073.6406, 12.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 3244, 2535.0938, -2131.8750, 12.9922, 0.25);
	RemoveBuildingForPlayer(playerid, 3244, 2532.0313, -2074.6250, 12.9922, 0.25);
	RemoveBuildingForPlayer(playerid, 3682, 2673.0859, -2114.9063, 36.5469, 0.25);
	RemoveBuildingForPlayer(playerid, 3683, 2684.7656, -2088.0469, 20.1172, 0.25);
	RemoveBuildingForPlayer(playerid, 3289, 2484.4141, -2141.0078, 12.1875, 0.25);
	RemoveBuildingForPlayer(playerid, 3289, 2496.0625, -2141.0078, 12.1875, 0.25);
	RemoveBuildingForPlayer(playerid, 3289, 2679.2344, -2106.9766, 12.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 3290, 2503.1250, -2073.3750, 12.4297, 0.25);
	RemoveBuildingForPlayer(playerid, 3290, 2515.4219, -2073.3750, 12.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 3290, 2647.1016, -2073.3750, 12.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 3290, 2658.7188, -2073.3750, 12.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 3290, 2671.5000, -2073.3750, 12.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 3288, 2432.7266, -2133.0234, 12.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 3686, 2448.1328, -2075.6328, 16.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 3745, 2475.1016, -2073.4766, 17.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3745, 2482.0234, -2073.4766, 17.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3745, 2489.1016, -2073.4766, 17.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3745, 2496.0938, -2073.4766, 17.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3290, 2452.9609, -2129.0156, 25.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 3756, 2484.2344, -2118.5547, 17.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 3755, 2484.2344, -2118.5547, 17.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 3779, 2631.9141, -2098.5781, 20.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 3779, 2653.9375, -2092.3359, 20.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 3257, 2432.7266, -2133.0234, 12.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 3258, 2484.4141, -2141.0078, 12.1875, 0.25);
	RemoveBuildingForPlayer(playerid, 3258, 2496.0625, -2141.0078, 12.1875, 0.25);
	RemoveBuildingForPlayer(playerid, 3256, 2452.9609, -2129.0156, 25.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 3567, 2446.8281, -2075.8438, 13.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 3567, 2438.3594, -2075.8438, 13.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 3627, 2448.1328, -2075.6328, 16.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 3643, 2489.1016, -2073.4766, 17.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3643, 2482.0234, -2073.4766, 17.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3643, 2475.1016, -2073.4766, 17.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3643, 2496.0938, -2073.4766, 17.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3256, 2515.4219, -2073.3750, 12.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 3256, 2503.1250, -2073.3750, 12.4297, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 2663.0547, -2121.6563, 30.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 2665.7734, -2122.5078, 22.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 2667.3594, -2120.7969, 19.4297, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 2669.3359, -2120.7969, 26.9141, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 2669.3359, -2120.7969, 13.2500, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 2679.4375, -2121.6563, 21.4297, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 2675.8594, -2121.6563, 25.6016, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 2684.2031, -2122.5078, 22.8906, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 2685.0547, -2119.7891, 14.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 2685.1172, -2119.1016, 19.4297, 0.25);
	RemoveBuildingForPlayer(playerid, 3637, 2631.9141, -2098.5781, 20.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 3637, 2653.9375, -2092.3359, 20.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 3673, 2673.0859, -2114.9063, 36.5469, 0.25);
	RemoveBuildingForPlayer(playerid, 3258, 2679.2344, -2106.9766, 12.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 3674, 2682.3203, -2114.5313, 39.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 3636, 2684.7656, -2088.0469, 20.1172, 0.25);
	RemoveBuildingForPlayer(playerid, 3256, 2647.1016, -2073.3750, 12.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 3256, 2658.7188, -2073.3750, 12.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 3256, 2671.5000, -2073.3750, 12.4453, 0.25);
	//RemoveBuildingForPlayer(playerid, 1311, 2234.7500, -1737.4766, 16.5547, 0.25);
	RemoveBuildingForPlayer(playerid, 1307, 2263.5234, -1742.1953, 12.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 1307, 2295.7031, -1742.1953, 12.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 1307, 2331.2656, -1742.4141, 12.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 1307, 2364.2500, -1742.1172, 12.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 1307, 2403.2891, -1741.7422, 12.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 2367.6016, -1706.2891, 11.2891, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 2375.0625, -1715.7969, 11.2891, 0.25);
	RemoveBuildingForPlayer(playerid, 641, 2379.1484, -1715.4219, 10.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 17876, 2393.0625, -1677.5234, 20.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1190.3047, -1389.8047, 15.5000, 0.25);
	
	//Spraycans
	/*RemoveBuildingForPlayer(playerid, 5422, 2071.4766, -1831.4219, 14.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 5340, 2644.8594, -2039.2344, 14.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 5856, 1024.9844, -1029.3516, 33.1953, 0.25);
	RemoveBuildingForPlayer(playerid, 5779, 1041.3516, -1025.9297, 32.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 6400, 488.2813, -1734.6953, 12.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 10575, -2716.3516, 217.4766, 5.3828, 0.25);
	RemoveBuildingForPlayer(playerid, 11313, -1935.8594, 239.5313, 35.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 11319, -1904.5313, 277.8984, 42.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 10182, -1786.8125, 1209.4219, 25.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 9625, -2425.7266, 1027.9922, 52.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 9093, 2386.6563, 1043.6016, 11.5938, 0.25);
	RemoveBuildingForPlayer(playerid, 7891, 1968.7422, 2162.4922, 12.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 3294, -1420.5469, 2591.1563, 57.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 3294, -100.0000, 1111.4141, 21.6406, 0.25);
	RemoveBuildingForPlayer(playerid, 13028, 720.0156, -462.5234, 16.8594, 0.25);*/
	
	//salsa
	RemoveBuildingForPlayer(playerid, 5207, 2167.0391, -1925.2031, 15.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 5208, 2115.0000, -1921.5234, 15.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2159.8281, -1930.6328, 15.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 3770, 2197.9766, -1970.5625, 14.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 3626, 2197.9766, -1970.5625, 14.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 3567, 2142.9141, -1947.4219, 13.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2118.2891, -1939.3984, 16.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 2114.5547, -1928.1875, 5.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 2113.3984, -1925.0391, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 2115.6719, -1922.7656, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 2123.3594, -1928.0703, 6.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2159.8281, -1930.6328, 15.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 5181, 2167.0391, -1925.2031, 15.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 5182, 2115.0000, -1921.5234, 15.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 2122.6563, -1916.7891, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 2116.9297, -1916.0781, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 5231, 2085.2813, -1909.7109, 23.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 2121.5078, -1909.5313, 10.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2084.5313, -1905.4922, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2092.9141, -1891.3750, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2101.2578, -1900.1797, 16.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 2110.2734, -1906.5859, 5.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, 2175.7734, -1910.5781, 12.7031, 0.25);
	RemoveBuildingForPlayer(playerid, 1226, 2134.6016, -1900.4063, 16.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 1307, 2139.1641, -1904.2734, 12.7656, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2207.4297, -1897.1172, 15.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1315, 2229.9688, -1891.3750, 15.8125, 0.25);
	
	    //prsioón
    RemoveBuildingForPlayer(playerid, 3682, 247.9297, 1461.8594, 33.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 3682, 192.2734, 1456.1250, 33.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 3682, 199.7578, 1397.8828, 33.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 3683, 133.7422, 1356.9922, 17.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 3683, 166.7891, 1356.9922, 17.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 3683, 166.7891, 1392.1563, 17.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 3683, 133.7422, 1392.1563, 17.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 3683, 166.7891, 1426.9141, 17.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 3683, 133.7422, 1426.9141, 17.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 3288, 221.5703, 1374.9688, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3289, 212.0781, 1426.0313, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3290, 218.2578, 1467.5391, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3291, 246.5625, 1435.1953, 9.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 3291, 246.5625, 1410.5391, 9.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 3291, 246.5625, 1385.8906, 9.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 3291, 246.5625, 1361.2422, 9.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 3290, 190.9141, 1371.7734, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3289, 183.7422, 1444.8672, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3289, 222.5078, 1444.6953, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3289, 221.1797, 1390.2969, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3288, 223.1797, 1421.1875, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3683, 133.7422, 1459.6406, 17.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 3289, 207.5391, 1371.2422, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3424, 220.6484, 1355.1875, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3424, 221.7031, 1404.5078, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3424, 210.4141, 1444.8438, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3424, 262.5078, 1465.2031, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3259, 220.6484, 1355.1875, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3636, 133.7422, 1356.9922, 17.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 3636, 166.7891, 1356.9922, 17.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 3256, 190.9141, 1371.7734, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3636, 166.7891, 1392.1563, 17.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 3636, 133.7422, 1392.1563, 17.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 3258, 207.5391, 1371.2422, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 205.6484, 1394.1328, 10.1172, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 205.6484, 1392.1563, 16.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 205.6484, 1394.1328, 23.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 207.3594, 1390.5703, 19.1484, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 206.5078, 1387.8516, 27.4922, 0.25);
	RemoveBuildingForPlayer(playerid, 3673, 199.7578, 1397.8828, 33.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 3257, 221.5703, 1374.9688, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3258, 221.1797, 1390.2969, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 203.9531, 1409.9141, 16.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 3674, 199.3828, 1407.1172, 35.8984, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 204.6406, 1409.8516, 11.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 206.5078, 1404.2344, 18.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 206.5078, 1400.6563, 22.4688, 0.25);
	RemoveBuildingForPlayer(playerid, 3259, 221.7031, 1404.5078, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 207.3594, 1409.0000, 19.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 3257, 223.1797, 1421.1875, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3258, 212.0781, 1426.0313, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3636, 166.7891, 1426.9141, 17.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 3636, 133.7422, 1426.9141, 17.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 3255, 246.5625, 1361.2422, 9.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 3255, 246.5625, 1385.8906, 9.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 3255, 246.5625, 1410.5391, 9.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 3258, 183.7422, 1444.8672, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3259, 210.4141, 1444.8438, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3258, 222.5078, 1444.6953, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 16086, 232.2891, 1434.4844, 13.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 3673, 192.2734, 1456.1250, 33.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 3674, 183.0391, 1455.7500, 35.8984, 0.25);
	RemoveBuildingForPlayer(playerid, 3636, 133.7422, 1459.6406, 17.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 196.0234, 1462.0156, 10.1172, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 198.0000, 1462.0156, 16.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 196.0234, 1462.0156, 23.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 180.2422, 1460.3203, 16.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 180.3047, 1461.0078, 11.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 3256, 218.2578, 1467.5391, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 199.5859, 1463.7266, 19.1484, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 181.1563, 1463.7266, 19.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 185.9219, 1462.8750, 18.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 202.3047, 1462.8750, 27.4922, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 189.5000, 1462.8750, 22.4688, 0.25);
	RemoveBuildingForPlayer(playerid, 3255, 246.5625, 1435.1953, 9.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 254.6797, 1451.8281, 27.4922, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 253.8203, 1458.1094, 23.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 255.5313, 1454.5469, 19.1484, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 253.8203, 1456.1328, 16.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 253.8203, 1458.1094, 10.1172, 0.25);
	RemoveBuildingForPlayer(playerid, 3259, 262.5078, 1465.2031, 9.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 254.6797, 1468.2109, 18.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 3673, 247.9297, 1461.8594, 33.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 254.6797, 1464.6328, 22.4688, 0.25);
	RemoveBuildingForPlayer(playerid, 3674, 247.5547, 1471.0938, 35.8984, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 255.5313, 1472.9766, 19.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 252.8125, 1473.8281, 11.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 3675, 252.1250, 1473.8906, 16.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 16089, 342.1250, 1431.0938, 5.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 16090, 315.7734, 1431.0938, 5.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 16091, 289.7422, 1431.0938, 5.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 16087, 358.6797, 1430.4531, 11.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 16088, 368.4297, 1431.0938, 5.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 16092, 394.1563, 1431.0938, 5.2734, 0.25);
	return 1;
}

stock PlayerNearPlayer(p1, p2, Float:distance)
{
	if(IsPlayerConnected(p1) && IsPlayerConnected(p2))
	{
		static Float:p[3];
		GetPlayerPos(p2, p[0], p[1], p[2]);
	 	if(IsPlayerInRangeOfPoint(p1, distance, p[0], p[1], p[2])) return 1;
	 	else return 0;
	}
	else return 0;
}

stock SendClientMessageEx(playerid, colour, const fmat[],  va_args<>)
{
	new str[256];
	va_format(str, sizeof (str), fmat, va_start<3>);
	return (playerid != -1) ? SendClientMessage(playerid, colour, str) : SendClientMessageToAll(colour, str);
}

stock GetPlayerIdFromName(playername[])
{
    foreach(new i : Player)
    {
        if(!strcmp(PlayerNameNormal(i), playername))
        {
            return i;
        }
    }
    return false;
}

stock IsKnowPlayer(playerid, p2)
{
	if(IsPlayerConnected(playerid) && IsPlayerConnected(p2))
	{
		if(PlayerKnownPlayer[playerid][p2] == 1) return true;
		else return false;
	}
	return false;
}

stock StripNewLine(string[]) //DracoBlue (bugfix idea by Y_Less)
{
	new len = strlen(string);
	if (string[0]==0) return ;
	if ((string[len - 1] == '\n') || (string[len - 1] == '\r')) {
		string[len - 1] = 0;
		if (string[0]==0) return ;
		if ((string[len - 2] == '\n') || (string[len - 2] == '\r')) string[len - 2] = 0;
	}
}

funcion:BitchContinue(playerid, d)
{
	switch(d)
	{
		case 0:
		{
			InterpolateCameraPos(playerid, 1206.4519, 13.3467, 1002.5107, 1200.5004, 16.3557, 1002.0889, 5000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, 1205.9796, 14.2284, 1002.1209, 1201.4412, 16.6938, 1001.7643, 5000, CAMERA_MOVE);
			MyTimers[playerid][11] = SetTimerEx("BitchContinue", 10000, false, "id", playerid, 1);
		}
		case 1:
		{
			InterpolateCameraPos(playerid, 1200.5004, 16.3557, 1002.0889, 1203.1359, 19.1191, 1001.1140, 5000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, 1201.4412, 16.6938, 1001.7643, 1203.5944, 18.2302, 1000.9246, 5000, CAMERA_MOVE);
			MyTimers[playerid][11] = SetTimerEx("BitchContinue", 10000, false, "id", playerid, 2);
		}
		case 2:
		{
			InterpolateCameraPos(playerid, 1203.1359, 19.1191, 1001.1140, 1207.1952, 17.7792, 1001.2449, 5000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, 1203.5944, 18.2302, 1000.9246, 1206.2045, 17.6444, 1001.0204, 5000, CAMERA_MOVE);
			MyTimers[playerid][11] = SetTimerEx("BitchContinue", 10000, false, "id", playerid, 3);
		}
		case 3:
		{
		    InterpolateCameraPos(playerid, 1207.1952, 17.7792, 1001.2449, 1206.4519, 13.3467, 1002.5107, 5000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid, 1206.2045, 17.6444, 1001.0204, 1205.9796, 14.2284, 1002.1209, 5000, CAMERA_MOVE);
			ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_END_P", 4.0, 0, 1, 1, 1, 1);
			ApplyAnimation(playerid, "BLOWJOBZ", "BJ_COUCH_END_P", 4.0, 0, 1, 1, 1, 1);
			ApplyAnimation(NPCS[BITCH_BJ], "BLOWJOBZ", "BJ_STAND_END_W", 4.0, 0, 1, 1, 1, 1);
			ApplyAnimation(NPCS[BITCH_BJ], "BLOWJOBZ", "BJ_STAND_END_W", 4.0, 0, 1, 1, 1, 1);
			MyTimers[playerid][11] = SetTimerEx("BitchContinue", 5000, false, "id", playerid, 4);
		}
		case 4:
		{
		    RemovePlayerAttachedObject(playerid, 0);
		    GameTextForPlayer(playerid, "~r~-50", 3000, 0);
		    SetCameraBehindPlayer(playerid);
		    TogglePlayerControllable(playerid, false);
		    MyTimers[playerid][11] = SetTimerEx("BitchContinue", 3000, false, "id", playerid, 5);
		    PlayerPlaySound(playerid, 0, 1206.4519, 13.3467, 1002.5107);
		}
		case 5:
		{
		    SetPlayerPos(playerid, 1203.6499, 8.7910, 1001.6718);
		    SetPlayerInteriorEx(playerid, 2, INT_PIGPEN);
		    TogglePlayerControllable(playerid, true);
		    PlayerEvent[playerid][BITCH_BJ] = false;
		    NPC_USED[NPCS[BITCH_BJ]] = false;
		}
	}
	return 1;
}

funcion:RobContinue(playerid, a, SHOP)
{
	switch(a)
	{
		case 0:
		{
		    SetPlayerDrunkLevel(playerid, 2500);
		    ApplyAnimation(NPCS[SHOP],"SHOP","SHP_Rob_GiveCash",4.1,0,1,1,1,1,1);
		    ApplyAnimation(NPCS[SHOP],"SHOP","SHP_Rob_GiveCash",4.1,0,1,1,1,1,1);
		    MyTimers[playerid][12] = SetTimerEx("RobContinue", 5000, 0, "idi", playerid, 1, SHOP);
		}
		case 1:
		{
		    if(SHOP == SHOP_UNITY)
		    {
				InterpolateCameraPos(playerid, -24.371448, -184.631881, 1005.830017, -28.919799, -183.278396, 1004.433410, 3000);
				InterpolateCameraLookAt(playerid, -28.462133, -186.144622, 1003.385009, -28.672475, -184.235733, 1004.283996, 3000);
			}
			else if(SHOP == SHOP_AYUNT)
			{
			    InterpolateCameraPos(playerid, -27.082044, -27.978450, 1005.534057, -31.010599, -27.289100, 1004.428771, 3000);
				InterpolateCameraLookAt(playerid, -27.810798, -28.538206, 1005.139587, -30.681732, -28.221578, 1004.279357, 3000);
			}
			else if(SHOP == SHOP_VINE)
			{
			    InterpolateCameraPos(playerid, 7.980316, -27.542730, 1005.657958, 1.124199, -26.738199, 1004.537780, 3000);
				InterpolateCameraLookAt(playerid, 7.156741, -27.963136, 1005.277221, 1.620131, -27.593605, 1004.388366, 3000);
			}
			SetPlayerDrunkLevel(playerid, 2500);
	        MyTimers[playerid][12] = SetTimerEx("RobContinue", 3000, 0, "idi", playerid, 2, SHOP);
		}
		case 2:
		{
			SetCameraBehindPlayer(playerid);
			ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1);
			TogglePlayerControllable(playerid, true);
			ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1);
	        TextDrawHideForPlayer(playerid, TD_BX[0]);
	    	TextDrawHideForPlayer(playerid, TD_BX[1]);
	    	GameTextForPlayer(playerid, "~g~+1500", 3000, 0);
	    	PlayerInfo[playerid][dinero] += 1500;
	    	ResetPlayerMoney(playerid);
	    	GivePlayerMoney(playerid, PlayerInfo[playerid][dinero]);
	    	SetPlayerDrunkLevel(playerid, 0);
	    	PlayerTextDrawHide(playerid, TD_IO[playerid]);
	    	PlayerEvent[playerid][SHOP] = false;
	    	ChatLogDisabled[playerid] = false;
      		SetTimerEx("OpenStore", 3600000, false, "i", NPCS[SHOP]);
	    	NPC_USED[NPCS[SHOP]] = 1;
		}
		case 3:
		{
		    DisablePlayerCheckpoint(playerid);
		    P_No_Message_Atraco[playerid] = 0;
		}
	}
	return 1;
}

funcion:OpenStore(storeid)
{
    NPC_USED[storeid] = false;
    ApplyAnimation(storeid,"PED","WALK_player",4.0,0,0,0,0,1);
    ApplyAnimation(storeid,"PED","WALK_player",4.0,0,0,0,0,1);
	return 1;
}

funcion:SetPlayerPosAndFreeze(playerid, Float:x, Float:y, Float:z, freeze)
{
	if(freeze == 0)
	{
        SetPlayerPos(playerid, x, y, z);
        TogglePlayerControllable(playerid, false);
        MyTimers[playerid][14] = SetTimerEx("SetPlayerPosAndFreeze", 1500, false, "ifffd", playerid, x, y, z, 1);
    }
	else if(freeze == 1) TogglePlayerControllable(playerid, true);
	return 1;
}

funcion:MyPhoneContinue(playerid, type, toplayerid)
{
	switch(type)
	{
		case 0:
		{
			HidePlayerPhone(playerid);
			UsingPhone[playerid] = 0;
			NumeroMarcado[playerid] = 0;
		}
		case 1:
		{
			ShowPlayerPhone(playerid, "", "Llamada finalizada");
            new r = random(9999);
			SendClientMessageEx(playerid, -1, "Su tarjera acaba de ser activada, su número es {00CCFF}%d.", r);
			PlayerInfo[playerid][phonenumber] = r;
			MyTimers[playerid][15] = SetTimerEx("MyPhoneContinue", 2000, false, "idi", playerid, 0, -1);
		}
		case 2:
		{
		    PlayerPlaySound(toplayerid, 20600, 0, 0, 0);
		    if(IsKnowPlayer(toplayerid, playerid))
		    {
		        new str[10];
			    format(str, 10, "%s", FirstName(playerid));
			    ShowPlayerPhone(toplayerid, str, "Llamada entrante");
		    }
		    else
		    {
			    new str[10];
			    format(str, 10, "%d", PlayerInfo[playerid][phonenumber]);
			    ShowPlayerPhone(toplayerid, str, "Llamada entrante");
			}
            UsingPhone[toplayerid] = 1;
            UsingPhone[playerid] = 4;
            NumeroMarcado[toplayerid] = playerid;
		}
		case 3:
		{
		    ShowPlayerPhone(playerid, "", simbolos("Número no disponible"));
			MyTimers[playerid][15] = SetTimerEx("MyPhoneContinue", 2000, false, "idi", playerid, 0, -1);
		}
	}
	return 1;
}

stock GetSex(playerid)
{
	new n[24];
	if(PlayerInfo[playerid][sexo] == 0) n = "masculino";
	else n = "femenino";
	return n;
}

stock SetPlayerInteriorEx(playerid, i_interiorid, e_interior = 0)
{
	SetPlayerInterior(playerid, i_interiorid);
	PlayerInfo[playerid][Interior] = e_interior;
	return 1;
}

stock GetPlayerInteriorEx(playerid)
{
	return PlayerInfo[playerid][Interior];
}

stock posicionDetras(jugadorid, &Float: x, &Float:y, &Float:z, Float:d)
{
	new Float:angulo,
	    Float:distancia = d,
	    Float:aumento = 180.0;

	GetPlayerFacingAngle(jugadorid, angulo);

	GetPlayerPos(jugadorid, x, y, z);
	x += (distancia * floatsin(-(angulo+aumento), degrees));
	y += (distancia * floatcos(-(angulo+aumento), degrees));
	return 1;
}

funcion:CameraContinueV(playerid, Float:fromx, Float:fromy, Float:fromz, set)
{
    SetPlayerVirtualWorld(playerid, 0);
    SetCameraBehindPlayer(playerid);
    TogglePlayerControllable(playerid, true);
    ChatLogDisabled[playerid] = false;
    CancelSelectTextDraw(playerid);
	SendClientMessageEx(playerid, -1, "Bienvenido de nuevo a {00CCFF}eXtreme Roleplay{FFFFFF}, %s.", PlayerName(playerid));
	return 1;
}

funcion:opwc_timer(playerid)
{
    new aArma = GetPlayerWeapon(playerid);
    if(aArma != gArma[playerid]){
        CallLocalFunction("OnPlayerWeaponChange", "iii", playerid, aArma, gArma[playerid]);
        gArma[playerid] = aArma;
    }
    return 1;
}

funcion:BankContinue(playerid, t)
{
	switch(t)
	{
	    case 0:
		{
		    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		    TextDrawShowForPlayer(playerid, Bank[11]);
		    MyTimers[playerid][17] = SetTimerEx("BankContinue", 500, false, "id", playerid, 1);
		}
		case 1:
		{
		    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		    TextDrawShowForPlayer(playerid, Bank[12]);
		    MyTimers[playerid][17] = SetTimerEx("BankContinue", 500, false, "id", playerid, 2);
		}
		case 2:
		{
		    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		    TextDrawShowForPlayer(playerid, Bank[13]);
		    MyTimers[playerid][17] = SetTimerEx("BankContinue", 500, false, "id", playerid, 3);
		}
		case 3:
		{
		    PlayerPlaySound(playerid, 17803, 0.0, 0.0, 0.0);
		    TextDrawShowForPlayer(playerid, Bank[14]);
		    MyTimers[playerid][17] = SetTimerEx("BankContinue", 500, false, "id", playerid, 4);
		}
		case 4:
		{
		    PlayerPlaySound(playerid, 45400, 0.0, 0.0, 0.0);
		    TextDrawHideForPlayer(playerid, Bank[8]);
		    TextDrawHideForPlayer(playerid, Bank[9]);
		    TextDrawHideForPlayer(playerid, Bank[10]);
		    TextDrawHideForPlayer(playerid, Bank[11]);
		    TextDrawHideForPlayer(playerid, Bank[12]);
		    TextDrawHideForPlayer(playerid, Bank[13]);
		    TextDrawHideForPlayer(playerid, Bank[14]);
		    TextDrawShowForPlayer(playerid, Bank[15]);
		    TextDrawShowForPlayer(playerid, Bank[16]);
		    TextDrawShowForPlayer(playerid, Bank[17]);
		    TextDrawShowForPlayer(playerid, Bank[18]);
		    TextDrawShowForPlayer(playerid, Bank[19]);
		    new str[128];
		    format(str, 128, "Balance actual: $%d", PlayerInfo[playerid][dinerobank]);
		    PlayerTextDrawSetString(playerid, PlayerBank[playerid][0], str);
		    PlayerTextDrawSetString(playerid, PlayerBank[playerid][1], FirstName(playerid));
            PlayerTextDrawShow(playerid, PlayerBank[playerid][0]);
            PlayerTextDrawShow(playerid, PlayerBank[playerid][1]);
			SelectTextDraw(playerid, -1);
			KillTimer(MyTimers[playerid][17]);
		}
		case 5:
		{
			ChatLogDisabled[playerid] = false;
			loop(0, 11, l) TextDrawHideForPlayer(playerid, Bank[l]);
			P_bank_state[playerid] = -1;
			InfoMSG(playerid, 2500, "No tienes cuenta bancaria, ~n~~b~debes ir al banco ~w~para~n~crearte una.");
		}
	}
	return 1;
}

stock GetClosestATM(playerid)
{
    new hospitalid, Float:closest = GetPlayerDistanceFromPoint(playerid, Cajeros[0][0], Cajeros[0][1], Cajeros[0][2]);
    for(new i = 1; i < sizeof(Cajeros); i++)
    {
        if(GetPlayerDistanceFromPoint(playerid, Cajeros[i][0], Cajeros[i][1], Cajeros[i][2]) < closest)
        {
            closest = GetPlayerDistanceFromPoint(playerid, Cajeros[i][0], Cajeros[i][1], Cajeros[i][2]);
            hospitalid = i;
        }
    }
    return hospitalid;
}

funcion:ShowBankCash(playerid, time)
{
	if(time == -1)
	{
	    PlayerTextDrawHide(playerid, BankCash[playerid]);
	    return 1;
	}
	if(time == 0)
	{
	    new str[64];
		format(str, 64, "$%d", PlayerInfo[playerid][dinerobank]);
		PlayerTextDrawSetString(playerid, BankCash[playerid], str);
		PlayerTextDrawShow(playerid, BankCash[playerid]);
	    return 1;
	}
	new str[64];
	format(str, 64, "$%d", PlayerInfo[playerid][dinerobank]);
	PlayerTextDrawSetString(playerid, BankCash[playerid], str);
	PlayerTextDrawShow(playerid, BankCash[playerid]);
	MyTimers[playerid][18] = SetTimerEx("ShowBankCash", time, false, "id", playerid, -1);
	return 1;
}

stock ShowPlayerPhone(playerid, txt1[], txt2[])
{
	loop(0, 10, i) TextDrawShowForPlayer(playerid, TD_Phone[i]);
	PlayerTextDrawShow(playerid, PTD_PhoneString1[playerid]);
	PlayerTextDrawShow(playerid, PTD_PhoneString2[playerid]);
	if(!isnull(txt1)) PlayerTextDrawSetString(playerid, PTD_PhoneString1[playerid], txt1);
	if(!isnull(txt2)) PlayerTextDrawSetString(playerid, PTD_PhoneString2[playerid], txt2);
	return 1;
}

stock HidePlayerPhone(playerid)
{
    loop(0, 10, i) TextDrawHideForPlayer(playerid, TD_Phone[i]);
    PlayerTextDrawHide(playerid, PTD_PhoneString1[playerid]);
	PlayerTextDrawHide(playerid, PTD_PhoneString2[playerid]);
	PlayerTextDrawSetString(playerid, PTD_PhoneString1[playerid], " ");
	PlayerTextDrawSetString(playerid, PTD_PhoneString2[playerid], " ");
	return 1;
}

stock IsValidName(name[])
{
	for(new c = 0; c < strlen(name); c++)
	{
	    switch(name[c])
	    {
	        case 'A' .. 'Z', 'a' .. 'z', '_': continue;
	        default: return false;
	    }
	}
	return true;
}

funcion:washcontinue(playerid, vehicleid, in)
{
	if(!IsPlayerInAnyVehicle(playerid)) return 1;
	switch(in)
	{
		case 0:
		{
      		new Float:pos[3];
		    GetVehiclePos(vehicleid, pos[0], pos[1], pos[2]);
		    if(-1778.0 < pos[1])
		    {
				MyTimers[playerid][20] = SetTimerEx("washcontinue", 500, 0, "idd", playerid, vehicleid, 1);
    			TogglePlayerControllable(playerid, false);
				SetVehicleZAngle(vehicleid, 0.0);
		        return 1;
		    }
		    SetVehicleVelocity(vehicleid, 0.0, 0.1, 0.0);
		    MyTimers[playerid][20] = SetTimerEx("washcontinue", 100, 0, "idd", playerid, vehicleid, 0);
		}
		case 1:
		{
		    SetVehiclePos(vehicleid, 1911.147094, -1777.152465, 13.109889);
			PlayerPlaySound(playerid, 12600, 1911.147094, -1777.152465, 13.109889);
			SetPlayerCameraPos(playerid, 1909.0233, -1767.4805, 13.3087);
			SetPlayerCameraLookAt(playerid, 1909.3793, -1768.4137, 13.3187);
			SetDynamicObjectPos(CarWash[0], 1911, -1776, 10);
		    SetDynamicObjectPos(CarWash[1], 1914, -1776, 10);
		    SetDynamicObjectPos(CarWash[2], 1909.256713, -1773.727539, 12.382807);
		    SetDynamicObjectPos(CarWash[3], 1913.54663, -1779.261718, 12.382807);
			MoveDynamicObject(CarWash[2], 1909.256713, -1779.261718, 12.382807, 0.5);
			MoveDynamicObject(CarWash[3], 1913.54663, -1773.727539, 12.382807, 0.5);
		    MyTimers[playerid][20] = SetTimerEx("washcontinue", 15000, 0, "idd", playerid, vehicleid, 2);
		}
		case 2:
		{
		    SetDynamicObjectPos(CarWash[2], 0, 0, -100);
		    SetDynamicObjectPos(CarWash[3], 0, 0, -100);
		    SetObjectPos(CarWash[4], 1911.270751, -1778.91394, 14.152816);
		    MoveObject(CarWash[4], 1911.270751, -1773.727539, 14.152816, 0.5);
		    MyTimers[playerid][20] = SetTimerEx("washcontinue", 10000, 0, "idd", playerid, vehicleid, 3);
		}
		case 3:
		{
			InterpolateCameraPos(playerid, 1909.0233, -1767.4805, 13.3087, 1914.3645, -1763.0110, 15.5584, 5000);
			InterpolateCameraLookAt(playerid, 1909.3793, -1768.4137, 13.3187, 1913.9342, -1763.9115, 15.3034, 5000);
		    MyTimers[playerid][20] = SetTimerEx("washcontinue", 5000, 0, "idd", playerid, vehicleid, 4);
		}
		case 4:
		{
		    TogglePlayerControllable(playerid, true);
		    MyTimers[playerid][20] = SetTimerEx("washcontinue", 100, 0, "idd", playerid, vehicleid, 5);
		}
		case 5:
		{
      		new Float:pos[3];
		    GetVehiclePos(vehicleid, pos[0], pos[1], pos[2]);
		    if(-1769.7117 < pos[1])
		    {
		        SetDynamicObjectPos(CarWash[0], 0, 0, -100);
		        SetDynamicObjectPos(CarWash[1], 0, 0, -100);
		        SetObjectPos(CarWash[4], 0, 0, -100);
		        SetCameraBehindPlayer(playerid);
		        CarWashUsed = 0;
		        CarWashUsedBy[playerid] = 0;
				GameTextForPlayer(playerid, "~r~-25", 3000, 0);
				PlayerInfo[playerid][dinero] -= 25;
				ResetPlayerMoney(playerid);
				GivePlayerMoney(playerid, PlayerInfo[playerid][dinero]);
				PlayerPlaySound(playerid, 0, 1911.147094, -1777.152465, 13.109889);
		        return 1;
		    }
		    SetVehicleVelocity(vehicleid, 0.0, 0.1, 0.0);
		    MyTimers[playerid][20] = SetTimerEx("washcontinue", 100, 0, "idd", playerid, vehicleid, 5);
		}
	}
	return 1;
}

stock SetPlayerToFacePlayer(playerid, targetid)
{

    new
        Float:pX,
        Float:pY,
        Float:pZ,
        Float:X,
        Float:Y,
        Float:Z,
        Float:ang;

    if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)) return 0;

    GetPlayerPos(targetid, X, Y, Z);
    GetPlayerPos(playerid, pX, pY, pZ);

    ang = 180.0-atan2(pX-X,pY-Y);

    SetPlayerFacingAngle(playerid, ang);

    return 1;

}

funcion:GrottiNextView(playerid, view)
{
	switch(view)
	{
	    case 0:
	    {
	        InterpolateCameraPos(playerid, 557.7495, -1304.7958, 1998.8300, 556.8339, -1305.6442, 1998.8300, 10000);
			InterpolateCameraLookAt(playerid, 558.4281, -1305.5282, 1998.5769, 557.5126, -1306.3766, 1998.5769, 10000);
			PlayerTextDrawSetString(playerid, TD_IO[playerid], simbolos("_~n~__Solo acércate al mostrador para~n~__ver el catálogo, donde podrás~n~__elegir una variedad de~n~__vehículos deportivos...~n~~n~"));
			MyTimers[playerid][21] = SetTimerEx("GrottiNextView", 9000, 0, "id", playerid, 1);
	    }
	    case 1:
	    {
			PlayerTextDrawHide(playerid, TD_IO[playerid]);
			TogglePlayerSpectating(playerid, false);
			SetCameraBehindPlayer(playerid);
			SetPlayerPos(playerid, 545.4426,-1318.3784,1996.5759);
			SetPlayerSkin(playerid, PlayerInfo[playerid][skin]);
            SetPlayerFacingAngle(playerid, 350);
            PlayerInfo[playerid][VGrotti] = 1;
            ChatLogDisabled[playerid] = false;
	    }
	}
	return 1;
}

funcion:BankNextView(playerid, view)
{
	switch(view)
	{
	    case 0:
	    {
	        InterpolateCameraPos(playerid, 1459.6908, -1009.1484, 28.4681, 1458.8135, -1009.2402, 28.5244, 10000);
			InterpolateCameraLookAt(playerid, 1460.3192, -1008.3732, 28.3780, 1459.4419, -1008.4650, 28.4343, 10000);
			PlayerTextDrawSetString(playerid, TD_IO[playerid], simbolos("_~n~__Aquí podrás retirar, depositar~n~__y transferir dinero de tu~n~__cuenta bancaria...~n~~n~"));
			MyTimers[playerid][21] = SetTimerEx("BankNextView", 9000, 0, "id", playerid, 1);
	    }
	    case 1:
	    {
			PlayerTextDrawHide(playerid, TD_IO[playerid]);
			TogglePlayerSpectating(playerid, false);
			SetCameraBehindPlayer(playerid);
			SetPlayerPos(playerid, 1464.995117, -1009.071533, 26.815937);
	        SetPlayerFacingAngle(playerid, 0);
	        SetPlayerSkin(playerid, PlayerInfo[playerid][skin]);
            PlayerInfo[playerid][VBank] = 1;
            ChatLogDisabled[playerid] = false;
	    }
	}
	return 1;
}

stock EnviarDuda(playerid, msg[])
{
	new str[145];
	format(str, 145, "[Canal de dudas: %s(%d)]: %s", PlayerName(playerid), playerid, msg);
	for(new i = 0; i != GetMaxPlayers(); i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(PlayerInfo[i][DudeChannel] == 1 && ChatLogDisabled[i] == 0)
	        {
				SendClientMessage(i, 0x3366CCFF, str);
			}
		}
	}
	return 1;
}

funcion:CargarAnim(playerid)
{
    PreloadAnimLib(playerid, "PED");
    PreloadAnimLib(playerid, "SHOP");
    PreloadAnimLib(playerid, "BAR");
    PreloadAnimLib(playerid, "BLOWJOBZ");
    PreloadAnimLib(playerid, "GANGS");/*
    PreloadAnimLib(playerid,"AIRPORT");
    PreloadAnimLib(playerid,"ATTRACTORS");
    PreloadAnimLib(playerid,"BAR");
    PreloadAnimLib(playerid,"BASEBALL");
    PreloadAnimLib(playerid,"BD_FIRE");
    PreloadAnimLib(playerid,"BEACH");
    PreloadAnimLib(playerid,"BENCHPRESS");
    PreloadAnimLib(playerid,"BF_INJECTION");
    PreloadAnimLib(playerid,"BIKED");
    PreloadAnimLib(playerid,"BIKEH");
    PreloadAnimLib(playerid,"BIKELEAP");
    PreloadAnimLib(playerid,"BIKES");
    PreloadAnimLib(playerid,"BIKEV");
    PreloadAnimLib(playerid,"BIKE_DBZ");
    PreloadAnimLib(playerid,"BMX");
    PreloadAnimLib(playerid,"BOMBER");
    PreloadAnimLib(playerid,"BOX");
    PreloadAnimLib(playerid,"BSKTBALL");
    PreloadAnimLib(playerid,"BUDDY");
    PreloadAnimLib(playerid,"BUS");
    PreloadAnimLib(playerid,"CAMERA");
    PreloadAnimLib(playerid,"CAR");
    PreloadAnimLib(playerid,"CARRY");
    PreloadAnimLib(playerid,"CAR_CHAT");
    PreloadAnimLib(playerid,"CASINO");
    PreloadAnimLib(playerid,"CHAINSAW");
    PreloadAnimLib(playerid,"CHOPPA");
    PreloadAnimLib(playerid,"CLOTHES");
    PreloadAnimLib(playerid,"COACH");
    PreloadAnimLib(playerid,"COLT45");
    PreloadAnimLib(playerid,"COP_AMBIENT");
    PreloadAnimLib(playerid,"COP_DVBYZ");
    PreloadAnimLib(playerid,"CRACK");
    PreloadAnimLib(playerid,"CRIB");
    PreloadAnimLib(playerid,"DAM_JUMP");
    PreloadAnimLib(playerid,"DANCING");
    PreloadAnimLib(playerid,"DEALER");
    PreloadAnimLib(playerid,"DILDO");
    PreloadAnimLib(playerid,"DODGE");
    PreloadAnimLib(playerid,"DOZER");
    PreloadAnimLib(playerid,"DRIVEBYS");
    PreloadAnimLib(playerid,"FAT");
    PreloadAnimLib(playerid,"FIGHT_B");
    PreloadAnimLib(playerid,"FIGHT_C");
    PreloadAnimLib(playerid,"FIGHT_D");
    PreloadAnimLib(playerid,"FIGHT_E");
    PreloadAnimLib(playerid,"FINALE");
    PreloadAnimLib(playerid,"FINALE2");
    PreloadAnimLib(playerid,"FLAME");
    PreloadAnimLib(playerid,"FLOWERS");
    PreloadAnimLib(playerid,"FOOD");
    PreloadAnimLib(playerid,"FREEWEIGHTS");
    PreloadAnimLib(playerid,"GANGS");
    PreloadAnimLib(playerid,"GHANDS");
    PreloadAnimLib(playerid,"GHETTO_DB");
    PreloadAnimLib(playerid,"GOGGLES");
    PreloadAnimLib(playerid,"GRAFFITI");
    PreloadAnimLib(playerid,"GRAVEYARD");
    PreloadAnimLib(playerid,"GRENADE");
    PreloadAnimLib(playerid,"GYMNASIUM");
    PreloadAnimLib(playerid,"HAIRCUTS");
    PreloadAnimLib(playerid,"HEIST9");
    PreloadAnimLib(playerid,"INT_HOUSE");
    PreloadAnimLib(playerid,"INT_OFFICE");
    PreloadAnimLib(playerid,"INT_SHOP");
    PreloadAnimLib(playerid,"JST_BUISNESS");
    PreloadAnimLib(playerid,"KART");
    PreloadAnimLib(playerid,"KISSING");
    PreloadAnimLib(playerid,"KNIFE");
    PreloadAnimLib(playerid,"LAPDAN1");
    PreloadAnimLib(playerid,"LAPDAN2");
    PreloadAnimLib(playerid,"LAPDAN3");
    PreloadAnimLib(playerid,"LOWRIDER");
    PreloadAnimLib(playerid,"MD_CHASE");
    PreloadAnimLib(playerid,"MD_END");
    PreloadAnimLib(playerid,"MEDIC");
    PreloadAnimLib(playerid,"MISC");
    PreloadAnimLib(playerid,"MTB");
    PreloadAnimLib(playerid,"MUSCULAR");
    PreloadAnimLib(playerid,"NEVADA");
    PreloadAnimLib(playerid,"ON_LOOKERS");
    PreloadAnimLib(playerid,"OTB");
    PreloadAnimLib(playerid,"PARACHUTE");
    PreloadAnimLib(playerid,"PARK");
    PreloadAnimLib(playerid,"PAULNMAC");
    PreloadAnimLib(playerid,"PED");
    PreloadAnimLib(playerid,"PLAYER_DVBYS");
    PreloadAnimLib(playerid,"PLAYIDLES");
    PreloadAnimLib(playerid,"POLICE");
    PreloadAnimLib(playerid,"POOL");
    PreloadAnimLib(playerid,"POOR");
    PreloadAnimLib(playerid,"PYTHON");
    PreloadAnimLib(playerid,"QUAD");
    PreloadAnimLib(playerid,"QUAD_DBZ");
    PreloadAnimLib(playerid,"RAPPING");
    PreloadAnimLib(playerid,"RIFLE");
    PreloadAnimLib(playerid,"RIOT");
    PreloadAnimLib(playerid,"ROB_BANK");
    PreloadAnimLib(playerid,"ROCKET");
    PreloadAnimLib(playerid,"RUSTLER");
    PreloadAnimLib(playerid,"RYDER");
    PreloadAnimLib(playerid,"SCRATCHING");
    PreloadAnimLib(playerid,"SHAMAL");
    PreloadAnimLib(playerid,"SHOP");
    PreloadAnimLib(playerid,"SHOTGUN");
    PreloadAnimLib(playerid,"SILENCED");
    PreloadAnimLib(playerid,"SKATE");
    PreloadAnimLib(playerid,"SMOKING");
    PreloadAnimLib(playerid,"SNIPER");
    PreloadAnimLib(playerid,"SPRAYCAN");
    PreloadAnimLib(playerid,"STRIP");
    PreloadAnimLib(playerid,"SUNBATHE");
    PreloadAnimLib(playerid,"SWAT");
    PreloadAnimLib(playerid,"SWEET");
    PreloadAnimLib(playerid,"SWIM");
    PreloadAnimLib(playerid,"SWORD");
    PreloadAnimLib(playerid,"TANK");
    PreloadAnimLib(playerid,"TATTOOS");
    PreloadAnimLib(playerid,"TEC");
    PreloadAnimLib(playerid,"TRAIN");
    PreloadAnimLib(playerid,"TRUCK");
    PreloadAnimLib(playerid,"UZI");
    PreloadAnimLib(playerid,"VAN");
    PreloadAnimLib(playerid,"VENDING");
    PreloadAnimLib(playerid,"VORTEX");
    PreloadAnimLib(playerid,"WAYFARER");
    PreloadAnimLib(playerid,"WEAPONS");
    PreloadAnimLib(playerid,"WUZI");
    PreloadAnimLib(playerid,"WOP");
    PreloadAnimLib(playerid,"GFUNK");
    PreloadAnimLib(playerid,"RUNNINGMAN");*/
	return 1;
}
stock PreloadAnimLib(playerid, animlib[])
{
	ApplyAnimation(playerid,animlib,"null",0.0,0,0,0,0,0);
	return 1;
}

stock AddCar(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:vcangle, color1, color2)
{
	new veh;
    veh = AddStaticVehicle(modelid, spawn_x, spawn_y, spawn_z, vcangle, color1, color2);
	return veh;
}

stock CreatePersonalCar(playerid, modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:vcangle, color1, color2, vslot)
{
	new veh;
	veh = AddStaticVehicleEx(modelid, spawn_x, spawn_y, spawn_z, vcangle, color1, color2, 100);
	new str[20];
	new VEHKEYS = random(50000000);
	format(str, 20, "XRP%04d", VEHKEYS);
	SetVehicleNumberPlate(veh, str);
	SetVehicleToRespawn(veh);
    PlayerInfo[playerid][PlayerVehicle][vslot] = veh;
	PlayerInfo[playerid][PlayerVehicleKey][vslot] = VEHKEYS;
	VehicleInfo[veh][slot] = vslot;
    format(VehicleInfo[veh][VD], 24, "%s", PlayerNameNormal(playerid));
    VehicleInfo[veh][VKEY] = VEHKEYS;
    VehicleInfo[veh][vposx] = spawn_x;
    VehicleInfo[veh][vposy] = spawn_y;
    VehicleInfo[veh][vposz] = spawn_z;
    VehicleInfo[veh][vangle] = vcangle;
	VehicleInfo[veh][vmodelid] = modelid;
	VehicleInfo[veh][vcolor1] = color1;
	VehicleInfo[veh][vcolor2] = color2;
	VehicleInfo[veh][vpaintjob] = 3;
    new Query[600];
    format(Query, sizeof(Query), "INSERT INTO `VEHS` (`VKEY`, `VD`, `VPOSX`, `VPOSY`, `VPOSZ`, `VANGLE`, `VMODELID`, `VCOLOR1`, `VCOLOR2`, `VPAINTJOB`, `VM1`, `VM2`, `VM3`, `VM4`, `VM5`, `VM6`, `VM7`, `VM8`, `VM9`, `VM10`, `VM11`, `VM12`, `VM13`, `VM14`, `VM15`, `VM16`, `VM17`) VALUES('%d','%s','%f','%f','%f','%f','%d','%d','%d','3','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')", VEHKEYS, PlayerNameNormal(playerid), spawn_x, spawn_y, spawn_z, vcangle, modelid, color1, color2);
    db_query(Database, Query);
	return veh;
}

stock LoadPlayerCar(playerid)
{
    if(PlayerInfo[playerid][PlayerVehicle][0] == -1)
    {
		new Query[150],
			DBResult:Result;
		format(Query, sizeof(Query), "SELECT * FROM `VEHS` WHERE `VKEY` = '%d' AND `VD` = '%s'", PlayerInfo[playerid][PlayerVehicleKey][0], PlayerNameNormal(playerid));
		Result = db_query(Database, Query);
		if(db_num_rows(Result))
		{
		    new veh;
		    new V_VKEY, V_VD[24], Float:V_VPOSX, Float:V_VPOSY, Float:V_VPOSZ, Float:V_VANGLE,
		        V_MODEL, VCOL1, VCOL2, VPAINTJOB, VM1,VM2,VM3,VM4,VM5,VM6,VM7,VM8,VM9,VM10,VM11,VM12,VM13,VM14,VM15,VM16,VM17;
		    new f[24];
			db_get_field(Result, 0, f, 24), V_VKEY = strval(f);
			db_get_field(Result, 1, f, 24), format(V_VD, 24, "%s", f);
			db_get_field(Result, 2, f, 24), V_VPOSX = floatstr(f);
			db_get_field(Result, 3, f, 24), V_VPOSY = floatstr(f);
			db_get_field(Result, 4, f, 24), V_VPOSZ = floatstr(f);
			db_get_field(Result, 5, f, 24), V_VANGLE = floatstr(f);
			db_get_field(Result, 6, f, 24), V_MODEL = strval(f);
			db_get_field(Result, 7, f, 24), VCOL1 = strval(f);
			db_get_field(Result, 8, f, 24), VCOL2 = strval(f);
			db_get_field(Result, 9, f, 24), VPAINTJOB = strval(f);
			db_get_field(Result, 10, f, 24), VM1 = strval(f);
			db_get_field(Result, 11, f, 24), VM2 = strval(f);
			db_get_field(Result, 12, f, 24), VM3 = strval(f);
			db_get_field(Result, 13, f, 24), VM4 = strval(f);
			db_get_field(Result, 14, f, 24), VM5 = strval(f);
			db_get_field(Result, 15, f, 24), VM6 = strval(f);
			db_get_field(Result, 16, f, 24), VM7 = strval(f);
			db_get_field(Result, 17, f, 24), VM8 = strval(f);
			db_get_field(Result, 18, f, 24), VM9 = strval(f);
			db_get_field(Result, 19, f, 24), VM10 = strval(f);
			db_get_field(Result, 20, f, 24), VM11 = strval(f);
			db_get_field(Result, 21, f, 24), VM12 = strval(f);
			db_get_field(Result, 22, f, 24), VM13 = strval(f);
			db_get_field(Result, 23, f, 24), VM14 = strval(f);
			db_get_field(Result, 24, f, 24), VM15 = strval(f);
			db_get_field(Result, 25, f, 24), VM16 = strval(f);
			db_get_field(Result, 26, f, 24), VM17 = strval(f);
	        db_free_result(Result);
			new str[20];
			format(str, 20, "XRP%04d", V_VKEY);
			
			veh = AddStaticVehicleEx(V_MODEL, V_VPOSX, V_VPOSY, V_VPOSZ, V_VANGLE, VCOL1, VCOL2, 500);
			SetVehicleNumberPlate(veh, str);
			SetVehicleToRespawn(veh);
			
			format(VehicleInfo[veh][VD], 24, "%s", V_VD);
			VehicleInfo[veh][VKEY] = V_VKEY;
		    VehicleInfo[veh][vposx] = V_VPOSX;
			VehicleInfo[veh][vposy] = V_VPOSY;
			VehicleInfo[veh][vposz] = V_VPOSZ;
			VehicleInfo[veh][vangle] = V_VANGLE;
			VehicleInfo[veh][vmodelid] = V_MODEL;
			VehicleInfo[veh][vcolor1] = VCOL1;
			VehicleInfo[veh][vcolor2] = VCOL2;
			VehicleInfo[veh][vpaintjob] = VPAINTJOB;
			VehicleInfo[veh][mod1] = VM1;
			VehicleInfo[veh][mod2] = VM2;
			VehicleInfo[veh][mod3] = VM3;
			VehicleInfo[veh][mod4] = VM4;
			VehicleInfo[veh][mod5] = VM5;
			VehicleInfo[veh][mod6] = VM6;
			VehicleInfo[veh][mod7] = VM7;
			VehicleInfo[veh][mod8] = VM8;
			VehicleInfo[veh][mod9] = VM9;
			VehicleInfo[veh][mod10] = VM10;
			VehicleInfo[veh][mod11] = VM11;
			VehicleInfo[veh][mod12] = VM12;
			VehicleInfo[veh][mod13] = VM13;
			VehicleInfo[veh][mod14] = VM14;
			VehicleInfo[veh][mod15] = VM15;
			VehicleInfo[veh][mod16] = VM16;
			VehicleInfo[veh][mod17] = VM17;
			VehicleInfo[veh][slot] = 0;
			PlayerInfo[playerid][PlayerVehicle][0] = veh;
			PlayerInfo[playerid][PlayerVehicleKey][0] = V_VKEY;
			ChangeVehiclePaintjob(veh, VehicleInfo[veh][vpaintjob]);
	    	ModVehicle(veh);
		}
	}
	if(PlayerInfo[playerid][PlayerVehicle][1] == -1)
    {
		new Query[150],
			DBResult:Result;
		format(Query, sizeof(Query), "SELECT * FROM `VEHS` WHERE `VKEY` = '%d' AND `VD` = '%s'", PlayerInfo[playerid][PlayerVehicleKey][1], PlayerNameNormal(playerid));
		Result = db_query(Database, Query);
		if(db_num_rows(Result))
		{
		    new veh;
		    new V_VKEY, V_VD[24], Float:V_VPOSX, Float:V_VPOSY, Float:V_VPOSZ, Float:V_VANGLE,
		        V_MODEL, VCOL1, VCOL2, VPAINTJOB, VM1,VM2,VM3,VM4,VM5,VM6,VM7,VM8,VM9,VM10,VM11,VM12,VM13,VM14,VM15,VM16,VM17;
		    new f[24];
			db_get_field(Result, 0, f, 24), V_VKEY = strval(f);
			db_get_field(Result, 1, f, 24), format(V_VD, 24, "%s", f);
			db_get_field(Result, 2, f, 24), V_VPOSX = floatstr(f);
			db_get_field(Result, 3, f, 24), V_VPOSY = floatstr(f);
			db_get_field(Result, 4, f, 24), V_VPOSZ = floatstr(f);
			db_get_field(Result, 5, f, 24), V_VANGLE = floatstr(f);
			db_get_field(Result, 6, f, 24), V_MODEL = strval(f);
			db_get_field(Result, 7, f, 24), VCOL1 = strval(f);
			db_get_field(Result, 8, f, 24), VCOL2 = strval(f);
			db_get_field(Result, 9, f, 24), VPAINTJOB = strval(f);
			db_get_field(Result, 10, f, 24), VM1 = strval(f);
			db_get_field(Result, 11, f, 24), VM2 = strval(f);
			db_get_field(Result, 12, f, 24), VM3 = strval(f);
			db_get_field(Result, 13, f, 24), VM4 = strval(f);
			db_get_field(Result, 14, f, 24), VM5 = strval(f);
			db_get_field(Result, 15, f, 24), VM6 = strval(f);
			db_get_field(Result, 16, f, 24), VM7 = strval(f);
			db_get_field(Result, 17, f, 24), VM8 = strval(f);
			db_get_field(Result, 18, f, 24), VM9 = strval(f);
			db_get_field(Result, 19, f, 24), VM10 = strval(f);
			db_get_field(Result, 20, f, 24), VM11 = strval(f);
			db_get_field(Result, 21, f, 24), VM12 = strval(f);
			db_get_field(Result, 22, f, 24), VM13 = strval(f);
			db_get_field(Result, 23, f, 24), VM14 = strval(f);
			db_get_field(Result, 24, f, 24), VM15 = strval(f);
			db_get_field(Result, 25, f, 24), VM16 = strval(f);
			db_get_field(Result, 26, f, 24), VM17 = strval(f);
	        db_free_result(Result);
			new str[20];
			format(str, 20, "XRP%04d", V_VKEY);

			veh = AddStaticVehicleEx(V_MODEL, V_VPOSX, V_VPOSY, V_VPOSZ, V_VANGLE, VCOL1, VCOL2, 500);
			SetVehicleNumberPlate(veh, str);
			SetVehicleToRespawn(veh);


			format(VehicleInfo[veh][VD], 24, "%s", V_VD);
			VehicleInfo[veh][VKEY] = V_VKEY;
		    VehicleInfo[veh][vposx] = V_VPOSX;
			VehicleInfo[veh][vposy] = V_VPOSY;
			VehicleInfo[veh][vposz] = V_VPOSZ;
			VehicleInfo[veh][vangle] = V_VANGLE;
			VehicleInfo[veh][vmodelid] = V_MODEL;
			VehicleInfo[veh][vcolor1] = VCOL1;
			VehicleInfo[veh][vcolor2] = VCOL2;
			VehicleInfo[veh][vpaintjob] = VPAINTJOB;
			VehicleInfo[veh][mod1] = VM1;
			VehicleInfo[veh][mod2] = VM2;
			VehicleInfo[veh][mod3] = VM3;
			VehicleInfo[veh][mod4] = VM4;
			VehicleInfo[veh][mod5] = VM5;
			VehicleInfo[veh][mod6] = VM6;
			VehicleInfo[veh][mod7] = VM7;
			VehicleInfo[veh][mod8] = VM8;
			VehicleInfo[veh][mod9] = VM9;
			VehicleInfo[veh][mod10] = VM10;
			VehicleInfo[veh][mod11] = VM11;
			VehicleInfo[veh][mod12] = VM12;
			VehicleInfo[veh][mod13] = VM13;
			VehicleInfo[veh][mod14] = VM14;
			VehicleInfo[veh][mod15] = VM15;
			VehicleInfo[veh][mod16] = VM16;
			VehicleInfo[veh][mod17] = VM17;
			VehicleInfo[veh][slot] = 1;
			PlayerInfo[playerid][PlayerVehicle][1] = veh;
			PlayerInfo[playerid][PlayerVehicleKey][1] = V_VKEY;
			ChangeVehiclePaintjob(veh, VehicleInfo[veh][vpaintjob]);
	    	ModVehicle(veh);
		}
	}
	if(PlayerInfo[playerid][PlayerVehicle][2] == -1)
    {
		new Query[150],
			DBResult:Result;
		format(Query, sizeof(Query), "SELECT * FROM `VEHS` WHERE `VKEY` = '%d' AND `VD` = '%s'", PlayerInfo[playerid][PlayerVehicleKey][2], PlayerNameNormal(playerid));
		Result = db_query(Database, Query);
		if(db_num_rows(Result))
		{
		    new veh;
		    new V_VKEY, V_VD[24], Float:V_VPOSX, Float:V_VPOSY, Float:V_VPOSZ, Float:V_VANGLE,
		        V_MODEL, VCOL1, VCOL2, VPAINTJOB, VM1,VM2,VM3,VM4,VM5,VM6,VM7,VM8,VM9,VM10,VM11,VM12,VM13,VM14,VM15,VM16,VM17;
		    new f[24];
			db_get_field(Result, 0, f, 24), V_VKEY = strval(f);
			db_get_field(Result, 1, f, 24), format(V_VD, 24, "%s", f);
			db_get_field(Result, 2, f, 24), V_VPOSX = floatstr(f);
			db_get_field(Result, 3, f, 24), V_VPOSY = floatstr(f);
			db_get_field(Result, 4, f, 24), V_VPOSZ = floatstr(f);
			db_get_field(Result, 5, f, 24), V_VANGLE = floatstr(f);
			db_get_field(Result, 6, f, 24), V_MODEL = strval(f);
			db_get_field(Result, 7, f, 24), VCOL1 = strval(f);
			db_get_field(Result, 8, f, 24), VCOL2 = strval(f);
			db_get_field(Result, 9, f, 24), VPAINTJOB = strval(f);
			db_get_field(Result, 10, f, 24), VM1 = strval(f);
			db_get_field(Result, 11, f, 24), VM2 = strval(f);
			db_get_field(Result, 12, f, 24), VM3 = strval(f);
			db_get_field(Result, 13, f, 24), VM4 = strval(f);
			db_get_field(Result, 14, f, 24), VM5 = strval(f);
			db_get_field(Result, 15, f, 24), VM6 = strval(f);
			db_get_field(Result, 16, f, 24), VM7 = strval(f);
			db_get_field(Result, 17, f, 24), VM8 = strval(f);
			db_get_field(Result, 18, f, 24), VM9 = strval(f);
			db_get_field(Result, 19, f, 24), VM10 = strval(f);
			db_get_field(Result, 20, f, 24), VM11 = strval(f);
			db_get_field(Result, 21, f, 24), VM12 = strval(f);
			db_get_field(Result, 22, f, 24), VM13 = strval(f);
			db_get_field(Result, 23, f, 24), VM14 = strval(f);
			db_get_field(Result, 24, f, 24), VM15 = strval(f);
			db_get_field(Result, 25, f, 24), VM16 = strval(f);
			db_get_field(Result, 26, f, 24), VM17 = strval(f);
	        db_free_result(Result);
			new str[20];
			format(str, 20, "XRP%04d", V_VKEY);

			veh = AddStaticVehicleEx(V_MODEL, V_VPOSX, V_VPOSY, V_VPOSZ, V_VANGLE, VCOL1, VCOL2, 500);
			SetVehicleNumberPlate(veh, str);
			SetVehicleToRespawn(veh);


			format(VehicleInfo[veh][VD], 24, "%s", V_VD);
			VehicleInfo[veh][VKEY] = V_VKEY;
		    VehicleInfo[veh][vposx] = V_VPOSX;
			VehicleInfo[veh][vposy] = V_VPOSY;
			VehicleInfo[veh][vposz] = V_VPOSZ;
			VehicleInfo[veh][vangle] = V_VANGLE;
			VehicleInfo[veh][vmodelid] = V_MODEL;
			VehicleInfo[veh][vcolor1] = VCOL1;
			VehicleInfo[veh][vcolor2] = VCOL2;
			VehicleInfo[veh][vpaintjob] = VPAINTJOB;
			VehicleInfo[veh][mod1] = VM1;
			VehicleInfo[veh][mod2] = VM2;
			VehicleInfo[veh][mod3] = VM3;
			VehicleInfo[veh][mod4] = VM4;
			VehicleInfo[veh][mod5] = VM5;
			VehicleInfo[veh][mod6] = VM6;
			VehicleInfo[veh][mod7] = VM7;
			VehicleInfo[veh][mod8] = VM8;
			VehicleInfo[veh][mod9] = VM9;
			VehicleInfo[veh][mod10] = VM10;
			VehicleInfo[veh][mod11] = VM11;
			VehicleInfo[veh][mod12] = VM12;
			VehicleInfo[veh][mod13] = VM13;
			VehicleInfo[veh][mod14] = VM14;
			VehicleInfo[veh][mod15] = VM15;
			VehicleInfo[veh][mod16] = VM16;
			VehicleInfo[veh][mod17] = VM17;
			VehicleInfo[veh][slot] = 2;
			PlayerInfo[playerid][PlayerVehicle][2] = veh;
			PlayerInfo[playerid][PlayerVehicleKey][2] = V_VKEY;
			ChangeVehiclePaintjob(veh, VehicleInfo[veh][vpaintjob]);
	    	ModVehicle(veh);
		}
	}
	if(PlayerInfo[playerid][PlayerVehicle][3] == -1)
    {
		new Query[150],
			DBResult:Result;
		format(Query, sizeof(Query), "SELECT * FROM `VEHS` WHERE `VKEY` = '%d' AND `VD` = '%s'", PlayerInfo[playerid][PlayerVehicleKey][3], PlayerNameNormal(playerid));
		Result = db_query(Database, Query);
		if(db_num_rows(Result))
		{
		    new veh;
		    new V_VKEY, V_VD[24], Float:V_VPOSX, Float:V_VPOSY, Float:V_VPOSZ, Float:V_VANGLE,
		        V_MODEL, VCOL1, VCOL2, VPAINTJOB, VM1,VM2,VM3,VM4,VM5,VM6,VM7,VM8,VM9,VM10,VM11,VM12,VM13,VM14,VM15,VM16,VM17;
		    new f[24];
			db_get_field(Result, 0, f, 24), V_VKEY = strval(f);
			db_get_field(Result, 1, f, 24), format(V_VD, 24, "%s", f);
			db_get_field(Result, 2, f, 24), V_VPOSX = floatstr(f);
			db_get_field(Result, 3, f, 24), V_VPOSY = floatstr(f);
			db_get_field(Result, 4, f, 24), V_VPOSZ = floatstr(f);
			db_get_field(Result, 5, f, 24), V_VANGLE = floatstr(f);
			db_get_field(Result, 6, f, 24), V_MODEL = strval(f);
			db_get_field(Result, 7, f, 24), VCOL1 = strval(f);
			db_get_field(Result, 8, f, 24), VCOL2 = strval(f);
			db_get_field(Result, 9, f, 24), VPAINTJOB = strval(f);
			db_get_field(Result, 10, f, 24), VM1 = strval(f);
			db_get_field(Result, 11, f, 24), VM2 = strval(f);
			db_get_field(Result, 12, f, 24), VM3 = strval(f);
			db_get_field(Result, 13, f, 24), VM4 = strval(f);
			db_get_field(Result, 14, f, 24), VM5 = strval(f);
			db_get_field(Result, 15, f, 24), VM6 = strval(f);
			db_get_field(Result, 16, f, 24), VM7 = strval(f);
			db_get_field(Result, 17, f, 24), VM8 = strval(f);
			db_get_field(Result, 18, f, 24), VM9 = strval(f);
			db_get_field(Result, 19, f, 24), VM10 = strval(f);
			db_get_field(Result, 20, f, 24), VM11 = strval(f);
			db_get_field(Result, 21, f, 24), VM12 = strval(f);
			db_get_field(Result, 22, f, 24), VM13 = strval(f);
			db_get_field(Result, 23, f, 24), VM14 = strval(f);
			db_get_field(Result, 24, f, 24), VM15 = strval(f);
			db_get_field(Result, 25, f, 24), VM16 = strval(f);
			db_get_field(Result, 26, f, 24), VM17 = strval(f);
	        db_free_result(Result);
			new str[20];
			format(str, 20, "XRP%04d", V_VKEY);

			veh = AddStaticVehicleEx(V_MODEL, V_VPOSX, V_VPOSY, V_VPOSZ, V_VANGLE, VCOL1, VCOL2, 500);
			SetVehicleNumberPlate(veh, str);
			SetVehicleToRespawn(veh);

			format(VehicleInfo[veh][VD], 24, "%s", V_VD);
			VehicleInfo[veh][VKEY] = V_VKEY;
		    VehicleInfo[veh][vposx] = V_VPOSX;
			VehicleInfo[veh][vposy] = V_VPOSY;
			VehicleInfo[veh][vposz] = V_VPOSZ;
			VehicleInfo[veh][vangle] = V_VANGLE;
			VehicleInfo[veh][vmodelid] = V_MODEL;
			VehicleInfo[veh][vcolor1] = VCOL1;
			VehicleInfo[veh][vcolor2] = VCOL2;
			VehicleInfo[veh][vpaintjob] = VPAINTJOB;
			VehicleInfo[veh][mod1] = VM1;
			VehicleInfo[veh][mod2] = VM2;
			VehicleInfo[veh][mod3] = VM3;
			VehicleInfo[veh][mod4] = VM4;
			VehicleInfo[veh][mod5] = VM5;
			VehicleInfo[veh][mod6] = VM6;
			VehicleInfo[veh][mod7] = VM7;
			VehicleInfo[veh][mod8] = VM8;
			VehicleInfo[veh][mod9] = VM9;
			VehicleInfo[veh][mod10] = VM10;
			VehicleInfo[veh][mod11] = VM11;
			VehicleInfo[veh][mod12] = VM12;
			VehicleInfo[veh][mod13] = VM13;
			VehicleInfo[veh][mod14] = VM14;
			VehicleInfo[veh][mod15] = VM15;
			VehicleInfo[veh][mod16] = VM16;
			VehicleInfo[veh][mod17] = VM17;
			VehicleInfo[veh][slot] = 3;
			PlayerInfo[playerid][PlayerVehicle][3] = veh;
			PlayerInfo[playerid][PlayerVehicleKey][3] = V_VKEY;
			ChangeVehiclePaintjob(veh, VehicleInfo[veh][vpaintjob]);
	    	ModVehicle(veh);
		}
	}
	return 1;
}

funcion:DestroyPlayerVehicle(vehicleid)
{
	new ocupado = 0;
	foreach(new i : Player)
	{
    	if(IsPlayerInVehicle(i, vehicleid)) ocupado = 1;
	}
	if(ocupado == 0)
	{
	    format(VehicleInfo[vehicleid][VD], 24, "null");
	    VehicleInfo[vehicleid][VKEY] = -1;
	    VehicleInfo[vehicleid][slot] = -1;
  		DestroyVehicle(vehicleid);
	}
	else DestroyVehiclesTimer[vehicleid] = SetTimerEx("DestroyPlayerVehicle", 5000, false, "d", vehicleid);
}

funcion:SaveComponent(playerid, vehicleid,componentid)
{

	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
    	    if(!strcmp(VehicleInfo[vehicleid][VD], PlayerNameNormal(playerid), false))
			{
				for(new s=0; s<20; s++) {
     				if(componentid == spoiler[s][0]) {
       					VehicleInfo[vehicleid][mod1] = componentid;
   	        		}
				}
				for(new s=0; s<3; s++) {
     				if(componentid == nitro[s][0]) {
       					VehicleInfo[vehicleid][mod2] = componentid;
   	        		}
				}
				for(new s=0; s<23; s++) {
     				if(componentid == fbumper[s][0]) {
       					VehicleInfo[vehicleid][mod3] = componentid;
   	        		}
				}
				for(new s=0; s<22; s++) {
     				if(componentid == rbumper[s][0]) {
       					VehicleInfo[vehicleid][mod4] = componentid;
   	        		}
				}
				for(new s=0; s<28; s++) {
     				if(componentid == exhaust[s][0]) {
       					VehicleInfo[vehicleid][mod5] = componentid;
   	        		}
				}
				for(new s=0; s<2; s++) {
     				if(componentid == bventr[s][0]) {
       					VehicleInfo[vehicleid][mod6] = componentid;
   	        		}
				}
				for(new s=0; s<2; s++) {
     				if(componentid == bventl[s][0]) {
       					VehicleInfo[vehicleid][mod7] = componentid;
   	        		}
				}
				for(new s=0; s<4; s++) {
     				if(componentid == bscoop[s][0]) {
       					VehicleInfo[vehicleid][mod8] = componentid;
   	        		}
				}
				for(new s=0; s<17; s++) {
     				if(componentid == rscoop[s][0]) {
       					VehicleInfo[vehicleid][mod9] = componentid;
   	        		}
				}
				for(new s=0; s<21; s++) {
     				if(componentid == lskirt[s][0]) {
       					VehicleInfo[vehicleid][mod10] = componentid;
   	        		}
				}
				for(new s=0; s<21; s++) {
     				if(componentid == rskirt[s][0]) {
       					VehicleInfo[vehicleid][mod11] = componentid;
   	        		}
				}
				for(new s=0; s<1; s++) {
     				if(componentid == hydraulics[s][0]) {
       					VehicleInfo[vehicleid][mod12] = componentid;
   	        		}
				}
				for(new s=0; s<1; s++) {
     				if(componentid == vbase[s][0]) {
       					VehicleInfo[vehicleid][mod13] = componentid;
   	        		}
				}
				for(new s=0; s<4; s++) {
     				if(componentid == rbbars[s][0]) {
       					VehicleInfo[vehicleid][mod14] = componentid;
   	        		}
				}
				for(new s=0; s<2; s++) {
     				if(componentid == fbbars[s][0]) {
       					VehicleInfo[vehicleid][mod15] = componentid;
   	        		}
				}
				for(new s=0; s<17; s++) {
     				if(componentid == wheels[s][0]) {
       					VehicleInfo[vehicleid][mod16] = componentid;
   	        		}
				}
				for(new s=0; s<2; s++) {
     				if(componentid == lights[s][0]) {
       					VehicleInfo[vehicleid][mod17] = componentid;
   	        		}
				}
				return 1;
			}
	}
	return 0;
}

stock GetVehicleModelGrotti(id)
{
	switch(id)
	{
	    case 0: return 506;
	    case 1: return 451;
	    case 2: return 429;
	    case 3: return 411;
	    case 4: return 541;
	    case 5: return 415;
	    case 6: return 603;
	}
	return -1;
}

stock GetVehiclePriceGrotti(id)
{
	switch(id)
	{
	    case 0: return 300000;
	    case 1: return 350000;
	    case 2: return 190000;
	    case 3: return 450000;
	    case 4: return 260000;
	    case 5: return 420000;
	    case 6: return 80000;
	}
	return -1;
}

stock RotateObject(objectid, Float:rotX, Float:rotY, Float:rotZ, Float:Speed)
{
	new Float:X, Float:Y, Float:Z;
	GetObjectPos(objectid, X, Y, Z);
	printf("%.4f", Speed);
	//MoveObject(objectid, X, Y, Z,
	return 1;
}
/*
				eXtreme RolePlay
				        En proceso de creación.





							SQLite Server

	adri1, Ner0x, Jeff, Martin, inuckles, raul.lg98, Sirgio, Angelyto



							    includes

						YSI			- Y_Less
						ZCMD		- Zeex
						SSCANF		- Y_Less
						STREANER	- Incognito
*/
