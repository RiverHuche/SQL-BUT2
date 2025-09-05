--(a) Afficher l’ensemble des occupants avec leur type.--
SELECT idO, nom, typeO FROM OCCUPANT;

--(b) Afficher toutes les salles qui ont le type ”Association”.--
SELECT nomSalle 
    from SALLE NATURAL JOIN ACCUEILLIR
    where typeO = "Association";


--(c) Afficher les occupants qui ont r´eserv´e la salle des fˆetes ou la salle info.--
select idO, nom 
    from OCCUPANT NATURAL JOIN RESERVER 
    where nomSalle = 'SalleB' or nomSalle ='SalleC';

--(d) Afficher les occupants qui ont r´eserv´e la salle des fˆetes et la salle info.--
select idO, nom 
    from OCCUPANT NATURAL JOIN RESERVER 
    where nomSalle = 'SalleB'
    intersect
    select idO, nom 
    from OCCUPANT NATURAL JOIN RESERVER 
    where nomSalle = 'SalleC';

--(e) Afficher les occupants qui ont r´eserv´e la salle des fˆetes mais pas la salle info.--
select idO, nom 
    from OCCUPANT NATURAL JOIN RESERVER 
    where nomSalle = 'SalleC'
    except
    select idO, nom 
    from OCCUPANT NATURAL JOIN RESERVER 
    where nomSalle = 'SalleB';


--(f) Afficher la salle qui a la plus grande capacit´e.--
select nomSalle from SALLE
    where capacite in (
        SELECT max(capacite) from
        SALLE
    )
group by nomSalle;

--(g) Afficher la dur´ee totale r´eserv´ee pour chaque salle par mois.--
with vue as(
    select nomSalle, sum(duree) as dure
)

select nomSalle, dure, MONTH(dateR)
    from RESERVER NATURAL JOIN vue
group by nomSalle;

--(h) Afficher les occupants qui ont d´ej`a r´eserv´e toutes les salles au moins une fois.--