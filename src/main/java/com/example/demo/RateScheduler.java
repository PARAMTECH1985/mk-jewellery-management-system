package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class RateScheduler {

    @Autowired
    private LiveRateService service;

    // Every 30 minutes
    @Scheduled(cron = "0 */30 * * * *")
    public void updateRate() {
        service.fetchAndSaveRate();
    }
}
