Config = {}

-- Coordonnées du PNJ de blanchiment
Config.NPC = {
    x = 106.3127,
    y = 493.5058,
    z = 148.1481,
	h = 279.2416687011719
}

Config.InteractionDistance = 2.0 -- La distance à laquelle le joueur peut interagir avec le PNJ
-- Montant d'argent propre obtenu par unité d'argent sale blanchi
Config.CleaningRate = 0.75 -- Exemple : 0.75 signifie 75% d'argent propre par rapport à l'argent sale

-- Cooldown du blanchiment en secondes
Config.CleaningCooldown = 120 -- 2 minutes

-- Messages
Config.Messages = {
    NoPermission = "Vous n'avez pas la permission de blanchir de l'argent.",
    ApproachNPC = "Approchez-vous du PNJ pour blanchir de l'argent.",
    MenuTitle = "Blanchiment d'argent",
    MenuPrompt = "Montant d'argent sale à blanchir :",
    InvalidAmount = "Montant invalide. Veuillez entrer un nombre positif.",
    CleaningInProgress = "Blanchiment d'argent en cours...",
    CleaningSuccess = "Vous avez blanchi %s d'argent sale et obtenu %s d'argent propre.",
    CleaningCooldown = "Vous devez attendre avant de pouvoir blanchir de l'argent à nouveau."
}
