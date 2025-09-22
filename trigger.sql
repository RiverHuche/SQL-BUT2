--trigger--
--on peut juste utiliser la solution "unique" pour l eocuple d'attributs "code" et "nom"

delimiter |
CREATE OR REPLACE TRIGGER nomEntrepots before insert on ENTREPOT for each 
    row
begin
    declare codeE int(9);
    declare nomE varchar(42);
    declare mes varchar(500) default '';
    select nom into nomE from ENTREPOT where departement = new.departement and nom = new.nom;
    if nomE is not NULL then
        set mes = concat('incsription impossible', new.nom,' dans le département' );
        signal SQLSTATE '45000' SET MESSAGE_TEXT = mes;
    end if;
end |
delimiter ;
    

delimiter |
CREATE OR REPLACE TRIGGER nomEntrepots2 before update on ENTREPOT for each 
    row
begin
    declare codeE int(9);
    declare mes varchar(500) default '';
    select code into codeE from ENTREPOT where departement = new.departement and nom = new.nom;
    if codeE is not NULL then
        set mes = concat(' incsription impossible ', new.nom,' dans le département' );
        signal SQLSTATE '45000' SET MESSAGE_TEXT = mes;
    end if;
end |
delimiter ;



 --2

 delimiter |
CREATE OR REPLACE TRIGGER nbEntrepots before insert on ENTREPOT for each 
    row
begin
    declare nbEnt varchar(42);
    declare mes varchar(500) default '';
    select IFNULL(count(*),0) into nbEnt from ENTREPOT where departement = new.departement;
    if nbEnt = 3 then
        set mes = concat('incsription impossible', new.nom,' trop d entrepots dans le département' );
        signal SQLSTATE '45000' SET MESSAGE_TEXT = mes;
    end if;
end |
delimiter ;

 delimiter |
CREATE OR REPLACE TRIGGER nbEntrepots1 before update on ENTREPOT for each 
    row
begin
    declare nbEnt varchar(42);
    declare mes varchar(500) default '';
    select IFNULL(count(*),0) into nbEnt from ENTREPOT where departement = new.departement;
    if nbEnt = 3 then
        set mes = concat('incsription impossible', new.nom,' trop d entrepots dans le département' );
        signal SQLSTATE '45000' SET MESSAGE_TEXT = mes;
    end if;
end |
delimiter ;
    


--3


delimiter |
create or replace trigger creer_stock after insert on STOCKER for each row 
begin
    insert into HISTORIQUE valunes(now(), "creation", new.reference, new.code, new.quantite);
end |

create or replace trigger supprimer_stock after insert on STOCKER for each row 
begin
    insert into HISTORIQUE valunes(now(), "suppression", new.reference, new.code, old.quantite);
end |


create or replace trigger update_stock after insert on STOCKER for each row 
begin
    insert into HISTORIQUE valunes(now(), "suppression", new.reference, new.code, new.quantite - old.quantite);
end |

delimiter ;


        update ARTICLE set prix=prixA where reference=refA;
        return refA;
    else 
        set refMax = maxRefArticle() + 1;
        insert into ARTICLE VALUES(
            refMax, nomA, prixA
        );
        return refMax;
    end if;
end |
delimiter ;


call majArticle();

