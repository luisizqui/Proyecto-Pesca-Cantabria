package TFG.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import TFG.model.PecesZona;
import TFG.repository.PecesZonaRepository;

import java.util.List;

@RestController
@RequestMapping("/api/peces-zona")
public class PecesZonaController {

    @Autowired
    private PecesZonaRepository pecesZonaRepository;

    // Obtener todas las relaciones peces-zona
    @GetMapping
    public Iterable<PecesZona> getAllPecesZona() {
        return pecesZonaRepository.findAll();
    }

    // Obtener una relación peces-zona por ID
    @GetMapping("/{id}")
    public ResponseEntity<PecesZona> getPecesZonaById(@PathVariable Integer id) {
        return pecesZonaRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Obtener relaciones peces-zona por ID de pez
    @GetMapping("/pez/{pezId}")
    public List<PecesZona> getPecesZonaByPezId(@PathVariable Integer pezId) {
        return pecesZonaRepository.findByPezZonaId(pezId);
    }

    // Obtener relaciones peces-zona por ID de zona
    @GetMapping("/zona/{zonaId}")
    public List<PecesZona> getPecesZonaByZonaId(@PathVariable Integer zonaId) {
        return pecesZonaRepository.findByZonaPezId(zonaId);
    }
}