
class Carrera {
    var property nombre
    const property materias = {}
}

class Materia {
    var property nombre 
    var property estudiantesAnotados = {}
    var property estudiantesEnListaDeEspera = []
    const property requisitos = {}
    const property cupo 

    method anotarEstudiante(estudiante) {
     //   self.validarAnotar(estudiante)
        estudianteListaDeEsperaOAnotado(estudiante)
    }
    
    method validarAnotar(estudiante) {
        if (puedeInscribirse(estudiante)) {}
    }
    method estudianteListaDeEsperaOAnotado(estudiante){
        if (estudiantesAnotados.size() < cupo) 
        {estudiantesAnotados.add(estudiante)}
        else estudiantesEnListaDeEspera.add(estudiante)

    }

    method puedeInscribirse(estudiante) = materiaCorrespondeACarrerasDe(materia, estudiante) && not estudianteAproboMateria(materia, estudiante) && 
            not estaInscriptoEstudianteEn(estudiante, materia) && estudianteCumpleRequisitos(estudiante)

    method darDeBaja (estudiante) {
        estudiantesAnotados.remove(estudiante)
        estudiantesAnotados.add(estudiantesEnListaDeEspera.first())
        estudiantesEnListaDeEspera.subList(1)
    }

}



class Estudiante {
    var property nombre
    var property materiasAprobadas = {}
    var property carrerasCursando = {} 
    var property materiasInscriptas= {}
    var property materiasEnEspera= {}

    method estudiarNuevaCarrera(carrera) = carrerasCursando.add(carrera)
    method aprobacionMateria() 
 
}


class Aprobacion {
    var property materia
    var property nota 

   /*  method aprobacion (){
        return (estudiante ++ "aprobo" ++ materia "con" ++ nota)
    } */
    

}



