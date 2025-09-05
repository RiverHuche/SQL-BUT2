drop table ACCUEILLIR;
drop tABLE RESERVER;
DROP TABLE OCCUPANT;
DROP TABLE SALLE;
DROP TABLE TYPEOO;


create table SALLE 
    (nomSalle varchar(15) primary key,
    capacite int);

create table TYPEOO(
    typeO varchar(15) primary key
);

create table OCCUPANT(
    idO int primary key,
    nom varchar(15),
    carac varchar(15),
    typeO varchar(15),
    foreign key (typeO) references TYPEOO(typeO)
);

create table ACCUEILLIR(
    nomSalle varchar(15),
    typeO varchar(15),
    foreign key (nomSalle) references SALLE(nomSalle),
    foreign key (typeO) references TYPEOO(typeO),
    primary key(nomSalle,typeO)
);

create table RESERVER(
    dateR DATE,
    heuredeb int,
    nomSalle varchar(15),
    duree int,
    nbPersonne int,
    idO int,
    foreign key (nomSalle) references SALLE(nomSalle),
    foreign key (idO) references OCCUPANT(idO),
    primary key(dateR,heuredeb,nomSalle)
);



