package TFG.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "peces_zona")
public class PecesZona {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idpeces_zona", nullable = false)
    private Integer id;

    @NotNull
    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "zona_pez", nullable = false)
    private TFG.model.Zona zonaPez;

    @NotNull
    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "pez_zona", nullable = false)
    private Pez pezZona;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public TFG.model.Zona getZonaPez() {
        return zonaPez;
    }

    public void setZonaPez(TFG.model.Zona zonaPez) {
        this.zonaPez = zonaPez;
    }

    public Pez getPezZona() {
        return pezZona;
    }

    public void setPezZona(Pez pezZona) {
        this.pezZona = pezZona;
    }

}