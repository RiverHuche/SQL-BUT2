prepare requete1 from 'select * FROM ARTICLE where
prix<?';
set @prix=50;
execute requete1 using @prix;

prepare requete2 from 'select quantite FROM ARTICLE NATURAL JOIN STOCKER NATURAL JOIN ENTREPOT where
libelle =? and departement =?';
set @libelle='Table';
set @departement='Loiret';
execute requete2 using@libelle,@departement;

--exo2--
-- Ecrire une fonction maxRefArticle qui retourne la plus grande
-- r´ef´erence utilis´ee pour identifier un article. (0 si la table article est vide).--

delimiter | 
create or replace function plusGrdRef() returns int
begin
    declare res int;
    select IFNULL(reference,0) into res
    from ARTICLE
    where reference in(
        select max(reference)
        from ARTICLE
    );
    return res;
end |
delimiter ;

select plusGrdRef();



delimiter |
create or replace function deptEntrepot(codent int) returns VARCHAR(42)
begin
    declare res varchar(42);
    select departement into res
    from ENTREPOT
    where code = codent;
    return res;
end |
delimiter ;

select deptEntrepot(3);


delimiter |
create or replace function valEntrepot(codeEnt int) returns int
begin
    declare res int default 0;
    select sum(prix*quantite) total into res
    from ARTICLE NATURAL JOIN STOCKER 
    where code = codeEnt;
    if res is NULL then
        set res=-1;
    end if;
    return res;
end |
delimiter ;

select valEntrepot(2);

delimiter |
create or replace procedure afficher() 
begin
    declare res varchar(500) default '';
    declare nomE varchar(42);
    declare codeE int;
    declare departementE varchar(42);
    declare fini boolean default false;
    declare lesEntrepots cursor for
        select nom,code,departement
        from ENTREPOT;
    declare continue handler for not found set fini = true;
    open lesEntrepots;
    while not fini do 
        fetch lesEntrepots into nomE,codeE,departementE;

        if not fini then
            set res = concat(res, nomE ,' ',codeE,' ',departementE, ' ');
        end if;
    end while;
    close lesEntrepots;
    select res;
end |
delimiter ;

call afficher();




--Note-- cursor est un type de variable pour laquelle on lui donne la variable à exécuter
--c'est un iterable,handler 


