/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 5;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "monospace:size=26" };
static const char dmenufont[]       = "monospace:size=26";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

typedef struct {
	const char *name;
	const void *cmd;
} Sp;
/*const char *spcmd1[] = {"urxvt", "-name", "spterm", "-geometry", "80x20", NULL };*/
const char *spcmd1[] = {"st", "-n", "spterm", "-g", "80x20", NULL };
const char *spcmd2[] = {"st", "-n", "spfm", "-g", "80x20", "-e", "ranger", NULL };
/*const char *spcmd3[] = {"st", "-n", "spminiterm", "-g", "48x12", "-f", "monospace:size=16" NULL };*/
const char *spcmd3[] = {"st", "-n", "spminiterm", "-g", "80x12", NULL };
const char *spcmd4[] = {"st", "-n", "sptinyterm", "-g", "130x8", "-f", "monospace:size=16", NULL };
/*const char *spcmd5[] = {"simplescreenrecorder", NULL };
const char *spcmd6[] = {"leafpad", NULL };*/
/*const char *spcmd2[] = {"urxvt", "-name", "spfm", "-geometry", "80x20", "-e", "ranger", NULL };*/
/*const char *spcmd3[] = {"keepassxc", NULL };*/
static Sp scratchpads[] = {
	/* name          cmd  */
	{"spterm",      spcmd1},
	{"spfm",        spcmd2},
	{"spminiterm",  spcmd3},
	{"sptinyterm",  spcmd4},
/*	{"sprec",       spcmd5},
	{"spnote",      spcmd6},*/
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "feh", 	NULL,	   NULL,       0,	     0,		  -1 },
	{ "TelegramDesktop",NULL,  NULL,       1 << 4,       0,           -1 },
	{ "Google-chrome", NULL,   NULL,       1 << 3,       0,           -1 },
	{ "Pidgin",     NULL,      NULL,       1 << 5,       0,           -1 },
	{ "SimpleScreenRecorder",  NULL,       NULL,         1 << 4,       0,           -1 },
	{ NULL,	       "spterm",   NULL,       SPTAG(0),     1,		  -1 },
	{ NULL,	       "spfm",	   NULL,       SPTAG(1),     1,		  -1 },
	{ NULL,	       "spminiterm", NULL,     SPTAG(2),     1,	          -1 },
	{ NULL,	       "sptinyterm", NULL,     SPTAG(3),     1,	          -1 },
/*	{ NULL,	       "sprec",    NULL,       SPTAG(4),     1,	          -1 },
	{ NULL,	       "spnote",   NULL,       SPTAG(5),     1,	          -1 },*/
};

/* layout(s) */
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[M]",      monocle },
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_recency", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", NULL };


static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_w,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	/*{ MODKEY,            			XK_x,  	   togglescratch,  {.ui = 0 } },
	{ MODKEY,            			XK_z,	   togglescratch,  {.ui = 1 } },
	{ MODKEY,            			XK_y,	   togglescratch,  {.ui = 2 } },*/
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },

	{ Mod4Mask,                     XK_a,      spawn,          SHCMD("sh /home/jonathan/texpander-master/texpander.sh") },
	{ Mod4Mask|ControlMask,         XK_a,      spawn,          SHCMD("sh /home/jonathan/Documents/laptop/scripts/bash-scripts/new-texpander-entry.sh") },
	{ Mod4Mask|ShiftMask,           XK_a,      spawn,          SHCMD("st -e ranger /home/jonathan/Documents/notes/texpander") },
	{ Mod4Mask,                     XK_b,      spawn,          SHCMD("sh /home/jonathan/Documents/laptop/scripts/bash-scripts/bitwarden.sh") },
	{ Mod4Mask,                     XK_c,      spawn,          SHCMD("leafpad /home/jonathan/Documents/laptop/scripts/configs/config.h") },
	{ Mod4Mask|ControlMask,         XK_c,      spawn,          SHCMD("leafpad /home/jonathan/Documents/laptop/scripts/configs/bashrc") },
	{ Mod4Mask|ShiftMask,           XK_c,      spawn,          SHCMD("leafpad /home/jonathan/Documents/laptop/scripts/configs/rc.conf") },
	{ Mod4Mask|ShiftMask|ControlMask,   XK_c,  spawn,          SHCMD("leafpad /home/jonathan/Documents/laptop/scripts/configs/rifle.conf") },
	{ MODKEY|Mod4Mask,              XK_c,      spawn,          SHCMD("sh /home/jonathan/Documents/common-scripts/croc-copy-send.sh") },
	{ Mod4Mask,                     XK_d,      spawn,          SHCMD("st sh /home/jonathan/Documents/common-scripts/calendar.sh 1") },
	{ Mod4Mask|ControlMask,         XK_d,      spawn,          SHCMD("st sh /home/jonathan/Documents/common-scripts/calendar.sh 2") },
	{ Mod4Mask,                     XK_e,      spawn,          SHCMD("st -e ranger /home/jonathan/Documents/excel/shs/20-21") },
	{ Mod4Mask,                     XK_g,      spawn,          SHCMD("sh /home/jonathan/Documents/laptop/scripts/bash-scripts/gromit-mpx.sh") },
	{ Mod4Mask|ControlMask,         XK_g,      spawn,          SHCMD("google-chrome-stable") },
	{ Mod4Mask,                     XK_l,      spawn,          SHCMD("sh /home/jonathan/Documents/common-scripts/transform-text.sh lower") },
	{ Mod4Mask|ControlMask,         XK_l,      spawn,          SHCMD("sh /home/jonathan/Documents/common-scripts/transform-text.sh upper") },
	{ Mod4Mask|ShiftMask,           XK_l,      spawn,          SHCMD("sh /home/jonathan/Documents/common-scripts/transform-text.sh camel") },
	{ MODKEY|Mod4Mask,              XK_l,      spawn,          SHCMD("sh /home/jonathan/Documents/common-scripts/transform-text.sh spinal") },
	{ MODKEY|Mod4Mask|ControlMask,  XK_l,      spawn,          SHCMD("sh /home/jonathan/Documents/laptop/scripts/bash-scripts/launch-class.sh") },
/*	{ Mod4Mask,                     XK_m,      togglescratch,  {.ui = 5 } },*/
	{ Mod4Mask,                     XK_m,      spawn,          SHCMD("leafpad") },
	{ Mod4Mask,                     XK_n,      spawn,          SHCMD("st -e ranger /home/jonathan/Documents/notes") },
	{ Mod4Mask|ControlMask,         XK_n,      spawn,          SHCMD("sh /home/jonathan/Documents/laptop/scripts/bash-scripts/new-note.sh") },
	{ Mod4Mask,                     XK_p,      spawn,          SHCMD("pidgin") },
	{ Mod4Mask,                     XK_q,      spawn,          SHCMD("sh /home/jonathan/Documents/laptop/scripts/bash-scripts/turn-off-monitor.sh") },	
	{ Mod4Mask|ControlMask,         XK_q,      spawn,          SHCMD("poweroff") },
	{ Mod4Mask|ControlMask,         XK_r,      spawn,          SHCMD("leafpad /home/jonathan/Documents/laptop/scripts/python-scripts/recitation-manager/student-names.txt") },
	{ Mod4Mask,                     XK_r,      spawn,          SHCMD("sh /home/jonathan/Documents/laptop/scripts/bash-scripts/cp-attendance.sh") },
	{ Mod4Mask|ShiftMask,           XK_r,      spawn,          SHCMD("sh /home/jonathan/Documents/laptop/scripts/bash-scripts/remove-newlines.sh") },
	{ Mod4Mask,                     XK_s,      spawn,          SHCMD("sh /home/jonathan/Documents/laptop/scripts/bash-scripts/screenshot.sh") },
	{ Mod4Mask|ControlMask,         XK_s,      spawn,          SHCMD("sh /home/jonathan/Documents/laptop/scripts/bash-scripts/screenshot.sh selection") },
	{ Mod4Mask|ShiftMask,           XK_s,      spawn,          SHCMD("simplescreenrecorder") },
	{ Mod4Mask,                     XK_t,      spawn,          SHCMD("telegram-desktop") },
	{ Mod4Mask,                     XK_u,      spawn,          SHCMD("st sh /home/jonathan/Documents/laptop/scripts/bash-scripts/update.sh") },
	{ Mod4Mask|ControlMask,         XK_u,      spawn,          SHCMD("st sh /home/jonathan/Documents/laptop/scripts/bash-scripts/update-compile.sh") },
	{ Mod4Mask,                     XK_v,      spawn,          SHCMD("clipmenu -i -fn Terminus:size=16 -nb '#002b36' -nf '#839496' -sb '#073642' -sf '#93a1a1'") },	
	{ MODKEY|Mod4Mask,              XK_v,      spawn,          SHCMD("sh /home/jonathan/Documents/laptop/scripts/common-scripts/croc-receive-paste.sh") },
	{ Mod4Mask,                     XK_w,      spawn,          SHCMD("firefox") },
	{ Mod4Mask|ControlMask,         XK_w,      spawn,          SHCMD("firefox -profile '/home/jonathan/.mozilla/profiles/personal'") },
	{ Mod4Mask|ShiftMask,	        XK_w,      spawn,          SHCMD("firefox -profile '/home/jonathan/.mozilla/profiles/work'") },
	{ Mod4Mask,              	XK_x,  	   togglescratch,  {.ui = 0 } },
	{ Mod4Mask|ShiftMask,           XK_x,      spawn,          SHCMD("st") },
	{ Mod4Mask|ControlMask,         XK_x,      togglescratch,  {.ui = 2 } },
	{ MODKEY|Mod4Mask,              XK_x,      togglescratch,  {.ui = 3 } },
	{ Mod4Mask,                     XK_y,      spawn,          SHCMD("sh /home/jonathan/Documents/laptop/scripts/bash-scripts/restart-dwm.sh") },
	{ Mod4Mask|ControlMask,         XK_y,      spawn,          SHCMD("reboot") },
	{ Mod4Mask,              	XK_z,  	   togglescratch,  {.ui = 1 } },
	{ Mod4Mask|ControlMask,         XK_z,      spawn,          SHCMD("st -e ranger /home/jonathan") },
	{ Mod4Mask|ShiftMask,           XK_z,      spawn,          SHCMD("st -e ranger /home/jonathan/Documents/laptop/scripts") },
	{ MODKEY|Mod4Mask,              XK_z,      spawn,          SHCMD("pcmanfm") },
	/*{ MODKEY,                       XK_d,      spawn,          SHCMD("sh /home/jonathan/Documents/laptop/scripts/bin/dmenu_run_history") },*/
	{ MODKEY,                       XK_x,      spawn,          SHCMD("gromit-mpx --toggle") },
	{ MODKEY|ControlMask,           XK_x,      spawn,          SHCMD("gromit-mpx --visibility") },
	{ MODKEY|ShiftMask,             XK_x,      spawn,          SHCMD("gromit-mpx --quit") },
	{ MODKEY|ControlMask,           XK_z,      spawn,          SHCMD("gromit-mpx --undo") },
	{ MODKEY|ShiftMask,             XK_z,      spawn,          SHCMD("gromit-mpx --redo") },
	{ MODKEY,                       XK_z,      spawn,          SHCMD("gromit-mpx --clear") },
	/*{ Mod4Mask,                     XK_period, spawn,          SHCMD("sh /home/jonathan/Documents/common-scripts/right-click.sh") },	*/
	{ Mod4Mask,                     XK_BackSpace, spawn,       SHCMD("sh /home/jonathan/Documents/common-scripts/delete-word.sh") },
	
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button1,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

