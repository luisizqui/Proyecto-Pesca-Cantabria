package TFG.repository;

import org.springframework.data.repository.CrudRepository;
import TFG.model.PecesZona;
import java.util.List;

public interface PecesZonaRepository extends CrudRepository<PecesZona, Integer> {

    // Find by pezZona ID
    List<PecesZona> findByPezZonaId(Integer pezId);

    // Find by zonaPez ID
    List<PecesZona> findByZonaPezId(Integer zonaId);
}