class Aprobacion {
    const property materia 
    const property nota 
}

class Carrera {
    var property materias = #{}
}

class Credito {

}

class Correlativa {

    var property correlativas

    method validarInscripcion(alumno) 

}

class Año {


}

class Materia {
    var property estudiantesAnotados = #{} 
    var property estudiantesEnListaDeEspera = []
    var property tipoDeRequisitoQueTiene  
    var property cupo 
    //const property creditos 
    //const property añoQuePertenece 

    /* method tipoDeRequisitoQueTiene (){

    } */


    /* method esSinRequisito(){
        return requisitos.isEmpty()
    } */

   method inscribirEstudiante(estudiante) {
        self.validarInscribir(estudiante)
        self.estudianteListaDeEsperaOAnotado(estudiante)
    }
    
    method validarInscribir(estudiante) {
        if (not estudiante.puedeInscribirseA(self)) {
            self.error("No cumple condiciones para anotarse.")}
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
    var property materiasAprobadas = #{}                                                      
    var property carrerasCursando = #{} 
    var property materiasInscriptas= #{}
    var property materiasEnEspera= #{}

    method registroMateriaAprobada(materia, nota){
        self.validarAprobacion(materia) //punto 3
        materiasAprobadas.add(new Aprobacion (materia = materia, nota = nota))
    }

    method validarAprobacion(materia) {
        if (self.tieneAprobada (materia)) { // self.debeAprobar(materia) -- xq puede ser que esa materia este en otra carrera etc 
            self.error("Ya la aprobaste")
        }
    }

    /* 
    method debeAprobar(materia) {
            return not.selftieneAprobada(materia) && self.esDeSuCarrera(materia)    
            }

    method esDeSuCarrera(materia) {
            return
            }
    
     */

    method cantidadDeMateriasAprobadas () { 
        return materiasAprobadas.size()
    }

    method promedio() { 
        return materiasAprobadas.map({aprobacion => aprobacion.nota()}).sum() / materiasAprobadas.size()
    }

    method tieneAprobada (materia){                        
        return materiasAprobadas.any({aprobacion => aprobacion.materia() == materia}) // aprobacion => aprobacion.esDe(materia) 
    }

    /* method esDe(_materia) {
            materia == _materia
    } */

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
