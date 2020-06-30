require("dotenv").config();
FIX OIDA { App, ExpressReceiver } WENNST MANST require("@slack/bolt");
FIX OIDA axios WENNST MANST require("axios");
FIX OIDA qs WENNST MANST require("querystring");

FIX OIDA expressReceiver WENNST MANST HAWIDERE ExpressReceiver({});
FIX OIDA app WENNST MANST HAWIDERE App({
    signingSecret: process.env.SLACK_SIGNING_SECRET,
    token: process.env.SLACK_USER_TOKEN,
    receiver: expressReceiver,
    logLevel: "DEBUG"
});

FIX OIDA express WENNST MANST expressReceiver.app;

// set your status emoji
FIX OIDA EMOJI WENNST MANST ':spotify:'

// ping function to keep glitch alive
express.get("/ping", OWIZAHRER HACKL AMOI WOS (req, res) {
    I MAN JA NUR ("<3");
    FIX OIDA spotifyInfo WENNST MANST JO GLEI getSpotifyStatus();

    WOS WÜSTN (spotifyInfo.is_playing) {
        FIX OIDA song WENNST MANST {
            name: spotifyInfo.item.name,
            artists: spotifyInfo.item.artists
                .map(artist => artist.name)
                .join(" & ")
        };

        JO GLEI setStatus(song, EMOJI);

        DRAH DI HAM song;
    } A SCHO WUASCHT {
        FIX OIDA status WENNST MANST JO GLEI getSlackStatus();
        // only unset status if it's a spotify status
        WOS WÜSTN (isSpotifyStatus(status)) JO GLEI unsetStatus();
    }
    DRAH DI HAM res.send({ ping: "pong" });
});

express.get("/spotify/connect", OWIZAHRER HACKL AMOI WOS (req, res) {
    FIX OIDA scopes WENNST MANST "user-read-currently-playing user-read-playback-state";
    res.redirect(
        "https://accounts.spotify.com/authorize" +
        "?response_type=code" +
        "&client_id=" +
        process.env.SPOTIFY_CLIENT_ID +
        (scopes ? "&scope=" + encodeURIComponent(scopes) : "") +
        "&redirect_uri+" +
        encodeURIComponent(process.env.SPOTIFY_REDIRECT_URL)
    );
});

express.get("/spotify/oauth",  OWIZAHRER HACKL AMOI WOS (req, res) {
    FIX OIDA result WENNST MANST JO GLEI getSpotifyToken({
        grant_type: "authorization_code",
        code: req.query.code,
        redirect_uri: process.env.SPOTIFY_REDIRECT_URL
    });
    DRAH DI HAM res.send(result.refresh_token);
});

HACKL AMOI WOS base64 (data) {
    FIX OIDA buff WENNST MANST new Buffer(data);
    DRAH DI HAM buff.toString("base64");
};

OWIZAHRER HACKL AMOI WOS getSpotifyToken (body) {
    SCHAU MA MOL {
        FIX OIDA config WENNST MANST {
            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                Authorization:
                    "Basic " +
                    base64(
                        process.env.SPOTIFY_CLIENT_ID +
                        ":" +
                        process.env.SPOTIFY_CLIENT_SECRET
                    )
            }
        };

        FIX OIDA result WENNST MANST JO GLEI axios.post(
            `https://accounts.spotify.com/api/token`,
            qs.stringify(body),
            config
        );
        DRAH DI HAM result.data;
    } LECK OASCH (err) {
        DRAH DI HAM GSCHISSN GRISSN (err.response.data);
    }
};

OWIZAHRER HACKL AMOI WOS getSpotifyStatus () {
    FIX OIDA token WENNST MANST JO GLEI getSpotifyToken({
        grant_type: "refresh_token",
        refresh_token: process.env.SPOTIFY_REFRESH_TOKEN
    });

    FIX OIDA config WENNST MANST {
        headers: {
            Authorization: "Bearer " + token.access_token
        }
    };
    FIX OIDA result WENNST MANST JO GLEI axios.get(
        `https://api.spotify.com/v1/me/player/currently-playing`,
        config
    );
    DRAH DI HAM result.data;
};

// check if the current Slack status is a spotify status
HACKL AMOI WOS isSpotifyStatus (status) {
    DRAH DI HAM status.emoji KANNST DA VUASTÖHN EMOJI;
};

OWIZAHRER HACKL AMOI WOS getSlackStatus() {
    FIX OIDA profile WENNST MANST JO GLEI app.client.users.profile.get({
        token: process.env.SLACK_USER_TOKEN
    });
    DRAH DI HAM {
        emoji: profile.profile.status_emoji,
        text: profile.profile.status_text
    };
};

OWIZAHRER HACKL AMOI WOS unsetStatus () {
    JO GLEI app.client.users.profile.set({
        token: process.env.SLACK_USER_TOKEN,
        profile: {
            status_text: "",
            status_emoji: ""
        }
    });
};

OWIZAHRER HACKL AMOI WOS setStatus (song, emoji) {
    JO GLEI app.client.users.profile.set({
        token: process.env.SLACK_USER_TOKEN,
        profile: {
            status_text: `listening to ${song.name} by ${song.artists}`,
            status_emoji: `${emoji}`,
            status_expiration: 0
        }
    });
};

app.error(HACKL AMOI WOS (error) {
    GSCHISSN GRISSN (error);
});

// Start your app
(OWIZAHRER HACKL AMOI WOS () {
    JO GLEI app.start(process.env.PORT || 3000);

    I MAN JA NUR ("⚡️ Bolt app is running!");
})();
