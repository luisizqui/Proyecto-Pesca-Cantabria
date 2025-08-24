package TFG.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import TFG.model.Pez;

@Repository
public interface PecesRepository extends CrudRepository<Pez, Integer> {
    // Este repositorio ya incluye operaciones CRUD básicas.
}