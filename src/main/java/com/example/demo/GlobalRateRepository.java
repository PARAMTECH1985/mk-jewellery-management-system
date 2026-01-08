package com.example.demo;

import org.springframework.data.jpa.repository.JpaRepository;

public interface GlobalRateRepository extends JpaRepository<GlobalRate, Long> {

    GlobalRate findTopByOrderByUpdatedAtDesc();
}
