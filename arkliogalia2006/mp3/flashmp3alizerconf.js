var FMrConf = 
{
	// If you're using this script on several pages, 
	// it's good to keep playlist.html in a separate folder, 
	// along with the js files. So you may want to do something like:
	//
	// playlistFile : "../javascript/playlist.html",
	//
	// or
	//
	// playlistFile : "/html/stuff/playlist.html",

	playlistFile : "playlist.html",
	
	popupWidth : 250,
	popupHeight : 400,

	// Only change these if you have some obscure reason to want 
	// to keep control of the id's of the HTML elements in your playlist.html
	playerId : "FMrPlayer",
	playlistId : "FMrPlaylist",
	
	// If the script is kind of flaky (sometimes work, sometimes doesn't),
	// it could be becuase of the way i'm setting it up. You may want to
	// try setting the value below to "true" (without the quotes)
	useOnLoad : false
}