package com.galvanize.autos.repositories;

import com.galvanize.autos.models.Automobile;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AutosRepository extends JpaRepository<Automobile, Long> {
    List<Automobile> findByColorContainsAndMakeContains(String color, String make);
    Optional<Automobile> findByVin(String vin);
}
