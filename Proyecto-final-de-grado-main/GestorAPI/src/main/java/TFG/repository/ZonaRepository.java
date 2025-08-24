package TFG.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import TFG.model.Zona;

@Repository
public interface ZonaRepository extends CrudRepository<Zona, Integer> {
    // Este repositorio ya incluye operaciones CRUD básicas.
}