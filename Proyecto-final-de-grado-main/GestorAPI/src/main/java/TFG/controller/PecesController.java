package TFG.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import TFG.model.Pez;
import TFG.repository.PecesRepository;

import java.util.Optional;

@RestController
@RequestMapping("/api/peces")
public class PecesController {

    @Autowired
    private PecesRepository pecesRepository;

    // Obtener todos los peces
    @GetMapping
    public Iterable<Pez> getAllPeces() {
        return pecesRepository.findAll();
    }

    // Obtener un pez por ID
    @GetMapping("/{id}")
    public ResponseEntity<Pez> getPezById(@PathVariable Integer id) {
        Optional<Pez> pez = pecesRepository.findById(id);
        return pez.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }


}