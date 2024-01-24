CREATE DATABASE Users;

Use Users;

CREATE TABLE Usuario (
	ID INT NOT NULL AUTO_INCREMENT, 
	Nombre VARCHAR(50) NOT NULL, 
	Apellido VARCHAR(50), 
	Email VARCHAR(100), 
	Fecha_Nacimiento DATE,
	Activo TINYINT,
    ID_Tipo_Usuario INT,
    Fecha_Creacion DATE,
	PRIMARY KEY (ID), 
);

ALTER TABLE Usuario ADD CONSTRAINT UK_Email UNIQUE (Email);
# -------------------------------------------------------

ALTER TABLE usuario
ADD INDEX idx_usuario_tipo_usuario (ID_TIPO_USUARIO); # creo que aca lo que querias poner era la llave foranea

# -------------------------------------------------------

CREATE TABLE Menu (
	ID INT NOT NULL AUTO_INCREMENT, 
	Titulo VARCHAR(50) NOT NULL, 
	Descripcion VARCHAR(50), 
	URL VARCHAR(100), 
    Activo boolean,
	PRIMARY KEY (ID)
);

CREATE TABLE menu_usuario (
	ID_usuario INT NOT NULL, 
	ID_Menu INT NOT NULL, 
	Fecha_Habilitado DATE,
	PRIMARY KEY (ID_usuario, id_MENU),
    foreign key (ID_Menu) references menu(ID),
    foreign key (ID_usuario) references Usuario(ID_Tipo_Usuario)
);

CREATE TABLE historial_conexion (
	ID INT NOT NULL AUTO_INCREMENT, 
	ID_Usuario INT NOT NULL, 
	Fecha_Hora datetime,
    Ip varchar(30),
    Navegador varchar(50),
    Duracion_sesion int,
	PRIMARY KEY (ID),
    foreign key (ID_usuario) references Usuario(ID_Tipo_Usuario)
);

CREATE TABLE Tipo_Usuario (
	ID INT NOT NULL AUTO_INCREMENT, 
	Nombre varchar(50), 
	Descripcion varchar(100), 
	PRIMARY KEY (ID)
);

CREATE TABLE Cuentas_Vinculadas (
	ID INT NOT NULL AUTO_INCREMENT, 
	Id_usuario int, 
	Nombre varchar(50),
    URL varchar(100), 
	PRIMARY KEY (ID)
);

DELIMITER //
DROP PROCEDURE IF EXISTS CrearUsuario;
CREATE PROCEDURE CrearUsuario(
    IN p_Nombre VARCHAR(50),
    IN p_Apellido VARCHAR(50),
    IN p_Email VARCHAR(100),
    IN p_Fecha_Nacimiento DATE,
    IN p_Activo TINYINT,
    IN p_ID_Tipo_Usuario INT
)
BEGIN
    -- Variable para almacenar el ID del nuevo usuario creado
    DECLARE nuevo_usuario_id INT;

    -- Inserción del nuevo usuario
    INSERT INTO Usuario (Nombre, Apellido, Email, Fecha_Nacimiento, Activo, ID_Tipo_Usuario, Fecha_Creacion)
    VALUES (p_Nombre, p_Apellido, p_Email, p_Fecha_Nacimiento, p_Activo, p_ID_Tipo_Usuario, CURDATE());

    -- Obtenemos el ID del usuario recién creado
    SET nuevo_usuario_id = LAST_INSERT_ID();

    -- Creación de cuentas vinculadas (ejemplo)
    INSERT INTO cuentas_vinculadas (usuario_id, cuenta_tipo)
    VALUES (nuevo_usuario_id, 'cuenta1');

    -- Asignación de tipo de usuario (ejemplo)
    UPDATE Usuario
    SET ID_Tipo_Usuario = "Pocedure user" # el tipo de dato para tipo usuario es int no varchar
    WHERE ID = nuevo_usuario_id; # este update es inncesario porque en el insert ya asignaste el tipo de usuario
	# -------------------------------------------------------
END;
//CrearUsuario
DELIMITER ;


DELIMITER $$
-- Crear la función para obtener el nombre del tipo de usuario por su ID
DROP FUNCTION IF EXISTS ObtenerNombreTipoUsuario;
CREATE FUNCTION ObtenerNombreTipoUsuario(p_ID_Tipo_Usuario INT)
RETURNS VARCHAR(50)
READS SQL DATA	
BEGIN
    DECLARE nombre_tipo_usuario VARCHAR(50);

    SELECT Nombre INTO nombre_tipo_usuario
    FROM tipo_usuario
    WHERE ID = p_ID_Tipo_Usuario;

    RETURN nombre_tipo_usuario;
END;
$$

DELIMITER //
DROP TRIGGER IF EXISTS impide_borrar_historial;
CREATE TRIGGER impide_borrar_historial
BEFORE DELETE ON Historial_Conexion
FOR EACH ROW
BEGIN
    -- Obtenemos la fecha y hora actual
    DECLARE fecha_hora_actual DATETIME;
    SET fecha_hora_actual = NOW();
	
	# -------------------------------------------------------
	# con un solo segundo de diferencia que haya entre ambos datos ya entraria al if, solo deberia entrar si la fecha (dia) es del dia anterior
    -- Comparamos la fecha y hora del registro con la fecha y hora actual
    IF OLD.fecha_hora < fecha_hora_actual THEN
        -- Generamos un error para evitar que se realice la eliminación
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se permite borrar historial de conexión de días anteriores a hoy.';
    END IF;
END//

SELECT * 
FROM MENU
WHERE activo = 1;
# -------------------------------------------------------
# hizo falta el order by

INSERT INTO usuario (Nombre, Apellido, Email, Fecha_Nacimiento, Activo, ID_Tipo_Usuario, Fecha_Creacion)
VALUES
('Juan', 'Pérez', 'juan@example.com', '1990-01-15', 1, 1, '2023-06-01'),
('María', 'López', 'maria@example.com', '1985-08-22', 1, 2, '2023-06-01'),
('Pedro', 'Gómez', 'pedro@example.com', '1995-03-10', 1, 2, '2023-06-01'),
('Ana', 'García', 'ana@example.com', '1992-11-05', 1, 3, '2023-06-01'),
('Carlos', 'Martínez', 'carlos@example.com', '1988-04-18', 1, 1, '2023-06-01'),
('Laura', 'Rodríguez', 'laura@example.com', '1998-07-25', 1, 2, '2023-06-01'),
('Luis', 'Hernández', 'luis@example.com', '1991-09-30', 1, 3, '2023-06-01'),
('Elena', 'Díaz', 'elena@example.com', '1987-12-12', 1, 4, '2023-06-01'),
('Miguel', 'Sánchez', 'miguel@example.com', '1986-06-08', 1, 4, '2023-06-01'),
('Diana', 'Ramírez', 'diana@example.com', '1994-02-28', 1, 5, '2023-06-01');


INSERT INTO historial_conexion (ID_Usuario, Fecha_Hora, Ip, Navegador, Duracion_sesion)
VALUES
(1, '2023-06-01 08:15:00', '192.168.1.1', 'Chrome', 3600),
(1, '2023-06-01 09:30:00', '192.168.1.2', 'Firefox', 2400),
(2, '2023-06-01 10:45:00', '192.168.1.3', 'Edge', 1800),
(3, '2023-06-01 11:00:00', '192.168.1.4', 'Safari', 1200),
(2, '2023-06-01 12:30:00', '192.168.1.5', 'Chrome', 3000),
(4, '2023-06-01 13:15:00', '192.168.1.6', 'Firefox', 2400),
(5, '2023-06-01 14:00:00', '192.168.1.7', 'Edge', 1800),
(2, '2023-06-01 15:45:00', '192.168.1.8', 'Safari', 1200),
(5, '2023-06-01 16:30:00', '192.168.1.9', 'Chrome', 3000),
(4, '2023-06-01 17:15:00', '192.168.1.10', 'Firefox', 2400);

INSERT INTO cuentas_vinculadas (Id_usuario, Nombre, URL)
VALUES
(1, 'Cuenta1', 'https://cuenta1.com'),
(2, 'Cuenta2', 'https://cuenta2.com'),
(3, 'Cuenta3', 'https://cuenta3.com'),
(4, 'Cuenta4', 'https://cuenta4.com'),
(5, 'Cuenta5', 'https://cuenta5.com'),
(2, 'Cuenta6', 'https://cuenta6.com'),
(1, 'Cuenta7', 'https://cuenta7.com'),
(3, 'Cuenta8', 'https://cuenta8.com'),
(4, 'Cuenta9', 'https://cuenta9.com'),
(5, 'Cuenta10', 'https://cuenta10.com');

INSERT INTO menu (Titulo, Descripcion, URL, activo)
VALUES
('Menú 1', 'Descripción del menú 1', '/menu1', 1),
('Menú 2', 'Descripción del menú 2', '/menu2', 1),
('Menú 3', 'Descripción del menú 3', '/menu3', 0),
('Menú 4', 'Descripción del menú 4', '/menu4', 1),
('Menú 5', 'Descripción del menú 5', '/menu5', 0),
('Menú 6', 'Descripción del menú 6', '/menu6', 1),
('Menú 7', 'Descripción del menú 7', '/menu7', 1),
('Menú 8', 'Descripción del menú 8', '/menu8', 0),
('Menú 9', 'Descripción del menú 9', '/menu9', 1),
('Menú 10', 'Descripción del menú 10', '/menu10', 1);

INSERT INTO tipo_usuario (Nombre, Descripcion)
VALUES
('Administrador', 'Rol de administrador con todos los privilegios'),
('Usuario', 'Rol de usuario con permisos básicos'),
('Invitado', 'Rol de usuario invitado con permisos limitados'),
('Editor', 'Rol de editor con permisos para editar contenido'),
('Supervisor', 'Rol de supervisor con permisos de supervisión'),
('Analista', 'Rol de analista con permisos de análisis'),
('Desarrollador', 'Rol de desarrollador con permisos de desarrollo'),
('Consultor', 'Rol de consultor con permisos de consultoría'),
('Soporte', 'Rol de soporte técnico con permisos de soporte'),
('Testeador', 'Rol de testeador con permisos para realizar pruebas');

INSERT INTO menu_usuario (ID_usuario, ID_Menu, Fecha_Habilitado)
VALUES
(1, 1, '2023-06-01'),
(1, 2, '2023-06-01'),
(2, 3, '2023-06-01'),
(3, 4, '2023-06-01'),
(2, 5, '2023-06-01'),
(4, 6, '2023-06-01'),
(3, 7, '2023-06-01'),
(5, 8, '2023-06-01'),
(4, 9, '2023-06-01'),
(5, 10, '2023-06-01');

####################################################################################################
# ejercicio SQL Murder Mystery queries

name
crime_scene_report
drivers_license
facebook_event_checkin
interview
get_fit_now_member
get_fit_now_check_in
solution
income
person
/****************************************************************************/ 
    
select * from crime_scene_report 
WHERE date = 20180115 AND TYPE = "murder" AND city ='SQL City'

date	type	description	city
20180115	murder	Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".	SQL City   
      
/****************************************************************************/

select * from PERSON
WHERE ADDRESS_STREET_NAME = "Northwestern Dr"
ORDER BY address_number DESC
LIMIT 10

id	name	license_id	address_number	address_street_name	ssn
14887	Morty Schapiro	118009	4919	Northwestern Dr	111564949

/****************************************************************************/

select * from PERSON
WHERE NAME lIKE '%Annabel%' AND address_street_name = "Franklin Ave"
LIMIT 10

id	name	license_id	address_number	address_street_name	ssn
16371	Annabel Miller	490173	103	Franklin Ave	318771143

/****************************************************************************/

select * from INTERVIEW
where person_id in (14887, 16371)

person_id	transcript
14887	I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".
16371	I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

/****************************************************************************/

select * from get_fit_now_member
where membership_status = "gold"
and id like "48Z%"
limit 10

id	person_id	name	membership_start_date	membership_status
48Z7A	28819	Joe Germuska	20160305	gold
48Z55	67318	Jeremy Bowers	20160101	gold

/****************************************************************************/

select * from INTERVIEW
where person_id in (28819, 67318)

person_id	transcript
67318	I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.

/****************************************************************************/

select * from drivers_license 
WHERE hair_color LIKE "%red%" 
and gender = 'female' 
and height between 65 and 67
and car_make = 'Tesla'
and car_model = 'Model S'
limit 10

id	age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
202298	68	66	green	red	female	500123	Tesla	Model S
291182	65	66	blue	red	female	08CM64	Tesla	Model S
918773	48	65	black	red	female	917UU3	Tesla	Model S


/****************************************************************************/

select * from person
where license_id in (202298, 291182, 918773)

id	name	license_id	address_number	address_street_name	ssn
78881	Red Korb	918773	107	Camerata Dr	961388910
90700	Regina George	291182	332	Maple Ave	337169072
99716	Miranda Priestly	202298	1883	Golden Ave	987756388

/****************************************************************************/

select *, count(person_id) as total_assist from facebook_event_checkin
WHERE DATE >= 20171201 and date <= 20171231 and event_name="SQL Symphony Concert"
group by person_id
having(total_assist) >=3
limit 10

person_id	event_id	event_name	date	total_assist
24556	1143	SQL Symphony Concert	20171224	3
99716	1143	SQL Symphony Concert	20171229	3

/****************************************************************************/

select * from income
where ssn = 987756388

ssn	annual_income
987756388	310000

/****************************************************************************/
select * from get_fit_now_check_in
where check_in_date = 20180109 and membership_id in ('48Z7A', '48Z55')
limit 10

membership_id	check_in_date	check_in_time	check_out_time
48Z7A	20180109	1600	1730
48Z55	20180109	1530	1700

/****************************************************************************/

select * from drivers_license 
WHERE plate_number LIKE "%H42W%"
limit 10

id	age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
183779	21	65	blue	blonde	female	H42W0X	Toyota	Prius
423327	30	70	brown	brown	male	0H42W2	Chevrolet	Spark LS
664760	21	71	black	black	male	4H42WR	Nissan	Altima

/****************************************************************************/

select * from drivers_license
where plate_number = "H42W0X"
limit 10

id	age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
183779	21	65	blue	blonde	female	H42W0X	Toyota	Prius

/****************************************************************************/

select * from person
where license_id = 183779
limit 10

id	name	license_id	address_number	address_street_name	ssn
78193	Maxine Whitely	183779	110	Fisk Rd	137882671

/****************************************************************************/

Solution:

INSERT INTO solution VALUES (1, 'Miranda Priestly');
        
        SELECT value FROM solution;

