-- Création de la base de données
CREATE DATABASE GestionBoites;
GO

USE GestionBoites;
GO

-- Table Client
CREATE TABLE Client (
    ID_Client VARCHAR(6) PRIMARY KEY CHECK (ID_Client LIKE '[a-z][a-z]-[0-9][0-9][0-9]'),
    Nom NVARCHAR(100) NOT NULL
);

-- Table Matière
CREATE TABLE Matiere (
    ID_Matiere INT PRIMARY KEY IDENTITY(1,1),
    Nom_Matiere NVARCHAR(50) NOT NULL
);

-- Table Couleur
CREATE TABLE Couleur (
    ID_Couleur INT PRIMARY KEY IDENTITY(1,1),
    Nom_Couleur NVARCHAR(50) NOT NULL,
    ID_Matiere INT NOT NULL,
    FOREIGN KEY (ID_Matiere) REFERENCES Matiere(ID_Matiere)
);

-- Table Commande
CREATE TABLE Commande (
    ID_Commande INT PRIMARY KEY IDENTITY(1,1),
    Date_Commande DATE NOT NULL,
    ID_Client VARCHAR(6) NOT NULL,
    FOREIGN KEY (ID_Client) REFERENCES Client(ID_Client)
);

-- Table Boîte
CREATE TABLE Boite (
    ID_Boite INT PRIMARY KEY IDENTITY(1,1),
    Longueur INT NOT NULL CHECK (Longueur > 0 AND Longueur <= 1000),
    Largeur INT NOT NULL CHECK (Largeur > 0 AND Largeur <= 1000),
    Hauteur INT NOT NULL CHECK (Hauteur > 0 AND Hauteur <= 1000),
    Surface_Ext AS ((2 * Longueur * Largeur) + (2 * Longueur * Hauteur) + (2 * Largeur * Hauteur)) PERSISTED,
    Prix_Unitaire DECIMAL(10, 2) NOT NULL,
    ID_Commande INT NOT NULL,
    ID_Matiere INT NOT NULL,
    ID_Couleur INT NOT NULL,
    FOREIGN KEY (ID_Commande) REFERENCES Commande(ID_Commande),
    FOREIGN KEY (ID_Matiere) REFERENCES Matiere(ID_Matiere),
    FOREIGN KEY (ID_Couleur) REFERENCES Couleur(ID_Couleur)
);
