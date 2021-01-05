/* creat per Laura Centellas 
creative commonsby by nc sa */

/*
Dillunss 19/10/2020
A les oficines de l'empresa GuZone, una empresa farmacèutica pionera en el mercat d'investigació,
s'ha trobat mort el sr Leonard Cameron. Hi ha evidències clares que demostren que es tracta d'un crim.
El metege forense ha determinat que l'hora de la mort es podria situar entre les 18:00 i les 20:00 del
passat dia 16, però no en podrà determinar les causes fins que en faci un estudi forense.
Mentrestant l'inspector en cap ha demanat a la direcció de l'empresa tota la informació possible.
Hem pogut aconseguir:
- la informació dels empleats
- els diferents departaments
- la relació de trucades de l'última setmana
- les compres de llibres de la passada setmana.
- els horaris laborals dels empleats (fitxatges de la setmana del crim)

També disposem de l'agenda de la víctima i el llistat de documents impresos l'última setmana.
David Burman ens ha fet arribar un backup de les dades.

Siusplau inspector és un cas urgent!
Ens podria dir quines pistes ha trobat? Pot saber qui ha estat l'assassí? com i perquè?'
*/
drop schema CLUEDO;
CREATE SCHEMA CLUEDO;
USE   CLUEDO;
-- DROPs




-- CREACIÓ DE TAULES

CREATE TABLE IF NOT EXISTS departaments (
        id INTEGER PRIMARY KEY,
        nom varchar(25) NOT NULL );


CREATE TABLE IF NOT EXISTS empleats (
	id INTEGER PRIMARY KEY,
	nom varchar(20) NOT NULL,
	cognom1 varchar(20) NOT NULL,
	cognom2 varchar(20) NOT NULL,
	sou int,
	telefon varchar(15) UNIQUE,
	dept  integer REFERENCES departaments (id),
	carrec varchar(25),
	address text );

CREATE TABLE IF NOT EXISTS compres (
	id serial PRIMARY KEY,
	dept INTEGER REFERENCES departaments (id),
	isbn text NOT NULL );


CREATE TABLE IF NOT EXISTS trucades (
        id serial PRIMARY KEY,
        origen varchar(15) REFERENCES empleats (telefon),
        desti varchar(15) NOT NULL,
	hora_inici TIMESTAMP,
	hora_fi TIMESTAMP);

CREATE TABLE IF NOT EXISTS fitxatges (
        hora TIMESTAMP NOT NULL,
        empleat INTEGER NOT NULL REFERENCES empleats (id),
        PRIMARY KEY(hora, empleat));

CREATE TABLE IF NOT EXISTS evidencies_policia (
	empleat INTEGER PRIMARY KEY REFERENCES empleats(id),
	testimoni varchar(50),
	evidencia text );

CREATE TABLE IF NOT EXISTS impresions_victima (
        hora timestamp PRIMARY KEY,
        document varchar(250) NOT NULL,
        descripcio text );

CREATE TABLE IF NOT EXISTS agenda (
        hora timestamp PRIMARY KEY,
        descripcio text NOT NULL );


ALTER TABLE compres ADD CONSTRAINT fk_compres_dept FOREIGN KEY (dept) REFERENCES departaments(id);
ALTER TABLE empleats ADD CONSTRAINT fk_empleats_dept FOREIGN KEY (dept) REFERENCES departaments(id);
ALTER TABLE trucades ADD CONSTRAINT fk_trucades_dept FOREIGN KEY (origen) REFERENCES empleats(telefon);
ALTER TABLE fitxatges ADD CONSTRAINT fk_compres_empleats FOREIGN KEY (empleat) REFERENCES empleats(id);
ALTER TABLE evidencies_policia ADD CONSTRAINT fk_evidencies_empleats FOREIGN KEY (empleat) REFERENCES empleats(id);

-- DADES DE DEPARTAMENTS

INSERT INTO departaments (id,nom) VALUES (1, 'Direcció General');
INSERT INTO departaments (id,nom) VALUES (2, 'I+D');
INSERT INTO departaments (id,nom) VALUES (3, 'Laboratori');
INSERT INTO departaments (id,nom) VALUES (4, 'Epidemiologia');
INSERT INTO departaments (id,nom) VALUES (5, 'Oncologia');
INSERT INTO departaments (id,nom) VALUES (6, 'IT');
INSERT INTO departaments (id,nom) VALUES (7, 'Sistemes informàtics');
INSERT INTO departaments (id,nom) VALUES (8, 'Comercial');
INSERT INTO departaments (id,nom) VALUES (9, 'R+H');
INSERT INTO departaments (id, nom) VALUES (10, 'Neteja');



-- DADES D'EMPLEATS

-- DADES D'EMPLEATS DEPT 1
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (1,'Jan','Cameron','Murphy',70000,938740101,'1','Director general', 'Gran 43, Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (2,'Xavier','Sevilla','Gagarin',22000,938740102,'1','Secretari', 'Trinitat 12, 5  Barcelona');

-- DADES D'EMPLEATS DEPT 2
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
	VALUES (3,'Leonard','Cameron','Callaghan',40000,938740201,'2','Director I+D', 'Guillem Cata 9, 1 Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (4,'Fran','Abbot','Edison',30000,938740202,'2','Investigador sénior', 'Major 13, 3 Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (5,'Neus','Ferrari','Caldwell',25000,938740203,'2','Investigador júnior', 'Pascal 23, 2 Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (28,'Fran','Lebaque','Chamin',20000,938740204,'2','Secretari', 'Balmes 72, 4 Barcelona');

-- DADES D'EMPLEATS DEPT 3
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (6,'Matilda','Yellow','Vaca',38000,938740301,'3','Investigadora cap', 'Guillem Cata 9, 1 Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (7,'Eduard','Roja','Valdes',33000,938740302,'3','Investigador sénior', 'Sant Andreu 44, Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (8,'Guillermina','Fructuos','Amstel',29000,938740303,'3','Investigador júnior', 'Cardona 12, 4 Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (30,'Ben','Harris','Neal',20000,938740304,'3','Secretari', 'Pere III 68, 6 Barcelona');

-- DADES D'EMPLEATS DEPT 4
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (9,'Oriol','Gran','Macías',35000,938740401,'4','Epidemioleg cap', 'Universitat 23, 8 Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (10,'Gorka','Boniquet','Fiedler',33000,938740402,'4','Epidemioleg sénior', 'Londres 13, Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (11,'Naiara','Fournier','Bakshi',27000,938740403,'4','Epidemioleg júnior', 'Paris 54, 5 Barcelona');

-- DADES D'EMPLEATS DEPT 5
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (12,'Laura','Essa','Naser',36000,938740501,'5','Oncoleg cap', 'Gaudi 24, Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (13,'Mafalda','Olivier','Patel',32000,938740502,'5','Oncoleg sénior', 'Picasso 57, 7 Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (14,'Aldo','Garcia','Delgado',23000,938740503,'5','Oncoleg júnior', 'Velazquez 499, 2 Barcelona');

-- DEADES D'EMPLEATS DEPT 6
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (15,'Qiu','Chan','Zhu',37000,938740601,'6','IT cap', 'Reina 243, 5 Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (16,'Vicente','Avilers','Murphy',34000,938740602,'6','IT sénior', 'Centelles 543, 6 Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (17,'Maria Veronica','Cabello','Mans',26000,938740603,'6','IT júnior', 'Horticultor Corset 79, 2 Barcelona');

-- DADES D'EMPLEATS DEPT 7
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefoN, dept, carrec, address )
        VALUES (18,'David','Burman','Tahan',40000,938740701,'7','Enginyer de Sistemes', 'Colorado 43, Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (19,'Victoria','Ganim','Dalal',40000,938740702,'7','Tècnic de seguretat', 'Everest 85, 4 Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (20,'Olga','Da Costa','Van Hal',18000,938740703,'7','Becari', 'Miseria 12, 9 Barcelona');

-- DADES D'EMPLEATS DEPT 8
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (21,'Marc','Cameron','Callaghan',35000,938740801,'8','Director comercial', 'Mediterrani 111, 1 Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (22,'Xènia','Kumar','Ray',35000,938740802,'8','comercial', 'Elba 232, 1 Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (23,'Saidou','Antar','Morcos',35000,938740803,'8','marketing', 'Garona 16, 12 Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (29,'Ona','Cortina','Garrett',20000,938740804,'8','Secretari', 'Tallers 61, 8 Barcelona');

-- DADES D'EMPLEATS DEPT 9
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (24,'Fatima','Bracamonte','Papadopoulus',35000,938740901,'9','Administrativa', 'Lepant 327, 1 Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (25,'Nicolai','Rytas','Yanovich',35000,938740902,'9','Administratiu', 'Còrcega 31, 1 Barcelona');

-- DADES D'EMPLEATS DEPT 10
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (26,'Mireia','Rojo','Callus',19000,null,'10','neteja', 'Rosselló 55, 6 Barcelona');
INSERT INTO empleats (id, nom, cognom1, cognom2, sou, telefon, dept, carrec, address )
        VALUES (27,'Jordi','Casp','Valldaura',19000,null,'10','neteja', 'Indústria 77, 3 Barcelona');



-- DADES DE TRUCADES
-- DADES DE TRUCADES DEL DIA 12/10/20
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740202, 938740602, '2020-10-12 09:11', '2020-10-12 09:23');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740304, 935442323, '2020-10-12 09:26', '2020-10-12 09:36');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740901, 935335646, '2020-10-12 09:45', '2020-10-12 09:49');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740402, 938740998, '2020-10-12 10:11', '2020-10-12 10:43');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740804, 0074952217777, '2020-10-12 10:20', '2020-10-12 10:40');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740602, 938740701, '2020-10-12 10:59', '2020-10-12 11:22');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740101, 934679955, '2020-10-12 11:44', '2020-10-12 12:03');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740402, 934522353, '2020-10-12 12:34', '2020-10-12 12:57');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740202, 937844496, '2020-10-12 15:36', '2020-10-12 15:57');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740801, 931288000, '2020-10-12 16:39', '2020-10-12 16:55');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740201, 938740501, '2020-10-12 18:05', '2020-10-12 18:15');


-- DADES DE TRUCADES DEL DIA 13/10/20
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740102, 938731577, '2020-10-13 11:24', '2020-10-13 11:34');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740803, 938760077, '2020-10-13 12:30', '2020-10-13 12:39');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740804, 939760077, '2020-10-13 15:45', '2020-10-13 15:48');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740102, 935460667, '2020-10-13 15:47', '2020-10-13 16:44');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740201, 935403355, '2020-10-13 15:52', '2020-10-13 16:12');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740902, 932458653, '2020-10-13 15:54', '2020-10-13 16:15');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740901, 932457783, '2020-10-13 16:42', '2020-10-13 16:51');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740803, 932452676, '2020-10-13 16:58', '2020-10-13 17:12');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740801, 932452676, '2020-10-13 17:38', '2020-10-13 17:47');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740302, 939747362, '2020-10-13 17:46', '2020-10-13 17:57');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740401, 935682348, '2020-10-13 17:41', '2020-10-13 18:00');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740501, 938740201, '2020-10-13 18:04', '2020-10-13 18:14');

-- DADES DE TRUCADES DEL DIA 14/10/20
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740102, 938660701, '2020-10-14 09:10', '2020-10-14 09:22');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740304, 935442333, '2020-10-14 09:25', '2020-10-14 09:32');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740902, 935335777, '2020-10-14 09:44', '2020-10-14 09:49');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740401, 938740601, '2020-10-14 10:31', '2020-10-14 10:40');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740601, 938740701, '2020-10-14 10:59', '2020-10-14 11:25');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740102, 934679222, '2020-10-14 11:41', '2020-10-14 12:02');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740401, 934556653, '2020-10-14 12:33', '2020-10-14 12:47');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740203, 937845996, '2020-10-14 15:35', '2020-10-14 15:53');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740802, 931288534, '2020-10-14 16:38', '2020-10-14 16:50');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740201, 938740501, '2020-10-14 18:07', '2020-10-14 18:15');

-- DADES DE TRUCADES DEL DIA 15/10/20
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
	VALUES (DEFAULT, 938740102, 938731527, '2020-10-15 11:21', '2020-10-15 11:33');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
	VALUES (DEFAULT, 938740803, 938760077, '2020-10-15 12:34', '2020-10-15 12:39');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740804, 939760077, '2020-10-15 15:30', '2020-10-15 15:36');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740102, 935460667, '2020-10-15 15:42', '2020-10-15 15:44');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740201, 935403355, '2020-10-15 15:52', '2020-10-15 16:09');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740902, 932458653, '2020-10-15 15:53', '2020-10-15 16:10');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740901, 932457783, '2020-10-15 16:43', '2020-10-15 16:50');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740803, 932452676, '2020-10-15 16:59', '2020-10-15 17:12');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740801, 932452676, '2020-10-15 17:39', '2020-10-15 17:43');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740302, 939747362, '2020-10-15 17:40', '2020-10-15 17:52');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740401, 935682348, '2020-10-15 17:51', '2020-10-15 18:00');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740201, 938740501, '2020-10-15 18:01', '2020-10-15 18:12');

-- DADES DE TRUCADES DEL DIA 16/10/20
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740601, 938740701, '2020-10-16 09:00', '2020-10-16 09:12');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740202, 935682333, '2020-10-16 09:15', '2020-10-16 09:22');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740301, 935535777, '2020-10-16 09:34', '2020-10-16 09:39');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740402, 931537655, '2020-10-16 09:51', '2020-10-16 10:10');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740601, 938740701, '2020-10-16 10:19', '2020-10-16 10:25');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740102, 934679223, '2020-10-16 10:41', '2020-10-16 11:03');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740304, 934556673, '2020-10-16 12:33', '2020-10-16 12:57');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740204, 937845366, '2020-10-16 15:30', '2020-10-16 15:23');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740804, 931276534, '2020-10-16 16:18', '2020-10-16 16:30');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740201, 938740203, '2020-10-16 17:15', '2020-10-16 17:17');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740902, 935682348, '2020-10-16 17:41', '2020-10-16 17:59');
INSERT INTO trucades (id,origen,desti,hora_inici,hora_fi)
        VALUES (DEFAULT, 938740501, 938740201, '2020-10-16 18:03', '2020-10-16 18:07');



-- DADES DE FITXATGES

INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:00', 2);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:00', 2);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:00', 2);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:00', 2);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:00', 2);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:00', 2);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:00', 2);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:00', 2);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:00', 2);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:00', 2);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:00', 3);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:16', 3);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:12', 3);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:15', 3);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:15', 3);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:16', 3);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:23', 3);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:13', 3);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:21', 3);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:03', 4);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:04', 4);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:06', 4);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:04', 4);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:03', 4);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:07', 4);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:40', 5);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:00', 5);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:50', 5);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:00', 5);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:55', 5);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:01', 5);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:42', 5);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:02', 5);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:52', 5);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:12', 5);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:10', 6);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:00', 6);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:12', 6);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:00', 6);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:15', 6);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:01', 6);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:23', 6);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:01', 6);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:00', 6);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:00', 6);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 08:50', 7);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:00', 7);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:01', 7);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:00', 7);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:02', 7);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:05', 7);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:04', 7);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:00', 7);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:03', 7);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:00', 7);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:02', 8);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:04', 8);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:05', 8);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:04', 8);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:50', 8);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:00', 8);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:06', 8);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:45', 8);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:00', 8);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:00', 8);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:10', 9);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:00', 9);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:02', 9);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:00', 9);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:03', 9);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 17:40', 9);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:05', 9);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:30', 9);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:00', 9);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:10', 9);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:30', 10);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:40', 10);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:30', 10);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 17:50', 10);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:05', 10);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:03', 10);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:00', 10);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:04', 10);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:02', 10);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:03', 10);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:30', 11);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:40', 11);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:35', 11);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 17:55', 11);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:05', 11);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:05', 11);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:05', 11);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:04', 11);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:05', 11);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:03', 11);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:02', 12);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:16', 12);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:03', 12);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:15', 12);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:04', 12);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:16', 12);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:05', 12);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:13', 12);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:08', 12);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:04', 13);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:22', 13);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:24', 13);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:12', 13);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:18', 13);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:15', 13);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:17', 13);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:24', 13);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:02', 13);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:10', 13);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:09', 14);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:22', 14);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:00', 14);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:22', 14);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:14', 14);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:01', 14);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:10', 14);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:03', 14);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:12', 14);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:09', 14);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:11', 15);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:23', 15);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:22', 15);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:08', 15);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:16', 15);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:17', 15);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:04', 15);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:11', 15);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:03', 15);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:00', 15);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:24', 16);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:04', 16);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:09', 16);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:11', 16);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:23', 16);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:05', 16);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:18', 16);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:02', 16);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:08', 16);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:23', 16);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:04', 17);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:19', 17);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:05', 17);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:10', 17);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:15', 17);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:02', 17);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:17', 17);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:14', 17);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:06', 17);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:05', 17);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:17', 18);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:04', 18);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:13', 18);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:20', 18);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:11', 18);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:16', 18);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:21', 18);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:18', 18);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:02', 18);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:08', 18);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:15', 19);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:11', 19);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:03', 19);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:09', 19);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:20', 19);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:23', 19);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:12', 19);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:00', 19);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:04', 19);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:05', 19);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:20', 20);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:17', 20);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:22', 20);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:24', 20);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:06', 20);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:19', 20);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:15', 20);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:12', 20);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:03', 20);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:29', 20);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:10', 21);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:13', 21);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:22', 21);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:17', 21);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:06', 21);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:26', 21);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:14', 22);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:13', 22);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:10', 22);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:11', 22);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:00', 22);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:22', 22);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:17', 22);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:19', 22);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:02', 22);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:15', 22);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:02', 23);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:24', 23);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:06', 23);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:03', 23);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:21', 23);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:24', 23);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:13', 23);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:06', 23);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:05', 23);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:21', 23);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:09', 24);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:23', 24);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:16', 24);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:05', 24);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:24', 24);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:13', 24);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:03', 24);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:13', 24);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:00', 24);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:02', 24);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:11', 25);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:16', 25);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:16', 25);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:17', 25);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:14', 25);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:22', 25);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:23', 25);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:06', 25);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:01', 25);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:02', 25);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:17', 26);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:12', 26);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:19', 26);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:06', 26);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:12', 26);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:19', 26);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:02', 26);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:08', 26);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:03', 26);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:20', 26);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:13', 27);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:24', 27);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:14', 27);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:21', 27);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:21', 27);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:12', 27);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:14', 27);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:16', 27);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:06', 27);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:05', 27);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:18', 28);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:10', 28);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:22', 28);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:01', 28);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:04', 28);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:08', 28);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:20', 28);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:05', 28);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:07', 10);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:17', 28);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:03', 29);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:08', 29);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:18', 29);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:19', 29);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:19', 29);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:11', 29);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:16', 29);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:15', 29);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 09:11', 30);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-12 18:15', 30);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 09:03', 30);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-13 18:09', 30);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 09:08', 30);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-14 18:09', 30);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 09:13', 30);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-15 18:13', 30);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 09:09', 30);
INSERT INTO fitxatges (hora, empleat) VALUES ('2020-10-16 18:01', 30);


-- DADES DE LLIBRES COMPRATS

INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 7 ,'Legislación sobre seguridad informática (LOPD)');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 2 ,'I+D farmacéutico: investigación y desarrollo ');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 4 ,'Molecular simulations of globins: Exploring the relationship between structure, dynamics and function ');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 2 ,'Membrane interaction of polymyxin B and synthetic analogues studied in biomimetic systems: implications for antibacterial action ');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 3 ,' Claus de la dermofarmàcia');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 2 ,'Farmàcia clínica ');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 4 ,'The Coming Plague: Newly Emerging Diseases in a World Out of Balance');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 3 ,'Operacions bàsiques al laboratori');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 8 ,'Pharmacology & Toxicology');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 1 ,'Innovación en empresas Farmacéuticas');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 1 ,'Direcció de empresas Farmacéuticas y Biotecnológicas');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 2 ,'Pharmakoteka');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 8 ,'What are Novichok agents and what do they do');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 1 ,'Análisis crítico, toma de decisiones y resolución de problemas en el sector farmacéutico ');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 3 ,'Gestión de muestras biológicas');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 3 ,'Anatomofisiologia i Patologies');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 2 ,'Eciclopedia de farmácia práctica');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 5 ,'Cancer: Principles & Practices of Oncology');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 5 ,'Cancer: The Facts');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 1 ,'Comunicación, negociación y liderazgo en el sector farmacéutico ');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 4 ,'Gordis Epidemiology');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 1 ,'Formación en la indústria farmacéutica');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 1 ,'Indústria farmacéutica i patents');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 1 ,'Los patrones de innovación en España a través del análisis de patentes');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 4 ,'Basics of epidemiology');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 3 ,'Operacions bàsiques al laboratori');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 4 ,'The vaccine friendly plan');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 5 ,'A Primer of Brain Tumors');
INSERT INTO compres (id, dept, isbn) VALUES (DEFAULT, 3 ,'Laboratory procedures for pharmacy technicians');


-- DADES DE L'AGENDA DE LA VÍCTIMA

INSERT INTO agenda (hora, descripcio) VALUES ('2020-10-12 09:30', 'Notari - posposat. tete?');
INSERT INTO agenda (hora, descripcio) VALUES ('2020-10-12 12:00', 'Reunió departament');
INSERT INTO agenda (hora, descripcio) VALUES ('2020-10-13 10:00', 'Reunió Xavier Sevilla ');
INSERT INTO agenda (hora, descripcio) VALUES ('2020-10-13 12:00', 'Reunió Dr Oliver - Vall Hebrón (Dr papa) Planta 2');
INSERT INTO agenda (hora, descripcio) VALUES ('2020-10-14 14:00', 'Dinar amb Oriol Gran');
INSERT INTO agenda (hora, descripcio) VALUES ('2020-10-15 12:00', 'Assessorament genètic - Vall Hebrón Planta Baixa');
INSERT INTO agenda (hora, descripcio) VALUES ('2020-10-16 17:30', 'Reunió Neus Ferrari');


-- DADES DE LA CUA D'IMPRESSIONS DE LA VÍCTIMA

INSERT INTO impresions_victima (hora, document, descripcio) VALUES ('2020-10-12 09:02', 'NouTestamentPapa.pdf',NULL);
INSERT INTO impresions_victima (hora, document, descripcio) VALUES ('2020-10-13 16:12', 'AugmentSouBenHarris.pdf',NULL);
INSERT INTO impresions_victima (hora, document, descripcio) VALUES ('2020-10-14 10:02', 'PartBaixaPapaCancer.pdf',NULL);
INSERT INTO impresions_victima (hora, document, descripcio) VALUES ('2020-10-14 11:02', 'PharmacNews034L.pdf',NULL);
INSERT INTO impresions_victima (hora, document, descripcio) VALUES ('2020-10-14 11:03', 'NovaPharmaTrend078T.pdf',NULL);
INSERT INTO impresions_victima (hora, document, descripcio) VALUES ('2020-10-15 09:15', 'AntecedentsGeneticsFamilia.pdf',NULL);
INSERT INTO impresions_victima (hora, document, descripcio) VALUES ('2020-10-15 15:15', 'PatologyTest0067.pdf',NULL);
INSERT INTO impresions_victima (hora, document, descripcio) VALUES ('2020-10-15 15:30', 'PatentReview.pdf',NULL);
INSERT INTO impresions_victima (hora, document, descripcio) VALUES ('2020-10-16 17:02', 'AcomiadamentNeusFerrari.pdf',NULL);
INSERT INTO impresions_victima (hora, document, descripcio) VALUES ('2020-10-16 17:58', 'AutoritzacioDesconnexio.pdf',NULL);

