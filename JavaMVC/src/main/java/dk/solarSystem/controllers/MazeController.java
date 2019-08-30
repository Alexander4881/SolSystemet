package dk.solarSystem.controllers;

import dk.solarSystem.model.MySQLAccess;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/maze/")
public class MazeController {

    @RequestMapping(method = RequestMethod.GET)
    public String Index(Model model, @RequestParam String planetName){

        MySQLAccess mySQLAccess = new MySQLAccess();



        model.addAttribute("mazeInfo", mySQLAccess.GetMazeGoal(planetName));

        return "maze";
    }

}