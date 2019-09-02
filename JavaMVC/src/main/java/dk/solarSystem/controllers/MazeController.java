package dk.solarSystem.controllers;

import dk.solarSystem.model.MySQLAccess;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/maze")
public class MazeController {

    @RequestMapping(method = RequestMethod.GET)
    public String Index(@RequestParam("id") String idName, Model model){

        MySQLAccess mySQLAccess = new MySQLAccess();

        model.addAttribute("test", idName);

        model.addAttribute("mazeInfo", mySQLAccess.GetMazeGoal(idName));

        return "maze";
    }

}