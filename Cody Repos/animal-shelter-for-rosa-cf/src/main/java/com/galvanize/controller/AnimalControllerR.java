package com.galvanize.controller;

import com.galvanize.models.Animal;
import com.galvanize.repository.AnimalRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/")
public class AnimalControllerR {
    private AnimalRepository repository;

    public AnimalControllerR(AnimalRepository repository) {
        this.repository = repository;
    }

    @GetMapping
    public List<Animal> getAllAnimals(){
        return repository.findAll();
    }

    @PostMapping
    public Animal addAnimal(@RequestBody Animal animal){
        return repository.save(animal);
    }

    @PostMapping("/addAll")
    public List<Animal> addAllAnimals(@RequestBody List<Animal> animals){
        return repository.saveAll(animals);
    }
}
