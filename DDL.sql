
--Drop the tables if needed 

/*
DROP TABLE IF EXISTS Goal;
DROP TABLE IF EXISTS Card;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Player;
DROP TABLE IF EXISTS Coach_Nationality;
DROP TABLE IF EXISTS Coach;
DROP TABLE IF EXISTS Team;
DROP TABLE IF EXISTS Referee_Nationality;
DROP TABLE IF EXISTS Referee;
DROP TABLE IF EXISTS Stadium;
*/

--Create the tables
CREATE TABLE Stadium (
	Stadium_ID INT NOT NULL PRIMARY KEY,
	Name VARCHAR(30),
	Location VARCHAR(30),
	Capacity INT
);

CREATE TABLE Referee (
	Referee_ID INT NOT NULL PRIMARY KEY,
	First_Name VARCHAR(30),
	Last_Name VARCHAR(30),
	Age INT,
	Nationality VARCHAR(30)
);

CREATE TABLE Team (
	Team_ID INT NOT NULL PRIMARY KEY,
	Country VARCHAR(30)
);

CREATE TABLE Coach (
	Coach_ID INT NOT NULL PRIMARY KEY,
	First_Name VARCHAR(30),
	Last_Name VARCHAR(30),
	Age INT,
	Team_ID INT,
	Nationality VARCHAR(30),
	CONSTRAINT FK_Coach_Team_ID FOREIGN KEY (Team_ID) REFERENCES Team(Team_ID)
);

CREATE TABLE Player (
	Player_ID INT NOT NULL PRIMARY KEY,
	First_Name VARCHAR(30),
	Last_Name VARCHAR(30),
	Age INT,
	Team_ID INT,
	Club VARCHAR(30),
	Position VARCHAR(30),
	Minutes_Played INT,
	CONSTRAINT FK_Player_Team_ID FOREIGN KEY (Team_ID) REFERENCES Team(Team_ID)
);

CREATE TABLE Game (
	Game_ID INT NOT NULL PRIMARY KEY,
	Team1_ID INT,
	Team2_ID INT,
	Winner_ID INT,
	Score VARCHAR(20),
	Referee_ID INT, 
	Stadium_ID INT,
	Date DATE,
	Description VARCHAR(50),
	CONSTRAINT FK_Game_Team1_ID FOREIGN KEY (Team1_ID) REFERENCES Team(Team_ID),
	CONSTRAINT FK_Game_Team2_ID FOREIGN KEY (Team2_ID) REFERENCES Team(Team_ID),
	CONSTRAINT FK_Game_Winner_ID FOREIGN KEY (Winner_ID) REFERENCES Team(Team_ID),
	CONSTRAINT FK_Game_Referee_ID FOREIGN KEY (Referee_ID) REFERENCES Referee(Referee_ID),
	CONSTRAINT FK_Stadium_ID FOREIGN KEY (Stadium_ID) REFERENCES Stadium(Stadium_ID)
);

CREATE TABLE Goal (
	Goal_ID INT NOT NULL PRIMARY KEY,
	Player_ID INT,
	Game_ID INT, 
	Minutes INT,
	Own_Goal BOOLEAN DEFAULT False,
	CONSTRAINT FK_Goal_Player_ID FOREIGN KEY (Player_ID) REFERENCES Player(Player_ID),
	CONSTRAINT FK_Goal_Game_ID FOREIGN KEY (Game_ID) REFERENCES Game(Game_ID)
);

CREATE TABLE Card (
	Card_ID INT NOT NULL PRIMARY KEY,
	Player_ID INT,
	Game_ID INT,
	Type ENUM('yellow', 'red'),
	Minute INT,
	CONSTRAINT FK_Card_Player_ID FOREIGN KEY (Player_ID) REFERENCES Player(Player_ID),
	CONSTRAINT FK_Card_Game_ID FOREIGN KEY (Game_ID) REFERENCES Game(Game_ID)
);
