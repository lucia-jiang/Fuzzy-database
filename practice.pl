%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% JIANG, LUCÍA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Explicación breve, intuitiva y descriptiva de la temática de la práctica
% Las tablas y sus campos así como nos nombres de las funciones se 
% escribirán en inglés como los del ejemplo.
% La explicación intuitiva inicial y las conclusiones al final se pueden
% redactar en español o en inglés, como mejor prefiera el alumno.


%% He decidido escoger el tema de los escape rooms porque me encanta resolver puzzles y enigmas. 
%% Entre a los que he ido en China y los de España, habré hecho unos 30 escapes en total.

%% Tan solo en Madrid hay más de 100 escapes, y por eso siempre ha sido complicado decidir a qué escape ir,
%% y me he llevado alguna mala experiencia que tal vez podría haber evitado si hubiera mirado más reseñas y
%% opiniones. Sin embargo, con tantas opciones no parece tan fácil elegir cuál sería el mejor escape.

%% Un escape idóneo para mí sería uno de precio aceptable, moderno, desafiante, que tenga buenas reseñas y
%% si puede ser, que esté cerca.

%% Para ello he definido la base de datos que se muestra más adelante:

:- module(practice,_,[rfuzzy,clpr]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% QUALIFIERS DEFINITIONS 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
define_modifier(rather/2, TV_In, TV_Out) :-
	TV_Out .=. TV_In * TV_In.
define_modifier(very/2, TV_In, TV_Out) :-
	TV_Out .=. TV_In * TV_In * TV_In.
define_modifier(little/2, TV_In, TV_Out) :-
	TV_Out * TV_Out .=. TV_In.
define_modifier(very_little/2, TV_In, TV_Out) :-
	TV_Out * TV_Out * TV_Out .=. TV_In.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DATA DEFINITION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definicion de tipos de los campos de las tablas de datos 
define_database(escape_rooms/19,
                [(place, rfuzzy_string_type), % name of the place
                (game, rfuzzy_string_type),  % name of the game
                (theme, rfuzzy_enum_type), % theme: scary, criminal, classic...
                (type_room, rfuzzy_enum_type), % type of game: hall escape, street escape...
                
                (min_n_people, rfuzzy_integer_type), % minimum number of people playing
                (max_n_people, rfuzzy_integer_type), % maximum number of people playing
                (competition_mode, rfuzzy_integer_type), % 1 if competition mode is available
                (difficulty, rfuzzy_integer_type), % difficulty over 100
                (average_price, rfuzzy_integer_type), % average price in euros
                (closed_covid, rfuzzy_truth_value_type), % 1 if it is closed due covid

                (address, rfuzzy_string_type), % address of the place
                
                (distance_from_home, rfuzzy_integer_type), % distance in km from home
                (distance_from_the_uni, rfuzzy_integer_type), % distance in km from uni (ETSIINF)
                (distance_from_the_center, rfuzzy_integer_type), % distance in km from the center (Sol)
                (modern_puzzles, rfuzzy_truth_value_type), % 1 if the escape room has modern puzzles
                (place_review, rfuzzy_integer_type), % review of the place over 100  (Google Maps)
                (game_review, rfuzzy_integer_type), %review of the game over 100  (the escape lover)
                
                (discounts, rfuzzy_integer_type), % in percentage
                (already_played, rfuzzy_truth_value_type)]).  % 1 if I have already gone to.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tantos hechos como registros se incluyan de las tablas definidas
escape_rooms('The Rombo Code', 'El Misterio de Don Quijote', mystery, escape_room, 2, 24, 1, 60, 16, 0, 'C/ de Fernandez de los Rios, 70, 28015 Madrid', 14, 20, 4, 0, 92, 70, 20, 0).
escape_rooms('The Rombo Code', 'El Ingrediente Perdido', classic, escape_room, 2, 12, 1, 70, 17, 0, 'C/ de Fernandez de los Rios, 70, 28015 Madrid', 14, 20, 4, 0, 92, 90, 20, 0).
escape_rooms('The Rombo Code', 'Tras el Espejo', classic, escape_room, 3, 12, 1, 75, 17, 0, 'C/ de Fernandez de los Rios, 70, 28015 Madrid', 14, 20, 4, 1, 92, 80, 20, 1).
escape_rooms('The Rombo Code', 'El Secreto del Camino', historical, escape_room, 3, 12, 1, 85, 18, 0, 'C/ de Fernandez de los Rios, 70, 28015 Madrid', 14, 20, 4, 1, 92, 90, 20, 1).
escape_rooms('The Fox in a Box', 'Asesinato del Zodiaco', scary, escape_room, 2, 12, 1, 100, 22, 0, 'C/ del Ancora, 12, 28045 Madrid', 20, 21, 1, 1, 96, 90, 10, 1).
escape_rooms('The Fox in a Box', 'Cadena Perpetua', criminal, escape_room, 2, 12, 1, 90, 22, 0, 'C/ del Ancora, 12, 28045 Madrid', 20, 21, 1, 1, 96, 81, 10, 0).
escape_rooms('The Fox in a Box', 'El Pollo Dorado Saloon', adventure, escape_room, 2, 6, 0, 80, 22, 0, 'C/ del Ancora, 12, 28045 Madrid', 20, 21, 1, 1, 96, 100, 10, 0).
escape_rooms('The Fox in a Box', 'Mastermind', criminal, escape_room, 2, 6, 0, 60, 22, 0, 'C/ del Ancora, 12, 28045 Madrid', 20, 21, 1, 1, 96, 90, 10, 0).
escape_rooms('The Enigma Express', 'Copycat: El Asesino del Jazz', classic, escape_room, 2, 8, 0, 90, 14, 0, 'C/ Calderilla 16. 28054, Madrid', 26, 13, 10, 1, 92, 100, 0, 0).
escape_rooms('The Enigma Express', 'Goya: La Ruta del Sordo', adventure, street_escape, 2, 6, 0, 80, 14, 0, 'Zona centro de Madrid', 16, 17, 0, 1, 92, 90, 0, 0).
escape_rooms('The Enigma Express', 'La Isla Maldita', adventure, escape_online, 2, 6, 0, 60, 5, 0, null, 0, 0, 0, 1, 92, 90, 0, 0).
escape_rooms('The Enigma Express', 'Pandemia', mystery, hall_escape, 2, 18, 0, 75, 8, 1, 'C/ Calderilla 16. 28054, Madrid', 26, 13, 10, 0, 92, 85, 0, 0).
escape_rooms('The Enigma Express', 'El Robo de la Formula Secreta', mystery, escape_room, 2, 6, 0, 80, 10, 1, 'Plaza de la Condesa de Gavia', 7, 21, 7, 1, 92, 100, 0, 1).
escape_rooms('The Enigma Express', 'Explosion Inminente', classic, escape_room, 2, 6, 0, 90, 10, 1, 'Plaza de la Condesa de Gavia', 7, 21, 7, 1, 92, 100, 0, 1).
escape_rooms('The Enigma Express', 'La Fuga del Zulo', adventure, escape_room, 2, 6, 0, 80, 10, 1, 'Plaza de la Condesa de Gavia', 7, 21, 7, 1, 92, 100, 0, 1).
escape_rooms('The Enigma Express', 'Amenaza Biologica', adventure, portatil, 10, 150, 1, 70, 19, 0, null, 0, 0, 0, 0, 92, 85, 0, 0).
escape_rooms('The Enigma Express', 'Proyecto (IA)rcangel', classic, portatil, 10, 150, 1, 70, 19, 0, null, 0, 0, 0, 0, 92, 85, 0, 0).
escape_rooms('Stime', 'La ruta perdida', adventure, escape_room, 3, 6, 0, 80, 15, 1, 'C/ de Hilarion Eslava, 34, 28015 Madrid', 13, 19, 3, 1, 92, 98, 0, 1).
escape_rooms('Stime', 'El orfanato', scary, escape_room, 4, 5, 0, 70, 16, 1, 'C/ de Hilarion Eslava, 34, 28015 Madrid', 13, 19, 3, 1, 92, 98, 0, 1).
escape_rooms('Stime', 'Mision Imposible', adventure, escape_room, 4, 6, 0, 100, 15, 1, 'C/ de Hilarion Eslava, 34, 28015 Madrid', 13, 19, 3, 1, 92, 98, 0, 1).
escape_rooms('Parapark', 'Experimento nº 5', classic, escape_room, 2, 5, 0, 60, 15, 0, 'C/ Manzana, 15, 28015 Madrid', 11, 21, 2, 0, 90, 60, 10, 0).
escape_rooms('Parapark', 'Noveno pasaje', classic, escape_room, 2, 5, 0, 80, 15, 0, 'C/ Manzana, 15, 28015 Madrid', 11, 21, 2, 0, 90, 60, 10, 1).
escape_rooms('The X-Door', 'El Viejo Teatro de Gran Via', mystery, escape_room, 2, 6, 0, 95, 18, 1, 'C/ Gran Via, 16, 28013 Madrid', 11, 22, 1, 1, 88, 85, 0, 1).
escape_rooms('The X-Door', 'The Haunted Prison', scary, escape_room, 2, 6, 0, 90, 17, 1, 'C/ Gran Via, 16, 28013 Madrid', 11, 22, 1, 1, 88, 95, 0, 1).
escape_rooms('The X-Door', 'White and Black', classic, escape_room, 2, 6, 0, 80, 17, 1, 'C/ Gran Via, 16, 28013 Madrid', 11, 22, 1, 1, 88, 90, 0, 1).
escape_rooms('The X-Door', 'Cain', scifi, escape_room, 2, 4, 0, 100, 20, 1, 'C/ Gran Via, 16, 28013 Madrid', 11, 22, 1, 1, 88, 100, 0, 0).
escape_rooms('The X-Door', 'Naturia', scifi, hall_escape, 4, 8, 1, 80, 19, 1, 'C/ Gran Via, 16, 28013 Madrid', 11, 22, 1, 1, 88, 85, 0, 0).
escape_rooms('The X-Door', 'El Mayordomo', child, hall_escape, 2, 10, 1, 60, 18, 1, 'C/ Gran Via, 16, 28013 Madrid', 11, 22, 1, 1, 88, 85, 0, 0).
escape_rooms('The X-Door', 'Venganza', scary, hall_escape, 4, 20, 1, 70, 17, 1, 'C/ Gran Via, 16, 28013 Madrid', 11, 22, 1, 1, 88, 80, 0, 0).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIMILARITY BETWEEN DATA VALUES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Defining similarities between themes:
define_similarity_between(escape_rooms, theme(X), theme(X), 1).

define_similarity_between(escape_rooms, theme(mystery), theme(criminal), 0.8).
define_similarity_between(escape_rooms, theme(mystery), theme(scary), 0.8).
define_similarity_between(escape_rooms, theme(mystery), theme(scifi), 0.6).

define_similarity_between(escape_rooms, theme(criminal), theme(scary), 0.9).

define_similarity_between(escape_rooms, theme(classical), theme(historical), 0.4).
define_similarity_between(escape_rooms, theme(classical), theme(scary), 0.6).
define_similarity_between(escape_rooms, theme(classical), theme(adventure), 0.8).
define_similarity_between(escape_rooms, theme(classical), theme(child), 0.8).

%same similarities but inverted, otherwise Uflese does not work

define_similarity_between(escape_rooms, theme(criminal), theme(mystery), 0.8).
define_similarity_between(escape_rooms, theme(scary), theme(mystery), 0.8).
define_similarity_between(escape_rooms, theme(scifi), theme(mystery), 0.6).

define_similarity_between(escape_rooms, theme(scary), theme(criminal), 0.9).

define_similarity_between(escape_rooms, theme(historical), theme(classical), 0.4).
define_similarity_between(escape_rooms, theme(scary), theme(classical), 0.6).
define_similarity_between(escape_rooms, theme(adventure), theme(classical), 0.8).
define_similarity_between(escape_rooms, theme(child), theme(classical), 0.8).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUZZY FUNCTIONS DEFINITIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% about prices:
expensive(escape_rooms) :~ function(average_price(escape_rooms), [(10,0), (12,0.1), (13,0.2), (14,0.3), (17,0.5), (20,0.7), (22,0.9), (25,1)]).
high_cost(escape_rooms) :~ synonym_of(expensive(escape_rooms), prod, 1).

cheap(escape_rooms) :~ antonym_of(expensive(escape_rooms), prod, 1).
low_cost(escape_rooms) :~ synonym_of(cheap(escape_rooms), prod, 1).

% distance:
close_from_home(escape_rooms) :~ function(distance_from_home(escape_rooms),  [(30,0), (20,0.3), (15,0.5), (10,0.7), (5,1)]).
close_from_uni(escape_rooms) :~ function(distance_from_the_uni(escape_rooms), [(30,0), (20,0.3), (15,0.5), (10,0.7), (5,1)]).
close_from_center(escape_rooms) :~ function(distance_from_the_center(escape_rooms), [(30,0), (20,0.3), (15,0.5), (10,0.7), (5,1)]).

far_from_home(escape_rooms) :~ antonym_of(close_from_home(escape_rooms), prod, 1).
far_from_uni(escape_rooms) :~ antonym_of(close_from_uni(escape_rooms), prod, 1).
far_from_center(escape_rooms) :~ antonym_of(close_from_center(escape_rooms), prod, 1).

% reviews:
good_review_place(escape_rooms) :~ function(place_review(escape_rooms), [(0,0), (50, 0.3), (100,1)]).
good_review_game(escape_rooms) :~ function(game_review(escape_rooms), [(0,0), (50, 0.5), (100,1)]).

bad_review_place(escape_rooms) :~ antonym_of(good_review_place(escape_rooms), prod, 1).
bad_review_game(escape_rooms) :~ antonym_of(good_review_game(escape_rooms), prod, 1).

% difficulty
difficult(escape_rooms) :~ function(difficulty(escape_rooms), [(50,0), (60,0.3), (70,0.5),(100,1)]).
challenging(escape_rooms) :~ synonym_of(difficult(escape_rooms), prod, 1).

easy(escape_rooms) :~ antonym_of(difficult(escape_rooms), prod, 1).
suitable_for_kids(escape_rooms) :~ antonym_of(difficult(escape_rooms), prod, 1).

% discounts:
big_discounts(escape_rooms) :~ function(discounts(escape_rooms), [(0,0), (10,0.5), (20,1)]).
small_discounts(escape_rooms) :~ antonym_of(big_discounts(escape_rooms), prod, 1).

% rules:
best_experience(escape_rooms) :~ rule(min, (good_review_place(escape_rooms), good_review_game(escape_rooms), modern_puzzles(escape_rooms))) with_credibility (min, 0.95).
cheap_with_discounts(escape_rooms) :~ rule(min, (cheap(escape_rooms), big_discounts(escape_rooms))).
most_recommended(escape_rooms) :~ rule(min, (cheap(escape_rooms), good_review_place(escape_rooms), good_review_game(escape_rooms))).
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% QUERIES, SEARCHES, RESULTS AND CONCLUSIONS 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%...  use Esc+X comment-region     
%...  use Esc+X uncomment-region     
%
% Copiar aquí algunas de las queries que se hayan consultado en Ciao o de 
% las búsquedas que se hayan realizado en UFleSe
% Mostrar los resultados y explicar conclusiones interesantes que se 
% hayan sacado de esas consultas o búsquedas.

%% BÚSQUEDAS
Se han hecho búsquedas tanto con UFleSe como con el propio Ciao. Se deja como prueba algunas consultas realizadas en Ciao para demostrar que funciona.

%% Consultas de precio:
%% Se ha consultado el precio por persona suponiendo el máximo de jugadores que se admiten por sala. Así, el escape más caro es "Mastermind" del sitio "The Fox in a Box", que cuesta 22 euros/persona:
%% ?- expensive(X,Y).
%%    X = escape_rooms('The Fox in a Box','Mastermind',criminal,escape_room,2,6,0,60,22,0,'C/ del Ancora, 12, 28045 Madrid',20,21,1,1,96,90,10,0),
%%    Y.=.0.75 ?

%% El escape más barato es el escape online "La Isla Maldita" de "The Enigma Express", que cuesta 5 euros/persona:
%% ?- expensive(X,Y).
%%    X = escape_rooms('The Enigma Express','La Isla Maldita',adventure,escape_online,2,6,0,60,5,0,null,0,0,0,1,92,90,0,0).
%%    Y.=.1.0 ?

%% Consultas de distancia:
%% Los escapes más cercanos son los que son online, ya que tienen distancia 0. Ignorando estos, el siguiente más cerca desde mi casa es "The Enigma Express" en la sede de "Plaza de la Condesa de Gavia" con una cercanía del 80%
%% ?- close_from_home(X,Y).
%%    X = escape_rooms('The Enigma Express','La Fuga del Zulo',adventure,escape_room,2,6,0,80,10,1,'Plaza de la Condesa de Gavia',7,21,7,1,92,100,0,1),
%%    Y.=.0.7999999999999999 ?

%% El más alejado de mi casa es "The X-Door", a distancia de 22km:
%% ?- far_from_home(X,Y).
%%    X = escape_rooms('The X-Door','Venganza',scary,hall_escape,4,20,1,70,17,1,'C/ Gran Via, 16, 28013 Madrid',11,22,1,1,88,80,0,0),
%%    Y.=.1.0 ?     

%% Estas mismas consultas se pueden hacer respecto de la universidad UPM ETSIINF y desde el centro (se ha tomado Sol como punto de referencia).
   
%% Consultas de valoraciones
    
%% El juego con mejores reseñas es "Caín" de "The X-Door", que de hecho ha recibido varios premios este año por los mejores enigmas.
%% ?- good_review_game(X,Y).
%%    X = escape_rooms('The X-Door','Cain',scifi,escape_room,2,4,0,100,20,1,'C/ Gran Via, 16, 28013 Madrid',11,22,1,1,88,100,0,0),
%%    Y.=.1.0 ?

%% El lugar con los mejores escape rooms es "The Fox in a Box" con un grado de certeza de 0.944:
%% ?- good_review_place(X,Y).
%%    X = escape_rooms('The Fox in a Box','Mastermind',criminal,escape_room,2,6,0,60,22,0,'C/ del Ancora, 12, 28045 Madrid',20,21,1,1,96,90,10,0),
%%    Y.=.0.944 ?

%% El juego con peores reseñas es "El Noveno Pasaje" de "Parapark":
%% ?- bad_review_game(X,Y).
%%    X = escape_rooms('Parapark','Noveno pasaje',classic,escape_room,2,5,0,80,15,0,'C/ Manzana, 15, 28015 Madrid',11,21,2,0,90,60,10,1),
%%    Y.=.0.4 ?

%% Consultas de dificultad:
%% El juego más adecuado para un niño es el escape "El Mayordomo" de "The X-Door", ya que es el más sencillo.
%% ?- suitable_for_kids(X,Y).
%%    X = escape_rooms('The X-Door','El Mayordomo',child,hall_escape,2,10,1,60,18,1,'C/ Gran Via, 16, 28013 Madrid',11,22,1,1,88,85,0,0),
%%    Y.=.0.7 ?    

%% Los más complicados son: "Caín", "Misión Imposible" y "Asesinato en el Zodiaco":
%% ?- challenging(X,Y).
%%    X = escape_rooms('The X-Door','Cain',scifi,escape_room,2,4,0,100,20,1,'C/ Gran Via, 16, 28013 Madrid',11,22,1,1,88,100,0,0),
%%    Y.=.1.0 ? ;

%%    X = escape_rooms('Stime','Mision Imposible',adventure,escape_room,4,6,0,100,15,1,'C/ de Hilarion Eslava, 34, 28015 Madrid',13,19,3,1,92,98,0,1),
%%    Y.=.1.0 ? ;

%%    X = escape_rooms('The Fox in a Box','Asesinato del Zodiaco',scary,escape_room,2,12,1,100,22,0,'C/ del Ancora, 12, 28045 Madrid',20,21,1,1,96,90,10,1),
%%    Y.=.1.0 ?

%% Consultas con descuentos:
%% Los mayores descuentos los ofrece el lugar "The Rombo Code" con hasta un 20% de descuento.
%% ?- big_discounts(X,Y).
%%    X = escape_rooms('The Rombo Code','El Secreto del Camino',historical,escape_room,3,12,1,85,18,0,'C/ de Fernandez de los Rios, 70, 28015 Madrid',14,20,4,1,92,90,20,1),
%%    Y.=.1.0 ?

%% Por último, dados estos parámetros se puede consultar cuáles son los escapes que me recomienda ir:       
%% La mejor experiencia, para mí, sería un juego con acertijos modernos, y que haya tenido muy buenas valoraciones. El resultado ha sido el juego "El Pollo Dorado Saloon" de "The Fox in a Box" con un nivel de certeza de 0.944
%% ?- best_experience(X,Y).
%%    X = escape_rooms('The Fox in a Box','El Pollo Dorado Saloon',adventure,escape_room,2,6,0,80,22,0,'C/ del Ancora, 12, 28045 Madrid',20,21,1,1,96,100,10,0),
%%    Y.=.0.944 ?
       
%% El más barato y con descuentos, al que se puede ir es "El Misterio de Don Quijote" de "The Rombo Code" puesto que tiene un precio aceptable de 16 euros, y además hay un descuento del 20% actualmente. Por tanto, otra buena recomendación sería aprovechar la rebaja. 
%% ?- cheap_with_discounts(X,Y).
%%    X = escape_rooms('The Rombo Code','El Misterio de Don Quijote',mystery,escape_room,2,24,1,60,16,0,'C/ de Fernandez de los Rios, 70, 28015 Madrid',14,20,4,0,92,70,20,0),
%%    Y.=.0.5666666666666667 ?    

%% Por último, el más recomendado, considerando las reseñas y precio (ignorando si son modernos o no) es "La Fuga del Zulo":
%% ?- most_recommended(X,Y).
%%    X = escape_rooms('The Enigma Express','La Fuga del Zulo',adventure,escape_room,2,6,0,80,10,1,'Plaza de la Condesa de Gavia',7,21,7,1,92,100,0,1),
%%    Y.=.0.8879999999999999 ? 


       
%% CONSIDERACIONES:
     
%%     Hay que considerar que las dificultades no son totalmente objetivas, pues la dificultad lo ha determinado cada escape room. Probablemente, un 80 de dificultad en "The Fox in a Box" no sea igual que en "The X-Door". 
    
%%     Las reseñas tampoco son 100% fiables, pues hay sitios con mas de 500 reseñas y otras con 20-30. Necesitaríamos más opiniones para determinar la credibilidad de estos datos.

%%     Por último, cabe destacar que el programa está diseñado para uso propio. Si otra persona quisiera utilizarlo, para empezar, habría que modificar el parámetro de los escapes que ya se han jugado "already_played".
%%     Además, los criterios de cercanía han sido puestos según los lugares que frecuento yo (casa, uni y centro). 

       

%% CONCLUSIONES:
%% Una conclusión bastante interesante es que el top de los mejores escapes son del mismo lugar. De la misma manera, los peores también son del mismo lugar.
%% Esto se puede apreciar haciendo algunas consultas como:
%% 
%% ?- most_recommended(X,Y).

%%    X = escape_rooms('The Enigma Express','La Fuga del Zulo',adventure,escape_room,2,6,0,80,10,1,'Plaza de la Condesa de Gavia',7,21,7,1,92,100,0,1),
%%    Y.=.0.8879999999999999 ? ;

%%    X = escape_rooms('The Enigma Express','Explosion Inminente',classic,escape_room,2,6,0,90,10,1,'Plaza de la Condesa de Gavia',7,21,7,1,92,100,0,1),
%%    Y.=.0.8879999999999999 ? ;

%%    X = escape_rooms('The Enigma Express','El Robo de la Formula Secreta',mystery,escape_room,2,6,0,80,10,1,'Plaza de la Condesa de Gavia',7,21,7,1,92,100,0,1),
%%    Y.=.0.8879999999999999 ? ;

%%    X = escape_rooms('The Enigma Express','La Isla Maldita',adventure,escape_online,2,6,0,60,5,0,null,0,0,0,1,92,90,0,0),
%%    Y.=.0.8879999999999999 ? ;

%%    X = escape_rooms('The Enigma Express','Pandemia',mystery,hall_escape,2,18,0,75,8,1,'C/ Calderilla 16. 28054, Madrid',26,13,10,0,92,85,0,0),
%%    Y.=.0.8500000000000001 ? ;
       
%% Y por otro lado: los peores son en ParaPark:             
%% 
%% ?- bad_review_game(X,Y).

%%    X = escape_rooms('Parapark','Noveno pasaje',classic,escape_room,2,5,0,80,15,0,'C/ Manzana, 15, 28015 Madrid',11,21,2,0,90,60,10,1),
%%    Y.=.0.4 ? ;

%%    X = escape_rooms('Parapark','Experimento nº 5',classic,escape_room,2,5,0,60,15,0,'C/ Manzana, 15, 28015 Madrid',11,21,2,0,90,60,10,0),
%%    Y.=.0.4 ?

%% Con ello, podemos deducir que en general, si ya se ha jugado una sala de ese lugar y ha estado bien, es muy probable que los demás estén al mismo nivel.
%% De la misma manera, si no me ha gustado un escape, lo mejor va a ser que no vuelva a intentar otro en ese lugar.

       
%% PÁGINAS DE REFERENCIA. Los diferentes parámetros de la base de datos se han obtenido de las siguientes páginas:
%%     Reseñas de los juegos, temática y tipo de juego: https://www.escaperoomlover.com/es
%%     Reseñas de los sitios, valoración del lugar y distancia: https://www.google.es/maps/?hl=es
%%     Precios y dificultad: se ha cogido de las respectivas páginas webs de cada escape. Para coger 
%% 		       	  https://therombocode.es
%% 			  https://foxinaboxmadrid.com
%% 			  https://www.enigmaexpres.com
%% 			  https://madrid.parapark.es/info/es
%% 			  https://www.thexdoormadrid.com
%%     Modernidad de los acertijos: https://www.tripadvisor.es

    









