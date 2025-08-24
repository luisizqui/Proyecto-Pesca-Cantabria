package TFG.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.hibernate.annotations.ColumnDefault;

import java.time.LocalDate;

@Entity
@Table(name = "peces")
public class Pez {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idpeces", nullable = false)
    private Integer id;

    @Size(max = 45)
    @NotNull
    @Column(name = "nombre", nullable = false, length = 45)
    private String nombre;

    @Size(max = 45)
    @NotNull
    @Column(name = "nombrecientifico", nullable = false, length = 45)
    private String nombrecientifico;

    @NotNull
    @ColumnDefault("0")
    @Column(name = "talla", nullable = false)
    private Integer talla;

    @NotNull
    @Column(name = "fini", nullable = false)
    private LocalDate fini;

    @Column(name = "ffin")
    private LocalDate ffin;

    @Size(max = 500)
    @Column(name = "notas", length = 500)
    private String notas;

    @Size(max = 200)
    @Column(name = "imageurl", length = 200)
    private String imageurl;

    public String getImageurl() {
        return imageurl;
    }

    public void setImageurl(String imageurl) {
        this.imageurl = imageurl;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getNombrecientifico() {
        return nombrecientifico;
    }

    public void setNombrecientifico(String nombrecientifico) {
        this.nombrecientifico = nombrecientifico;
    }

    public Integer getTalla() {
        return talla;
    }

    public void setTalla(Integer talla) {
        this.talla = talla;
    }

    public LocalDate getFini() {
        return fini;
    }

    public void setFini(LocalDate fini) {
        this.fini = fini;
    }

    public LocalDate getFfin() {
        return ffin;
    }

    public void setFfin(LocalDate ffin) {
        this.ffin = ffin;
    }

    public String getNotas() {
        return notas;
    }

    public void setNotas(String notas) {
        this.notas = notas;
    }

}