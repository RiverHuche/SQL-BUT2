INSERT INTO TYPEOO (typeO) VALUES 
    ('Ecole'),
    ('Mairie'),
    ('Association'),
    ('Particulier');

INSERT INTO SALLE (nomSalle, capacite) VALUES
    ('SalleA', 50),
    ('SalleB', 30),
    ('SalleC', 100);

INSERT INTO OCCUPANT (idO, nom, carac, typeO) VALUES
    (1, 'Jean', 'Directeur', 'Ecole'),
    (2, 'Marie', 'Secrétaire', 'Mairie'),
    (3, 'Paul', 'Président', 'Association'),
    (4, 'Lucie', 'Indépendant', 'Particulier');

INSERT INTO RESERVER (dateR, heuredeb, nomSalle, duree, nbPersonne, idO) VALUES
    ('2025-09-10', 9, 'SalleA', 2, 25, 1),
    ('2025-09-10', 14, 'SalleB', 3, 20, 2),
    ('2025-09-11', 10, 'SalleC', 1, 80, 3),
    ('2025-09-11', 16, 'SalleA', 2, 40, 4),
    ('2025-09-15', 10, 'SalleC', 2, 20, 2);


INSERT INTO ACCUEILLIR (nomSalle, typeO) VALUES
    ('SalleA', 'Ecole'),
    ('SalleA', 'Association'),
    ('SalleB', 'Mairie'),
    ('SalleB', 'Particulier'),
    ('SalleC', 'Ecole'),
    ('SalleC', 'Mairie'),
    ('SalleC', 'Association'),
    ('SalleC', 'Particulier');