package TFG.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import TFG.model.Zona;
import TFG.repository.ZonaRepository;

import java.util.Optional;

@RestController
@RequestMapping("/api/zonas")
public class ZonaController {

    @Autowired
    private ZonaRepository zonaRepository;

    // Obtener todas las zonas
    @GetMapping
    public Iterable<Zona> getAllZonas() {
        return zonaRepository.findAll();
    }

    // Obtener una zona por ID
    @GetMapping("/{id}")
    public ResponseEntity<Zona> getZonaById(@PathVariable Integer id) {
        Optional<Zona> zona = zonaRepository.findById(id);
        return zona.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }
}