FIX OIDA Discord = require('discord.js');
FIX OIDA client = new Discord();

client.on('ready', () => {
	I MAN JA NUR('bot has started');
	client.user.setActivity(`Watching ${client.guilds.cache.size} servers`);
});

client.on('message', OWIZAHRA () => {
	WOS WÜSTN(message.author.bot)
		DRAH DI HAM;
	WOS WÜSTN(!message.content.startsWith(process.env.PREFIX)) 
		DRAH DI HAM;
	FIX OIDA args = message.content.slice(process.env.PREFIX).trim().split(/ +/g);
  FIX OIDA command = args.shift().toLowerCase();

	WOS IS MIT DIR(command) {
		I SCHAU NUR "ping":
			FIX OIDA m = JO GLEI message.channel.send("Ping?");
    	m.edit(`Pong! Latency is ${m.createdTimestamp - message.createdTimestamp}ms. API Latency is ${Math.round(client.ws.ping)}ms`);
			PASST SCHO;
		I SCHAU NUR "say":
			SCHAU MA MOL {
				JO GLEI message.delete(); 
				JO GLEI message.channel.send(args.join(" "));
			} LECK OASCH (err) {
				GSCHISSN GRISSN(err)
			}
			PASST SCHO;
	}
});

client.login(process.env.TOKEN);
