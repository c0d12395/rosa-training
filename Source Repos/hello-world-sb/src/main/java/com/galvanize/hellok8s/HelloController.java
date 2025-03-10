package com.galvanize.hellok8s;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @Value("${app.server.id}")
    private int serverId;

    @GetMapping("/hello")
    public String sayHello(@RequestParam(defaultValue = "World") String name){
        return "Hello "+name+"!";
    }

    @GetMapping("/sid")
    public String getServerId(){
        return "The server id is '"+serverId+"'";
    }

}
