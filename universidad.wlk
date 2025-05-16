
class Carrera {
    const property materias = {}
}

class Materia {
    var property estudiantesAnotados = {} 
    var property estudiantesEnListaDeEspera = []
    const property requisitos = {}
    const property cupo 

   method inscribirEstudiante(estudiante) {
        self.validarInscribir(estudiante)
        self.estudianteListaDeEsperaOAnotado(estudiante)
    }
    
    method validarInscribir(estudiante) {
        if (not estudiante.puedeInscribirseA(self)) 
        {self.error("No cumple condiciones para anotarse.")}
    } 

    method estudianteListaDeEsperaOAnotado(estudiante){ //5
        if (estudiantesAnotados.size() < cupo) {
            estudiantesAnotados.add(estudiante)
            estudiante.materiasInscriptas().add(self) //chequear
        }
        else {
        estudiantesEnListaDeEspera.add(estudiante)
        estudiante.materiasEnEspera().add(self)
        }

    }

    method darDeBaja (estudiante) {  //7
        estudiantesAnotados.remove(estudiante)
        estudiantesAnotados.add(estudiantesEnListaDeEspera.first())
        estudiantesEnListaDeEspera = estudiantesEnListaDeEspera.subList(1)
    }

    method estudiantesInscriptos(){ //8
        return estudiantesAnotados
    }

    method estudiantesEnListaDeEspera(){  //8
        return estudiantesEnListaDeEspera
    }



}



class Estudiante {
    var property materiasAprobadas = new Dictionary() //no se me ocurre otra forma que no sea con un map. Intente hacer una class Aprobacion, como se ve en
                                                      //la linea , pero al intentar añadir una materia aprobada al set, fallaba
    var property carrerasCursando = {} 
    var property materiasInscriptas= {}
    var property materiasEnEspera= {}

    method estudiarNuevaCarrera(carrera) = carrerasCursando.add(carrera)

    method registroMateriaAprobada(materia, nota){
        self.validarAprobacion(materia) //punto 3
        materiasAprobadas.put(materia, nota)
    }

    method validarAprobacion(materia) {
        if (self.tieneAprobada (materia)) { 
            self.error("Ya la aprobaste")
        }
    }

    method cantidadDeMateriasAprobadas () { 
        return materiasAprobadas.size()
    }

    method promedio() { 
        return materiasAprobadas.values().sum() / materiasAprobadas.size()
    }

    method tieneAprobada (materia){                        
        return materiasAprobadas.containsKey(materia)
    }

    method materiasDeTodasLasCarreras() {
        return carrerasCursando.map({carrera => carrera.materias()}).flatten() //uno listas en una sola lista. 
    }

    method puedeInscribirseA(materia){
        return self.materiaPerteneceACarreras(materia) && not self.tieneAprobada(materia) && not materiasInscriptas.contains(materia) 
        && self.cumpleRequisitosPara(materia)
    }

    method materiaPerteneceACarreras(materia) {
        return self.materiasDeTodasLasCarreras().contains(materia)
    }

    method cumpleRequisitosPara(materia) {
        return materia.requisitos().all({materia => self.tieneAprobada(materia)}) 

    }

    method materiasEnLasQueInscribio(){                                                                     //9
        return self.materiasDeTodasLasCarreras().filter({materia => materiasInscriptas.contains(materia)})

    }

    method materiasEnListaDeEspera(){                                                                       //9
        return self.materiasDeTodasLasCarreras().filter({materia => materiasEnEspera.contains(materia)})
    }

    method materiasALasQueSePuedeInscribirDe(carrera) {
        self.validarInscripcionEnCarrera(carrera)
        return carrera.materias().filter({materia => self.puedeInscribirseA(materia) })
    }

    method validarInscripcionEnCarrera(carrera) {
        if (not self.carrerasCursando().contains(carrera)) { self.error ("No estas inscripto en esta carrera")}
    }



    }


/* 
class Aprobacion {
    var property materia
    var property nota 

   
} */

