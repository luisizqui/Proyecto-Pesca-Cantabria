package TFG.controller;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
@RequestMapping("/api/foto")
public class FotoController {

    // Path a las imagenes
    private final Path picturesDirectory = Paths.get("src/main/java/TFG/pictures");

    
    @GetMapping("/{filename}")
    public ResponseEntity<Resource> getPictureByName(@PathVariable String filename) {
        try {
            // comprueba el path de la imagen
            Path picturePath = picturesDirectory.resolve(filename).normalize();

            // comprueba si la imagen existe y es legible
            if (!Files.exists(picturePath) || !Files.isReadable(picturePath)) {
                return ResponseEntity.notFound().build();
            }

            
            Resource resource = new UrlResource(picturePath.toUri());
            if (resource.exists() && resource.isReadable()) {
                // determina el tipo de contenido de la imagen
                String contentType = Files.probeContentType(picturePath);

                // Devuelve la imagen para ser mostrada en el navegador
                return ResponseEntity.ok()
                        .contentType(MediaType.parseMediaType(contentType))
                        .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + resource.getFilename() + "\"")
                        .body(resource);
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
            }
        } catch (MalformedURLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}