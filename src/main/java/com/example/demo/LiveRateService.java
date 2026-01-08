package com.example.demo;

import java.time.LocalDateTime;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class LiveRateService {

    @Autowired
    private GlobalRateRepository repo;

    public void fetchAndSaveRate() {

        // Example API (replace API_KEY later)
        String url = "https://api.metals.dev/v1/latest?api_key=demo";

        RestTemplate rt = new RestTemplate();
        Map response = rt.getForObject(url, Map.class);

        Map rates = (Map) response.get("rates");

        Double gold = Double.valueOf(rates.get("XAU").toString());
        Double silver = Double.valueOf(rates.get("XAG").toString());

        GlobalRate rate = repo.findAll().stream().findFirst().orElse(new GlobalRate());
        rate.setGoldRate(gold);
        rate.setSilverRate(silver);
        rate.setUpdatedAt(LocalDateTime.now());

        repo.save(rate);
    }
}
