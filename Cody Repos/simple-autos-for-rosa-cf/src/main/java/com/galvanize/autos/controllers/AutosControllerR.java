package com.galvanize.autos.controllers;

import com.galvanize.autos.services.AutosService;
import com.galvanize.autos.models.UpdateOwnerRequest;
import com.galvanize.autos.exceptions.AutoNotFoundException;
import com.galvanize.autos.exceptions.InvalidAutoException;
import com.galvanize.autos.models.Automobile;
import com.galvanize.autos.models.AutosList;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
public class AutosControllerR {

    AutosService autosService;

    public AutosControllerR(AutosService autosService) {
        this.autosService = autosService;
    }

    @GetMapping("/")
    public ResponseEntity<AutosList> getAutos(@RequestParam(defaultValue = "") String color,
                                              @RequestParam(defaultValue = "") String make){
        AutosList autosList;
        if(color.equals("") && make.equals("")) {
            autosList = autosService.getAutos();
        }else{
            autosList = autosService.getAutos(color, make);
        }
        return autosList ==null || autosList.isEmpty() ? ResponseEntity.noContent().build() :
                ResponseEntity.ok(autosList);
    }

    @PostMapping("/")
    public Automobile addAuto(@RequestBody Automobile auto){
        return autosService.addAuto(auto);
    }

    @GetMapping("/{vin}")
    public ResponseEntity<Automobile> getAuto(@PathVariable String vin){
        Automobile auto = autosService.getAuto(vin);
        return auto == null ? ResponseEntity.noContent().build() :
                ResponseEntity.ok(auto);
    }

    @PatchMapping("/{vin}")
    public Automobile updateAuto(@PathVariable String vin,
                                 @RequestBody UpdateOwnerRequest update){
        Automobile automobile = autosService.updateAuto(vin, update.getColor(), update.getOwner());
        automobile.setColor(update.getColor());
        automobile.setOwner(update.getOwner());
        return automobile;
    }

    @DeleteMapping("/{vin}")
    public ResponseEntity<String> deleteAuto(@PathVariable String vin){
        try {
            autosService.deleteAuto(vin);
        }catch (AutoNotFoundException e){
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.accepted().build();
    }

    @ExceptionHandler
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public void invalidAutoExceptionHandlr(InvalidAutoException e){
    }
}
