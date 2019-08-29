package dk.solarSystem.controllers;

import dk.solarSystem.model.MySQLAccess;
import dk.solarSystem.model.PersonForm;
import dk.solarSystem.model.Planet;
import dk.solarSystem.model.Planet3DInformation;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.validation.Valid;
import java.util.ArrayList;

@Controller
@RequestMapping("/")
public class HomeController {

    @RequestMapping(method = RequestMethod.GET)
    public String Index(ModelMap model){
        // add a string to the model that get sent to the view
        model.addAttribute("variableName", "string content");
        model.addAttribute("title", "Home");

        MySQLAccess mySQL = new MySQLAccess();

        ArrayList<Planet3DInformation> planet3DInformations = mySQL.GetAll3DPlanetsInformation();

        model.addAttribute("planets", planet3DInformations);
        // view name
        return "home";
    }
}