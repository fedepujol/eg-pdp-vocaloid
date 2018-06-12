% vocaloid(Cantante).
vocaloid(megurineLuka).
vocaloid(hatsumeMiku).
vocaloid(gumi).
vocaloid(seeU).
vocaloid(kaito).
vocaloid(fede).

% sabeCantar(Vocaloid, Cancion)
sabeCantar(megurineLuka, cancion(nightFever, 4)).
sabeCantar(megurineLuka, cancion(foreverYoung, 5)).
sabeCantar(hatsumeMiku, cancion(tellYourWorld, 4)).
sabeCantar(gumi, cancion(foreverYoung, 4)).
sabeCantar(gumi, cancion(tellYourWorld, 5)).
sabeCantar(seeU, cancion(novemberRain, 6)).
sabeCantar(seeU, cancion(tellYourWorld, 5)).
sabeCantar(fede, cancion(aloha, 3)).

% esNovedoso(Vocaloid)
esNovedoso(Vocaloid):-
    tiene2Canciones(Vocaloid),
    cancionesConDuracionMayorA(Vocaloid, 5).

esNovedoso(Vocaloid):-
    cancionesConDuracionMayorA(Vocaloid, 10).

% cancionesConDuracionMayorA(Vocaloid, Minutos)
cancionesConDuracionMayorA(Vocaloid, Minutos):-
    vocaloid(Vocaloid),
    foreach(sabeCantar(Vocaloid, Cancion), duracionSuperiorA(Cancion, Minutos)).

% cantidadCanciones(Vocaloid)
cantidadCanciones(Vocaloid):-
    aggregate(count, sabeCantar(Vocaloid, _), _).

% tiene2Canciones(Vocaloid)
tiene2Canciones(Vocaloid):-
    aggregate(count, cantidadCanciones(Vocaloid), Count),
    Count is 2.

% duracionSuperiorA(Cancion, Minutos)
duracionSuperiorA(cancion(_, Duracion), Minutos):-
    Duracion > Minutos.

% esAcelerado(Vocaloid)
esAcelerado(Vocaloid):-
    vocaloid(Vocaloid),
    forall(sabeCantar(Vocaloid, Cancion), duracionMenorQue(Cancion, 4)).

duracionMenorQue(cancion(_, Duracion), Minutos):-
    Duracion =< Minutos.

% concierto(Concierto).
concierto(mikuExpo, pais(estadosUnidos), 2000, gigante(6)).
concierto(magicalMirai, pais(japon), 3000, gigante(10)).
concierto(vocalektVisions, pais(estadosUnidos), 1000, mediano(novemberRain)).
concierto(mikuFest, pais(argentina), 100, pequenio(4)).

% puedeParticiparEn(Vocaloid, Concierto).
puedeParticiparEn(Vocaloid, Concierto):-
	concierto(Concierto, _ , _, Tipo),
	cumpleCondicionesConcierto(Vocaloid, Tipo).

puedeParticiparEn(hatsumeMiku, Concierto):-
	concierto(Concierto, _, _ , _).

cumpleCondicionesConcierto(Vocaloid, gigante(Duracion)):-
	esNovedosoOAcelerado(Vocaloid),
	forall(sabeCantar(Vocaloid, Cancion), duracionMenorQue(Cancion, Duracion)).
	
cumpleCondicionesConcierto(Vocaloid, mediano(NombreCancion)):-
	sabeCantar(Vocaloid, cancion(NombreCancion, _)).
		
cumpleCondicionesConcierto(Vocaloid, pequenio(DuracionMinima)):-
	forall(sabeCantar(Vocaloid, Cancion), duracionSuperiorA(Cancion, DuracionMinima)).

esNovedosoOAcelerado(Vocaloid):-
	esNovedoso(Vocaloid).
esNovedosoOAcelerado(Vocaloid):-	
	esAcelerado(Vocaloid).

% masFamoso(Vocaloid).
masFamoso(Vocaloid):-
	vocaloid(Vocaloid),
	concierto(Concierto, _, _, _),
	findall(Vocaloid, famaTotal(Vocaloid, Concierto), Ws).

famaTotal(Vocaloid, Concierto):-
	findall(W, (concierto(Concierto, _, W, _), puedeParticiparEn(Vocaloid, Concierto)), Ws), 
	sumlist(Ws, Concierto),
	nombre(Vocaloid, N),
	N is (Concierto + Concierto) * N.
	
nombre(Vocaloid, N):-
	vocaloid(Vocaloid),
	atom_length(Vocaloid, N).

conoce(megurineLuka, hatsumeMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).

unicoVocaloidEnConcierto(Vocaloid):-
	conoce(Vocaloid, OtroVocaloid),
	Vocaloid \= OtroVocaloid,
	
