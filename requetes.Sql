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


delimiter |
create or replace procedure afficherQ5() 
begin
    declare res varchar(500) default '';
    declare nomE varchar(42);
    declare codeE int;
    declare departementE varchar(42);
    declare nbE int;
    declare fini boolean default false;
    declare entrepot_en_cours varchar(42) default '';
    declare lesEntrepots cursor for
        select nom,code,departement
        from ENTREPOT 
        order by departement; 
    declare continue handler for not found set fini = true;
    open lesEntrepots;
    while not fini do 
        fetch lesEntrepots into nomE,codeE,departementE;

        if not fini then
            if entrepot_en_cours = departementE then
                SET nbE = nbE + 1
            else
                if entrepot_en_cours != '' THEN
                    set res = concat(res, 'Le département', entrepot_en_cours, 'a', nbE, 'entrepots \n');
                end if;
                SET entrepot_en_cours = departementE;
                SET nbE = 1;
                END IF;
                set res = concat(res ,nomE ,'(',departementE,') \n');
    end while;
    set res = = concat(res ,nomE ,' dont le code est ',codeE, ' dans le ',departementE, ' ,ce département contient ',nbE,' entrepots', '\n');
    close lesEntrepots;
    select res;
end |
delimiter ;

call afficherQ5();



delimiter |
create or replace procedure afficherQ5c() 
begin
    declare res varchar(500) default '';
    declare nomE varchar(42);
    declare codeE int;
    declare departementE varchar(42);
    declare deptPrec varchar(42);
    declare nbE int;
    declare fini boolean default false;
    declare lesEntrepots cursor for
        select nom,code,departement
        from ENTREPOT 
        order by departement; 
    declare continue handler for not found set fini = true;
    open lesEntrepots;
    set deptPrec ='';
    set nbE = 0;
    while not fini do 
        fetch lesEntrepots into nomE,codeE,departementE;

        if not fini then
            if (deptPrec !='' and deptPrec!=departementE) then
             set res = concat(res, '****** il y a', nbE, 'entrepots');
             set nbE =0;
            end if;
            set deptPrec = departementE;
            set nbE = nbE +1;
            set res = concat(res,'entrepot code', codeE, 'nom', nomE,'dans',departementE)
        end if;
    end while;
    close lesEntrepots;
    if nbE != 0 then
        set res = concat(res, '***** il y a', nbE,'entrepots dans', departementE)
    end if;
    select res;
end |
delimiter ; 

call afficherQ5c();



delimiter |
create or replace function majArticle(refA INT, nomA VARCHAR(42), prixA DECIMAL(6,2)) returns INT
begin 
    declare refMax int;
    declare refExiste int;
    select reference into refExiste from ARTICLE
    where reference=refA;
    if refExiste is not NULL then
        update ARTICLE set prix=prixA where reference = refA;
        return refA;
    else
        set 

