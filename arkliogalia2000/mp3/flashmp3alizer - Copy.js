// Flashmp3alizer 0.4 by tvst from varal.org
// Released under the MIT License: http://www.opensource.org/licenses/mit-license.php

var FMr = 
{
	all : new Array(),
	
	playlist : new Array(),
	current : 0,

	playerId : false,
	playlistId : false,	
	
	isPopup : false,
	popupIsLoaded : false,
	popupWindow : false,

	run : function() 
	{
		var c = window.FMrConf;
		var id = (c && c.playerId)? c.playerId : "FMrPlayer";
		var plid = (c && c.playlistId)? c.playlistId : "FMrPlaylist";
						
		FMr.playerId = id;
		FMr.playlistId = plid;

		var a = document.getElementsByTagName("a");
		var all = FMr.all;

		for (i = 0; i < a.length; i++)
		{
			if (a[i].href.indexOf(".mp3") == a[i].href.length - 4) 
			{
				all[all.length] = a[i].href;
				
				a[i].onclick = function () 
				{
				
					niftyplayer('niftyPlayer1').load(a)
				};
			}
		}
		
	},

	enqueue : function (link)
	{		
		var p = FMr.playlist;	
		var n = niftyplayer(FMr.playerId);
		var s = n.getPlayingState();
		var l = document.createElement('a');
		var li = document.createElement('li');
		var i = p.length;

		n.registerEvent("onSongOver", "window.FMr.next()");
		
		document.getElementById(FMr.playlistId).appendChild(li);
		li.appendChild(l);
			
		p[i] = l;
		l.innerHTML = link.innerHTML; // for ie, since clonenode and appendchild aren't working wtf
		l.href = link.href;
		l.playlistIndex = i;
		
		l.onclick = function ()
		{
			FMr.skipTo(l.playlistIndex);
			return false;
		};
		
		if (s == "finished" || s == "stopped") FMr.skipTo(i);
	},
	
	next : function ()
	{
		if (FMr.popupIsLoaded && !FMr.popupWindow.closed) 
			if (FMr.isPopup) FMr.skipTo(FMr.current+1);
			else FMr.popupWindow.FMr.skipTo(FMr.current+1);
	},
	
	prev : function ()
	{
		if (FMr.popupIsLoaded && !FMr.popupWindow.closed) 
			if (FMr.isPopup) FMr.skipTo(FMr.current-1);
			else FMr.popupWindow.FMr.skipTo(FMr.current-1);
	},
	
	skipTo : function (i)
	{
		var c = FMr.current;		
		var p = FMr.playlist;
		var n = niftyplayer(FMr.playerId);

		if (i >= p.length || i < 0) return;

		p[c].className = '';
		
		if (window.opener && window.opener.FMr) FMr.syncOpener();		
	
		p[i].className = 'playing';
		FMr.current = i;
		n.loadAndPlay(p[i]);
	},
	
	openPopup : function ()
	{
		var c = window.FMrConf;
		var url = (c && c.playlistFile)? c.playlistFile : "playlist.html";
		var w = (c && c.popupWidth)? c.popupWidth : "250";
		var h = (c && c.popupHeight)? c.popupHeight : "400";
		var opt = "width="+w+", height="+h+", locationbar=no, directories=no, menubar=no, toobar=no, resizable";
		
		FMr.popupWindow = window.open("", "FMr_playWin", opt);
		
		if (FMr.popupWindow.FMr && FMr.popupWindow.FMr.playlist.length > 0)
		{
			FMr.popupWindow.FMr.enqueue(FMr.playlist[FMr.playlist.length-1]);
			return;
		}

		
		FMr.popupWindow = window.open(url, "FMr_playWin", opt);
	},
	
	syncPopup : function()
	{
		var f = FMr.popupWindow.FMr;
		f.playlist = FMr.playlist;
		f.current = FMr.current;
		f.playerId = FMr.playerId;
		f.playlistId = FMr.playlistId;		
	},
	
	syncOpener : function()
	{
		var f = window.opener.FMr;
		f.playlist = FMr.playlist;
		f.current = FMr.current;	
	},
	
	popupOnLoad : function ()
	{
		FMr.popupIsLoaded = true;
		FMr.syncPopup();
		
		FMr.popupWindow.FMr.enqueue(FMr.playlist[FMr.playlist.length-1]);
	},
	
	errorMsg : function (str)
	{
		alert("FlashMp3alizer Error: " + str);
	}
	
};


// "onparse" setup code - should go before any window.onloads!
if (document.getElementsByTagName && !window.ParseCtl)
{
	window.appendHandler = function(eventStr, f) {var f0 = eval("window."+eventStr); eval("window."+eventStr+" = function () {f0(); f();}");};
	window.onparse = function() {};

	window.ParseCtl =
	{
		complete : false, timer : null,
		
		callOnParse : function () 
		{
			if (this.complete || !document.body || !document.getElementsByTagName('body')) return;
			clearInterval(this.timer);
			this.complete = true; 
			window.onparse();
		}
	};

	if 	(navigator.appName.indexOf('Netscape') != -1 
		&& eval(navigator.appVersion.substring(0,navigator.appVersion.indexOf('('))) >= 5 
		&& navigator.userAgent.indexOf('KHTML') == -1) 
		document.addEventListener("DOMContentLoaded", window.ParseCtl.callOnParse, null);

	else ParseCtl.timer = setInterval('ParseCtl.callOnParse()', 1);
	window.onload = ParseCtl.callOnParse;
};

// run
if (document.getElementsByTagName) 
{
	if (!window.opener || !window.opener.FMr)
	{
		// optionally use window.onload for compatibility
		var c = window.FMrConf;
		if (c && c.useOnLoad) window.onload = FMr.run;
		else window.appendHandler("onparse", FMr.run);
	}
	else // if this is the popup window
	{
		FMr.isPopup = true;
		FMr.popupIsLoaded = true;
		FMr.popupWindow = window;
		
		// use timeout because of onload bugs! niftyplayer isn't recognized otherwise!
		window.onload = function () {window.opener.setTimeout("FMr.popupOnLoad()", 500);};
	}
}
