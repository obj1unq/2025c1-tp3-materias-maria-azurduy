
class Carrera {
    const property materias = {}
}

class Materia {
    var property estudiantesAnotados = {} 
    var property estudiantesEnListaDeEspera = []
    const property requisitos = {}
    const property cupo 

   /*  method anotarEstudiante(estudiante) {
     //   self.validarAnotar(estudiante)
        self.estudianteListaDeEsperaOAnotado()
    }
    
    method validarAnotar(estudiante) {
        if (puedeInscribirse(estudiante)) {}
    } */
    method estudianteListaDeEsperaOAnotado(){
        if (estudiantesAnotados.size() < cupo) 
        {estudiantesAnotados.add(self)}
        else estudiantesEnListaDeEspera.add(self)

    }

    method darDeBaja (estudiante) {
        estudiantesAnotados.remove(estudiante)
        estudiantesAnotados.add(estudiantesEnListaDeEspera.first())
        estudiantesEnListaDeEspera = estudiantesEnListaDeEspera.subList(1)
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
        if (self.tieneAprobada (materia)) { //materiasAprobadas.containsKey(materia)
            self.error("Ya la aprobaste")
        }
    }

    method cantidadDeMateriasAprobadas () { 
        return materiasAprobadas.size()
    }

    method promedio() { 
        return materiasAprobadas.values().sum() / materiasAprobadas.size()
    }

    method tieneAprobada (materia){ //si tiene o no aprobada una materia.
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
        return materia.requisitos.all({requisito => self.tieneAprobada(requisito)}) //rompe 

    }

    }


/* 
class Aprobacion {
    var property materia
    var property nota 

   
} */

